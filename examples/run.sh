#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_machine_distill info
PYTHONPATH=src python -m gbt_machine_distill check --payload '{}'
PYTHONPATH=src python -m gbt_machine_distill run   --payload '{}'
