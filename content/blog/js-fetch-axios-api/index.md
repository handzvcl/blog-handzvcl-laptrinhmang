---
title: "Fetch API & Axios: gọi API hiệu quả"
date: 2025-10-13
draft: false
tags: ["JavaScript", "HTTP", "API", "Fetch", "Axios"]
categories: ["JavaScript"]
summary: "So sánh Fetch API và Axios, hai cách phổ biến nhất để gọi HTTP API trong JavaScript."
cover:
  image: "/images/covers/js-fetch-axios.png"
  alt: "Fetch API và Axios"
  caption: "HTTP requests trong JavaScript"
---

## Giới thiệu

Khi làm việc với API trong JavaScript, hai công cụ phổ biến nhất là:

1. **Fetch API** - Native browser API
2. **Axios** - Third-party library

## Fetch API

**Fetch API** là API native của browser, cho phép thực hiện HTTP requests một cách hiện đại.

### GET Request cơ bản

```javascript
// GET request đơn giản
fetch("https://jsonplaceholder.typicode.com/users/1")
  .then((response) => response.json())
  .then((data) => {
    console.log(data);
  })
  .catch((error) => {
    console.error("Error:", error);
  });
```

### Với Async/Await

```javascript
async function getUser(id) {
  try {
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/users/${id}`
    );

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();
    console.log(data);
    return data;
  } catch (error) {
    console.error("Error fetching user:", error);
  }
}

getUser(1);
```

### POST Request với JSON

```javascript
async function createPost(postData) {
  try {
    const response = await fetch("https://jsonplaceholder.typicode.com/posts", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(postData),
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();
    console.log("Created:", data);
    return data;
  } catch (error) {
    console.error("Error creating post:", error);
  }
}

// Sử dụng
createPost({
  title: "Học JavaScript",
  body: "Fetch API rất mạnh mẽ",
  userId: 1,
});
```

### PUT Request

```javascript
async function updatePost(id, updates) {
  const response = await fetch(
    `https://jsonplaceholder.typicode.com/posts/${id}`,
    {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(updates),
    }
  );

  return response.json();
}

// Sử dụng
updatePost(1, {
  title: "Updated Title",
  body: "Updated Body",
  userId: 1,
});
```

### DELETE Request

```javascript
async function deletePost(id) {
  try {
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/posts/${id}`,
      {
        method: "DELETE",
      }
    );

    if (response.ok) {
      console.log(`Post ${id} deleted successfully`);
    }
  } catch (error) {
    console.error("Error deleting post:", error);
  }
}

deletePost(1);
```

## Fetch Options

```javascript
const response = await fetch(url, {
  method: "POST", // GET, POST, PUT, DELETE, PATCH
  headers: {
    "Content-Type": "application/json",
    Authorization: "Bearer token123",
    Accept: "application/json",
  },
  body: JSON.stringify(data), // String, FormData, Blob, ArrayBuffer
  mode: "cors", // cors, no-cors, same-origin
  credentials: "include", // include, same-origin, omit
  cache: "no-cache", // default, no-cache, reload, force-cache
  redirect: "follow", // follow, error, manual
  referrerPolicy: "no-referrer",
  signal: abortController.signal, // Abort signal
});
```

## Response Object

```javascript
const response = await fetch(url);

// Properties
console.log(response.ok); // true nếu status 200-299
console.log(response.status); // 200, 404, 500, ...
console.log(response.statusText); // "OK", "Not Found", ...
console.log(response.headers); // Headers object
console.log(response.url); // Final URL (sau redirects)

// Methods để đọc body
const json = await response.json(); // Parse JSON
const text = await response.text(); // Raw text
const blob = await response.blob(); // Binary data
const arrayBuffer = await response.arrayBuffer();
const formData = await response.formData();
```

## Abort Request (Timeout)

```javascript
async function fetchWithTimeout(url, timeout = 5000) {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), timeout);

  try {
    const response = await fetch(url, {
      signal: controller.signal,
    });

    clearTimeout(timeoutId);
    return response;
  } catch (error) {
    if (error.name === "AbortError") {
      console.error("Request timeout!");
    }
    throw error;
  }
}

// Sử dụng
fetchWithTimeout("https://api.example.com/slow", 3000)
  .then((response) => response.json())
  .catch((error) => console.error(error));
```

## Axios

**Axios** là một HTTP client library phổ biến với nhiều tính năng tiện lợi.

### Cài đặt

```bash
# NPM
npm install axios

# CDN
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
```

### GET Request

```javascript
import axios from "axios";

// Cách 1
axios
  .get("https://jsonplaceholder.typicode.com/users/1")
  .then((response) => {
    console.log(response.data);
  })
  .catch((error) => {
    console.error("Error:", error);
  });

// Cách 2: async/await
async function getUser(id) {
  try {
    const response = await axios.get(
      `https://jsonplaceholder.typicode.com/users/${id}`
    );
    console.log(response.data);
    return response.data;
  } catch (error) {
    console.error("Error:", error.response?.data || error.message);
  }
}
```

### POST Request

```javascript
async function createPost(postData) {
  try {
    const response = await axios.post(
      "https://jsonplaceholder.typicode.com/posts",
      postData
    );

    console.log("Created:", response.data);
    console.log("Status:", response.status);
    return response.data;
  } catch (error) {
    console.error("Error:", error.response?.data || error.message);
  }
}

// Sử dụng
createPost({
  title: "Học Axios",
  body: "Axios rất tiện lợi",
  userId: 1,
});
```

### PUT & DELETE

```javascript
// PUT
await axios.put(`/posts/${id}`, {
  title: "Updated",
  body: "New content",
});

// PATCH
await axios.patch(`/posts/${id}`, {
  title: "Updated Title",
});

// DELETE
await axios.delete(`/posts/${id}`);
```

## Axios Configuration

```javascript
// Config cho một request
axios.get("/users", {
  params: {
    page: 1,
    limit: 10,
  },
  headers: {
    Authorization: "Bearer token123",
  },
  timeout: 5000, // 5 seconds
  responseType: "json", // json, text, blob, arraybuffer, stream
});

// Tạo instance với default config
const api = axios.create({
  baseURL: "https://api.example.com",
  timeout: 10000,
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
});

// Sử dụng instance
api.get("/users").then((response) => console.log(response.data));
```

## Interceptors

Interceptors cho phép can thiệp vào request/response:

```javascript
const api = axios.create({
  baseURL: "https://api.example.com",
});

// Request interceptor
api.interceptors.request.use(
  (config) => {
    // Thêm token vào mọi request
    const token = localStorage.getItem("token");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    console.log("Request:", config.method.toUpperCase(), config.url);
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor
api.interceptors.response.use(
  (response) => {
    console.log("Response:", response.status, response.config.url);
    return response;
  },
  (error) => {
    // Xử lý lỗi global
    if (error.response) {
      switch (error.response.status) {
        case 401:
          console.error("Unauthorized! Redirect to login...");
          // Redirect to login
          break;
        case 403:
          console.error("Forbidden!");
          break;
        case 404:
          console.error("Not Found!");
          break;
        case 500:
          console.error("Server Error!");
          break;
      }
    }

    return Promise.reject(error);
  }
);
```

## Query Parameters

### Fetch

```javascript
const params = new URLSearchParams({
  page: 1,
  limit: 10,
  sort: "name",
});

fetch(`https://api.example.com/users?${params}`).then((response) =>
  response.json()
);
```

### Axios

```javascript
// Tự động encode params
axios.get("/users", {
  params: {
    page: 1,
    limit: 10,
    sort: "name",
  },
});
```

## Error Handling

### Fetch

```javascript
async function fetchData(url) {
  try {
    const response = await fetch(url);

    // Fetch KHÔNG reject với HTTP errors!
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    if (error instanceof TypeError) {
      console.error("Network error:", error.message);
    } else {
      console.error("Error:", error.message);
    }
    throw error;
  }
}
```

### Axios

```javascript
async function fetchData(url) {
  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    if (error.response) {
      // Server responded với error status
      console.error("Status:", error.response.status);
      console.error("Data:", error.response.data);
      console.error("Headers:", error.response.headers);
    } else if (error.request) {
      // Request đã gửi nhưng không nhận được response
      console.error("No response:", error.request);
    } else {
      // Lỗi khi setup request
      console.error("Error:", error.message);
    }
    throw error;
  }
}
```

## Parallel Requests

### Fetch với Promise.all

```javascript
async function fetchMultiple() {
  try {
    const [users, posts, comments] = await Promise.all([
      fetch("/users").then((r) => r.json()),
      fetch("/posts").then((r) => r.json()),
      fetch("/comments").then((r) => r.json()),
    ]);

    console.log("Users:", users);
    console.log("Posts:", posts);
    console.log("Comments:", comments);
  } catch (error) {
    console.error("Error:", error);
  }
}
```

### Axios với Promise.all

```javascript
async function fetchMultiple() {
  try {
    const [usersRes, postsRes, commentsRes] = await Promise.all([
      axios.get("/users"),
      axios.get("/posts"),
      axios.get("/comments"),
    ]);

    console.log("Users:", usersRes.data);
    console.log("Posts:", postsRes.data);
    console.log("Comments:", commentsRes.data);
  } catch (error) {
    console.error("Error:", error);
  }
}
```

## Upload Files

### Fetch

```javascript
async function uploadFile(file) {
  const formData = new FormData();
  formData.append("file", file);
  formData.append("description", "My file");

  try {
    const response = await fetch("/upload", {
      method: "POST",
      body: formData,
      // KHÔNG set Content-Type header - browser tự thêm với boundary
    });

    const result = await response.json();
    console.log("Upload result:", result);
  } catch (error) {
    console.error("Upload error:", error);
  }
}

// Sử dụng
const fileInput = document.getElementById("fileInput");
fileInput.addEventListener("change", (e) => {
  const file = e.target.files[0];
  uploadFile(file);
});
```

### Axios

```javascript
async function uploadFile(file, onProgress) {
  const formData = new FormData();
  formData.append("file", file);

  try {
    const response = await axios.post("/upload", formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
      onUploadProgress: (progressEvent) => {
        const percent = Math.round(
          (progressEvent.loaded * 100) / progressEvent.total
        );
        console.log(`Upload: ${percent}%`);
        onProgress?.(percent);
      },
    });

    console.log("Upload success:", response.data);
  } catch (error) {
    console.error("Upload error:", error);
  }
}
```

## So sánh Fetch vs Axios

| Feature                  | Fetch                    | Axios                |
| ------------------------ | ------------------------ | -------------------- |
| **Browser support**      | Modern browsers          | IE11+ (với polyfill) |
| **Kích thước**           | Native (0 KB)            | ~13 KB (minified)    |
| **JSON parsing**         | Manual `.json()`         | Automatic            |
| **Error handling**       | Không reject HTTP errors | Reject HTTP errors   |
| **Interceptors**         | ❌ Không có              | ✅ Có                |
| **Request cancellation** | AbortController          | CancelToken          |
| **Progress events**      | ❌ Không có              | ✅ Có                |
| **Timeout**              | AbortController          | Built-in config      |
| **XSRF protection**      | ❌ Không có              | ✅ Có                |
| **Default config**       | ❌ Không có              | ✅ Có                |

## Khi nào dùng cái nào?

### Dùng Fetch khi:

✅ Không muốn thêm dependencies  
✅ Ứng dụng đơn giản  
✅ Browser modern  
✅ Cần tối ưu bundle size

### Dùng Axios khi:

✅ Cần interceptors  
✅ Cần upload progress  
✅ Muốn error handling tốt hơn  
✅ Cần nhiều tính năng tiện lợi  
✅ Dự án lớn với nhiều API calls

## API Client Wrapper Example

```javascript
class ApiClient {
  constructor(baseURL) {
    this.baseURL = baseURL;
  }

  async request(endpoint, options = {}) {
    const url = `${this.baseURL}${endpoint}`;

    const config = {
      headers: {
        "Content-Type": "application/json",
        ...options.headers,
      },
      ...options,
    };

    try {
      const response = await fetch(url, config);

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error(`API Error [${endpoint}]:`, error);
      throw error;
    }
  }

  get(endpoint, options) {
    return this.request(endpoint, { method: "GET", ...options });
  }

  post(endpoint, data, options) {
    return this.request(endpoint, {
      method: "POST",
      body: JSON.stringify(data),
      ...options,
    });
  }

  put(endpoint, data, options) {
    return this.request(endpoint, {
      method: "PUT",
      body: JSON.stringify(data),
      ...options,
    });
  }

  delete(endpoint, options) {
    return this.request(endpoint, { method: "DELETE", ...options });
  }
}

// Sử dụng
const api = new ApiClient("https://jsonplaceholder.typicode.com");

const users = await api.get("/users");
const newPost = await api.post("/posts", { title: "Test", body: "Content" });
```

## Tổng kết

- **Fetch API**: Native, lightweight, modern
- **Axios**: Feature-rich, convenient, robust
- Fetch cần xử lý HTTP errors manually
- Axios có interceptors, progress, timeout built-in
- Cả hai đều support async/await
- Chọn based on project requirements

## Tài liệu tham khảo

- [Fetch API (MDN)](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [Axios Documentation](https://axios-http.com/)
- [Using Fetch (MDN)](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch)
