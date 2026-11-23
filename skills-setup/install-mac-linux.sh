#!/usr/bin/env bash
# Cài bộ skill Claude Code (coding + dựng video bằng AI) — macOS / Linux
# Chạy:  bash install-mac-linux.sh
set -u
OK=(); FAIL=()
run() { echo; echo "▶ $*"; if "$@"; then OK+=("$*"); else FAIL+=("$*"); fi; }
need() { command -v "$1" >/dev/null 2>&1; }

echo "== 1. Kiểm tra công cụ nền =="
if [[ "$(uname)" == "Darwin" ]]; then
  need brew || { echo "Cần Homebrew: https://brew.sh"; exit 1; }
  need node || run brew install node@22
  need ffmpeg || run brew install ffmpeg
  need git || run brew install git
else
  need ffmpeg || run sudo apt-get install -y ffmpeg
  need git || run sudo apt-get install -y git
  need node || echo "⚠ Cần Node.js 22+: https://nodejs.org (hoặc dùng nvm)"
fi
need claude || run npm install -g @anthropic-ai/claude-code
node -v; ffmpeg -version | head -1

echo "== 2. Plugin Claude Code (tier S+ / A) =="
run claude plugin marketplace add anthropics/claude-plugins-official
run claude plugin install superpowers@claude-plugins-official
run claude plugin marketplace add anthropics/skills
run claude plugin install example-skills@anthropic-agent-skills   # Skill Creator, Frontend Design...
run claude plugin marketplace add heygen-com/hyperframes
run claude plugin install hyperframes@hyperframes
run claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
run claude plugin install ui-ux-pro-max@ui-ux-pro-max-skill
run claude plugin marketplace add JuliusBrussee/caveman
run claude plugin install caveman@caveman
run claude plugin marketplace add blader/humanizer
run claude plugin install humanizer@humanizer
run claude plugin marketplace add DietrichGebert/ponytail
run claude plugin install ponytail@ponytail
run claude plugin marketplace add addyosmani/agent-skills
run claude plugin install agent-skills@addy-agent-skills

echo "== 3. Skill dạng thư mục (tier B) =="
run npx -y skills add remotion-dev/skills -g -a claude-code -y
run npx -y skills add coreyhaines31/marketingskills -g -a claude-code -y
run npx -y skills add vercel-labs/agent-skills --skill vercel-react-best-practices -g -a claude-code -y

echo "== 4. Công cụ đi kèm =="
run npm install -g @playwright/cli@latest
run npx -y playwright install chromium
if need pipx; then run pipx install graphifyy; else run python3 -m pip install --user graphifyy; fi
run graphify install

echo "== 5. Herk Edit Kit (dựng video từ footage của bạn) =="
KIT="$HOME/herk-edit-kit"
[[ -d "$KIT" ]] || run git clone https://github.com/nateherkai/herk-edit-kit.git "$KIT"
( cd "$KIT" && run npm ci && run npm run setup )

echo; echo "================ KẾT QUẢ ================"
echo "✅ Thành công: ${#OK[@]}"; echo "❌ Lỗi: ${#FAIL[@]}"
for f in "${FAIL[@]}"; do echo "   - $f"; done
echo "Khởi động lại Claude Code rồi gõ /plugin để kiểm tra."
