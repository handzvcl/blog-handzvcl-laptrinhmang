---
title: "Xử lý đa luồng cho server TCP với ExecutorService"
date: 2025-10-05
draft: false
tags: ["Java", "Networking", "Concurrency", "ExecutorService"]
categories: ["Java"]
summary: "Cách xây dựng server TCP xử lý nhiều client đồng thời bằng multithreading và ExecutorService."
cover:
  image: "/images/covers/java-multithreading.png"
  alt: "Multithreading server Java"
  caption: "Server đa luồng với ExecutorService"
---

## Vấn đề của Server đơn luồng

Server đơn luồng chỉ xử lý được **1 client tại 1 thời điểm**:

```java
while (true) {
    Socket client = serverSocket.accept();
    handleClient(client); // Blocking - chỉ xử lý được 1 client
}
```

Khi đang xử lý client A, các client khác phải chờ. Điều này không chấp nhận được trong ứng dụng thực tế!

## Giải pháp: Multi-threading

Mỗi client được xử lý bởi một thread riêng:

```java
while (true) {
    Socket client = serverSocket.accept();

    // Tạo thread mới cho mỗi client
    new Thread(() -> handleClient(client)).start();
}
```

## Server đa luồng cơ bản

```java
import java.io.*;
import java.net.*;

public class MultiThreadedServer {
    private final int port;

    public MultiThreadedServer(int port) {
        this.port = port;
    }

    public void start() {
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("🚀 Server đang chạy tại port " + port);

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("✅ Client mới kết nối: "
                    + clientSocket.getInetAddress());

                // Tạo thread mới cho mỗi client
                Thread clientThread = new Thread(
                    new ClientHandler(clientSocket)
                );
                clientThread.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new MultiThreadedServer(8080).start();
    }
}

// Handler xử lý mỗi client
class ClientHandler implements Runnable {
    private final Socket socket;

    public ClientHandler(Socket socket) {
        this.socket = socket;
    }

    @Override
    public void run() {
        try (
            socket;
            BufferedReader in = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(
                socket.getOutputStream(), true)
        ) {
            String clientId = socket.getInetAddress() + ":" + socket.getPort();
            System.out.println("🔧 [" + clientId + "] Bắt đầu xử lý");

            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                System.out.println("📩 [" + clientId + "] " + inputLine);

                if ("bye".equalsIgnoreCase(inputLine)) {
                    out.println("Goodbye!");
                    break;
                }

                out.println("Echo: " + inputLine);
            }

            System.out.println("👋 [" + clientId + "] Ngắt kết nối");

        } catch (IOException e) {
            System.err.println("❌ Lỗi xử lý client: " + e.getMessage());
        }
    }
}
```

## Vấn đề của cách tiếp cận trên

### 1. Thread explosion

Nếu có 1000 clients → 1000 threads → quá tải hệ thống!

### 2. Không kiểm soát tài nguyên

Mỗi thread tiêu tốn ~1MB memory (stack size).

### 3. Overhead tạo/hủy thread

Tạo thread là expensive operation.

## Giải pháp: ExecutorService (Thread Pool)

**Thread Pool** giới hạn số lượng thread và tái sử dụng chúng:

```java
ExecutorService executor = Executors.newFixedThreadPool(10);

while (true) {
    Socket client = serverSocket.accept();
    executor.submit(() -> handleClient(client));
}
```

## Server với ExecutorService

```java
import java.io.*;
import java.net.*;
import java.util.concurrent.*;

public class ThreadPoolServer {
    private final int port;
    private final ExecutorService executorService;

    public ThreadPoolServer(int port, int poolSize) {
        this.port = port;
        this.executorService = Executors.newFixedThreadPool(poolSize);
    }

    public void start() {
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("🚀 Server khởi động tại port " + port);
            System.out.println("🔧 Thread pool size: "
                + ((ThreadPoolExecutor) executorService).getCorePoolSize());

            // Graceful shutdown hook
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                System.out.println("\n⏹️  Đang tắt server...");
                shutdown();
            }));

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("✅ Client kết nối: "
                    + clientSocket.getInetAddress());

                // Submit task vào thread pool
                executorService.submit(new ClientTask(clientSocket));
            }
        } catch (IOException e) {
            System.err.println("❌ Server error: " + e.getMessage());
        } finally {
            shutdown();
        }
    }

    private void shutdown() {
        try {
            executorService.shutdown();

            if (!executorService.awaitTermination(60, TimeUnit.SECONDS)) {
                executorService.shutdownNow();

                if (!executorService.awaitTermination(60, TimeUnit.SECONDS)) {
                    System.err.println("❌ ExecutorService không dừng được");
                }
            }

            System.out.println("✅ Server đã tắt");
        } catch (InterruptedException e) {
            executorService.shutdownNow();
            Thread.currentThread().interrupt();
        }
    }

    public static void main(String[] args) {
        int port = 8080;
        int poolSize = 10; // Tối đa 10 client đồng thời

        new ThreadPoolServer(port, poolSize).start();
    }
}

class ClientTask implements Runnable {
    private final Socket socket;

    public ClientTask(Socket socket) {
        this.socket = socket;
    }

    @Override
    public void run() {
        String clientId = socket.getInetAddress() + ":" + socket.getPort();
        String threadName = Thread.currentThread().getName();

        System.out.println("🔧 [" + threadName + "] Xử lý client " + clientId);

        try (
            socket;
            BufferedReader in = new BufferedReader(
                new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(
                socket.getOutputStream(), true)
        ) {
            out.println("Welcome! You're handled by " + threadName);

            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                System.out.println("📩 [" + threadName + "] " + inputLine);

                if ("bye".equalsIgnoreCase(inputLine)) {
                    out.println("Goodbye from " + threadName);
                    break;
                }

                // Simulate processing
                Thread.sleep(100);

                out.println("[" + threadName + "] Echo: " + inputLine);
            }

            System.out.println("👋 [" + threadName + "] Client "
                + clientId + " ngắt kết nối");

        } catch (IOException | InterruptedException e) {
            System.err.println("❌ [" + threadName + "] Error: "
                + e.getMessage());
        }
    }
}
```

## Các loại ExecutorService

### 1. FixedThreadPool

```java
// Cố định số lượng thread
ExecutorService executor = Executors.newFixedThreadPool(10);
```

✅ **Use case**: Server với số lượng kết nối giới hạn

### 2. CachedThreadPool

```java
// Tự động tạo thread khi cần, tái sử dụng thread idle
ExecutorService executor = Executors.newCachedThreadPool();
```

✅ **Use case**: Nhiều task ngắn hạn, số lượng không dự đoán được

### 3. ScheduledThreadPool

```java
// Hỗ trợ lên lịch task
ScheduledExecutorService executor = Executors.newScheduledThreadPool(5);
executor.schedule(task, 10, TimeUnit.SECONDS); // Chạy sau 10s
executor.scheduleAtFixedRate(task, 0, 5, TimeUnit.SECONDS); // Mỗi 5s
```

### 4. SingleThreadExecutor

```java
// Chỉ 1 thread, đảm bảo thứ tự
ExecutorService executor = Executors.newSingleThreadExecutor();
```

## ThreadPoolExecutor - Tùy chỉnh nâng cao

```java
import java.util.concurrent.*;

public class CustomThreadPoolServer {
    private ThreadPoolExecutor createThreadPool() {
        int corePoolSize = 5;      // Số thread tối thiểu
        int maxPoolSize = 20;      // Số thread tối đa
        long keepAliveTime = 60L;  // Thread idle tồn tại 60s

        BlockingQueue<Runnable> workQueue =
            new LinkedBlockingQueue<>(100); // Queue tối đa 100 tasks

        ThreadPoolExecutor executor = new ThreadPoolExecutor(
            corePoolSize,
            maxPoolSize,
            keepAliveTime,
            TimeUnit.SECONDS,
            workQueue,
            new ThreadPoolExecutor.CallerRunsPolicy() // Reject policy
        );

        return executor;
    }

    public void start() {
        ThreadPoolExecutor executor = createThreadPool();

        try (ServerSocket serverSocket = new ServerSocket(8080)) {
            System.out.println("🚀 Server với custom thread pool");

            while (true) {
                Socket client = serverSocket.accept();

                // Kiểm tra thread pool status
                System.out.printf("📊 Pool: %d/%d active, %d queued%n",
                    executor.getActiveCount(),
                    executor.getPoolSize(),
                    executor.getQueue().size());

                executor.execute(new ClientTask(client));
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            executor.shutdown();
        }
    }

    public static void main(String[] args) {
        new CustomThreadPoolServer().start();
    }
}
```

## Reject Policies

Khi thread pool và queue đều đầy:

```java
// 1. AbortPolicy (default) - throw RejectedExecutionException
new ThreadPoolExecutor.AbortPolicy()

// 2. CallerRunsPolicy - thread gọi submit() tự chạy task
new ThreadPoolExecutor.CallerRunsPolicy()

// 3. DiscardPolicy - bỏ qua task, không exception
new ThreadPoolExecutor.DiscardPolicy()

// 4. DiscardOldestPolicy - bỏ task cũ nhất trong queue
new ThreadPoolExecutor.DiscardOldestPolicy()
```

## Monitoring Thread Pool

```java
public class MonitoredServer {
    private void monitorThreadPool(ThreadPoolExecutor executor) {
        ScheduledExecutorService monitor =
            Executors.newSingleThreadScheduledExecutor();

        monitor.scheduleAtFixedRate(() -> {
            System.out.printf("""
                📊 Thread Pool Status:
                   - Pool Size: %d
                   - Active Threads: %d
                   - Completed Tasks: %d
                   - Queued Tasks: %d
                %n""",
                executor.getPoolSize(),
                executor.getActiveCount(),
                executor.getCompletedTaskCount(),
                executor.getQueue().size()
            );
        }, 0, 10, TimeUnit.SECONDS);
    }
}
```

## Best Practices

### 1. Luôn shutdown ExecutorService

```java
executor.shutdown(); // Không nhận task mới
executor.awaitTermination(60, TimeUnit.SECONDS); // Chờ task hiện tại
executor.shutdownNow(); // Force stop nếu cần
```

### 2. Sử dụng Callable cho task có return value

```java
Callable<String> task = () -> {
    // Process client
    return "Result";
};

Future<String> future = executor.submit(task);
String result = future.get(); // Blocking
```

### 3. Exception handling trong task

```java
executor.submit(() -> {
    try {
        handleClient(socket);
    } catch (Exception e) {
        logger.error("Task failed", e);
    }
});
```

### 4. Chọn pool size hợp lý

```java
// CPU-intensive tasks
int poolSize = Runtime.getRuntime().availableProcessors();

// I/O-intensive tasks (như network)
int poolSize = Runtime.getRuntime().availableProcessors() * 2;
```

## So sánh các cách tiếp cận

| Approach           | Pros                 | Cons             | Use Case                 |
| ------------------ | -------------------- | ---------------- | ------------------------ |
| Single-threaded    | Đơn giản             | Chỉ 1 client     | Testing, learning        |
| Thread per client  | Đơn giản, độc lập    | Không scale      | < 100 clients            |
| Fixed Thread Pool  | Kiểm soát tài nguyên | Giới hạn clients | Production, bounded load |
| Cached Thread Pool | Linh hoạt            | Có thể quá tải   | Variable load            |
| NIO Selector       | Rất hiệu quả         | Phức tạp         | High performance         |

## Tổng kết

- **Multi-threading** giải quyết vấn đề xử lý nhiều client đồng thời
- **ExecutorService** quản lý thread pool hiệu quả
- **FixedThreadPool** phù hợp nhất cho server TCP production
- Luôn shutdown executor properly
- Chọn pool size phù hợp với workload

Trong bài tiếp theo, chúng ta sẽ tìm hiểu về **Java NIO** - giải pháp non-blocking I/O hiệu quả hơn cho server hiệu năng cao!

## Tài liệu tham khảo

- [ExecutorService (Java SE 17)](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/concurrent/ExecutorService.html)
- [Java Concurrency in Practice](https://jcip.net/)
