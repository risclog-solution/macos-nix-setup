{ config, pkgs, ... }:

let
  pg = pkgs.postgresql_16;

  port = 55432;

  ramDiskName = "pgtest";
  ramDiskMount = "/Volumes/${ramDiskName}";
  dataDir = "${ramDiskMount}/data";

  # 2 GiB
  ramDiskSizeMiB = 16384;

  testRolesSql = pkgs.writeText "postgresql-test-roles.sql" ''
    SELECT format('CREATE ROLE %I', role)
    FROM (
      VALUES
        ('postgres'),
        ('claimx'),
        ('clx'),
        ('clx_readonly'),
        ('clxdmci'),
        ('mp'),
        ('brokeruser'),
        ('backup'),
        ('aamweb')
    ) AS roles(role)
    WHERE NOT EXISTS (
      SELECT
      FROM pg_roles
      WHERE rolname = roles.role
    )
    \gexec
  '';

  startPostgresqlTest = pkgs.writeShellScript "postgresql-test-start" ''
    set -euo pipefail

    #
    # RAM-Disk erzeugen, falls sie noch nicht existiert
    #
    if ! /usr/sbin/diskutil info "${ramDiskMount}" >/dev/null 2>&1; then
      device=$(
        /usr/bin/hdiutil attach \
          -nomount \
          "ram://$(( ${toString ramDiskSizeMiB} * 2048 ))" \
          | /usr/bin/awk '{ print $1 }'
      )

      echo "Creating PostgreSQL RAM disk on $device"

      /usr/sbin/diskutil apfs create \
        "$device" \
        "${ramDiskName}"
    fi

    #
    # PostgreSQL-Cluster beim ersten Start initialisieren
    #
    if [ ! -f "${dataDir}/PG_VERSION" ]; then
      mkdir -p "${dataDir}"
      pwfile=$(mktemp)
      printf '%s\n' 'asdf' > "$pwfile"

      ${pg}/bin/initdb \
        -D "${dataDir}" \
        --encoding=UTF8 \
        --locale=C \
        --username=kravagtest \
        --pwfile="$pwfile" \
        --auth=trust

      rm -f "$pwfile"
    fi

    #
    # PostgreSQL starten
    #
    ${pg}/bin/postgres \
      -D "${dataDir}" \
      -p ${toString port} \
      -c listen_addresses=127.0.0.1 \
      -c unix_socket_directories=/tmp \
      -c fsync=off \
      -c synchronous_commit=off \
      -c full_page_writes=off \
      -c max_locks_per_transaction=512 \
      -c max_connections=400 &

    #
    # Rollen anlegen
    #

    pg_pid=$!

    trap 'kill "$pg_pid" 2>/dev/null || true' EXIT INT TERM

    until ${pg}/bin/pg_isready \
      -h 127.0.0.1 \
      -p ${toString port} >/dev/null 2>&1
    do
      sleep 0.1
    done

    ${pg}/bin/psql \
      -h 127.0.0.1 \
      -p ${toString port} \
      -U kravagtest \
      -d postgres \
      -v ON_ERROR_STOP=1 \
      -f ${testRolesSql}

    wait "$pg_pid"

  '';

in {
  home.packages = [
    pg
  ];

  launchd.agents.postgresql-test = {
    enable = true;

    config = {
      ProgramArguments = [
        "${startPostgresqlTest}"
      ];

      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Interactive";

      StandardOutPath =
        "${config.home.homeDirectory}/Library/Logs/postgresql-test.log";

      StandardErrorPath =
        "${config.home.homeDirectory}/Library/Logs/postgresql-test-error.log";
    };
  };
}
