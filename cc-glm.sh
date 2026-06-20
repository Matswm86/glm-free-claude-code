# cc-glm - launch Claude Code driven by free GLM 5.2 (via ZenMux).
#
# Install:  add  `source /path/to/cc-glm.sh`  to your ~/.bashrc (or ~/.zshrc),
# open a new terminal, then run:  cc-glm
#
# The whole session runs on free GLM 5.2. Every /model tier (opus/sonnet/haiku)
# maps to GLM 5.2 free, because the base URL is per-process. That is also why you
# cannot mix a subscription-Opus session and a GLM session in ONE terminal: run
# `cc-glm` in its own terminal and your normal `claude` (Opus) in another.
#
# The `( )` subshell scopes the exports so they never leak into your Opus shell.

cc-glm() (
  key="${ZENMUX_API_KEY:-$(cat ~/.config/zenmux/key 2>/dev/null)}"
  if [ -z "$key" ]; then
    echo "cc-glm: set \$ZENMUX_API_KEY or write the key to ~/.config/zenmux/key" >&2
    exit 1
  fi
  export ANTHROPIC_BASE_URL="https://zenmux.ai/api/anthropic"
  export ANTHROPIC_AUTH_TOKEN="$key"
  export ANTHROPIC_API_KEY=""
  export ANTHROPIC_DEFAULT_OPUS_MODEL="z-ai/glm-5.2-free"
  export ANTHROPIC_DEFAULT_SONNET_MODEL="z-ai/glm-5.2-free"
  export ANTHROPIC_DEFAULT_HAIKU_MODEL="z-ai/glm-5.2-free"
  claude "$@"
)
