const net = require("net");
// const udp = require('dgram')
const server = net.createServer();

server.on('connection', (socket) => {
    socket.on('data', (data) => {
        console.log("\nserver received: ", data.toString());
        socket.write("Hello from anass server, we received your message!");
    })
    
    socket.on('close', () => {
        console.log("server closed");
    })

socket.on('error', (err) => {
        console.log("server socket error: ", err.message);
    })

});

server.listen(9000, () => {
    console.log("server listening on port 9000", server.address());
});


