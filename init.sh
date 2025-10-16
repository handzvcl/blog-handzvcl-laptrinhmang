#!/bin/bash
# ===================================
# Script khởi tạo blog Hugo
# Blog Lập Trình Mạng
# ===================================

echo -e "\033[1;36m🚀 Đang khởi tạo blog Hugo...\033[0m"
echo ""

# 1. Kiểm tra Git
echo -e "\033[1;33m📌 Bước 1: Kiểm tra Git...\033[0m"
if ! command -v git &> /dev/null; then
    echo -e "\033[1;31m❌ Git chưa được cài đặt!\033[0m"
    echo -e "\033[1;33m📥 Cài Git: sudo apt install git (Ubuntu) hoặc brew install git (macOS)\033[0m"
    exit 1
fi
echo -e "\033[1;32m✅ Git đã cài đặt\033[0m"

# 2. Kiểm tra Hugo
echo ""
echo -e "\033[1;33m📌 Bước 2: Kiểm tra Hugo...\033[0m"
if ! command -v hugo &> /dev/null; then
    echo -e "\033[1;31m❌ Hugo chưa được cài đặt!\033[0m"
    echo -e "\033[1;33m📥 Cài Hugo:\033[0m"
    echo -e "\033[1;33m   - Ubuntu: sudo snap install hugo\033[0m"
    echo -e "\033[1;33m   - macOS:  brew install hugo\033[0m"
    echo -e "\033[1;33m   - Hoặc:   https://gohugo.io/installation/\033[0m"
    exit 1
fi
HUGO_VERSION=$(hugo version)
echo -e "\033[1;32m✅ $HUGO_VERSION\033[0m"

# 3. Khởi tạo Git repository (nếu chưa có)
echo ""
echo -e "\033[1;33m📌 Bước 3: Khởi tạo Git repository...\033[0m"
if [ ! -d ".git" ]; then
    git init
    echo -e "\033[1;32m✅ Git repository đã được khởi tạo\033[0m"
else
    echo -e "\033[1;32m✅ Git repository đã tồn tại\033[0m"
fi

# 4. Thêm theme PaperMod
echo ""
echo -e "\033[1;33m📌 Bước 4: Tải theme PaperMod...\033[0m"
if [ ! -d "themes/PaperMod" ]; then
    git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
    git submodule update --init --recursive
    echo -e "\033[1;32m✅ Theme PaperMod đã được tải về\033[0m"
else
    echo -e "\033[1;32m✅ Theme PaperMod đã tồn tại\033[0m"
    echo -e "\033[1;33m🔄 Cập nhật theme...\033[0m"
    git submodule update --remote --merge
fi

# 5. Tạo thư mục images (nếu chưa có)
echo ""
echo -e "\033[1;33m📌 Bước 5: Tạo thư mục images...\033[0m"
mkdir -p static/images
echo -e "\033[1;32m✅ Thư mục images đã sẵn sàng\033[0m"

# 6. Tạo file .gitignore bổ sung (nếu cần)
echo ""
echo -e "\033[1;33m📌 Bước 6: Kiểm tra .gitignore...\033[0m"
if [ -f ".gitignore" ]; then
    echo -e "\033[1;32m✅ File .gitignore đã tồn tại\033[0m"
else
    cat > .gitignore << 'EOF'
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
EOF
    echo -e "\033[1;32m✅ File .gitignore đã được tạo\033[0m"
fi

# 7. Commit đầu tiên (nếu chưa có)
echo ""
echo -e "\033[1;33m📌 Bước 7: Tạo commit đầu tiên...\033[0m"
if ! git rev-parse HEAD > /dev/null 2>&1; then
    git add .
    git commit -m "🎉 Initial commit: Blog Lập Trình Mạng"
    echo -e "\033[1;32m✅ Commit đầu tiên đã được tạo\033[0m"
else
    echo -e "\033[1;32m✅ Repository đã có commits\033[0m"
fi

# 8. Hoàn thành
echo ""
echo -e "\033[1;36m============================================\033[0m"
echo -e "\033[1;32m✅ KHỞI TẠO HOÀN TẤT!\033[0m"
echo -e "\033[1;36m============================================\033[0m"
echo ""
echo -e "\033[1;33m📝 BƯỚC TIẾP THEO:\033[0m"
echo ""
echo -e "\033[1;37m1️⃣  Thêm ảnh đại diện:\033[0m"
echo -e "\033[0;37m   Copy ảnh của bạn vào: static/images/avatar.jpg\033[0m"
echo ""
echo -e "\033[1;37m2️⃣  Chạy blog local:\033[0m"
echo -e "\033[1;36m   hugo server -D\033[0m"
echo -e "\033[0;37m   Mở: http://localhost:1313\033[0m"
echo ""
echo -e "\033[1;37m3️⃣  Deploy lên GitHub Pages:\033[0m"
echo -e "\033[0;37m   a. Tạo repo trên GitHub: blog-lap-trinh-mang\033[0m"
echo -e "\033[0;37m   b. Chạy lệnh:\033[0m"
echo -e "\033[1;36m      git remote add origin https://github.com/<username>/blog-lap-trinh-mang.git\033[0m"
echo -e "\033[1;36m      git branch -M main\033[0m"
echo -e "\033[1;36m      git push -u origin main\033[0m"
echo -e "\033[0;37m   c. Settings > Pages > Source: GitHub Actions\033[0m"
echo ""
echo -e "\033[1;37m4️⃣  Cập nhật thông tin cá nhân:\033[0m"
echo -e "\033[1;36m   Sửa file: hugo.yaml\033[0m"
echo -e "\033[0;37m   - baseURL (URL của bạn)\033[0m"
echo -e "\033[0;37m   - params.author (tên của bạn)\033[0m"
echo -e "\033[0;37m   - params.social (GitHub, LinkedIn, Email)\033[0m"
echo ""
echo -e "\033[1;33m📚 Tài liệu hỗ trợ:\033[0m"
echo -e "\033[0;37m   - README.md      : Tổng quan dự án\033[0m"
echo -e "\033[0;37m   - SETUP.md       : Hướng dẫn chi tiết\033[0m"
echo -e "\033[0;37m   - QUICKSTART.md  : Các lệnh nhanh\033[0m"
echo -e "\033[0;37m   - CHEATSHEET.md  : Cheat sheet\033[0m"
echo ""
echo -e "\033[1;32m🎉 Chúc bạn viết blog vui vẻ!\033[0m"
echo ""

