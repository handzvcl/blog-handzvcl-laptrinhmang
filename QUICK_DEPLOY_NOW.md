# ⚡ DEPLOY NGAY - 3 BƯỚC

## ✅ PRE-CHECK (30 giây)

```powershell
# 1. Check .nojekyll
Test-Path static\.nojekyll  # Phải: True

# 2. Check baseURL
Get-Content hugo.yaml | Select-String "baseURL"
# Phải: baseURL: "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"

# 3. Test build
hugo --cleanDestinationDir --minify
# Phải: Pages: 69, No errors
```

---

## 🚀 DEPLOY (3 lệnh)

```powershell
# 1. Commit
git add .
git commit -m "🚀 Deploy with .nojekyll and correct baseURL"

# 2. Push
git push origin main

# 3. Wait & Test (3-4 phút)
Start-Process "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"
```

---

## ⚙️ GitHub Pages Setting (QUAN TRỌNG!)

**VÀO:** https://github.com/handzvcl/blog-handzvcl-laptrinhmang/settings/pages

**CHECK:**

```
Source: [GitHub Actions]  ← PHẢI CHỌN CÁI NÀY!
        (KHÔNG chọn "Deploy from a branch")
```

---

## ✅ Test Checklist

Sau 3-4 phút, check:

- [ ] https://handzvcl.github.io/blog-handzvcl-laptrinhmang/ → 200 OK
- [ ] Avatar hiển thị
- [ ] CSS loaded
- [ ] Blog posts work

---

## 🔥 Nếu vẫn 404:

1. **Check Actions:** https://github.com/handzvcl/blog-handzvcl-laptrinhmang/actions

   - Workflow phải ✅ (green)

2. **Check Pages Source:** Settings → Pages

   - Phải là "GitHub Actions"

3. **Clear cache:** Ctrl + Shift + R

---

**RUN 3 COMMANDS ABOVE NOW!**

See **DEPLOY_STEP_BY_STEP_FINAL.md** for detailed guide.
