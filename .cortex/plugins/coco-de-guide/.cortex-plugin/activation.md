# coco-de-guide

Project plugin for the dbt TPC-H transformation project (`DEMO_DB.TPCH_TRANSFORMED`, warehouse `DEMO_WH`).

Includes:
- **Skills** (`./skills`): project workflows such as creating new dbt models that follow the conventions in `AGENTS.md`.
- **Agents** (`./agents`): subagents for delegated dbt tasks.
- **Hooks** (defined in `plugin.json`): a PreToolUse hook (`hooks/validate-bash.sh`) that blocks dbt commands targeting prod. Requires `bash` on PATH (on Windows, add Git for Windows' `bin` directory to PATH and restart CoCo Desktop).
