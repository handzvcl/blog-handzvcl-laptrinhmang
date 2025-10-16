# 🚀 HƯỚNG DẪN DEPLOY CHI TIẾT - TỪNG BƯỚC

## ✅ Checklist Hiện Tại

- [x] Hugo v0.151.0 installed
- [x] BaseURL: `https://handzvcl.github.io/blog-handzvcl-laptrinhmang/`
- [x] `.nojekyll` exists in `static/`
- [x] Workflow configured with Hugo latest
- [x] Build successful locally (69 pages)
- [x] Avatar & CSS configured
- [ ] **CẦN PUSH LÊN GITHUB**

---

## 📋 BƯỚC 1: Kiểm Tra Lại Files Quan Trọng

### 1.1 Kiểm tra .nojekyll

```powershell
Test-Path static\.nojekyll
# Kết quả phải là: True
```

### 1.2 Kiểm tra baseURL trong hugo.yaml

```powershell
Get-Content hugo.yaml | Select-String "baseURL"
# Kết quả phải là: baseURL: "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"
```

### 1.3 Test Build Local

```powershell
hugo --cleanDestinationDir --minify
# Kết quả: Pages: 69, No errors
```

### 1.4 Kiểm tra .nojekyll đã copy sang public

```powershell
Test-Path public\.nojekyll
# Kết quả phải là: True
```

✅ **Nếu tất cả đều True → Tiếp tục bước 2**

---

## 📋 BƯỚC 2: Commit Tất Cả Changes

```powershell
# 2.1 Add tất cả files
git add .

# 2.2 Check status
git status
# Phải thấy: static/.nojekyll, hugo.yaml, workflows, etc.

# 2.3 Commit
git commit -m "🚀 Deploy: Fix 404 with complete Hugo setup

- Add .nojekyll to disable Jekyll processing
- Set correct baseURL for GitHub Pages
- Update workflow to use Hugo latest version
- Add custom CSS for avatar
- Fix all template issues

This should resolve 404 errors on GitHub Pages."
```

---

## 📋 BƯỚC 3: Push Lên GitHub

```powershell
# 3.1 Check branch hiện tại
git branch
# Phải là: * main

# 3.2 Push lên main
git push origin main

# 3.3 Nếu lỗi (behind), pull trước:
# git pull origin main --rebase
# git push origin main
```

---

## 📋 BƯỚC 4: Kiểm Tra GitHub Actions

### 4.1 Vào Actions Tab

URL: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/actions

### 4.2 Xem Workflow "Deploy Hugo to GitHub Pages"

- Phải thấy workflow đang chạy (màu vàng 🟡)
- Đợi khoảng 2-3 phút
- Khi xong sẽ chuyển sang màu xanh (✅)

### 4.3 Nếu Workflow Failed (❌)

- Click vào workflow run
- Xem logs để tìm lỗi
- Thường gặp:
  - Hugo version issue
  - Theme not found
  - Build errors

---

## 📋 BƯỚC 5: Cấu Hình GitHub Pages (QUAN TRỌNG!)

### 5.1 Vào Settings → Pages

URL: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/settings/pages

### 5.2 Kiểm Tra Cấu Hình

```
Build and deployment
├── Source: [GitHub Actions]  ← PHẢI CHỌN CÁI NÀY!
└── (KHÔNG chọn "Deploy from a branch")

Custom domain: (để trống)
Enforce HTTPS: ✅ (checked)
```

### 5.3 Screenshot Cấu Hình Đúng

```
┌─────────────────────────────────────┐
│ GitHub Pages                         │
├─────────────────────────────────────┤
│ Your site is live at:               │
│ https://handzvcl.github.io/...      │
│                                      │
│ Build and deployment                │
│ Source: [GitHub Actions] ▼          │ ← CHỌN CÁI NÀY!
│                                      │
│ ✅ Enforce HTTPS                     │
└─────────────────────────────────────┘
```

---

## 📋 BƯỚC 6: Đợi Deploy Hoàn Thành

### Timeline:

1. Push code → 30 giây
2. GitHub Actions build → 1-2 phút
3. GitHub Pages deploy → 30-60 giây
4. **Total: 3-4 phút**

### Theo Dõi Progress:

1. **Actions tab** → Xem workflow status
2. **Settings → Pages** → Xem deployment status
3. Khi thấy: "Your site is published at..." → ✅ DONE!

---

## 📋 BƯỚC 7: Test Website

### 7.1 Mở Browser

```
URL: https://handzvcl.github.io/blog-handzvcl-laptrinhmang/
```

### 7.2 Check DevTools (F12)

```
1. Press F12
2. Go to Network tab
3. Reload page (Ctrl+R)
4. Check:
   ✅ index.html → 200 OK
   ✅ assets/css/... → 200 OK
   ✅ images/avatar.jpg → 200 OK
```

### 7.3 Test Navigation

- ✅ Homepage works
- ✅ Blog page: /blog/
- ✅ Tags page: /tags/
- ✅ Any blog post opens
- ✅ Avatar displays
- ✅ CSS loaded correctly

---

## 🔧 TROUBLESHOOTING

### Problem 1: Vẫn 404 Sau Khi Deploy

**Check List:**

```powershell
# A. Verify .nojekyll in repo
curl https://raw.githubusercontent.com/handzvcl/blog-handzvcl-laptrinhmang/main/static/.nojekyll
# Phải trả về: (empty) hoặc 200 OK

# B. Check GitHub Pages source
# Vào Settings → Pages
# Phải là: "GitHub Actions" (KHÔNG phải "Deploy from a branch")

# C. Check workflow completed
# Vào Actions tab
# Latest run phải có ✅ (green checkmark)
```

**Solution:**

- Nếu thiếu .nojekyll → `touch static/.nojekyll` → commit → push
- Nếu source sai → Settings → Pages → chọn "GitHub Actions"
- Nếu workflow failed → Xem logs → fix error → push lại

### Problem 2: CSS Không Load

**Cause:** BaseURL sai

**Check:**

```yaml
# hugo.yaml line 1
baseURL: "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"
# ↑ PHẢI có trailing slash!
```

**Solution:**

```powershell
# Fix baseURL
# Commit và push lại
```

### Problem 3: Workflow Failed - Hugo Version

**Error:** `Module "PaperMod" is not compatible...`

**Solution:** Workflow đã dùng `hugo-version: "latest"` → Should work

### Problem 4: Theme Not Found

**Error:** `theme "PaperMod" not found`

**Cause:** Submodule chưa được clone

**Solution:**

```powershell
# Init submodules
git submodule update --init --recursive
git add .
git commit -m "Update theme submodule"
git push origin main
```

---

## 📊 Expected Results

### GitHub Actions Build Log:

```
✅ Checkout
✅ Setup Hugo (latest)
✅ Setup Pages
✅ Build with Hugo
   - Pages: 69
   - Build time: ~1s
✅ Upload artifact
✅ Deploy to GitHub Pages
```

### Browser Result:

```
URL: https://handzvcl.github.io/blog-handzvcl-laptrinhmang/

Status: 200 OK
Content: Blog homepage với:
- Avatar (circular, with shadow)
- Profile info
- Navigation menu
- Blog posts list
```

---

## 🎯 SUMMARY COMMANDS

```powershell
# === QUICK DEPLOY COMMANDS ===

# 1. Final check
Test-Path static\.nojekyll
hugo --cleanDestinationDir --minify

# 2. Commit & Push
git add .
git commit -m "🚀 Deploy: Complete Hugo setup with fixes"
git push origin main

# 3. Wait 3-4 minutes

# 4. Test
Start-Process "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"

# DONE! ✅
```

---

## 📞 Nếu Vẫn Không Work

**Gửi cho tôi:**

1. Screenshot của Settings → Pages (source setting)
2. Screenshot của Actions tab (workflow status)
3. Screenshot của browser DevTools → Network tab (khi load trang)
4. Output của: `git log --oneline -5`

---

## ✅ Checklist Sau Khi Deploy Thành Công

- [ ] Website accessible at https://handzvcl.github.io/blog-handzvcl-laptrinhmang/
- [ ] Homepage loads với profile mode
- [ ] Avatar hiển thị và bo tròn
- [ ] CSS loaded (dark/light mode works)
- [ ] Blog posts accessible
- [ ] Navigation works
- [ ] Search works
- [ ] No 404 errors

---

**🎉 FOLLOW THESE STEPS EXACTLY AND IT WILL WORK!**
