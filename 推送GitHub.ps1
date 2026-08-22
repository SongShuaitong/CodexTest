# 一键推送到 GitHub
# 目标仓库: https://github.com/SongShuaitong/CodexTest.git
$repo = "D:\Codex++\GitTest"
$url  = "https://github.com/SongShuaitong/CodexTest.git"
$branch = "master"

Set-Location $repo

Write-Host "=== 1/4 暂存文件 ===" -ForegroundColor Cyan
git add -A
if ($LASTEXITCODE -ne 0) { Write-Host "暂存失败，请重试" -ForegroundColor Red; Read-Host "按回车退出"; exit 1 }

Write-Host "=== 2/4 创建提交 ===" -ForegroundColor Cyan
git commit -m "Initial commit: 初始化仓库"
if ($LASTEXITCODE -ne 0) {
  Write-Host "注意：没有新的提交内容，继续执行推送" -ForegroundColor Yellow
}

Write-Host "=== 3/4 配置远程仓库 ===" -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin $url
if ($LASTEXITCODE -ne 0) { Write-Host "远程仓库配置失败" -ForegroundColor Red; Read-Host "按回车退出"; exit 1 }
Write-Host "远程地址: $url"

Write-Host "=== 4/4 推送到 GitHub ===" -ForegroundColor Cyan
Write-Host "如果弹出 GitHub 登录窗口，请按提示完成登录..." -ForegroundColor Yellow
git push -u origin $branch
if ($LASTEXITCODE -eq 0) {
  Write-Host ""
  Write-Host "推送成功！" -ForegroundColor Green
  Write-Host "仓库地址: https://github.com/SongShuaitong/CodexTest"
} else {
  Write-Host ""
  Write-Host "推送失败（错误码 $LASTEXITCODE）" -ForegroundColor Red
  Write-Host "常见原因：1) 未登录 GitHub 或登录失败  2) GitHub 上该仓库已有不同内容"
}

Read-Host "按回车键退出"