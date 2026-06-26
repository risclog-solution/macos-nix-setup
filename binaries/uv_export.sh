#!/bin/bash

set -e
uv export --format requirements.txt --no-dev --no-hashes --no-header --no-annotate
