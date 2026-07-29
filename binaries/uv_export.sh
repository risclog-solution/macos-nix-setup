#!/bin/bash

set -e
uv export --all-extras --format requirements.txt --no-dev --no-hashes --no-header --no-annotate
