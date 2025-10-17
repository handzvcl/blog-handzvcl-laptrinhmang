---
title: "Xây dựng client TCP nhỏ bằng Node.js (net module)"
date: 2024-10-12
draft: false
tags: ["JavaScript", "Node.js", "TCP", "Networking"]
categories: ["JavaScript"]
summary: "Học cách sử dụng net module trong Node.js để tạo TCP client và server."
cover:
  image: "/images/covers/js-node-tcp-client.jpg"
  alt: "Node.js TCP networking"
  caption: "TCP trong Node.js"
---

## Node.js Net Module

Module **net** trong Node.js cung cấp API để tạo TCP server và client. Đây là module cốt lõi (core module), không cần cài đặt thêm.

```javascript
const net = require("net");
```

## TCP Client cơ bản

### Kết nối đến Server

```javascript
const net = require("net");

// Tạo TCP client
const client = net.createConnection(
  {
    host: "localhost",
    port: 8080,
  },
  () => {
    console.log("✅ Đã kết nối đến server!");

    // Gửi dữ liệu
    client.write("Hello Server!\n");
  }
);

// Nhận dữ liệu từ server
client.on("data", (data) => {
  console.log("📩 Nhận:", data.toString());

  // Đóng kết nối sau khi nhận response
  client.end();
});

// Kết nối bị đóng
client.on("end", () => {
  console.log("👋 Đã ngắt kết nối");
});

// Xử lý lỗi
client.on("error", (err) => {
  console.error("❌ Lỗi:", err.message);
});
```

### Echo Client tương tác

```javascript
const net = require("net");
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

const client = net.createConnection({ host: "localhost", port: 8080 }, () => {
  console.log('✅ Đã kết nối! Nhập tin nhắn (hoặc "exit" để thoát):\n');
  promptUser();
});

function promptUser() {
  rl.question("You: ", (message) => {
    if (message.toLowerCase() === "exit") {
      client.end();
      rl.close();
      return;
    }

    client.write(message + "\n");
  });
}

client.on("data", (data) => {
  console.log("Server:", data.toString().trim());
  promptUser();
});

client.on("end", () => {
  console.log("\n👋 Đã ngắt kết nối");
  process.exit(0);
});

client.on("error", (err) => {
  console.error("❌ Lỗi:", err.message);
  process.exit(1);
});
```

## TCP Server cơ bản

### Echo Server

```javascript
const net = require("net");

// Tạo TCP server
const server = net.createServer((socket) => {
  const clientAddr = `${socket.remoteAddress}:${socket.remotePort}`;
  console.log(`✅ Client kết nối: ${clientAddr}`);

  // Gửi welcome message
  socket.write("Welcome to Echo Server!\n");

  // Echo lại dữ liệu nhận được
  socket.on("data", (data) => {
    console.log(`📩 [${clientAddr}] ${data.toString().trim()}`);
    socket.write(`Echo: ${data}`);
  });

  // Client ngắt kết nối
  socket.on("end", () => {
    console.log(`👋 [${clientAddr}] Ngắt kết nối`);
  });

  // Xử lý lỗi
  socket.on("error", (err) => {
    console.error(`❌ [${clientAddr}] Lỗi: ${err.message}`);
  });
});

// Lắng nghe tại port 8080
server.listen(8080, () => {
  console.log("🚀 Server lắng nghe tại port 8080");
});

// Xử lý lỗi server
server.on("error", (err) => {
  console.error("❌ Server error:", err.message);
});
```

## Socket Events

### Client Socket Events

```javascript
const client = net.createConnection({ host: "localhost", port: 8080 });

// connect - Kết nối thành công
client.on("connect", () => {
  console.log("Connected!");
});

// data - Nhận dữ liệu
client.on("data", (data) => {
  console.log("Data:", data.toString());
});

// end - Server đóng kết nối
client.on("end", () => {
  console.log("Server closed connection");
});

// close - Kết nối đã đóng hoàn toàn
client.on("close", (hadError) => {
  console.log("Connection closed", hadError ? "with error" : "normally");
});

// error - Có lỗi xảy ra
client.on("error", (err) => {
  console.error("Error:", err);
});

// timeout - Timeout
client.on("timeout", () => {
  console.log("Socket timeout");
  client.end();
});
```

### Server Socket Events

```javascript
const server = net.createServer();

// connection - Client mới kết nối
server.on("connection", (socket) => {
  console.log("New connection");
});

// listening - Server đã bắt đầu lắng nghe
server.on("listening", () => {
  const addr = server.address();
  console.log(`Server listening on ${addr.address}:${addr.port}`);
});

// close - Server đóng
server.on("close", () => {
  console.log("Server closed");
});

// error - Lỗi server
server.on("error", (err) => {
  console.error("Server error:", err);
});

server.listen(8080);
```

## Chat Server - Multi-client

```javascript
const net = require("net");

const clients = new Set();
let clientId = 0;

const server = net.createServer((socket) => {
  // Gán ID cho client
  const id = ++clientId;
  socket.clientId = id;
  clients.add(socket);

  console.log(`✅ Client #${id} joined (Total: ${clients.size})`);

  // Thông báo cho tất cả clients
  broadcast(`[System] Client #${id} joined the chat\n`, socket);
  socket.write(`Welcome! You are Client #${id}\n`);
  socket.write(`Type your message and press Enter\n\n`);

  // Nhận message
  socket.on("data", (data) => {
    const message = data.toString().trim();
    console.log(`📩 Client #${id}: ${message}`);

    // Broadcast đến tất cả clients khác
    broadcast(`Client #${id}: ${message}\n`, socket);
  });

  // Client ngắt kết nối
  socket.on("end", () => {
    clients.delete(socket);
    console.log(`👋 Client #${id} left (Total: ${clients.size})`);
    broadcast(`[System] Client #${id} left the chat\n`, socket);
  });

  // Lỗi
  socket.on("error", (err) => {
    console.error(`❌ Client #${id} error:`, err.message);
  });
});

// Broadcast message đến tất cả clients (trừ sender)
function broadcast(message, sender) {
  for (const client of clients) {
    if (client !== sender && !client.destroyed) {
      client.write(message);
    }
  }
}

server.listen(8080, () => {
  console.log("🚀 Chat Server listening on port 8080");
});

// Graceful shutdown
process.on("SIGINT", () => {
  console.log("\n⏹️  Shutting down server...");

  for (const client of clients) {
    client.write("[System] Server is shutting down\n");
    client.end();
  }

  server.close(() => {
    console.log("✅ Server closed");
    process.exit(0);
  });
});
```

## Socket Methods

```javascript
const socket = net.createConnection({ host: "localhost", port: 8080 });

// Ghi dữ liệu
socket.write("Hello\n");
socket.write(Buffer.from("Binary data"));

// Kết thúc kết nối (gửi FIN packet)
socket.end();
socket.end("Goodbye\n"); // Gửi data cuối trước khi đóng

// Hủy kết nối ngay lập tức
socket.destroy();

// Set timeout (ms)
socket.setTimeout(10000); // 10 seconds

// Pause/Resume receiving data
socket.pause();
socket.resume();

// Thông tin socket
console.log("Local address:", socket.localAddress);
console.log("Local port:", socket.localPort);
console.log("Remote address:", socket.remoteAddress);
console.log("Remote port:", socket.remotePort);
console.log("Bytes read:", socket.bytesRead);
console.log("Bytes written:", socket.bytesWritten);
```

## HTTP Client đơn giản bằng net

```javascript
const net = require("net");

function httpGet(host, port, path) {
  const client = net.createConnection({ host, port }, () => {
    // Gửi HTTP request
    const request = [
      `GET ${path} HTTP/1.1`,
      `Host: ${host}`,
      `Connection: close`,
      "",
      "",
    ].join("\r\n");

    client.write(request);
  });

  let response = "";

  client.on("data", (data) => {
    response += data.toString();
  });

  client.on("end", () => {
    console.log("Response:\n");
    console.log(response);
  });

  client.on("error", (err) => {
    console.error("Error:", err.message);
  });
}

// Sử dụng
httpGet("example.com", 80, "/");
```

## File Transfer Client

```javascript
const net = require("net");
const fs = require("fs");

function sendFile(host, port, filePath) {
  const client = net.createConnection({ host, port }, () => {
    console.log("✅ Connected, sending file...");

    const readStream = fs.createReadStream(filePath);

    readStream.on("data", (chunk) => {
      client.write(chunk);
    });

    readStream.on("end", () => {
      console.log("✅ File sent");
      client.end();
    });

    readStream.on("error", (err) => {
      console.error("File read error:", err);
      client.destroy();
    });
  });

  client.on("error", (err) => {
    console.error("Connection error:", err.message);
  });
}

// Sử dụng
sendFile("localhost", 8080, "./document.pdf");
```

## File Transfer Server

```javascript
const net = require("net");
const fs = require("fs");
const path = require("path");

const server = net.createServer((socket) => {
  const fileName = `received_${Date.now()}.dat`;
  const filePath = path.join(__dirname, fileName);
  const writeStream = fs.createWriteStream(filePath);

  console.log(`📥 Receiving file: ${fileName}`);

  socket.pipe(writeStream);

  socket.on("end", () => {
    console.log(`✅ File saved: ${fileName}`);
  });

  writeStream.on("error", (err) => {
    console.error("File write error:", err);
  });
});

server.listen(8080, () => {
  console.log("🚀 File server listening on port 8080");
});
```

## JSON Protocol Client/Server

### Protocol: Length-Prefixed JSON

```javascript
// ===== Server =====
const net = require("net");

const server = net.createServer((socket) => {
  let buffer = Buffer.alloc(0);

  socket.on("data", (data) => {
    buffer = Buffer.concat([buffer, data]);

    while (buffer.length >= 4) {
      // Đọc length (4 bytes)
      const length = buffer.readUInt32BE(0);

      if (buffer.length < 4 + length) {
        break; // Chưa đủ dữ liệu
      }

      // Đọc JSON
      const jsonStr = buffer.toString("utf8", 4, 4 + length);
      buffer = buffer.slice(4 + length);

      try {
        const message = JSON.parse(jsonStr);
        console.log("📩 Received:", message);

        // Gửi response
        sendJSON(socket, {
          status: "ok",
          echo: message,
        });
      } catch (err) {
        console.error("JSON parse error:", err);
      }
    }
  });
});

function sendJSON(socket, obj) {
  const json = JSON.stringify(obj);
  const buffer = Buffer.from(json, "utf8");
  const length = Buffer.alloc(4);
  length.writeUInt32BE(buffer.length, 0);

  socket.write(length);
  socket.write(buffer);
}

server.listen(8080, () => {
  console.log("🚀 JSON Server listening on port 8080");
});

// ===== Client =====
const client = net.createConnection({ host: "localhost", port: 8080 }, () => {
  console.log("✅ Connected");

  sendJSON(client, {
    type: "greeting",
    message: "Hello Server!",
    timestamp: Date.now(),
  });
});

let buffer = Buffer.alloc(0);

client.on("data", (data) => {
  buffer = Buffer.concat([buffer, data]);

  while (buffer.length >= 4) {
    const length = buffer.readUInt32BE(0);

    if (buffer.length < 4 + length) {
      break;
    }

    const jsonStr = buffer.toString("utf8", 4, 4 + length);
    buffer = buffer.slice(4 + length);

    try {
      const message = JSON.parse(jsonStr);
      console.log("📩 Server response:", message);
      client.end();
    } catch (err) {
      console.error("JSON parse error:", err);
    }
  }
});
```

## Socket Options

```javascript
const socket = net.createConnection({ host: "localhost", port: 8080 });

// Keep-alive
socket.setKeepAlive(true, 60000); // 60s initial delay

// No delay (disable Nagle's algorithm)
socket.setNoDelay(true);

// Timeout
socket.setTimeout(30000); // 30s

// Encoding
socket.setEncoding("utf8"); // Data events sẽ emit strings

// Buffer size
socket.setDefaultEncoding("utf8");
```

## Error Handling Best Practices

```javascript
const net = require("net");

function createResilientClient(host, port, maxRetries = 3) {
  let retries = 0;

  function connect() {
    const client = net.createConnection({ host, port });

    client.on("connect", () => {
      console.log("✅ Connected");
      retries = 0; // Reset counter
    });

    client.on("error", (err) => {
      console.error("❌ Error:", err.message);

      if (retries < maxRetries) {
        retries++;
        console.log(`🔄 Retrying (${retries}/${maxRetries})...`);
        setTimeout(connect, 3000);
      } else {
        console.error("❌ Max retries reached");
      }
    });

    return client;
  }

  return connect();
}

// Sử dụng
const client = createResilientClient("localhost", 8080);
```

## net.Socket vs net.Server

| net.Socket                               | net.Server                                |
| ---------------------------------------- | ----------------------------------------- |
| Client connection                        | Accepts connections                       |
| `net.createConnection()`                 | `net.createServer()`                      |
| `connect`, `data`, `end`, `close` events | `connection`, `listening`, `close` events |
| `write()`, `end()`                       | `listen()`, `close()`                     |

## Tổng kết

- **net module**: Core module cho TCP networking trong Node.js
- **Client**: `net.createConnection()` hoặc `new net.Socket()`
- **Server**: `net.createServer()`
- **Events**: `connect`, `data`, `end`, `close`, `error`
- **Methods**: `write()`, `end()`, `destroy()`
- Phù hợp cho: TCP clients, custom protocols, chat servers
- Cần xử lý binary data và stream-based communication

## Tài liệu tham khảo

- [Net Module (Node.js)](https://nodejs.org/api/net.html)
- [Stream API (Node.js)](https://nodejs.org/api/stream.html)
- [Buffer (Node.js)](https://nodejs.org/api/buffer.html)
