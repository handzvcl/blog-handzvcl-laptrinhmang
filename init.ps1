# ===================================
# Script khởi tạo blog Hugo
# Blog Lập Trình Mạng
# ===================================

Write-Host "🚀 Đang khởi tạo blog Hugo..." -ForegroundColor Cyan
Write-Host ""

# 1. Kiểm tra Git
Write-Host "📌 Bước 1: Kiểm tra Git..." -ForegroundColor Yellow
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git chưa được cài đặt!" -ForegroundColor Red
    Write-Host "📥 Tải Git tại: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}
Write-Host "✅ Git đã cài đặt" -ForegroundColor Green

# 2. Kiểm tra Hugo
Write-Host ""
Write-Host "📌 Bước 2: Kiểm tra Hugo..." -ForegroundColor Yellow
if (-not (Get-Command hugo -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Hugo chưa được cài đặt!" -ForegroundColor Red
    Write-Host "📥 Cài Hugo bằng Chocolatey: choco install hugo-extended -y" -ForegroundColor Yellow
    Write-Host "📥 Hoặc tải tại: https://gohugo.io/installation/windows/" -ForegroundColor Yellow
    exit 1
}
$hugoVersion = hugo version
Write-Host "✅ $hugoVersion" -ForegroundColor Green

# 3. Khởi tạo Git repository (nếu chưa có)
Write-Host ""
Write-Host "📌 Bước 3: Khởi tạo Git repository..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    git init
    Write-Host "✅ Git repository đã được khởi tạo" -ForegroundColor Green
} else {
    Write-Host "✅ Git repository đã tồn tại" -ForegroundColor Green
}

# 4. Thêm theme PaperMod
Write-Host ""
Write-Host "📌 Bước 4: Tải theme PaperMod..." -ForegroundColor Yellow
if (-not (Test-Path "themes/PaperMod")) {
    git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
    git submodule update --init --recursive
    Write-Host "✅ Theme PaperMod đã được tải về" -ForegroundColor Green
} else {
    Write-Host "✅ Theme PaperMod đã tồn tại" -ForegroundColor Green
    Write-Host "🔄 Cập nhật theme..." -ForegroundColor Yellow
    git submodule update --remote --merge
}

# 5. Tạo thư mục images (nếu chưa có)
Write-Host ""
Write-Host "📌 Bước 5: Tạo thư mục images..." -ForegroundColor Yellow
if (-not (Test-Path "static/images")) {
    New-Item -ItemType Directory -Path "static/images" -Force | Out-Null
}
Write-Host "✅ Thư mục images đã sẵn sàng" -ForegroundColor Green

# 6. Tạo file .gitignore bổ sung (nếu cần)
Write-Host ""
Write-Host "📌 Bước 6: Kiểm tra .gitignore..." -ForegroundColor Yellow
if (Test-Path ".gitignore") {
    Write-Host "✅ File .gitignore đã tồn tại" -ForegroundColor Green
} else {
    @"
# Hugo
/public/
/resources/
.hugo_build.lock

# OS
.DS_Store
Thumbs.db

# Editor
.vscode/
.idea/
*.swp
*.swo
*~
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
    Write-Host "✅ File .gitignore đã được tạo" -ForegroundColor Green
}

# 7. Commit đầu tiên (nếu chưa có)
Write-Host ""
Write-Host "📌 Bước 7: Tạo commit đầu tiên..." -ForegroundColor Yellow
$hasCommits = git rev-parse HEAD 2>$null
if (-not $hasCommits) {
    git add .
    git commit -m "🎉 Initial commit: Blog Lập Trình Mạng"
    Write-Host "✅ Commit đầu tiên đã được tạo" -ForegroundColor Green
} else {
    Write-Host "✅ Repository đã có commits" -ForegroundColor Green
}

# 8. Hoàn thành
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "✅ KHỞI TẠO HOÀN TẤT!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📝 BƯỚC TIẾP THEO:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1️⃣  Thêm ảnh đại diện:" -ForegroundColor White
Write-Host "   Copy ảnh của bạn vào: static/images/avatar.jpg" -ForegroundColor Gray
Write-Host ""
Write-Host "2️⃣  Chạy blog local:" -ForegroundColor White
Write-Host "   hugo server -D" -ForegroundColor Cyan
Write-Host "   Mở: http://localhost:1313" -ForegroundColor Gray
Write-Host ""
Write-Host "3️⃣  Deploy lên GitHub Pages:" -ForegroundColor White
Write-Host "   a. Tạo repo trên GitHub: blog-lap-trinh-mang" -ForegroundColor Gray
Write-Host "   b. Chạy lệnh:" -ForegroundColor Gray
Write-Host "      git remote add origin https://github.com/<username>/blog-lap-trinh-mang.git" -ForegroundColor Cyan
Write-Host "      git branch -M main" -ForegroundColor Cyan
Write-Host "      git push -u origin main" -ForegroundColor Cyan
Write-Host "   c. Settings > Pages > Source: GitHub Actions" -ForegroundColor Gray
Write-Host ""
Write-Host "4️⃣  Cập nhật thông tin cá nhân:" -ForegroundColor White
Write-Host "   Sửa file: hugo.yaml" -ForegroundColor Cyan
Write-Host "   - baseURL (URL của bạn)" -ForegroundColor Gray
Write-Host "   - params.author (tên của bạn)" -ForegroundColor Gray
Write-Host "   - params.social (GitHub, LinkedIn, Email)" -ForegroundColor Gray
Write-Host ""
Write-Host "📚 Tài liệu hỗ trợ:" -ForegroundColor Yellow
Write-Host "   - README.md      : Tổng quan dự án" -ForegroundColor Gray
Write-Host "   - SETUP.md       : Hướng dẫn chi tiết" -ForegroundColor Gray
Write-Host "   - QUICKSTART.md  : Các lệnh nhanh" -ForegroundColor Gray
Write-Host "   - CHEATSHEET.md  : Cheat sheet" -ForegroundColor Gray
Write-Host ""
Write-Host "🎉 Chúc bạn viết blog vui vẻ!" -ForegroundColor Green
Write-Host ""

