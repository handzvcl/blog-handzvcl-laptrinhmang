# 🚀 HƯỚNG DẪN DEPLOY GITHUB PAGES - TỪNG BƯỚC CHI TIẾT

## ✅ KIỂM TRA ĐÃ HOÀN TẤT

- ✅ Hugo build thành công (69 pages)
- ✅ BaseURL đúng: `https://handzvcl.github.io/blog-handzvcl-laptrinhmang/`
- ✅ File `.nojekyll` đã tạo
- ✅ Workflow file đúng
- ✅ All paths trong HTML đúng
- ✅ Avatar và CSS đã OK

---

## 📋 CÁC BƯỚC DEPLOY

### BƯỚC 1: Commit Tất Cả Changes

```bash
# Di chuyển vào thư mục project (nếu chưa ở đó)
cd D:\DATA\LapTrinhMang\DA\blog-handzvcl-laptrinhmang

# Kiểm tra status
git status

# Add tất cả files
git add .

# Commit với message rõ ràng
git commit -m "🚀 Complete blog setup - ready to deploy

- Fix Hugo version to latest (>= 0.146.0)
- Add .nojekyll to disable Jekyll processing
- Correct baseURL for GitHub Pages
- Add missing google_analytics.html partial
- Custom CSS for avatar styling
- All 69 pages build successfully"
```

### BƯỚC 2: Push Lên Branch Main

**QUAN TRỌNG:** GitHub Actions workflow chỉ chạy khi push lên branch `main`!

Hiện tại bạn đang ở branch **FixAvatar**, cần merge vào **main**:

```bash
# Kiểm tra branch hiện tại
git branch

# Checkout sang branch main
git checkout main

# Merge changes từ FixAvatar
git merge FixAvatar

# Push lên GitHub
git push origin main
```

**HOẶC** nếu muốn push trực tiếp từ FixAvatar lên main:

```bash
# Push FixAvatar lên remote main
git push origin FixAvatar:main --force
```

### BƯỚC 3: Enable GitHub Pages

1. **Truy cập Repository Settings:**

   - Vào: https://github.com/handzvcl/blog-handzvcl-laptrinhmang
   - Click tab **Settings**

2. **Tìm GitHub Pages:**

   - Scroll xuống sidebar bên trái
   - Click **Pages**

3. **Cấu hình Source:**

   - **Source:** Chọn `GitHub Actions` (KHÔNG phải Deploy from a branch)
   - Click **Save** nếu có button

   ![image](https://docs.github.com/assets/cb-47267/mw-1440/images/help/pages/configure-github-actions.webp)

### BƯỚC 4: Kiểm Tra Workflow

1. **Vào Actions Tab:**

   - Vào: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/actions

2. **Xem Workflow Runs:**

   - Bạn sẽ thấy "Deploy Hugo to GitHub Pages" đang chạy
   - Status: 🟡 Yellow (đang chạy) → 🟢 Green (thành công)

3. **Nếu KHÔNG thấy workflow:**

   - Có thể workflow chưa được trigger
   - Push lại một commit:
     ```bash
     git commit --allow-empty -m "Trigger workflow"
     git push origin main
     ```

4. **Nếu workflow FAILED (🔴 Red):**
   - Click vào workflow run
   - Xem logs để tìm lỗi
   - Thường là Hugo version hoặc build error

### BƯỚC 5: Đợi Deploy Hoàn Tất

**Timeline:**

- Build: 1-2 phút
- Deploy: 30-60 giây
- **Total: ~3 phút**

Bạn sẽ thấy:

1. ✅ **build** job completed
2. ✅ **deploy** job completed
3. ✅ Green checkmark

### BƯỚC 6: Truy Cập Website

Sau khi workflow hoàn tất, truy cập:

**🔗 https://handzvcl.github.io/blog-handzvcl-laptrinhmang/**

Bạn sẽ thấy trang chủ với:

- ✅ Avatar bo tròn
- ✅ Tên và subtitle
- ✅ Social icons
- ✅ Buttons: Blog, Tags, Archive

---

## 🔍 TROUBLESHOOTING

### ❌ Vẫn bị 404 sau khi deploy?

#### Check 1: Workflow có chạy không?

```
Vào: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/actions
Kiểm tra: Có workflow runs không? Status gì?
```

#### Check 2: GitHub Pages đã enable chưa?

```
Vào: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/settings/pages
Kiểm tra: Source = "GitHub Actions"?
```

#### Check 3: Branch đúng chưa?

```
git branch
# Phải thấy: * main (đang ở main)
```

#### Check 4: Đợi đủ thời gian chưa?

```
Đợi ít nhất 5 phút sau khi workflow xong
Clear browser cache: Ctrl + Shift + R
Thử incognito mode
```

### ❌ Workflow failed?

**Lỗi Hugo Version:**

```
ERROR => hugo v0.146.0 or greater is required
```

**Fix:** Workflow đã dùng `hugo-version: "latest"`, nên không lỗi này nữa

**Lỗi Submodule:**

```
fatal: No url found for submodule path 'themes/PaperMod'
```

**Fix:**

```bash
git submodule update --init --recursive
git add .gitmodules themes/
git commit -m "Fix submodule"
git push origin main
```

**Lỗi Missing Files:**

```
ERROR: File not found
```

**Fix:**

```bash
# Verify files tồn tại
ls static/.nojekyll
ls layouts/partials/google_analytics.html
```

### ❌ CSS không load, site trông xấu?

**Nguyên nhân:** Jekyll đã xử lý files (thiếu .nojekyll)

**Fix:**

```bash
# Verify .nojekyll exists
cat static/.nojekyll  # Should be empty file

# Rebuild và push lại
hugo --cleanDestinationDir --minify
git add public/ static/.nojekyll
git commit -m "Add .nojekyll"
git push origin main
```

---

## 📝 CHECKLIST CUỐI CÙNG

Trước khi deploy, check list này:

- [ ] **Branch main** có latest code
- [ ] **File `.nojekyll`** tồn tại trong `static/`
- [ ] **Workflow file** đúng trong `.github/workflows/gh-pages.yml`
- [ ] **BaseURL** đúng trong `hugo.yaml`
- [ ] **Theme submodule** đã init: `git submodule status`
- [ ] **Build local** thành công: `hugo --minify`
- [ ] **GitHub Pages** đã enable trong Settings → Pages
- [ ] **Source** = "GitHub Actions" (KHÔNG phải branch)

---

## 🎯 QUICK COMMANDS (Copy & Paste)

```bash
# 1. Commit all changes
git add .
git commit -m "🚀 Ready to deploy"

# 2. Merge to main and push
git checkout main
git merge FixAvatar
git push origin main

# 3. Verify workflow
# Vào: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/actions

# 4. Wait 3 minutes

# 5. Open site
# https://handzvcl.github.io/blog-handzvcl-laptrinhmang/
```

---

## 📞 NẾU VẪN LỖI SAU TẤT CẢ

**Kiểm tra logs chi tiết:**

1. Workflow logs:
   https://github.com/handzvcl/blog-handzvcl-laptrinhmang/actions

2. Browser DevTools (F12):

   - Console tab: Có lỗi JavaScript?
   - Network tab: Files nào 404?

3. GitHub Pages status:
   https://github.com/handzvcl/blog-handzvcl-laptrinhmang/settings/pages

**Thông tin cần:**

- Workflow status: Success/Failed?
- Browser error messages
- Screenshot của 404 page

---

## ✅ SUCCESS INDICATORS

Sau khi deploy thành công, bạn sẽ thấy:

✅ **GitHub Actions:**

- Build job: Green ✓
- Deploy job: Green ✓

✅ **Settings → Pages:**

- "Your site is live at https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"

✅ **Browser:**

- Trang chủ hiển thị đẹp
- Avatar bo tròn
- CSS load đầy đủ
- Links hoạt động

---

**🎉 DONE! Làm theo từng bước trên và site sẽ hoạt động!**
