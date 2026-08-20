# TODO – Privates MacBook Nix Setup

## Ziel

Das bestehende Arbeitsrechner-Setup als Basis verwenden und daraus ein sauberes, privates macOS/Nix-Setup bauen.

Geplanter Stack:

```text
macOS
├── Determinate Nix
├── nix-darwin
├── Home Manager
├── PostgreSQL
│   └── pgvector
├── Redis                    # optional
├── Ollama
├── Python
│   └── uv
│       ├── Polars
│       ├── ArcticDB
│       ├── ConnectorX
│       └── ADBC PostgreSQL  # optional
├── Node.js
├── Git / GitHub
└── CLI / Dev Tools
```

---

# 1. Repository auf private Nutzung umstellen

* [ ] Fork als eigenständiges privates MacBook-Setup behandeln.
* [ ] Repository-Beschreibung aktualisieren.
* [ ] GitHub-Standardbranch auf `main` umstellen.
* [x] `README.md` auf private Nutzung umschreiben.
* [x] Installations-URL im README vom ursprünglichen Arbeits-Repository auf den privaten Fork ändern.
* [x] Alle Verweise auf `risclog-solution/macos-nix-setup` entfernen.
* [x] Alle Firmennamen und Firmen-Domains suchen und prüfen.
* [x] Alle hartcodierten Benutzernamen suchen und ersetzen.
* [x] Alle hartcodierten Hostnamen suchen und ersetzen.
* [x] Private MacBook-Konfiguration eindeutig benennen.

Beispiel:

```text
darwinConfigurations."private-macbook"
homeConfigurations."private-macbook"
```

---

# 2. Zentrale Host-/User-Konfiguration einführen

Derzeit sollten Benutzername, Hostname und ähnliche Werte nicht an mehreren Stellen dupliziert werden.

* [ ] Benutzername zentral definieren.
* [ ] Hostname zentral definieren.
* [ ] Vollständigen Namen zentral definieren.
* [ ] Private E-Mail-Adresse zentral definieren.
* [ ] GitHub-Benutzernamen zentral definieren.
* [ ] Architektur zentral definieren.
* [ ] Werte über `specialArgs` oder ein gemeinsames Config-Modul an nix-darwin/Home Manager übergeben.

Beispielwerte:

```nix
{
  username = "marcus";
  hostname = "private-macbook";
  system = "aarch64-darwin";
}
```

---

# 3. Flake-Struktur aufräumen

* [ ] `flake.nix.in` prüfen und vereinfachen.
* [ ] `darwinConfigurations` passend zum privaten Host umbenennen.
* [ ] `homeConfigurations.rlmbp2025` umbenennen.
* [ ] Benutzername nicht mehr per Template mehrfach einsetzen.
* [ ] `aarch64-darwin` beibehalten, falls das private MacBook Apple Silicon nutzt.
* [ ] Home Manager möglichst direkt als nix-darwin-Modul integrieren.
* [ ] Ziel: nur noch ein zentraler Rebuild-Befehl.

Bevorzugt:

```bash
sudo darwin-rebuild switch --flake .#private-macbook
```

* [ ] `flake.lock` aktualisieren.
* [ ] Alte oder nicht mehr benötigte Flake-Inputs entfernen.
* [ ] Release-Versionen von nixpkgs, nix-darwin und Home Manager konsistent halten.

---

# 4. Arbeits-spezifische Git-Konfiguration entfernen

In `home-manager/modules/git.nix.in`:

* [ ] Private `user.name` setzen.
* [ ] Private `user.email` setzen.
* [ ] Privaten Signing-Key setzen.
* [ ] `redmine.risclog.de` entfernen.
* [ ] `changelog.preprocess` entfernen oder neutralisieren.
* [ ] `CHANGES.rst` als Standard hinterfragen.
* [ ] Firmen-spezifische Git-Konventionen entfernen.
* [ ] Arbeits-spezifische Git-Aliases prüfen.
* [ ] Nur wirklich verwendete Aliases behalten.
* [ ] Default-Branch prüfen.

Optional:

```nix
init.defaultBranch = "main";
```

* [ ] `core.editor = "mvim -f"` prüfen.
* [ ] Optional auf `nvim`, `vim` oder VS Code umstellen.
* [ ] Git-LFS nur behalten, wenn benötigt.
* [ ] Git-Signing testen.

Smoke-Test:

```bash
git config --global user.name
git config --global user.email
git config --global commit.gpgsign
```

---

# 5. Arbeits-spezifische SSH-Konfiguration entfernen

In `home-manager/modules/ssh.nix.in`:

* [x] `flyingcircus-jump-host` entfernen.
* [x] `dev.risclog.net` entfernen.
* [x] `*.fcio.net` entfernen.
* [x] `*.gocept.net` entfernen.
* [x] `risclog*` entfernen.
* [x] `kravag*` entfernen.
* [x] `volkswagen*` entfernen.
* [x] `vwfs*` entfernen.
* [x] `rlservices*` entfernen.
* [x] Weitere Firmen-Hostpatterns entfernen.
* [ ] Private SSH-Hosts separat ergänzen.

## SSH-Agent entscheiden

Eine Variante wählen:

### Variante A: normales SSH

* [ ] `~/.ssh/id_ed25519` verwenden.
* [ ] Private SSH-Key-Paar erzeugen.
* [ ] Public Key bei GitHub hinterlegen.

### Variante B: 1Password SSH Agent

* [ ] 1Password SSH Agent aktivieren.
* [ ] Home-Manager-SSH-Konfiguration dafür anpassen.
* [ ] Keine zusätzliche private Key-Datei nötig.

## SSH-Sicherheit verbessern

* [ ] `strictHostKeyChecking = "no"` entfernen.
* [ ] Normales Known-Hosts-Verhalten verwenden.
* [ ] `forwardAgent = "yes"` nur aktivieren, falls benötigt.
* [ ] `pubkeyAcceptedKeyTypes = "+ssh-rsa"` entfernen, falls nicht für Legacy-Systeme notwendig.
* [ ] `ControlMaster`/`ControlPersist` nur behalten, wenn gewünscht.

Smoke-Test:

```bash
ssh -T git@github.com
```

---

# 6. GPG / Git Signing bereinigen

* [ ] Entscheiden: GPG-Signing oder SSH-Signing verwenden.
* [ ] Privaten Signing-Key verwenden.
* [ ] Keine Arbeits-GPG-Keys übernehmen.
* [ ] Keine Schlüssel ins Repository committen.
* [ ] `pinentry_mac` behalten, falls GPG genutzt wird.
* [ ] `programs.gpg.enable` passend konfigurieren.
* [ ] Git-Signing komplett testen.

Optional moderner:

```text
Git SSH signing
statt
GPG signing
```

---

# 7. `common.nix` aufräumen

Die bestehende Paketliste ist historisch gewachsen und sollte zerlegt werden.

* [ ] Pakete nach Themen aufteilen.
* [ ] `common.nix` klein halten.

Vorgeschlagene Struktur:

```text
home-manager/
├── mac.nix
└── modules/
    ├── common.nix
    ├── shell.nix
    ├── git.nix
    ├── ssh.nix
    ├── development.nix
    ├── python.nix
    ├── node.nix
    ├── databases.nix
    ├── ai.nix
    └── documents.nix
```

---

# 8. Alte Pakete prüfen und entfernen

Folgende Pakete kritisch prüfen:

* [ ] `python27`
* [ ] Python-2-Ausnahme in `permittedInsecurePackages`
* [ ] alte Python-Package-Overrides
* [ ] `grunt-cli`
* [ ] `maven`
* [ ] `jdk17`
* [ ] `haskellPackages.cryptohash-sha256`
* [ ] `mitmproxy`
* [ ] `watchman`
* [ ] `geckodriver`
* [ ] `ctags`
* [ ] `ruby`
* [ ] `sphinx`
* [ ] `swig`
* [ ] `texlive.combined.scheme-full`
* [ ] X11-Libraries
* [ ] `libxcb`
* [ ] `libX11`
* [ ] `xorgproto`
* [ ] `cairo`
* [ ] `zopfli.dev`
* [ ] `grunt-cli`

Nur behalten, was auf dem privaten Rechner wirklich gebraucht wird.

---

# 9. X11-Overlay prüfen

Aktuell existiert ein spezieller `XKBgeom`-Workaround.

* [ ] Prüfen, ob `noXKBgeomOverlay` weiterhin notwendig ist.
* [ ] Falls nicht: Overlay komplett entfernen.
* [ ] Falls X11-Pakete entfernt werden: wahrscheinlich ebenfalls unnötig.
* [ ] Build ohne Overlay testen.

---

# 10. Hardcodierte `/nix/store`-Pfade entfernen

Insbesondere:

```text
/nix/store/...-wkhtmltopdf...
```

* [ ] Keine absoluten Store-Hashes verwenden.
* [ ] Paket direkt über Nix referenzieren.
* [ ] Falls `wkhtmltopdf` nicht mehr benötigt wird: entfernen.
* [ ] Repo nach `/nix/store/` durchsuchen.

```bash
grep -R "/nix/store/" .
```

---

# 11. `/opt/nixpkgs/binaries` aufräumen

Aktuell zeigen mehrere Home-Manager-Symlinks auf `/opt/nixpkgs/binaries`.

* [ ] Prüfen, welche Helper-Scripts privat benötigt werden.
* [ ] Arbeits-spezifische Scripts entfernen.
* [ ] Scripts repo-relativ verwalten.
* [ ] Möglichst `home.file` direkt aus dem Repository verwenden.

Prüfen:

* [ ] `b`
* [ ] `drop_testdb.sh`
* [ ] `clean_repo.sh`
* [ ] `restart_nginx.sh`
* [ ] `mvim`
* [ ] `t`
* [ ] `tf`
* [ ] `update_nix`
* [ ] `pdftk`
* [ ] `prepare-commit-msg`

---

# 12. PostgreSQL als eigenes Modul bauen

Aktuell läuft PostgreSQL 16 direkt als LaunchAgent.

Neue Struktur:

```text
darwin/
└── services/
    └── postgresql.nix
```

* [ ] PostgreSQL aus `darwin-configuration.nix` herausziehen.
* [ ] PostgreSQL-Version bewusst wählen.
* [ ] Vorerst PostgreSQL 16 beibehalten, falls Kompatibilität wichtig ist.
* [ ] Server und Development-Files dieselbe PostgreSQL-Version verwenden lassen.
* [ ] `postgresql_16.dev` beibehalten, wenn lokale Builds es benötigen.
* [ ] `postgresql_16.pg_config` verfügbar halten.

---

# 13. PostgreSQL-Datenverzeichnis modernisieren

Derzeit:

```text
/etc/local/postgres16/data
```

Privat besser benutzerspezifisch.

Zum Beispiel:

```text
~/.local/share/postgresql/16
```

oder:

```text
~/Library/Application Support/PostgreSQL/16
```

* [ ] Zielverzeichnis auswählen.
* [ ] `initdb` automatisch oder dokumentiert durchführen.
* [ ] Eigentümer/Rechte korrekt setzen.
* [ ] LaunchAgent auf das neue Verzeichnis umstellen.
* [ ] Daten nicht ins Git-Repository legen.
* [ ] Backup-Konzept festlegen.

---

# 14. PostgreSQL-Grundkonfiguration

* [ ] Port festlegen, Standard `5432`.
* [ ] Listen-Adresse auf localhost beschränken.
* [ ] UTF-8 verwenden.
* [ ] Locale prüfen.
* [ ] Development-Datenbank automatisch oder per Script erzeugen.
* [ ] Private Standard-Rolle anlegen.
* [ ] Passwortlose Local-Socket-Authentifizierung optional konfigurieren.
* [ ] TCP-Authentifizierung sinnvoll konfigurieren.

Smoke-Test:

```bash
psql postgres
```

---

# 15. pgvector hinzufügen

pgvector soll fest zum privaten PostgreSQL gehören.

* [ ] pgvector gegen exakt dieselbe PostgreSQL-Major-Version bauen.
* [ ] pgvector über Nix verwalten.
* [ ] Keine manuelle Installation nach `/usr/local`.
* [ ] PostgreSQL-Extension-Pfade prüfen.
* [ ] `vector.control` muss verfügbar sein.
* [ ] Shared Library muss vom PostgreSQL-Server gefunden werden.
* [ ] Extension in Development-Datenbanken aktivieren.

SQL:

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

---

# 16. pgvector Smoke-Test

* [ ] Test-Tabelle erstellen.

```sql
CREATE TABLE vector_test (
    id bigserial PRIMARY KEY,
    embedding vector(3)
);
```

* [ ] Testdaten einfügen.

```sql
INSERT INTO vector_test (embedding)
VALUES
    ('[1,2,3]'),
    ('[4,5,6]');
```

* [ ] Similarity Search testen.

```sql
SELECT *
FROM vector_test
ORDER BY embedding <-> '[3,1,2]'
LIMIT 1;
```

* [ ] Extension-Version prüfen.

```sql
SELECT extversion
FROM pg_extension
WHERE extname = 'vector';
```

---

# 17. pgvector Indexe testen

Für spätere AI-/Embedding-Projekte:

* [ ] HNSW testen.

```sql
CREATE INDEX ON vector_test
USING hnsw (embedding vector_l2_ops);
```

* [ ] Optional IVFFlat testen.
* [ ] Cosine-Distance testen.
* [ ] Inner Product testen.
* [ ] Indexparameter später projektspezifisch konfigurieren.

---

# 18. Redis hinterfragen

Redis ist aktuell als LaunchAgent vorhanden.

* [ ] Prüfen, ob Redis privat benötigt wird.
* [ ] Wenn nein: komplett entfernen.
* [ ] Wenn ja: in eigenes Modul verschieben.

```text
darwin/services/redis.nix
```

* [ ] Datenverzeichnis aus `/etc/local` herausnehmen.
* [ ] Redis nur an localhost binden.
* [ ] Persistence bewusst konfigurieren.
* [ ] LaunchAgent separat testen.

---

# 19. nginx hinterfragen

* [ ] Prüfen, ob lokales nginx auf dem privaten MacBook dauerhaft benötigt wird.
* [ ] Wenn nein: entfernen.
* [ ] Wenn ja: in eigenes Modul verschieben.
* [ ] `/etc/local/nginx` ersetzen.
* [ ] Config innerhalb des Repositories verwalten.
* [ ] Logs in benutzerspezifisches Verzeichnis verschieben.
* [ ] Root-LaunchDaemon vermeiden, falls nicht notwendig.

---

# 20. FakeS3 entfernen

Der bisherige FakeS3-Agent sollte nicht übernommen werden.

* [ ] `fakes3` LaunchAgent entfernen.
* [ ] Hardcodierten Ruby-Pfad entfernen.
* [ ] Eingetragene License-ID entfernen.
* [ ] Prüfen, ob diese License-ID eventuell aus der Git-Historie entfernt werden sollte.
* [ ] Falls lokales S3 benötigt wird: moderne Alternative einsetzen.

Mögliche Alternative:

```text
MinIO
```

Nur hinzufügen, wenn tatsächlich gebraucht.

---

# 21. Python-Basis modernisieren

Ziel:

```text
Nix
└── Python Runtime + uv

Projektabhängigkeiten
└── uv / pyproject.toml
```

* [ ] Python 2 komplett entfernen.
* [ ] Python 3.12 oder 3.13 als Basis wählen.
* [ ] Nicht mehrere globale Python-Versionen ohne Grund installieren.
* [ ] `uv` behalten.
* [ ] `pipx` nur behalten, wenn wirklich genutzt.
* [ ] Python-Projektabhängigkeiten nicht global über Home Manager installieren.
* [ ] Für Projekte `pyproject.toml` + `uv.lock` verwenden.

---

# 22. Polars hinzufügen

Polars sollte projektbezogen über `uv` installiert werden.

* [ ] `polars` nicht zwingend global über Nix installieren.
* [ ] In Data-Projekten hinzufügen.

```bash
uv add polars
```

Smoke-Test:

```bash
uv run python -c "import polars as pl; print(pl.__version__)"
```

---

# 23. ConnectorX für Polars + PostgreSQL

Für schnellen PostgreSQL-Import in Polars:

* [ ] `connectorx` hinzufügen.

```bash
uv add connectorx
```

Beispiel:

```python
import polars as pl

df = pl.read_database_uri(
    query="SELECT * FROM documents",
    uri="postgresql://localhost/mydb",
)

print(df)
```

* [ ] PostgreSQL-Verbindung testen.
* [ ] Größere Tabellen testen.
* [ ] Prüfen, ob Vector-Spalten sinnvoll konvertiert werden.

---

# 24. ADBC für Polars + PostgreSQL Writes

Optional für sauberes Datenbank-I/O:

* [ ] `adbc-driver-postgresql` ergänzen, wenn DataFrames zurück nach PostgreSQL geschrieben werden sollen.

```bash
uv add adbc-driver-postgresql
```

* [ ] Read-Path testen.
* [ ] Write-Path testen.
* [ ] SQLAlchemy/Pandas nur ergänzen, wenn ein konkretes Projekt es benötigt.

---

# 25. PyArrow nicht pauschal installieren

* [ ] `pyarrow` zunächst weglassen.
* [ ] Erst ergänzen, wenn eine konkrete Library es benötigt.
* [ ] Polars soweit möglich nativ verwenden.
* [ ] Arrow-PyCapsule-Interop bevorzugen, wenn unterstützt.

Bei Bedarf:

```bash
uv add pyarrow
```

---

# 26. ArcticDB hinzufügen

ArcticDB ebenfalls projektbezogen über `uv`.

* [ ] `arcticdb` hinzufügen.

```bash
uv add arcticdb
```

* [ ] Nicht als macOS-Systemdienst behandeln.
* [ ] Lokales LMDB-Backend als Startpunkt verwenden.
* [ ] Datenverzeichnis festlegen.

Beispiel:

```text
~/.local/share/arcticdb
```

---

# 27. ArcticDB Smoke-Test

```python
from arcticdb import Arctic
import polars as pl

arctic = Arctic(
    "lmdb:///Users/<USER>/.local/share/arcticdb"
)

if "test" not in arctic.list_libraries():
    arctic.create_library("test")

library = arctic["test"]
```

* [ ] Library erzeugen.
* [ ] Daten schreiben.
* [ ] Daten lesen.
* [ ] Verhalten mit Polars testen.
* [ ] Bei Bedarf zwischen Polars/Pandas/Arrow konvertieren.

---

# 28. ArcticDB Storage-Strategie

Vorerst:

```text
ArcticDB
└── lokales LMDB
```

Später optional:

```text
ArcticDB
├── S3
├── MinIO
└── Cloud Object Storage
```

* [ ] Lokal mit LMDB starten.
* [ ] Kein MinIO installieren, solange es nicht gebraucht wird.
* [ ] Bei S3-Nutzung Credentials niemals ins Repository schreiben.

---

# 29. Gemeinsamen Data-Dev-Stack definieren

Empfohlene Basis pro Projekt:

```bash
uv add \
    polars \
    arcticdb \
    connectorx
```

Optional:

```bash
uv add adbc-driver-postgresql
```

Bei ML-/AI-Projekten später beispielsweise:

```bash
uv add \
    numpy \
    scikit-learn
```

Nicht pauschal global installieren.

---

# 30. Beispiel für ein Data-Projekt

Ordner:

```text
projects/
└── data-playground/
    ├── pyproject.toml
    ├── uv.lock
    ├── src/
    └── README.md
```

Initialisierung:

```bash
mkdir data-playground
cd data-playground

uv init
uv add polars arcticdb connectorx adbc-driver-postgresql
```

Test:

```bash
uv run python
```

---

# 31. Ollama behalten

Ollama ist bereits Teil des bestehenden Paketsatzes.

* [ ] Ollama behalten, wenn lokale LLMs/Embeddings genutzt werden sollen.
* [ ] Prüfen, ob Nix-Paket oder offizielle macOS-App sinnvoller ist.
* [ ] Modelle nicht über Nix verwalten.
* [ ] Modell-Daten nicht ins Repository legen.

Smoke-Test:

```bash
ollama --version
```

---

# 32. Ollama + pgvector vorbereiten

Für lokale RAG-/Embedding-Projekte:

```text
Dokumente
    ↓
Polars
    ↓
Embedding Model via Ollama
    ↓
PostgreSQL + pgvector
```

* [ ] Embedding-Modell auswählen.
* [ ] Embeddings lokal erzeugen.
* [ ] Vector-Dimension passend zur pgvector-Spalte wählen.
* [ ] Batch-Ingestion mit Polars vorbereiten.
* [ ] Similarity Search testen.

---

# 33. Polars + pgvector Zusammenspiel testen

* [ ] Normale Metadaten direkt mit Polars laden.
* [ ] Vector-Spalten gesondert prüfen.
* [ ] Similarity Search bevorzugt in PostgreSQL durchführen.
* [ ] Nur Resultset als Polars DataFrame laden.

Beispiel:

```sql
SELECT
    id,
    title,
    embedding <-> $1 AS distance
FROM documents
ORDER BY embedding <-> $1
LIMIT 20;
```

Dann Resultset mit Polars lesen.

---

# 34. macOS-Systemeinstellungen mit nix-darwin verwalten

* [ ] Tastaturwiederholung konfigurieren.
* [ ] `ApplePressAndHoldEnabled` deaktivieren, falls gewünscht.
* [ ] Finder konfigurieren.
* [ ] Dock konfigurieren.
* [ ] Trackpad konfigurieren.
* [ ] Screenshot-Verzeichnis setzen.
* [ ] Dateiendungen im Finder anzeigen.
* [ ] versteckte Dateien optional anzeigen.
* [ ] Key Repeat beschleunigen.
* [ ] Initial Key Repeat einstellen.
* [ ] Natural Scrolling nach Präferenz setzen.
* [ ] Dock-Autohide konfigurieren.

---

# 35. Touch ID für sudo

* [ ] Prüfen, ob Touch ID für `sudo` über nix-darwin aktiviert werden soll.
* [ ] Nach macOS-Updates testen.
* [ ] Fallback auf Passwort sicherstellen.

---

# 36. Homebrew-Strategie festlegen

Prinzip:

```text
Nix zuerst
Homebrew nur bei Bedarf
```

* [ ] CLI-Tools bevorzugt über Nix installieren.
* [ ] GUI-Apps ggf. über Homebrew Casks verwalten.
* [ ] Mac-App-Store-Apps separat behandeln.
* [ ] Keine Tools doppelt über Nix und Homebrew installieren.

---

# 37. GUI-Apps definieren

Private Auswahl festlegen, z. B.:

* [ ] 1Password
* [ ] iTerm2 oder Ghostty
* [ ] VS Code / Cursor
* [ ] Firefox
* [ ] Chrome
* [ ] Docker Desktop / OrbStack / Colima
* [ ] DBeaver / TablePlus
* [ ] Obsidian
* [ ] Raycast
* [ ] Slack nur falls privat benötigt
* [ ] Spotify
* [ ] Signal
* [ ] Rectangle oder vergleichbarer Window Manager

Nicht automatisch alles aus dem Arbeitsrechner übernehmen.

---

# 38. Docker-Strategie festlegen

Aktuell sind Docker-CLI und Docker Compose im Nix-Setup.

* [ ] Docker CLI behalten.
* [ ] Docker Compose behalten, falls genutzt.
* [ ] Backend festlegen.

Möglichkeiten:

```text
Docker Desktop
OrbStack
Colima
```

* [ ] Nur ein Backend gleichzeitig nutzen.
* [ ] Prüfen, ob Docker überhaupt global benötigt wird.

---

# 39. Node.js modernisieren

Aktuell ist Node.js 24 vorgesehen.

* [ ] Node-Version prüfen.
* [ ] Node nur global installieren, wenn sinnvoll.
* [ ] `yarn` prüfen.
* [ ] `npm` reicht eventuell.
* [ ] Alternativ `pnpm` erwägen.
* [ ] `grunt-cli` entfernen, sofern keine Legacy-Projekte existieren.

Empfohlen:

```text
nodejs
pnpm
```

oder nur projektspezifisch.

---

# 40. Rust-Toolchain prüfen

Aktuell ist `rustc` global installiert.

* [ ] Entscheiden, ob Nix-Rust ausreicht.
* [ ] Falls häufig Rust entwickelt wird: `rustup` erwägen.
* [ ] Falls Rust nur Build-Dependency ist: Nix-Version reicht.
* [ ] Keine zwei Toolchains ohne Grund parallel pflegen.

---

# 41. Java-Toolchain prüfen

* [ ] `jdk17` nur behalten, wenn benötigt.
* [ ] Maven nur behalten, wenn benötigt.
* [ ] Falls Java privat nicht verwendet wird: beides entfernen.

---

# 42. Dokument-/PDF-Tools prüfen

Aktuell u. a.:

```text
ghostscript
poppler-utils
qpdf
imagemagick
texlive
tesseract
```

* [ ] Ghostscript behalten?
* [ ] Poppler behalten?
* [ ] qpdf behalten?
* [ ] ImageMagick behalten?
* [ ] Tesseract behalten?
* [ ] komplettes TeX Live wirklich nötig?
* [ ] Lieber kleines TeX-Schema einsetzen, falls möglich.
* [ ] `pdftk`-Helper prüfen.

---

# 43. Shell-Setup übernehmen und aufräumen

* [ ] Zsh behalten.
* [ ] Oh My Zsh prüfen.
* [ ] Powerlevel10k behalten, falls gewünscht.
* [ ] `zsh-syntax-highlighting` behalten.
* [ ] `zsh-history-substring-search` behalten.
* [ ] `fzf` behalten.
* [ ] `zoxide` behalten.
* [ ] `bat` behalten.
* [ ] `bottom` behalten.
* [ ] `dust` behalten.
* [ ] `tree` behalten.

---

# 44. Terminal-Font sauber konfigurieren

* [ ] Nerd Font über Nix oder Homebrew installieren.
* [ ] Terminal auf Nerd Font konfigurieren.
* [ ] `p10k configure` nur einmal nötig machen.
* [ ] README entsprechend aktualisieren.

---

# 45. `direnv` / `nix-direnv` behalten

Aktuell bereits aktiviert.

* [ ] `direnv` behalten.
* [ ] `nix-direnv` behalten.
* [ ] `.envrc`-Pattern dokumentieren.
* [ ] Private Umgebungsvariablen nicht committen.
* [ ] `.env` zu `.gitignore` hinzufügen.

Beispiel:

```bash
use flake
```

---

# 46. Secrets-Management festlegen

Keine Secrets direkt in Nix-Dateien.

* [ ] Private API-Keys nicht committen.
* [ ] AWS-Credentials nicht committen.
* [ ] PostgreSQL-Passwörter nicht committen.
* [ ] GitHub-Tokens nicht committen.
* [ ] Ollama braucht lokal typischerweise keine Secrets.
* [ ] ArcticDB-S3-Credentials nicht committen.

Mögliche Lösung:

```text
sops-nix
```

oder:

```text
agenix
```

oder für einfache private Nutzung:

```text
1Password CLI
```

---

# 47. GitHub CLI konfigurieren

* [ ] `gh` behalten.
* [ ] Privat bei GitHub anmelden.
* [ ] SSH-Protokoll konfigurieren.
* [ ] Auth-State nicht ins Repository legen.

Smoke-Test:

```bash
gh auth status
```

---

# 48. AWS CLI prüfen

Aktuell ist `awscli2` installiert.

* [ ] Nur behalten, wenn AWS/S3 verwendet wird.
* [ ] Profile unter `~/.aws/` pflegen.
* [ ] Keine Credentials ins Nix-Repository übernehmen.
* [ ] Bei ArcticDB + S3 später wieder relevant.

---

# 49. LaunchAgents modularisieren

Statt alles in `darwin-configuration.nix`:

```text
darwin/
└── services/
    ├── postgresql.nix
    ├── redis.nix
    └── nginx.nix
```

* [ ] Jeder Service in eigenes Modul.
* [ ] Service separat aktivierbar.
* [ ] `enable`-Optionen einführen, falls sinnvoll.
* [ ] Logs definieren.
* [ ] Datenverzeichnisse definieren.
* [ ] Restart-Verhalten definieren.

---

# 50. Möglichst keine Root-Dienste

* [ ] Prüfen, welche Services wirklich Root benötigen.
* [ ] PostgreSQL als User laufen lassen.
* [ ] Redis als User laufen lassen.
* [ ] nginx möglichst nicht als Root betreiben, falls nur Development.
* [ ] Ports >1024 verwenden, wenn dadurch Root vermieden werden kann.

---

# 51. `install.sh` bereinigen

* [ ] Ursprüngliche Repo-URLs ersetzen.
* [ ] Firmen-spezifische Texte entfernen.
* [ ] Firmen-spezifische Defaults entfernen.
* [ ] GPG-Setup privat anpassen.
* [ ] SSH-Setup privat anpassen.
* [ ] Hostname sauber erkennen oder abfragen.
* [ ] Benutzername sauber erkennen.
* [ ] Apple-Silicon-Prüfung einbauen.
* [ ] Determinate Nix weiterhin sauber installieren.
* [ ] nix-darwin bootstrap sauber durchführen.
* [ ] Home Manager über nix-darwin aktivieren.
* [ ] PostgreSQL-Initialisierung berücksichtigen.

---

# 52. Installationsprozess idempotent machen

Idealerweise kann `install.sh` mehrfach laufen.

* [ ] Bereits installiertes Nix erkennen.
* [ ] Bereits installierte Command Line Tools erkennen.
* [ ] Bereits vorhandene Config erkennen.
* [ ] PostgreSQL-Data-Directory nicht erneut initialisieren.
* [ ] Vorhandene SSH-/GPG-Keys nicht überschreiben.
* [ ] Fehler verständlich ausgeben.
* [ ] Am Ende klare nächste Schritte anzeigen.

---

# 53. README neu strukturieren

README sollte enthalten:

* [ ] Voraussetzungen.
* [ ] Installation.
* [ ] Bootstrap.
* [ ] Update.
* [ ] Rebuild.
* [ ] Rollback.
* [ ] PostgreSQL.
* [ ] pgvector.
* [ ] Python/uv.
* [ ] Polars.
* [ ] ArcticDB.
* [ ] Ollama.
* [ ] Secrets.
* [ ] Troubleshooting.
* [ ] macOS-Upgrade-Hinweise.

---

# 54. Update-Workflow dokumentieren

Beispiel:

```bash
nix flake update
sudo darwin-rebuild switch --flake .#private-macbook
```

* [ ] Update-Script bauen oder vorhandenes Script überarbeiten.
* [ ] Vor Update `git status` prüfen.
* [ ] Lockfile committen.
* [ ] Rollback dokumentieren.

---

# 55. Flake Checks hinzufügen

* [ ] `nix flake check` lauffähig machen.
* [ ] Konfiguration evaluieren lassen.
* [ ] Format-Check ergänzen.
* [ ] Keine kaputten Packages im normalen Build.
* [ ] Optional GitHub Actions später ergänzen.

---

# 56. Nix Formatter modernisieren

Aktuell `nixpkgs-fmt`.

* [ ] Prüfen, ob `nixfmt`/`nixfmt-rfc-style` verwendet werden soll.
* [ ] Einen Formatter festlegen.
* [ ] `formatter.<system>` im Flake definieren.

Danach:

```bash
nix fmt
```

---

# 57. Nix Development Shell optional ergänzen

Optional eine Repo-DevShell:

```text
nix develop
```

Enthalten:

* [ ] Nix Formatter
* [ ] Git
* [ ] Shellcheck
* [ ] jq
* [ ] ggf. pre-commit

---

# 58. Pre-commit Hooks optional ergänzen

* [ ] Nix formatieren.
* [ ] Shell-Scripts mit ShellCheck prüfen.
* [ ] Secrets mit Gitleaks prüfen.
* [ ] `gitleaks` ist bereits vorhanden.
* [ ] Keine `.env`-Dateien committen.

---

# 59. Arbeitsreste im gesamten Repository suchen

Suchen nach:

```bash
grep -Rni "risclog" .
grep -Rni "fcio" .
grep -Rni "gocept" .
grep -Rni "kravag" .
grep -Rni "volkswagen" .
grep -Rni "vwfs" .
grep -Rni "redmine" .
grep -Rni "/etc/local" .
grep -Rni "/opt/nixpkgs" .
grep -Rni "/nix/store" .
```

* [ ] Jeden Treffer bewerten.
* [ ] Firmenbezug entfernen.
* [ ] Alte Pfade entfernen.
* [ ] Secrets/Lizenzen entfernen.

---

# 60. Git-Historie auf Secrets prüfen

Da im bisherigen Setup eine FakeS3-License-ID vorhanden ist:

* [ ] Prüfen, ob es sich um ein echtes Secret handelt.
* [ ] Falls ja: Secret rotieren.
* [ ] Falls nötig Git-Historie bereinigen.
* [ ] Gitleaks über die gesamte History laufen lassen.

```bash
gitleaks git .
```

---

# 61. PostgreSQL Backup einrichten

Für private lokale Daten:

* [ ] Backup-Verzeichnis bestimmen.
* [ ] `pg_dumpall` oder einzelne `pg_dump`s verwenden.
* [ ] Optional tägliches lokales Backup.
* [ ] Backup ggf. über Time Machine sichern.
* [ ] Große Development-Datenbanken bewusst ausschließen.

---

# 62. ArcticDB Backup festlegen

Bei lokalem LMDB:

* [ ] Datenverzeichnis kennen.
* [ ] Entscheiden, ob Time Machine es sichern soll.
* [ ] Nicht gleichzeitig laufende Datenbankdateien blind synchronisieren.
* [ ] Für wichtige Daten Export-/Backup-Strategie verwenden.

---

# 63. Time Machine berücksichtigen

* [ ] Nix Store nicht als einzige Wiederherstellungsquelle betrachten.
* [ ] Repository extern bei GitHub sichern.
* [ ] Datenbanken separat sichern.
* [ ] SSH-/GPG-/1Password-Zugang sicherstellen.
* [ ] Restore-Anleitung im README aktualisieren.

---

# 64. macOS Major Update testen

Nach jedem größeren macOS-Update:

* [ ] Nix-Daemon prüfen.
* [ ] nix-darwin rebuild prüfen.
* [ ] Home Manager prüfen.
* [ ] PostgreSQL starten.
* [ ] pgvector laden.
* [ ] Ollama starten.
* [ ] Docker/OrbStack/Colima prüfen.
* [ ] SSH-Agent prüfen.
* [ ] Git-Signing prüfen.

---

# 65. Finale Zielstruktur

Vorschlag:

```text
macos-nix-setup/
├── flake.nix
├── flake.lock
├── README.md
├── install.sh
│
├── hosts/
│   └── private-macbook/
│       └── default.nix
│
├── darwin/
│   ├── default.nix
│   ├── macos-defaults.nix
│   └── services/
│       ├── postgresql.nix
│       ├── redis.nix
│       └── nginx.nix
│
├── home-manager/
│   ├── default.nix
│   └── modules/
│       ├── common.nix
│       ├── shell.nix
│       ├── git.nix
│       ├── ssh.nix
│       ├── python.nix
│       ├── node.nix
│       ├── ai.nix
│       ├── databases.nix
│       └── documents.nix
│
├── scripts/
│   ├── update-nix
│   ├── reset-testdb
│   └── clean-repo
│
└── examples/
    └── data-playground/
        ├── pyproject.toml
        └── README.md
```

---

# 66. Empfohlene Priorisierung

## Phase 1 – Arbeitsrechner entkoppeln

* [ ] Firmen-SSH-Konfiguration entfernen.
* [ ] Firmen-Git-Konfiguration entfernen.
* [ ] Firmendomains entfernen.
* [ ] Lizenz-/Secret-Reste entfernen.
* [ ] Benutzer/Hostname zentralisieren.
* [ ] README privat machen.

## Phase 2 – Nix-Struktur aufräumen

* [ ] Flake vereinfachen.
* [ ] Home Manager in nix-darwin integrieren.
* [ ] `common.nix` modularisieren.
* [ ] alte Packages entfernen.
* [ ] Hardcoded Store-Pfade entfernen.
* [ ] `/opt/nixpkgs`-Abhängigkeit entfernen.

## Phase 3 – Datenbank-Stack

* [ ] PostgreSQL-Modul bauen.
* [ ] Datenverzeichnis umstellen.
* [ ] pgvector integrieren.
* [ ] PostgreSQL Smoke-Test.
* [ ] pgvector Smoke-Test.
* [ ] Backup definieren.

## Phase 4 – Python/Data Stack

* [ ] Python modernisieren.
* [ ] `uv` als Standard festlegen.
* [ ] Polars testen.
* [ ] ConnectorX testen.
* [ ] ADBC optional testen.
* [ ] ArcticDB testen.
* [ ] gemeinsames Data-Playground-Projekt anlegen.

## Phase 5 – AI Stack

* [ ] Ollama testen.
* [ ] Embedding-Modell auswählen.
* [ ] Ollama + pgvector integrieren.
* [ ] Polars-Ingestion testen.
* [ ] kleine lokale RAG-Demo bauen.

## Phase 6 – Komfort und Wartbarkeit

* [ ] macOS Defaults deklarativ verwalten.
* [ ] Homebrew-/GUI-App-Strategie festlegen.
* [ ] Install-Script idempotent machen.
* [ ] Flake Checks hinzufügen.
* [ ] Formatter einrichten.
* [ ] Gitleaks/Pre-commit ergänzen.
* [ ] Restore-Dokumentation aktualisieren.

---

# 67. Definition of Done

Das private Setup ist fertig, wenn:

* [ ] keine Firmen-Domains mehr enthalten sind.
* [ ] keine Firmen-SSH-Hosts mehr enthalten sind.
* [ ] keine Arbeits-Git-Konfiguration mehr enthalten ist.
* [ ] keine Secrets/Lizenzkeys im Repository liegen.
* [ ] keine hardcodierten `/nix/store`-Pfade existieren.
* [ ] keine unnötigen `/opt/nixpkgs`-Abhängigkeiten existieren.
* [ ] keine Python-2-Abhängigkeit mehr existiert.
* [ ] das Setup auf einem frischen Apple-Silicon-Mac reproduzierbar installierbar ist.
* [ ] `nix flake check` funktioniert.
* [ ] `darwin-rebuild switch` funktioniert.
* [ ] Shell funktioniert.
* [ ] Git funktioniert.
* [ ] GitHub SSH funktioniert.
* [ ] Git-Signing funktioniert.
* [ ] PostgreSQL automatisch startet.
* [ ] `psql` funktioniert.
* [ ] pgvector geladen werden kann.
* [ ] Vector Similarity Search funktioniert.
* [ ] `uv` funktioniert.
* [ ] Polars importiert werden kann.
* [ ] Polars aus PostgreSQL lesen kann.
* [ ] ArcticDB lokal schreiben und lesen kann.
* [ ] Ollama funktioniert.
* [ ] ein lokaler Ollama → pgvector Workflow funktioniert.
* [ ] wichtige Daten gesichert werden.
* [ ] README Installation, Update und Restore vollständig erklärt.

## Ziel-Stack am Ende

```text
Private MacBook
│
├── macOS
│   └── nix-darwin
│
├── Home Manager
│   ├── zsh
│   ├── git
│   ├── ssh
│   ├── CLI tools
│   └── development tools
│
├── PostgreSQL
│   └── pgvector
│
├── Python
│   └── uv
│       ├── Polars
│       ├── ConnectorX
│       ├── ADBC PostgreSQL
│       └── ArcticDB
│
├── Ollama
│
├── Optional
│   ├── Redis
│   ├── nginx
│   ├── Docker / OrbStack / Colima
│   └── MinIO
│
└── Secrets
    └── 1Password / sops-nix / agenix
```
