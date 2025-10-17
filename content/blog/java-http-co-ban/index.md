---
title: "Giao thức HTTP cơ bản cho lập trình viên Java"
date: 2024-09-22
draft: false
tags: ["Java", "HTTP", "Networking", "REST"]
categories: ["Java"]
summary: "Tìm hiểu giao thức HTTP, cách gửi request và nhận response trong Java với HttpURLConnection và HttpClient."
cover:
  image: "/images/covers/java-http-basic.jpg"
  alt: "HTTP protocol in Java"
  caption: "HTTP trong Java"
---

## HTTP là gì?

**HTTP** (HyperText Transfer Protocol) là giao thức ứng dụng phổ biến nhất trên Internet, được sử dụng để truyền tải dữ liệu giữa client và server.

### Đặc điểm của HTTP

- **Stateless**: Mỗi request độc lập, không lưu trạng thái
- **Text-based**: Headers và body có thể đọc được (plain text)
- **Request-Response**: Client gửi request, server trả về response
- **Port mặc định**: 80 (HTTP), 443 (HTTPS)

## Cấu trúc HTTP Request

```http
GET /api/users/123 HTTP/1.1
Host: example.com
User-Agent: Mozilla/5.0
Accept: application/json
Authorization: Bearer token123

```

**Thành phần:**

1. **Request Line**: Method + URI + HTTP Version
2. **Headers**: Metadata về request
3. **Body** (optional): Dữ liệu gửi đi

## Cấu trúc HTTP Response

```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 58
Date: Mon, 01 Oct 2025 10:00:00 GMT

{"id":123,"name":"John Doe","email":"john@example.com"}
```

**Thành phần:**

1. **Status Line**: HTTP Version + Status Code + Reason Phrase
2. **Headers**: Metadata về response
3. **Body**: Dữ liệu trả về

## HTTP Methods chính

| Method  | Mục đích                      | Idempotent | Safe |
| ------- | ----------------------------- | ---------- | ---- |
| GET     | Lấy dữ liệu                   | ✅         | ✅   |
| POST    | Tạo mới                       | ❌         | ❌   |
| PUT     | Cập nhật/thay thế             | ✅         | ❌   |
| PATCH   | Cập nhật một phần             | ❌         | ❌   |
| DELETE  | Xóa                           | ✅         | ❌   |
| HEAD    | Giống GET nhưng không có body | ✅         | ✅   |
| OPTIONS | Kiểm tra methods được hỗ trợ  | ✅         | ✅   |

## HTTP Status Codes

### 2xx - Success

- **200 OK**: Thành công
- **201 Created**: Tạo resource thành công
- **204 No Content**: Thành công nhưng không có body

### 3xx - Redirection

- **301 Moved Permanently**: Chuyển hướng vĩnh viễn
- **302 Found**: Chuyển hướng tạm thời
- **304 Not Modified**: Cache còn hiệu lực

### 4xx - Client Error

- **400 Bad Request**: Request không hợp lệ
- **401 Unauthorized**: Chưa xác thực
- **403 Forbidden**: Không có quyền truy cập
- **404 Not Found**: Không tìm thấy resource

### 5xx - Server Error

- **500 Internal Server Error**: Lỗi server
- **502 Bad Gateway**: Gateway lỗi
- **503 Service Unavailable**: Service không khả dụng

## Java HTTP APIs

Java cung cấp 2 API chính:

1. **HttpURLConnection** (legacy, Java 1.1+)
2. **HttpClient** (modern, Java 11+) ✅ Recommended

## HttpURLConnection - Legacy API

### GET Request

```java
import java.io.*;
import java.net.*;

public class HttpURLConnectionExample {
    public static void main(String[] args) throws IOException {
        String urlString = "https://jsonplaceholder.typicode.com/users/1";

        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        try {
            // Cấu hình request
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");
            connection.setConnectTimeout(5000); // 5s
            connection.setReadTimeout(5000);

            // Gửi request và nhận response code
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Đọc response body
                BufferedReader in = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()));

                String inputLine;
                StringBuilder response = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();

                System.out.println("Response Body:");
                System.out.println(response.toString());
            } else {
                System.err.println("GET request failed");
            }
        } finally {
            connection.disconnect();
        }
    }
}
```

### POST Request với JSON

```java
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;

public class HttpPostExample {
    public static void main(String[] args) throws IOException {
        String urlString = "https://jsonplaceholder.typicode.com/posts";

        // JSON data
        String jsonInputString = """
            {
                "title": "Học Java HTTP",
                "body": "Gửi POST request với JSON",
                "userId": 1
            }
            """;

        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        try {
            // Cấu hình POST request
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            connection.setDoOutput(true); // Cho phép ghi body

            // Ghi JSON vào request body
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Đọc response
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_CREATED) {
                BufferedReader in = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()));

                String line;
                StringBuilder response = new StringBuilder();
                while ((line = in.readLine()) != null) {
                    response.append(line);
                }
                in.close();

                System.out.println("Created:");
                System.out.println(response.toString());
            }
        } finally {
            connection.disconnect();
        }
    }
}
```

## HttpClient - Modern API (Java 11+)

**HttpClient** là API hiện đại, hỗ trợ HTTP/2, async, và dễ sử dụng hơn.

### GET Request

```java
import java.net.URI;
import java.net.http.*;
import java.net.http.HttpResponse.BodyHandlers;

public class HttpClientGetExample {
    public static void main(String[] args) throws Exception {
        // Tạo HttpClient
        HttpClient client = HttpClient.newHttpClient();

        // Tạo request
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("https://jsonplaceholder.typicode.com/users/1"))
            .header("Accept", "application/json")
            .GET()
            .build();

        // Gửi request (synchronous)
        HttpResponse<String> response = client.send(
            request,
            BodyHandlers.ofString()
        );

        // Xử lý response
        System.out.println("Status Code: " + response.statusCode());
        System.out.println("Headers: " + response.headers().map());
        System.out.println("Body:");
        System.out.println(response.body());
    }
}
```

### POST Request với JSON

```java
import java.net.URI;
import java.net.http.*;
import java.net.http.HttpRequest.BodyPublishers;
import java.net.http.HttpResponse.BodyHandlers;

public class HttpClientPostExample {
    public static void main(String[] args) throws Exception {
        HttpClient client = HttpClient.newHttpClient();

        String json = """
            {
                "title": "Java HttpClient",
                "body": "Modern HTTP API",
                "userId": 1
            }
            """;

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("https://jsonplaceholder.typicode.com/posts"))
            .header("Content-Type", "application/json")
            .POST(BodyPublishers.ofString(json))
            .build();

        HttpResponse<String> response = client.send(
            request,
            BodyHandlers.ofString()
        );

        System.out.println("Status: " + response.statusCode());
        System.out.println("Response: " + response.body());
    }
}
```

### Async Request

```java
import java.net.URI;
import java.net.http.*;
import java.util.concurrent.CompletableFuture;

public class HttpClientAsyncExample {
    public static void main(String[] args) {
        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("https://jsonplaceholder.typicode.com/users"))
            .build();

        // Async request
        CompletableFuture<HttpResponse<String>> futureResponse =
            client.sendAsync(request, HttpResponse.BodyHandlers.ofString());

        // Xử lý kết quả khi có
        futureResponse
            .thenApply(HttpResponse::body)
            .thenAccept(body -> {
                System.out.println("Async Response:");
                System.out.println(body);
            })
            .join(); // Chờ hoàn thành

        System.out.println("Request đã gửi, đang chờ response...");
    }
}
```

## HttpClient Configuration

### Custom HttpClient

```java
HttpClient client = HttpClient.newBuilder()
    .version(HttpClient.Version.HTTP_2)  // HTTP/2
    .connectTimeout(Duration.ofSeconds(10))
    .followRedirects(HttpClient.Redirect.NORMAL)
    .build();
```

### Authentication

```java
// Basic Authentication
String auth = "username:password";
String encodedAuth = Base64.getEncoder()
    .encodeToString(auth.getBytes(StandardCharsets.UTF_8));

HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create("https://api.example.com/data"))
    .header("Authorization", "Basic " + encodedAuth)
    .build();

// Bearer Token
HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create("https://api.example.com/data"))
    .header("Authorization", "Bearer " + token)
    .build();
```

## Xử lý Response nâng cao

### Parse JSON với Jackson

```java
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonParseExample {
    public static void main(String[] args) throws Exception {
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("https://jsonplaceholder.typicode.com/users/1"))
            .build();

        HttpResponse<String> response = client.send(
            request,
            HttpResponse.BodyHandlers.ofString()
        );

        // Parse JSON
        ObjectMapper mapper = new ObjectMapper();
        User user = mapper.readValue(response.body(), User.class);

        System.out.println("User: " + user.getName());
        System.out.println("Email: " + user.getEmail());
    }
}

class User {
    private int id;
    private String name;
    private String email;

    // Getters and setters
    public String getName() { return name; }
    public String getEmail() { return email; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
}
```

### Download File

```java
HttpClient client = HttpClient.newHttpClient();

HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create("https://example.com/file.pdf"))
    .build();

HttpResponse<Path> response = client.send(
    request,
    HttpResponse.BodyHandlers.ofFile(Path.of("downloaded-file.pdf"))
);

System.out.println("File saved to: " + response.body());
```

## REST API Client Example

```java
import java.net.URI;
import java.net.http.*;
import java.net.http.HttpResponse.BodyHandlers;

public class RestApiClient {
    private final HttpClient client;
    private final String baseUrl;

    public RestApiClient(String baseUrl) {
        this.client = HttpClient.newHttpClient();
        this.baseUrl = baseUrl;
    }

    public String get(String path) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(baseUrl + path))
            .header("Accept", "application/json")
            .GET()
            .build();

        HttpResponse<String> response = client.send(request, BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            throw new RuntimeException("GET failed: " + response.statusCode());
        }

        return response.body();
    }

    public String post(String path, String jsonBody) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(baseUrl + path))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
            .build();

        HttpResponse<String> response = client.send(request, BodyHandlers.ofString());

        if (response.statusCode() != 201 && response.statusCode() != 200) {
            throw new RuntimeException("POST failed: " + response.statusCode());
        }

        return response.body();
    }

    public static void main(String[] args) throws Exception {
        RestApiClient api = new RestApiClient("https://jsonplaceholder.typicode.com");

        // GET
        String user = api.get("/users/1");
        System.out.println("GET: " + user);

        // POST
        String json = "{\"title\":\"Test\",\"body\":\"Content\",\"userId\":1}";
        String created = api.post("/posts", json);
        System.out.println("POST: " + created);
    }
}
```

## Best Practices

### 1. Sử dụng HttpClient (Java 11+)

```java
// ✅ Modern, clean API
HttpClient client = HttpClient.newHttpClient();

// ❌ Legacy, verbose
HttpURLConnection connection = (HttpURLConnection) url.openConnection();
```

### 2. Reuse HttpClient instance

```java
// ✅ Tạo 1 lần, dùng nhiều lần
private static final HttpClient CLIENT = HttpClient.newHttpClient();

// ❌ Tạo mới mỗi lần
HttpClient client = HttpClient.newHttpClient(); // Trong loop
```

### 3. Set Timeout

```java
HttpClient client = HttpClient.newBuilder()
    .connectTimeout(Duration.ofSeconds(10))
    .build();

HttpRequest request = HttpRequest.newBuilder()
    .uri(uri)
    .timeout(Duration.ofSeconds(30))
    .build();
```

### 4. Exception Handling

```java
try {
    HttpResponse<String> response = client.send(request, BodyHandlers.ofString());

    if (response.statusCode() >= 400) {
        throw new HttpException("HTTP " + response.statusCode());
    }

} catch (IOException e) {
    // Network error
} catch (InterruptedException e) {
    Thread.currentThread().interrupt();
}
```

## Tổng kết

- **HTTP** là giao thức request-response, stateless
- **HttpClient** (Java 11+) là API modern, hỗ trợ HTTP/2 và async
- Hiểu rõ HTTP methods, status codes, headers
- Luôn set timeout và xử lý exception
- Reuse HttpClient instance cho performance

## Tài liệu tham khảo

- [HttpClient (Java SE 17)](https://docs.oracle.com/en/java/javase/17/docs/api/java.net.http/java/net/http/HttpClient.html)
- [HTTP/1.1 Specification (RFC 7231)](https://tools.ietf.org/html/rfc7231)
- [REST API Best Practices](https://restfulapi.net/)
