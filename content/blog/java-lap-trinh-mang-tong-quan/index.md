---
title: "Tổng quan lập trình mạng với Java"
date: 2024-09-10
draft: false
tags: ["Java", "Networking", "Socket"]
categories: ["Java"]
summary: "Giới thiệu tổng quan về lập trình mạng trong Java, các khái niệm cơ bản và thư viện hỗ trợ."
cover:
  image: "/images/covers/java-networking-overview.jpg"
  alt: "Lập trình mạng Java"
  caption: "Tổng quan lập trình mạng với Java"
---

## Giới thiệu

Lập trình mạng là một phần quan trọng trong phát triển ứng dụng hiện đại. Java cung cấp một bộ API mạnh mẽ và toàn diện để xử lý các tác vụ liên quan đến mạng máy tính.

## Java Network API

Java cung cấp các package chính cho lập trình mạng:

### 1. Package java.net

Package `java.net` là nền tảng cơ bản cho lập trình mạng trong Java:

```java
import java.net.*;
import java.io.*;

// Các class quan trọng
// - Socket: kết nối client TCP
// - ServerSocket: lắng nghe kết nối từ client
// - DatagramSocket: giao tiếp UDP
// - URL, URLConnection: làm việc với URL
// - InetAddress: địa chỉ IP
```

### 2. Package java.nio

Java NIO (New I/O) cung cấp khả năng xử lý I/O hiệu quả hơn:

```java
import java.nio.*;
import java.nio.channels.*;

// Non-blocking I/O
// Selector pattern
// Buffer-based I/O
```

## Mô hình Client-Server

Trong lập trình mạng, mô hình Client-Server là mô hình phổ biến nhất:

```java
// SERVER
ServerSocket serverSocket = new ServerSocket(8080);
System.out.println("Server đang chờ kết nối...");

Socket clientSocket = serverSocket.accept();
System.out.println("Client đã kết nối!");

// CLIENT
Socket socket = new Socket("localhost", 8080);
System.out.println("Đã kết nối tới server!");
```

## Các giao thức mạng

### TCP (Transmission Control Protocol)

- **Đặc điểm**: Hướng kết nối, đáng tin cậy, đảm bảo thứ tự
- **Use case**: HTTP, FTP, Email, Chat
- **Java API**: Socket, ServerSocket

### UDP (User Datagram Protocol)

- **Đặc điểm**: Không kết nối, nhanh, không đảm bảo
- **Use case**: Video streaming, Gaming, DNS
- **Java API**: DatagramSocket, DatagramPacket

## Ví dụ đơn giản: Echo Server

```java
public class SimpleEchoServer {
    public static void main(String[] args) {
        int port = 8080;

        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("Echo Server khởi động tại port " + port);

            while (true) {
                try (Socket clientSocket = serverSocket.accept();
                     BufferedReader in = new BufferedReader(
                         new InputStreamReader(clientSocket.getInputStream()));
                     PrintWriter out = new PrintWriter(
                         clientSocket.getOutputStream(), true)) {

                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        System.out.println("Nhận: " + inputLine);
                        out.println("Echo: " + inputLine);
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Lỗi server: " + e.getMessage());
        }
    }
}
```

## Các khái niệm quan trọng

### 1. Port và Socket

- **Port**: Số từ 0-65535, xác định ứng dụng
- **Well-known ports**: 0-1023 (HTTP: 80, HTTPS: 443)
- **Socket**: Điểm cuối của kết nối mạng

### 2. Địa chỉ IP

```java
InetAddress localhost = InetAddress.getLocalHost();
System.out.println("Host: " + localhost.getHostName());
System.out.println("IP: " + localhost.getHostAddress());

InetAddress google = InetAddress.getByName("google.com");
System.out.println("Google IP: " + google.getHostAddress());
```

### 3. Stream I/O

```java
// Input Stream - đọc dữ liệu từ socket
InputStream in = socket.getInputStream();
BufferedReader reader = new BufferedReader(new InputStreamReader(in));

// Output Stream - ghi dữ liệu vào socket
OutputStream out = socket.getOutputStream();
PrintWriter writer = new PrintWriter(out, true);
```

## Best Practices

### 1. Sử dụng try-with-resources

```java
try (Socket socket = new Socket("localhost", 8080);
     BufferedReader in = new BufferedReader(
         new InputStreamReader(socket.getInputStream()))) {
    // Tự động đóng resource khi kết thúc
}
```

### 2. Xử lý timeout

```java
Socket socket = new Socket();
socket.connect(new InetSocketAddress("localhost", 8080), 5000); // 5s timeout
socket.setSoTimeout(10000); // 10s read timeout
```

### 3. Xử lý exception

```java
try {
    // Network operations
} catch (UnknownHostException e) {
    System.err.println("Không tìm thấy host: " + e.getMessage());
} catch (ConnectException e) {
    System.err.println("Không thể kết nối: " + e.getMessage());
} catch (SocketTimeoutException e) {
    System.err.println("Timeout: " + e.getMessage());
} catch (IOException e) {
    System.err.println("Lỗi I/O: " + e.getMessage());
}
```

## Tổng kết

Lập trình mạng với Java cung cấp:

- API phong phú và dễ sử dụng
- Hỗ trợ cả TCP và UDP
- Khả năng xử lý blocking và non-blocking I/O
- Cross-platform compatibility

Trong các bài viết tiếp theo, chúng ta sẽ đi sâu vào từng chủ đề cụ thể như Socket programming, multithreading, và NIO.

## Tài liệu tham khảo

- [Java Network Programming (Oracle)](https://docs.oracle.com/javase/tutorial/networking/)
- [java.net Package Documentation](https://docs.oracle.com/javase/8/docs/api/java/net/package-summary.html)
- [Java NIO Tutorial](https://jenkov.com/tutorials/java-nio/index.html)
