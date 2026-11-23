# Cài bộ skill Claude Code (coding + dựng video bằng AI) — Windows
# Chạy trong PowerShell:  powershell -ExecutionPolicy Bypass -File .\install-windows.ps1
$ok = @(); $fail = @()
function Run([string]$cmd) {
  Write-Host "`n> $cmd" -ForegroundColor Cyan
  cmd /c $cmd
  if ($LASTEXITCODE -eq 0) { $script:ok += $cmd } else { $script:fail += $cmd }
}
function Need($n) { [bool](Get-Command $n -ErrorAction SilentlyContinue) }

Write-Host "== 1. Kiem tra cong cu nen =="
if (-not (Need node))   { Run "winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements" }
if (-not (Need ffmpeg)) { Run "winget install -e --id Gyan.FFmpeg --accept-source-agreements --accept-package-agreements" }
if (-not (Need git))    { Run "winget install -e --id Git.Git --accept-source-agreements --accept-package-agreements" }
$env:Path = [Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [Environment]::GetEnvironmentVariable("Path","User")
if (-not (Need claude)) { Run "npm install -g @anthropic-ai/claude-code" }

Write-Host "== 2. Plugin Claude Code (tier S+ / A) =="
Run "claude plugin marketplace add anthropics/claude-plugins-official"
Run "claude plugin install superpowers@claude-plugins-official"
Run "claude plugin marketplace add anthropics/skills"
Run "claude plugin install example-skills@anthropic-agent-skills"
Run "claude plugin marketplace add heygen-com/hyperframes"
Run "claude plugin install hyperframes@hyperframes"
Run "claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill"
Run "claude plugin install ui-ux-pro-max@ui-ux-pro-max-skill"
Run "claude plugin marketplace add JuliusBrussee/caveman"
Run "claude plugin install caveman@caveman"
Run "claude plugin marketplace add blader/humanizer"
Run "claude plugin install humanizer@humanizer"
Run "claude plugin marketplace add DietrichGebert/ponytail"
Run "claude plugin install ponytail@ponytail"
Run "claude plugin marketplace add addyosmani/agent-skills"
Run "claude plugin install agent-skills@addy-agent-skills"

Write-Host "== 3. Skill dang thu muc (tier B) =="
Run "npx -y skills add remotion-dev/skills -g -a claude-code -y"
Run "npx -y skills add coreyhaines31/marketingskills -g -a claude-code -y"
Run "npx -y skills add vercel-labs/agent-skills --skill vercel-react-best-practices -g -a claude-code -y"

Write-Host "== 4. Cong cu di kem =="
Run "npm install -g @playwright/cli@latest"
Run "npx -y playwright install chromium"
Run "python -m pip install --user graphifyy"
Run "graphify install"

Write-Host "== 5. Herk Edit Kit =="
$kit = Join-Path $HOME "herk-edit-kit"
if (-not (Test-Path $kit)) { Run "git clone https://github.com/nateherkai/herk-edit-kit.git `"$kit`"" }
Push-Location $kit; Run "npm ci"; Run "npm run setup"; Pop-Location

Write-Host "`n================ KET QUA ================"
Write-Host "Thanh cong: $($ok.Count)" -ForegroundColor Green
Write-Host "Loi: $($fail.Count)" -ForegroundColor Red
$fail | ForEach-Object { Write-Host "  - $_" }
Write-Host "Khoi dong lai Claude Code roi go /plugin de kiem tra."
