# 🎨 Portfolio Website - Phan Trường Hân

Modern, responsive portfolio website built with pure HTML, CSS, and JavaScript.

## 🌐 Live Demo

**https://handzvcl.github.io/blog-handzvcl-laptrinhmang/**

## ✨ Features

### Design

- 🎨 **Modern UI/UX** - Clean, professional design
- 🌓 **Dark/Light Mode** - Theme toggle with localStorage
- 💫 **Smooth Animations** - Particle effects, scroll animations, transitions
- 📱 **Fully Responsive** - Works on all devices
- ⚡ **Fast Loading** - Optimized performance

### Pages

- **Home** - Hero with animated particles, skills preview, achievements
- **About** - Bio, skills with progress bars, certificates timeline, education
- **Contact** - Contact form, info cards, social links

### Technical

- ✅ Pure HTML/CSS/JS (no frameworks)
- ✅ CSS Grid & Flexbox layouts
- ✅ Canvas particle animation
- ✅ Intersection Observer for scroll animations
- ✅ Form validation & submission handling
- ✅ LocalStorage for theme preference
- ✅ SEO optimized (meta tags, semantic HTML)

## 🚀 Quick Start

### Option 1: View Locally

```bash
# Clone the repository
git clone https://github.com/handzvcl/blog-handzvcl-laptrinhmang.git
cd blog-handzvcl-laptrinhmang

# Open in browser
# Just open index.html in your browser
# Or use a local server:
python -m http.server 8000
# Then visit: http://localhost:8000
```

### Option 2: Deploy to GitHub Pages

Already configured! Just push to `main` branch and GitHub Actions will deploy automatically.

## 📁 Project Structure

```
blog-handzvcl-laptrinhmang/
├── index.html              # Homepage
├── about.html              # About page
├── contact.html            # Contact page
├── css/
│   ├── variables.css       # CSS variables & design system
│   ├── reset.css           # CSS reset
│   ├── components.css      # Reusable components
│   ├── layout.css          # Layout & navigation
│   ├── main.css            # Main styles
│   ├── about.css           # About page styles
│   └── contact.css         # Contact page styles
├── js/
│   └── app.js              # Main JavaScript
├── data/
│   └── certificates.json   # Certificates data
├── static/
│   └── images/
│       └── avatar.jpg      # Profile image
└── .github/
    └── workflows/
        └── gh-pages.yml    # GitHub Actions deployment
```

## 🎨 Customization

### Colors

Edit `css/variables.css`:

```css
:root {
  --primary: #667eea; /* Main color */
  --secondary: #764ba2; /* Secondary color */
  --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
```

### Content

- **Profile Info**: Edit HTML files directly
- **Certificates**: Update `data/certificates.json`
- **Social Links**: Update URLs in HTML files

### Images

- Replace `static/images/avatar.jpg` with your photo
- Update certificate placeholder images

## 🛠 Technologies

- **HTML5** - Semantic markup
- **CSS3** - Modern styling with Grid, Flexbox, Variables
- **JavaScript (ES6+)** - Vanilla JS, no frameworks
- **Canvas API** - Particle animations
- **Intersection Observer** - Scroll animations
- **LocalStorage** - Theme persistence

## 🌟 Key Features

### 1. Animated Particle Background

Canvas-based particle system with interactive connections

### 2. Scroll Animations

Elements fade in as you scroll using Intersection Observer

### 3. Dark Mode

Smooth theme toggle with system preference detection

### 4. Contact Form

Real-time validation with loading states

### 5. Skills Progress Bars

Animated skill levels on scroll

### 6. Certificates Timeline

Beautiful vertical timeline with hover effects

## 📱 Browser Support

- ✅ Chrome (latest)
- ✅ Firefox (latest)
- ✅ Safari (latest)
- ✅ Edge (latest)
- ✅ Mobile browsers

## 🚀 Performance

- **First Contentful Paint**: < 1s
- **Largest Contentful Paint**: < 2s
- **Time to Interactive**: < 2s
- **Lighthouse Score**: 95+

## 📄 License

MIT License - feel free to use for your own portfolio!

## 👤 Author

**Phan Trường Hân**

- GitHub: [@handzvcl](https://github.com/handzvcl)
- University: HUTECH - Computer Science

## 🙏 Acknowledgments

- Design inspiration from modern portfolio websites
- Icons from SVG libraries
- Fonts from Google Fonts (Inter)

---

⭐ **Star this repo if you find it useful!**
