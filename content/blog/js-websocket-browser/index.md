---
title: "WebSocket bằng JavaScript phía trình duyệt"
date: 2025-10-11
draft: false
tags: ["JavaScript", "WebSocket", "Real-time"]
categories: ["JavaScript"]
summary: "Tìm hiểu WebSocket API trong trình duyệt để xây dựng ứng dụng real-time với JavaScript."
cover:
  image: "/images/covers/js-websocket.png"
  alt: "WebSocket trong JavaScript"
  caption: "WebSocket - Real-time communication"
---

## WebSocket là gì?

**WebSocket** là giao thức truyền thông **hai chiều** (full-duplex) qua một kết nối TCP duy nhất. Khác với HTTP request-response, WebSocket cho phép server **push** dữ liệu đến client bất cứ lúc nào.

### So sánh HTTP vs WebSocket

**HTTP:**

```
Client -> Request -> Server
Client <- Response <- Server
(Kết thúc kết nối)
```

**WebSocket:**

```
Client <---> Persistent Connection <---> Server
(Kết nối luôn mở, dữ liệu đi về hai chiều)
```

## Khi nào dùng WebSocket?

✅ **Nên dùng:**

- Chat applications
- Real-time notifications
- Live updates (stock prices, sports scores)
- Multiplayer games
- Collaborative editing
- Live streaming data

❌ **Không cần:**

- REST API calls
- Tải trang web thông thường
- One-time data fetch

## WebSocket API trong Browser

### Tạo WebSocket Connection

```javascript
// Kết nối đến WebSocket server
const socket = new WebSocket("ws://localhost:8080");

// Hoặc với SSL
const secureSocket = new WebSocket("wss://example.com/socket");

console.log("Đang kết nối...");
```

### WebSocket Events

```javascript
const socket = new WebSocket("ws://localhost:8080");

// 1. onopen - Khi kết nối thành công
socket.onopen = (event) => {
  console.log("✅ WebSocket connected!");
  console.log("Ready state:", socket.readyState);
};

// 2. onmessage - Khi nhận message từ server
socket.onmessage = (event) => {
  console.log("📩 Nhận:", event.data);

  // Parse JSON nếu cần
  try {
    const data = JSON.parse(event.data);
    console.log("Parsed data:", data);
  } catch (e) {
    console.log("Text message:", event.data);
  }
};

// 3. onerror - Khi có lỗi
socket.onerror = (error) => {
  console.error("❌ WebSocket error:", error);
};

// 4. onclose - Khi kết nối đóng
socket.onclose = (event) => {
  console.log("👋 WebSocket closed");
  console.log("Code:", event.code);
  console.log("Reason:", event.reason);
  console.log("Clean:", event.wasClean);
};
```

### Gửi dữ liệu

```javascript
// Gửi text
socket.send("Hello Server!");

// Gửi JSON
const data = { type: "message", content: "Hello" };
socket.send(JSON.stringify(data));

// Gửi ArrayBuffer
const buffer = new ArrayBuffer(8);
socket.send(buffer);

// Gửi Blob
const blob = new Blob(["Hello"], { type: "text/plain" });
socket.send(blob);
```

### Đóng kết nối

```javascript
// Đóng kết nối
socket.close();

// Đóng với code và reason
socket.close(1000, "Work complete");
```

## Ready States

```javascript
console.log(socket.readyState);

// WebSocket.CONNECTING = 0 - Đang kết nối
// WebSocket.OPEN = 1 - Đã kết nối, sẵn sàng giao tiếp
// WebSocket.CLOSING = 2 - Đang đóng
// WebSocket.CLOSED = 3 - Đã đóng

// Kiểm tra trạng thái
if (socket.readyState === WebSocket.OPEN) {
  socket.send("Hello!");
}
```

## Chat Application Example

### HTML

```html
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <title>WebSocket Chat</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
      }
      #messages {
        border: 1px solid #ddd;
        height: 300px;
        overflow-y: auto;
        padding: 10px;
        margin-bottom: 10px;
        background: #f9f9f9;
      }
      .message {
        margin: 5px 0;
        padding: 5px;
      }
      .message.sent {
        text-align: right;
        color: blue;
      }
      .message.received {
        text-align: left;
        color: green;
      }
      .message.system {
        text-align: center;
        color: gray;
        font-style: italic;
      }
      #messageInput {
        width: 80%;
        padding: 10px;
      }
      #sendButton {
        padding: 10px 20px;
      }
      .status {
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
      }
      .status.connected {
        background: #d4edda;
        color: #155724;
      }
      .status.disconnected {
        background: #f8d7da;
        color: #721c24;
      }
    </style>
  </head>
  <body>
    <h1>💬 WebSocket Chat</h1>

    <div id="status" class="status disconnected">⏳ Đang kết nối...</div>

    <div id="messages"></div>

    <div>
      <input type="text" id="messageInput" placeholder="Nhập tin nhắn..." />
      <button id="sendButton" disabled>Gửi</button>
    </div>

    <script src="chat.js"></script>
  </body>
</html>
```

### JavaScript (chat.js)

```javascript
class WebSocketChat {
  constructor(url) {
    this.url = url;
    this.socket = null;
    this.init();
  }

  init() {
    this.messageInput = document.getElementById("messageInput");
    this.sendButton = document.getElementById("sendButton");
    this.messagesDiv = document.getElementById("messages");
    this.statusDiv = document.getElementById("status");

    this.sendButton.addEventListener("click", () => this.sendMessage());
    this.messageInput.addEventListener("keypress", (e) => {
      if (e.key === "Enter") {
        this.sendMessage();
      }
    });

    this.connect();
  }

  connect() {
    this.socket = new WebSocket(this.url);

    this.socket.onopen = () => {
      console.log("✅ Connected to server");
      this.updateStatus("Đã kết nối", true);
      this.sendButton.disabled = false;
      this.addMessage("Đã kết nối đến server", "system");
    };

    this.socket.onmessage = (event) => {
      console.log("📩 Received:", event.data);
      this.handleMessage(event.data);
    };

    this.socket.onerror = (error) => {
      console.error("❌ WebSocket error:", error);
      this.addMessage("Lỗi kết nối", "system");
    };

    this.socket.onclose = (event) => {
      console.log("👋 Connection closed");
      this.updateStatus("Mất kết nối", false);
      this.sendButton.disabled = true;
      this.addMessage("Đã ngắt kết nối", "system");

      // Auto reconnect sau 3 giây
      setTimeout(() => {
        this.addMessage("Đang kết nối lại...", "system");
        this.connect();
      }, 3000);
    };
  }

  sendMessage() {
    const message = this.messageInput.value.trim();

    if (message === "") {
      return;
    }

    if (this.socket.readyState === WebSocket.OPEN) {
      const data = {
        type: "message",
        content: message,
        timestamp: new Date().toISOString(),
      };

      this.socket.send(JSON.stringify(data));
      this.addMessage(message, "sent");
      this.messageInput.value = "";
    } else {
      alert("Chưa kết nối đến server!");
    }
  }

  handleMessage(data) {
    try {
      const message = JSON.parse(data);

      switch (message.type) {
        case "message":
          this.addMessage(message.content, "received");
          break;
        case "notification":
          this.addMessage(message.content, "system");
          break;
        default:
          this.addMessage(data, "received");
      }
    } catch (e) {
      // Plain text message
      this.addMessage(data, "received");
    }
  }

  addMessage(text, type = "received") {
    const messageDiv = document.createElement("div");
    messageDiv.className = `message ${type}`;

    const time = new Date().toLocaleTimeString("vi-VN");

    if (type === "sent") {
      messageDiv.textContent = `You [${time}]: ${text}`;
    } else if (type === "received") {
      messageDiv.textContent = `Server [${time}]: ${text}`;
    } else {
      messageDiv.textContent = `[${time}] ${text}`;
    }

    this.messagesDiv.appendChild(messageDiv);
    this.messagesDiv.scrollTop = this.messagesDiv.scrollHeight;
  }

  updateStatus(text, connected) {
    this.statusDiv.textContent = connected ? "✅ " + text : "❌ " + text;
    this.statusDiv.className = connected
      ? "status connected"
      : "status disconnected";
  }
}

// Khởi tạo chat
const chat = new WebSocketChat("ws://localhost:8080");
```

## Advanced WebSocket Client

```javascript
class AdvancedWebSocket {
  constructor(url, options = {}) {
    this.url = url;
    this.options = {
      reconnectInterval: 3000,
      maxReconnectAttempts: 5,
      heartbeatInterval: 30000,
      ...options,
    };

    this.socket = null;
    this.reconnectAttempts = 0;
    this.heartbeatTimer = null;
    this.eventHandlers = {};

    this.connect();
  }

  connect() {
    try {
      this.socket = new WebSocket(this.url);
      this.setupEventListeners();
    } catch (error) {
      console.error("Failed to create WebSocket:", error);
      this.reconnect();
    }
  }

  setupEventListeners() {
    this.socket.onopen = () => {
      console.log("✅ WebSocket connected");
      this.reconnectAttempts = 0;
      this.startHeartbeat();
      this.emit("open");
    };

    this.socket.onmessage = (event) => {
      this.handleMessage(event.data);
    };

    this.socket.onerror = (error) => {
      console.error("❌ WebSocket error:", error);
      this.emit("error", error);
    };

    this.socket.onclose = (event) => {
      console.log("👋 WebSocket closed:", event.code, event.reason);
      this.stopHeartbeat();
      this.emit("close", event);

      if (!event.wasClean) {
        this.reconnect();
      }
    };
  }

  handleMessage(data) {
    try {
      const message = JSON.parse(data);

      // Heartbeat pong
      if (message.type === "pong") {
        return;
      }

      this.emit("message", message);

      // Emit specific event type
      if (message.type) {
        this.emit(message.type, message.data);
      }
    } catch (e) {
      this.emit("message", data);
    }
  }

  send(data) {
    if (this.socket.readyState === WebSocket.OPEN) {
      const message = typeof data === "string" ? data : JSON.stringify(data);
      this.socket.send(message);
      return true;
    } else {
      console.warn("WebSocket not open. State:", this.socket.readyState);
      return false;
    }
  }

  close(code = 1000, reason = "Client closing") {
    this.stopHeartbeat();
    this.socket.close(code, reason);
  }

  reconnect() {
    if (this.reconnectAttempts >= this.options.maxReconnectAttempts) {
      console.error("Max reconnect attempts reached");
      this.emit("maxReconnectAttemptsReached");
      return;
    }

    this.reconnectAttempts++;
    console.log(
      `Reconnecting... (${this.reconnectAttempts}/${this.options.maxReconnectAttempts})`
    );

    setTimeout(() => {
      this.connect();
    }, this.options.reconnectInterval);
  }

  startHeartbeat() {
    this.stopHeartbeat();

    this.heartbeatTimer = setInterval(() => {
      if (this.socket.readyState === WebSocket.OPEN) {
        this.send({ type: "ping", timestamp: Date.now() });
      }
    }, this.options.heartbeatInterval);
  }

  stopHeartbeat() {
    if (this.heartbeatTimer) {
      clearInterval(this.heartbeatTimer);
      this.heartbeatTimer = null;
    }
  }

  // Event emitter
  on(event, handler) {
    if (!this.eventHandlers[event]) {
      this.eventHandlers[event] = [];
    }
    this.eventHandlers[event].push(handler);
  }

  off(event, handler) {
    if (this.eventHandlers[event]) {
      this.eventHandlers[event] = this.eventHandlers[event].filter(
        (h) => h !== handler
      );
    }
  }

  emit(event, data) {
    if (this.eventHandlers[event]) {
      this.eventHandlers[event].forEach((handler) => handler(data));
    }
  }
}

// Sử dụng
const ws = new AdvancedWebSocket("ws://localhost:8080", {
  reconnectInterval: 3000,
  maxReconnectAttempts: 5,
  heartbeatInterval: 30000,
});

ws.on("open", () => {
  console.log("Connected!");
  ws.send({ type: "join", room: "lobby" });
});

ws.on("message", (message) => {
  console.log("Received:", message);
});

ws.on("close", () => {
  console.log("Connection closed");
});
```

## WebSocket với Promise

```javascript
function connectWebSocket(url) {
  return new Promise((resolve, reject) => {
    const socket = new WebSocket(url);

    socket.onopen = () => {
      resolve(socket);
    };

    socket.onerror = (error) => {
      reject(error);
    };
  });
}

// Sử dụng với async/await
async function main() {
  try {
    const socket = await connectWebSocket("ws://localhost:8080");
    console.log("✅ Connected!");

    socket.send("Hello Server!");

    socket.onmessage = (event) => {
      console.log("Message:", event.data);
    };
  } catch (error) {
    console.error("Connection failed:", error);
  }
}
```

## Binary Data với WebSocket

```javascript
const socket = new WebSocket("ws://localhost:8080");

// Set binary type
socket.binaryType = "arraybuffer"; // hoặc 'blob'

socket.onopen = () => {
  // Gửi ArrayBuffer
  const buffer = new ArrayBuffer(8);
  const view = new DataView(buffer);
  view.setInt32(0, 12345);
  socket.send(buffer);

  // Gửi Typed Array
  const uint8Array = new Uint8Array([1, 2, 3, 4, 5]);
  socket.send(uint8Array);
};

socket.onmessage = (event) => {
  if (event.data instanceof ArrayBuffer) {
    const view = new DataView(event.data);
    console.log("Received number:", view.getInt32(0));
  }
};
```

## Best Practices

### 1. Xử lý reconnection

```javascript
function createResilientWebSocket(url) {
  let socket;
  let reconnectTimer;

  function connect() {
    socket = new WebSocket(url);

    socket.onclose = () => {
      console.log("Disconnected, reconnecting in 3s...");
      reconnectTimer = setTimeout(connect, 3000);
    };

    return socket;
  }

  return connect();
}
```

### 2. Heartbeat/Ping-Pong

```javascript
let heartbeatInterval;

socket.onopen = () => {
  heartbeatInterval = setInterval(() => {
    socket.send(JSON.stringify({ type: "ping" }));
  }, 30000); // 30s
};

socket.onclose = () => {
  clearInterval(heartbeatInterval);
};
```

### 3. Message queue khi offline

```javascript
class QueuedWebSocket {
  constructor(url) {
    this.url = url;
    this.messageQueue = [];
    this.connect();
  }

  connect() {
    this.socket = new WebSocket(this.url);

    this.socket.onopen = () => {
      // Gửi các message đã queue
      while (this.messageQueue.length > 0) {
        const message = this.messageQueue.shift();
        this.socket.send(message);
      }
    };
  }

  send(message) {
    if (this.socket.readyState === WebSocket.OPEN) {
      this.socket.send(message);
    } else {
      this.messageQueue.push(message);
    }
  }
}
```

## Tổng kết

- **WebSocket** = Full-duplex, real-time communication
- Browser WebSocket API đơn giản: `new WebSocket(url)`
- 4 events: `onopen`, `onmessage`, `onerror`, `onclose`
- Phù hợp cho chat, notifications, live updates
- Cần xử lý reconnection và heartbeat
- Hỗ trợ cả text và binary data

## Tài liệu tham khảo

- [WebSocket API (MDN)](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)
- [WebSocket Protocol (RFC 6455)](https://tools.ietf.org/html/rfc6455)
- [Socket.IO](https://socket.io/) - WebSocket library với fallbacks
