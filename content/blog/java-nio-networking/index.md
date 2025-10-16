---
title: "Java NIO và Channel/Selector trong ứng dụng mạng"
date: 2025-10-09
draft: false
tags: ["Java", "NIO", "Networking", "Performance"]
categories: ["Java"]
summary: "Tìm hiểu Java NIO (Non-blocking I/O) với Channel, Buffer và Selector để xây dựng server hiệu năng cao."
cover:
  image: "/images/covers/java-nio.png"
  alt: "Java NIO networking"
  caption: "Java NIO - Non-blocking I/O"
---

## Java NIO là gì?

**Java NIO** (New I/O hoặc Non-blocking I/O) được giới thiệu từ Java 1.4, cung cấp cách tiếp cận khác với I/O truyền thống (blocking I/O).

### So sánh Blocking I/O vs Non-blocking I/O

**Blocking I/O (java.io):**

```java
// Thread bị block cho đến khi có dữ liệu
InputStream in = socket.getInputStream();
int data = in.read(); // BLOCKING!
```

**Non-blocking I/O (java.nio):**

```java
// Thread kiểm tra và tiếp tục nếu chưa có dữ liệu
socketChannel.configureBlocking(false);
ByteBuffer buffer = ByteBuffer.allocate(1024);
int bytesRead = socketChannel.read(buffer); // NON-BLOCKING!
```

## Các thành phần chính của NIO

### 1. Buffer

Buffer là container cho dữ liệu, thay thế stream:

```java
ByteBuffer buffer = ByteBuffer.allocate(1024);

// Ghi dữ liệu vào buffer
buffer.put("Hello".getBytes());

// Chuyển từ write mode sang read mode
buffer.flip();

// Đọc dữ liệu từ buffer
while (buffer.hasRemaining()) {
    byte b = buffer.get();
    System.out.print((char) b);
}

// Xóa buffer để ghi lại
buffer.clear();
```

### 2. Channel

Channel là kết nối đến I/O device (file, socket):

```java
// SocketChannel - TCP client
SocketChannel clientChannel = SocketChannel.open();

// ServerSocketChannel - TCP server
ServerSocketChannel serverChannel = ServerSocketChannel.open();

// DatagramChannel - UDP
DatagramChannel udpChannel = DatagramChannel.open();

// FileChannel - File I/O
FileChannel fileChannel = FileChannel.open(path);
```

### 3. Selector

Selector cho phép **1 thread** quản lý **nhiều channel**:

```java
Selector selector = Selector.open();

// Đăng ký channel với selector
channel.configureBlocking(false);
SelectionKey key = channel.register(selector, SelectionKey.OP_READ);

// Chờ events
int readyChannels = selector.select(); // Blocking
```

## Buffer Properties

Buffer có 4 properties quan trọng:

```java
ByteBuffer buffer = ByteBuffer.allocate(10);

// capacity: Kích thước tối đa (10)
int capacity = buffer.capacity();

// position: Vị trí hiện tại (0)
int position = buffer.position();

// limit: Giới hạn đọc/ghi (10)
int limit = buffer.limit();

// mark: Đánh dấu vị trí (optional)
buffer.mark();
buffer.reset(); // Quay về mark
```

### Buffer Operations

```java
ByteBuffer buffer = ByteBuffer.allocate(1024);

// 1. Put data (write mode)
buffer.put("Hello World".getBytes());
System.out.println("After put: pos=" + buffer.position()); // 11

// 2. Flip: switch to read mode
buffer.flip();
System.out.println("After flip: pos=" + buffer.position() + ", limit=" + buffer.limit());
// pos=0, limit=11

// 3. Get data (read mode)
byte[] data = new byte[buffer.remaining()];
buffer.get(data);
System.out.println("Data: " + new String(data));

// 4. Clear: reset to write mode
buffer.clear();
System.out.println("After clear: pos=" + buffer.position() + ", limit=" + buffer.limit());
// pos=0, limit=1024

// 5. Compact: preserve unread data
buffer.compact();

// 6. Rewind: read again from beginning
buffer.rewind();
```

## Non-blocking TCP Client

```java
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SocketChannel;
import java.nio.charset.StandardCharsets;

public class NioClient {
    public static void main(String[] args) throws IOException {
        // Mở SocketChannel
        SocketChannel socketChannel = SocketChannel.open();
        socketChannel.configureBlocking(false); // Non-blocking mode

        // Kết nối đến server
        socketChannel.connect(new InetSocketAddress("localhost", 8080));

        // Chờ kết nối hoàn tất
        while (!socketChannel.finishConnect()) {
            System.out.println("Đang kết nối...");
            Thread.sleep(100);
        }

        System.out.println("✅ Đã kết nối tới server");

        // Gửi dữ liệu
        String message = "Hello from NIO Client!";
        ByteBuffer buffer = ByteBuffer.wrap(message.getBytes(StandardCharsets.UTF_8));

        while (buffer.hasRemaining()) {
            socketChannel.write(buffer);
        }

        System.out.println("📤 Đã gửi: " + message);

        // Nhận phản hồi
        buffer.clear();
        int bytesRead = socketChannel.read(buffer);

        if (bytesRead > 0) {
            buffer.flip();
            byte[] data = new byte[buffer.remaining()];
            buffer.get(data);
            System.out.println("📥 Nhận: " + new String(data, StandardCharsets.UTF_8));
        }

        socketChannel.close();
    }
}
```

## NIO Server với Selector

**Selector Pattern** cho phép 1 thread xử lý nhiều connections:

```java
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.*;
import java.nio.charset.StandardCharsets;
import java.util.Iterator;
import java.util.Set;

public class NioServer {
    private final int port;
    private Selector selector;

    public NioServer(int port) {
        this.port = port;
    }

    public void start() throws IOException {
        // Tạo selector
        selector = Selector.open();

        // Tạo server channel
        ServerSocketChannel serverChannel = ServerSocketChannel.open();
        serverChannel.bind(new InetSocketAddress(port));
        serverChannel.configureBlocking(false);

        // Đăng ký ACCEPT event
        serverChannel.register(selector, SelectionKey.OP_ACCEPT);

        System.out.println("🚀 NIO Server khởi động tại port " + port);

        // Event loop
        while (true) {
            // Chờ events (blocking)
            int readyChannels = selector.select();

            if (readyChannels == 0) {
                continue;
            }

            // Xử lý events
            Set<SelectionKey> selectedKeys = selector.selectedKeys();
            Iterator<SelectionKey> keyIterator = selectedKeys.iterator();

            while (keyIterator.hasNext()) {
                SelectionKey key = keyIterator.next();
                keyIterator.remove();

                if (!key.isValid()) {
                    continue;
                }

                if (key.isAcceptable()) {
                    handleAccept(key);
                } else if (key.isReadable()) {
                    handleRead(key);
                } else if (key.isWritable()) {
                    handleWrite(key);
                }
            }
        }
    }

    private void handleAccept(SelectionKey key) throws IOException {
        ServerSocketChannel serverChannel = (ServerSocketChannel) key.channel();
        SocketChannel clientChannel = serverChannel.accept();

        if (clientChannel != null) {
            clientChannel.configureBlocking(false);
            clientChannel.register(selector, SelectionKey.OP_READ);

            System.out.println("✅ Client mới: " + clientChannel.getRemoteAddress());
        }
    }

    private void handleRead(SelectionKey key) throws IOException {
        SocketChannel clientChannel = (SocketChannel) key.channel();
        ByteBuffer buffer = ByteBuffer.allocate(1024);

        int bytesRead;
        try {
            bytesRead = clientChannel.read(buffer);
        } catch (IOException e) {
            System.out.println("❌ Client ngắt kết nối");
            key.cancel();
            clientChannel.close();
            return;
        }

        if (bytesRead == -1) {
            System.out.println("👋 Client đóng kết nối");
            key.cancel();
            clientChannel.close();
            return;
        }

        if (bytesRead > 0) {
            buffer.flip();
            byte[] data = new byte[buffer.remaining()];
            buffer.get(data);
            String message = new String(data, StandardCharsets.UTF_8);

            System.out.println("📩 Nhận: " + message);

            // Chuẩn bị response
            String response = "Echo: " + message;
            key.attach(ByteBuffer.wrap(response.getBytes(StandardCharsets.UTF_8)));

            // Đăng ký WRITE event
            key.interestOps(SelectionKey.OP_WRITE);
        }
    }

    private void handleWrite(SelectionKey key) throws IOException {
        SocketChannel clientChannel = (SocketChannel) key.channel();
        ByteBuffer buffer = (ByteBuffer) key.attachment();

        if (buffer != null && buffer.hasRemaining()) {
            clientChannel.write(buffer);

            if (!buffer.hasRemaining()) {
                // Đã gửi xong, quay lại READ mode
                key.interestOps(SelectionKey.OP_READ);
                key.attach(null);
            }
        }
    }

    public static void main(String[] args) throws IOException {
        new NioServer(8080).start();
    }
}
```

## SelectionKey Operations

```java
// Interest Set - events muốn lắng nghe
key.interestOps(SelectionKey.OP_READ);
key.interestOps(SelectionKey.OP_READ | SelectionKey.OP_WRITE);

// Ready Set - events đã sẵn sàng
boolean isReadable = key.isReadable();
boolean isWritable = key.isWritable();
boolean isAcceptable = key.isAcceptable();
boolean isConnectable = key.isConnectable();

// Channel & Selector
Channel channel = key.channel();
Selector selector = key.selector();

// Attachment - lưu trữ dữ liệu
key.attach(myObject);
Object obj = key.attachment();

// Cancel registration
key.cancel();
```

## 4 loại Operations

```java
// 1. OP_ACCEPT - ServerSocketChannel có client mới
SelectionKey.OP_ACCEPT

// 2. OP_CONNECT - SocketChannel kết nối thành công
SelectionKey.OP_CONNECT

// 3. OP_READ - Channel có dữ liệu để đọc
SelectionKey.OP_READ

// 4. OP_WRITE - Channel sẵn sàng để ghi
SelectionKey.OP_WRITE

// Kết hợp nhiều ops
channel.register(selector, SelectionKey.OP_READ | SelectionKey.OP_WRITE);
```

## Echo Server hoàn chỉnh

```java
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.*;
import java.util.Iterator;

public class NioEchoServer {
    private static final int BUFFER_SIZE = 1024;

    public static void main(String[] args) throws IOException {
        Selector selector = Selector.open();
        ServerSocketChannel serverChannel = ServerSocketChannel.open();

        serverChannel.bind(new InetSocketAddress(8080));
        serverChannel.configureBlocking(false);
        serverChannel.register(selector, SelectionKey.OP_ACCEPT);

        System.out.println("🔊 Echo Server (NIO) chạy tại port 8080");

        while (true) {
            selector.select(); // Blocking until events

            Iterator<SelectionKey> keys = selector.selectedKeys().iterator();

            while (keys.hasNext()) {
                SelectionKey key = keys.next();
                keys.remove();

                try {
                    if (key.isAcceptable()) {
                        accept(key, selector);
                    } else if (key.isReadable()) {
                        read(key);
                    }
                } catch (IOException e) {
                    key.cancel();
                    try {
                        key.channel().close();
                    } catch (IOException ex) {
                        // Ignore
                    }
                }
            }
        }
    }

    private static void accept(SelectionKey key, Selector selector)
            throws IOException {
        ServerSocketChannel serverChannel = (ServerSocketChannel) key.channel();
        SocketChannel clientChannel = serverChannel.accept();
        clientChannel.configureBlocking(false);
        clientChannel.register(selector, SelectionKey.OP_READ);

        System.out.println("✅ Client: " + clientChannel.getRemoteAddress());
    }

    private static void read(SelectionKey key) throws IOException {
        SocketChannel clientChannel = (SocketChannel) key.channel();
        ByteBuffer buffer = ByteBuffer.allocate(BUFFER_SIZE);

        int bytesRead = clientChannel.read(buffer);

        if (bytesRead == -1) {
            System.out.println("👋 Client đóng: " + clientChannel.getRemoteAddress());
            clientChannel.close();
            return;
        }

        if (bytesRead > 0) {
            // Echo back
            buffer.flip();
            while (buffer.hasRemaining()) {
                clientChannel.write(buffer);
            }

            System.out.println("📤 Echo " + bytesRead + " bytes");
        }
    }
}
```

## Direct vs Heap ByteBuffer

```java
// Heap Buffer - trong JVM heap
ByteBuffer heapBuffer = ByteBuffer.allocate(1024);

// Direct Buffer - ngoài JVM heap, hiệu quả hơn cho I/O
ByteBuffer directBuffer = ByteBuffer.allocateDirect(1024);
```

**Direct Buffer:**

- ✅ Nhanh hơn cho I/O operations
- ✅ Không bị garbage collected
- ❌ Tốn kém hơn khi tạo
- ❌ Khó debug hơn

## Ưu điểm của NIO

### 1. Scalability

```
Blocking I/O:  10,000 clients = 10,000 threads ❌
NIO + Selector: 10,000 clients = 1 thread ✅
```

### 2. Performance

- Non-blocking operations
- Ít context switching
- Direct buffer cho I/O nhanh

### 3. Resource efficiency

- Ít thread hơn
- Ít memory overhead
- Phù hợp với C10K problem

## Khi nào dùng NIO?

✅ **Nên dùng NIO:**

- Server với nhiều concurrent connections
- Long-lived connections
- High-performance requirements
- Limited thread resources

❌ **Không cần NIO:**

- Ứng dụng đơn giản với ít connections
- Prototype, POC
- Khi code simplicity quan trọng hơn performance

## NIO vs Traditional I/O

| Feature         | Traditional I/O     | NIO                        |
| --------------- | ------------------- | -------------------------- |
| **Blocking**    | Yes                 | Optional                   |
| **API**         | Stream-based        | Buffer + Channel           |
| **Scalability** | 1 thread/connection | 1 thread/nhiều connections |
| **Complexity**  | Simple              | Complex                    |
| **Use case**    | Low concurrency     | High concurrency           |

## Tổng kết

- **NIO** = Non-blocking I/O với Buffer, Channel, Selector
- **Selector** cho phép 1 thread xử lý nhiều connections
- **ByteBuffer** là container cho dữ liệu
- Phù hợp cho server high-performance với nhiều concurrent clients
- Trade-off: Performance vs Complexity

## Tài liệu tham khảo

- [Java NIO Tutorial (Oracle)](https://docs.oracle.com/javase/tutorial/essential/io/fileio.html)
- [Selector (Java SE 17)](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/nio/channels/Selector.html)
- [The C10K Problem](http://www.kegel.com/c10k.html)
