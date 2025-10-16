---
title: "Hiểu Socket và ServerSocket trong Java"
date: 2025-10-03
draft: false
tags: ["Java", "Networking", "Socket", "TCP"]
categories: ["Java"]
summary: "Giải thích cơ chế socket, vòng đời kết nối TCP, ví dụ server đơn giản với Socket và ServerSocket."
cover:
  image: "/images/covers/java-socket.png"
  alt: "Minh họa kết nối socket TCP"
  caption: "Socket/ServerSocket trong Java"
---

## Socket là gì?

**Socket** là một điểm cuối (endpoint) của kết nối mạng hai chiều giữa hai chương trình trên mạng. Trong Java, socket được sử dụng chủ yếu cho giao tiếp TCP.

### Hai loại Socket chính

1. **Socket** (Client Socket): Khởi tạo kết nối đến server
2. **ServerSocket**: Lắng nghe và chấp nhận kết nối từ client

## Vòng đời kết nối TCP

```
CLIENT                          SERVER
  |                               |
  |  1. ServerSocket.bind()       |
  |  2. ServerSocket.listen()     |
  |  3. ServerSocket.accept() --> |
  |                          (chờ)|
  |                               |
  | --- connect() ------------->  |
  |                               |
  | <-- accept() returns ------   |
  |                               |
  | <====== Dữ liệu =========>    |
  |                               |
  | --- close() ---------------->  |
  |                               |
```

## ServerSocket - Phía Server

### Tạo ServerSocket

```java
// Cách 1: Bind ngay khi tạo
ServerSocket serverSocket = new ServerSocket(8080);

// Cách 2: Bind sau
ServerSocket serverSocket = new ServerSocket();
serverSocket.bind(new InetSocketAddress("localhost", 8080));

// Cách 3: Với backlog queue
ServerSocket serverSocket = new ServerSocket(8080, 50); // tối đa 50 kết nối chờ
```

### Chấp nhận kết nối

```java
public class SimpleServer {
    public static void main(String[] args) {
        int port = 8080;

        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("🚀 Server lắng nghe tại port " + port);

            // accept() là blocking call
            Socket clientSocket = serverSocket.accept();

            System.out.println("✅ Client đã kết nối từ: "
                + clientSocket.getInetAddress().getHostAddress());

            // Xử lý client
            handleClient(clientSocket);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void handleClient(Socket socket) throws IOException {
        try (
            BufferedReader in = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(
                socket.getOutputStream(), true)
        ) {
            String message = in.readLine();
            System.out.println("📩 Nhận: " + message);

            out.println("Server nhận được: " + message);
        }
    }
}
```

## Socket - Phía Client

### Kết nối đến Server

```java
public class SimpleClient {
    public static void main(String[] args) {
        String host = "localhost";
        int port = 8080;

        try (Socket socket = new Socket(host, port)) {
            System.out.println("✅ Đã kết nối tới " + host + ":" + port);

            // Gửi dữ liệu
            PrintWriter out = new PrintWriter(
                socket.getOutputStream(), true);
            out.println("Xin chào Server!");

            // Nhận phản hồi
            BufferedReader in = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
            String response = in.readLine();

            System.out.println("📩 Server phản hồi: " + response);

        } catch (UnknownHostException e) {
            System.err.println("❌ Không tìm thấy host: " + host);
        } catch (IOException e) {
            System.err.println("❌ Lỗi I/O: " + e.getMessage());
        }
    }
}
```

## Echo Server - Ví dụ hoàn chỉnh

### Echo Server với xử lý nhiều messages

```java
import java.io.*;
import java.net.*;

public class EchoServer {
    private final int port;

    public EchoServer(int port) {
        this.port = port;
    }

    public void start() {
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("🔊 Echo Server đang chạy tại port " + port);
            System.out.println("⏳ Chờ client kết nối...");

            while (true) {
                // Chấp nhận kết nối mới
                Socket clientSocket = serverSocket.accept();
                System.out.println("\n✅ Client kết nối: "
                    + clientSocket.getInetAddress());

                // Xử lý client (blocking - chỉ xử lý 1 client tại 1 thời điểm)
                handleClient(clientSocket);
            }
        } catch (IOException e) {
            System.err.println("❌ Server error: " + e.getMessage());
        }
    }

    private void handleClient(Socket socket) {
        try (
            socket; // auto-close
            BufferedReader in = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(
                socket.getOutputStream(), true)
        ) {
            String inputLine;

            // Đọc từng dòng từ client
            while ((inputLine = in.readLine()) != null) {
                System.out.println("📩 Nhận: " + inputLine);

                // Kiểm tra lệnh thoát
                if ("bye".equalsIgnoreCase(inputLine)) {
                    out.println("Goodbye!");
                    System.out.println("👋 Client ngắt kết nối");
                    break;
                }

                // Echo lại message
                String response = "ECHO: " + inputLine;
                out.println(response);
                System.out.println("📤 Gửi: " + response);
            }
        } catch (IOException e) {
            System.err.println("❌ Lỗi xử lý client: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        int port = args.length > 0 ? Integer.parseInt(args[0]) : 8080;
        new EchoServer(port).start();
    }
}
```

### Echo Client tương tác

```java
import java.io.*;
import java.net.*;
import java.util.Scanner;

public class EchoClient {
    private final String host;
    private final int port;

    public EchoClient(String host, int port) {
        this.host = host;
        this.port = port;
    }

    public void start() {
        try (
            Socket socket = new Socket(host, port);
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            BufferedReader in = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
            Scanner scanner = new Scanner(System.in)
        ) {
            System.out.println("✅ Đã kết nối tới " + host + ":" + port);
            System.out.println("💡 Nhập tin nhắn (gõ 'bye' để thoát):\n");

            String userInput;
            while (true) {
                System.out.print("You: ");
                userInput = scanner.nextLine();

                // Gửi tới server
                out.println(userInput);

                // Nhận phản hồi
                String response = in.readLine();
                System.out.println("Server: " + response);

                // Kiểm tra thoát
                if ("bye".equalsIgnoreCase(userInput)) {
                    break;
                }
            }

            System.out.println("\n👋 Đã ngắt kết nối");

        } catch (UnknownHostException e) {
            System.err.println("❌ Không tìm thấy host: " + host);
        } catch (IOException e) {
            System.err.println("❌ Lỗi I/O: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        String host = args.length > 0 ? args[0] : "localhost";
        int port = args.length > 1 ? Integer.parseInt(args[1]) : 8080;

        new EchoClient(host, port).start();
    }
}
```

## Các phương thức quan trọng

### ServerSocket Methods

```java
ServerSocket server = new ServerSocket(8080);

// Thông tin socket
int port = server.getLocalPort();
InetAddress addr = server.getInetAddress();

// Cấu hình
server.setSoTimeout(30000);  // Timeout cho accept()
server.setReuseAddress(true); // Cho phép bind port ngay sau close

// Đóng
server.close();
```

### Socket Methods

```java
Socket socket = new Socket("localhost", 8080);

// Thông tin kết nối
InetAddress remoteAddr = socket.getInetAddress();
int remotePort = socket.getPort();
InetAddress localAddr = socket.getLocalAddress();
int localPort = socket.getLocalPort();

// Cấu hình
socket.setSoTimeout(10000);      // Read timeout
socket.setKeepAlive(true);       // TCP keepalive
socket.setTcpNoDelay(true);      // Disable Nagle's algorithm
socket.setSoLinger(true, 10);    // Linger on close

// Stream
InputStream in = socket.getInputStream();
OutputStream out = socket.getOutputStream();

// Đóng
socket.close();
```

## Lưu ý quan trọng

### 1. Try-with-resources

Luôn sử dụng try-with-resources để đảm bảo đóng kết nối:

```java
try (ServerSocket server = new ServerSocket(8080);
     Socket client = server.accept()) {
    // Code
} // Tự động đóng
```

### 2. Blocking Operations

```java
// accept() - chờ đến khi có client kết nối
Socket client = serverSocket.accept();

// read() - chờ đến khi có dữ liệu
int data = inputStream.read();
```

### 3. Exception Handling

```java
try {
    Socket socket = new Socket("localhost", 8080);
} catch (ConnectException e) {
    // Server không chạy
} catch (SocketTimeoutException e) {
    // Timeout
} catch (UnknownHostException e) {
    // Host không tồn tại
} catch (IOException e) {
    // Lỗi I/O khác
}
```

## Hạn chế của mô hình cơ bản

Server đơn luồng ở trên chỉ xử lý được **1 client tại 1 thời điểm**. Để xử lý nhiều client đồng thời, ta cần:

1. **Multi-threading**: Mỗi client 1 thread riêng
2. **Thread Pool**: Giới hạn số thread với ExecutorService
3. **NIO**: Non-blocking I/O với Selector

Chúng ta sẽ tìm hiểu các giải pháp này trong bài viết tiếp theo!

## Tổng kết

- **ServerSocket**: Lắng nghe và chấp nhận kết nối từ client
- **Socket**: Kết nối client-server, truyền dữ liệu hai chiều
- **Blocking I/O**: accept() và read() đều là blocking operations
- **Resource management**: Luôn đóng socket sau khi sử dụng

## Tài liệu tham khảo

- [Socket (Java SE 17)](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/net/Socket.html)
- [ServerSocket (Java SE 17)](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/net/ServerSocket.html)
