// Install with: npm install ws
const WebSocket = require('ws');
const server = new WebSocket.Server({ port: 8080 });

console.log("WebSocket server started on ws://localhost:8080");

server.on('connection', socket => {
    console.log("Client connected.");

    socket.on('message', message => {
        console.log("Received from client:", message);
        // Echo back to client
        socket.send(`Server received: ${message}`);
    });

    socket.on('close', () => {
        console.log("Client disconnected.");
    });

    // Send welcome message
    socket.send("Hello from server!");
});
