---
title: "Bảo mật cơ bản: HTTPS, CORS, CSRF cho lập trình mạng"
date: 2024-10-14
draft: false
tags: ["Security", "HTTPS", "CORS", "CSRF", "Networking"]
categories: ["Java", "JavaScript"]
summary: "Tìm hiểu các khái niệm bảo mật quan trọng: HTTPS, CORS, CSRF và cách áp dụng trong lập trình mạng."
cover:
  image: "/images/covers/security-https-cors-csrf.jpg"
  alt: "Web security concepts"
  caption: "HTTPS, CORS, CSRF - Bảo mật web"
---

## Giới thiệu

Bảo mật là yếu tố quan trọng trong lập trình mạng. Ba khái niệm cơ bản mà mọi developer cần hiểu:

1. **HTTPS** - Mã hóa dữ liệu truyền tải
2. **CORS** - Kiểm soát cross-origin requests
3. **CSRF** - Ngăn chặn cross-site request forgery

## HTTPS (HTTP Secure)

### HTTPS là gì?

**HTTPS** = HTTP + TLS/SSL encryption. Mã hóa dữ liệu giữa client và server để:

- ✅ Bảo mật dữ liệu (confidentiality)
- ✅ Đảm bảo toàn vẹn (integrity)
- ✅ Xác thực server (authentication)

### HTTP vs HTTPS

```
HTTP:
Client ----> [Plain Text] ----> Server
       <---- [Plain Text] <----
       ⚠️ Ai cũng có thể đọc được!

HTTPS:
Client ----> [Encrypted] ----> Server
       <---- [Encrypted] <----
       ✅ Chỉ client & server đọc được
```

### TLS Handshake

```
1. Client Hello
   → Các cipher suites client hỗ trợ

2. Server Hello
   ← Chọn cipher suite, gửi certificate

3. Client verify certificate
   → Kiểm tra certificate với CA

4. Key Exchange
   ↔ Tạo session key

5. Encrypted Communication
   ↔ Dùng session key để mã hóa
```

### Certificate (Chứng chỉ)

```
Certificate bao gồm:
- Domain name
- Organization info
- Public key
- Expiration date
- Digital signature (signed by CA)
```

### HTTPS trong Java

```java
import javax.net.ssl.*;
import java.net.URL;
import java.io.*;

public class HttpsExample {
    public static void main(String[] args) throws Exception {
        // HTTPS GET request
        URL url = new URL("https://api.github.com/users/octocat");
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        int responseCode = conn.getResponseCode();
        System.out.println("Response Code: " + responseCode);

        if (responseCode == HttpsURLConnection.HTTP_OK) {
            BufferedReader in = new BufferedReader(
                new InputStreamReader(conn.getInputStream()));

            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            System.out.println("Response: " + response.toString());
        }
    }
}
```

### HTTPS trong JavaScript

```javascript
// Browser - tự động dùng HTTPS
fetch("https://api.github.com/users/octocat")
  .then((response) => response.json())
  .then((data) => console.log(data));

// Node.js
const https = require("https");

https
  .get(
    "https://api.github.com/users/octocat",
    {
      headers: {
        "User-Agent": "Node.js",
      },
    },
    (res) => {
      let data = "";

      res.on("data", (chunk) => {
        data += chunk;
      });

      res.on("end", () => {
        console.log(JSON.parse(data));
      });
    }
  )
  .on("error", (err) => {
    console.error("Error:", err.message);
  });
```

### Self-signed Certificate cho Development

```bash
# Tạo self-signed certificate
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

```javascript
// Node.js HTTPS server với self-signed cert
const https = require("https");
const fs = require("fs");

const options = {
  key: fs.readFileSync("key.pem"),
  cert: fs.readFileSync("cert.pem"),
};

const server = https.createServer(options, (req, res) => {
  res.writeHead(200);
  res.end("Hello HTTPS!\n");
});

server.listen(443, () => {
  console.log("HTTPS server running on port 443");
});
```

## CORS (Cross-Origin Resource Sharing)

### CORS là gì?

**CORS** là cơ chế cho phép server chỉ định ai có thể truy cập resources của mình từ một origin khác.

### Same-Origin Policy

Browser mặc định **chặn** cross-origin requests:

```javascript
// https://example.com/page.html

// ✅ Same origin
fetch("https://example.com/api/data");

// ❌ Different origin (blocked by default)
fetch("https://api.another-site.com/data");
```

**Same origin** = Same protocol + domain + port

```
https://example.com:443/page1
https://example.com:443/page2  → Same origin ✅

https://example.com:443/page
http://example.com:443/page     → Different protocol ❌
https://api.example.com:443/page → Different subdomain ❌
https://example.com:8080/page    → Different port ❌
```

### CORS Headers

Server phải gửi CORS headers để cho phép cross-origin requests:

```http
Access-Control-Allow-Origin: https://example.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE
Access-Control-Allow-Headers: Content-Type, Authorization
Access-Control-Allow-Credentials: true
Access-Control-Max-Age: 86400
```

### Simple Request vs Preflight Request

**Simple Request:**

- Methods: GET, HEAD, POST
- Headers: Accept, Content-Type (limited values)
- Content-Type: text/plain, application/x-www-form-urlencoded, multipart/form-data

```http
GET /api/data HTTP/1.1
Host: api.example.com
Origin: https://myapp.com

HTTP/1.1 200 OK
Access-Control-Allow-Origin: https://myapp.com
```

**Preflight Request** (với custom headers, PUT/DELETE, etc.):

```http
OPTIONS /api/data HTTP/1.1
Host: api.example.com
Origin: https://myapp.com
Access-Control-Request-Method: PUT
Access-Control-Request-Headers: Content-Type, Authorization

HTTP/1.1 204 No Content
Access-Control-Allow-Origin: https://myapp.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE
Access-Control-Allow-Headers: Content-Type, Authorization
Access-Control-Max-Age: 86400
```

### CORS trong Express.js

```javascript
const express = require("express");
const app = express();

// Cách 1: Manual CORS headers
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "https://myapp.com");
  res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
  res.header("Access-Control-Allow-Credentials", "true");

  // Handle preflight
  if (req.method === "OPTIONS") {
    return res.sendStatus(204);
  }

  next();
});

// Cách 2: Dùng cors middleware
const cors = require("cors");

app.use(
  cors({
    origin: "https://myapp.com",
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
    credentials: true,
  })
);

// Hoặc allow tất cả origins (⚠️ không nên dùng production)
app.use(cors());

app.get("/api/data", (req, res) => {
  res.json({ message: "Hello CORS!" });
});

app.listen(3000);
```

### CORS trong Spring Boot (Java)

```java
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins("https://myapp.com")
            .allowedMethods("GET", "POST", "PUT", "DELETE")
            .allowedHeaders("Content-Type", "Authorization")
            .allowCredentials(true)
            .maxAge(3600);
    }
}

// Hoặc dùng annotation trên controller
@RestController
@CrossOrigin(origins = "https://myapp.com")
public class ApiController {

    @GetMapping("/api/data")
    public ResponseEntity<?> getData() {
        return ResponseEntity.ok(Map.of("message", "Hello CORS!"));
    }
}
```

### CORS Best Practices

```javascript
// ✅ DO: Chỉ định specific origins
app.use(
  cors({
    origin: ["https://myapp.com", "https://admin.myapp.com"],
  })
);

// ❌ DON'T: Allow tất cả origins trong production
app.use(cors({ origin: "*" }));

// ✅ DO: Validate origin động
app.use(
  cors({
    origin: function (origin, callback) {
      const allowedOrigins = ["https://myapp.com", "https://admin.myapp.com"];

      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error("Not allowed by CORS"));
      }
    },
  })
);
```

## CSRF (Cross-Site Request Forgery)

### CSRF là gì?

**CSRF** là tấn công khiến user thực hiện actions không mong muốn trên một website mà họ đã authenticated.

### CSRF Attack Example

```
1. User đăng nhập vào bank.com
2. User nhận được cookie authentication
3. User mở email, click link độc hại
4. Link chứa: <img src="https://bank.com/transfer?to=hacker&amount=1000">
5. Browser tự động gửi request với cookie
6. Bank xử lý request (vì có valid cookie)
7. Tiền bị chuyển!
```

### Phòng chống CSRF

#### 1. CSRF Token

```javascript
// Server tạo và lưu CSRF token
app.use((req, res, next) => {
  if (!req.session.csrfToken) {
    req.session.csrfToken = generateRandomToken();
  }
  res.locals.csrfToken = req.session.csrfToken;
  next();
});

// Gửi token trong form
app.get("/transfer", (req, res) => {
  res.send(`
        <form method="POST" action="/transfer">
            <input type="hidden" name="_csrf" value="${res.locals.csrfToken}">
            <input name="to" placeholder="To">
            <input name="amount" placeholder="Amount">
            <button>Transfer</button>
        </form>
    `);
});

// Verify token
app.post("/transfer", (req, res) => {
  if (req.body._csrf !== req.session.csrfToken) {
    return res.status(403).send("Invalid CSRF token");
  }

  // Process transfer
  res.send("Transfer successful");
});
```

#### 2. SameSite Cookie

```javascript
// Set cookie với SameSite
res.cookie("sessionId", "abc123", {
  httpOnly: true, // Không thể đọc bằng JavaScript
  secure: true, // Chỉ gửi qua HTTPS
  sameSite: "strict", // Không gửi trong cross-site requests
});

// SameSite options:
// - strict: Không gửi trong bất kỳ cross-site request nào
// - lax: Gửi trong top-level navigation (click link)
// - none: Gửi trong mọi request (cần secure: true)
```

#### 3. Custom Headers

```javascript
// Client gửi custom header
fetch("/api/transfer", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest",
  },
  body: JSON.stringify({ to: "user", amount: 100 }),
});

// Server verify custom header
app.post("/api/transfer", (req, res) => {
  if (req.get("X-Requested-With") !== "XMLHttpRequest") {
    return res.status(403).send("Forbidden");
  }

  // Process transfer
});
```

#### 4. Origin/Referer Check

```javascript
app.post("/api/transfer", (req, res) => {
  const origin = req.get("Origin") || req.get("Referer");
  const allowedOrigins = ["https://myapp.com"];

  if (!origin || !allowedOrigins.includes(new URL(origin).origin)) {
    return res.status(403).send("Invalid origin");
  }

  // Process transfer
});
```

### CSRF Protection với csurf (Express)

```javascript
const csrf = require("csurf");
const cookieParser = require("cookie-parser");

app.use(cookieParser());
app.use(csrf({ cookie: true }));

// Gửi token trong response
app.get("/form", (req, res) => {
  res.render("form", { csrfToken: req.csrfToken() });
});

// Verify tự động
app.post("/process", (req, res) => {
  // csurf middleware tự động verify token
  res.send("Success!");
});

// Error handler
app.use((err, req, res, next) => {
  if (err.code === "EBADCSRFTOKEN") {
    res.status(403).send("Invalid CSRF token");
  } else {
    next(err);
  }
});
```

### CSRF Protection trong Spring Boot

```java
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.*;

@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf()
                .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
            .and()
            .authorizeRequests()
                .anyRequest().authenticated();

        return http.build();
    }
}
```

## Tổng hợp Best Practices

### HTTPS

✅ Luôn dùng HTTPS trong production  
✅ Force HTTPS redirect  
✅ Dùng HSTS header  
✅ Certificate từ trusted CA (Let's Encrypt miễn phí)  
✅ TLS 1.2+ only

```javascript
// Force HTTPS redirect
app.use((req, res, next) => {
  if (req.header("x-forwarded-proto") !== "https") {
    res.redirect(`https://${req.header("host")}${req.url}`);
  } else {
    next();
  }
});

// HSTS header
app.use((req, res, next) => {
  res.setHeader(
    "Strict-Transport-Security",
    "max-age=31536000; includeSubDomains"
  );
  next();
});
```

### CORS

✅ Chỉ định specific origins  
✅ Không allow `*` trong production  
✅ Validate origin động nếu cần  
✅ Chỉ cho phép necessary methods/headers  
✅ Không allow credentials với wildcard origin

### CSRF

✅ Dùng CSRF tokens cho state-changing requests  
✅ Set SameSite cookie attribute  
✅ Verify Origin/Referer headers  
✅ Dùng custom headers cho AJAX requests  
✅ Không dùng GET cho state-changing operations

## Security Headers

```javascript
const helmet = require("helmet");

app.use(helmet());

// Hoặc manual
app.use((req, res, next) => {
  // HTTPS only
  res.setHeader(
    "Strict-Transport-Security",
    "max-age=31536000; includeSubDomains"
  );

  // Prevent clickjacking
  res.setHeader("X-Frame-Options", "DENY");

  // XSS protection
  res.setHeader("X-Content-Type-Options", "nosniff");
  res.setHeader("X-XSS-Protection", "1; mode=block");

  // Content Security Policy
  res.setHeader("Content-Security-Policy", "default-src 'self'");

  next();
});
```

## Tổng kết

- **HTTPS**: Mã hóa dữ liệu, bắt buộc trong production
- **CORS**: Kiểm soát cross-origin access, cấu hình specific origins
- **CSRF**: Ngăn chặn unauthorized actions, dùng tokens + SameSite cookies
- **Defense in depth**: Kết hợp nhiều layers bảo mật
- Luôn validate input, sanitize output
- Keep dependencies updated

## Tài liệu tham khảo

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [MDN CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
- [OWASP CSRF Prevention](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html)
- [Let's Encrypt](https://letsencrypt.org/)
