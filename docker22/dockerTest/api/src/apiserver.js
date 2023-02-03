const http = require('http');
const os = require('os');
const url = require('url');

const port = process.argv[2] || 4000;
const hostname = os.hostname();

// GET
const server = http.createServer((req, res) => {
    // var ipreq = req.headers['x-forwarded-for'] ||
    //     req.socket.remoteAddress ||
    //     null;
    
    var param = parseInt(url.parse(req.url,true).query['data'] || 0);
    var json = JSON.stringify({
        host: req.socket.localAddress+":"+server.address().port,
        time: new Date().toLocaleTimeString(),
        data: param + 1
    });

    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', '*');
    res.setHeader('Access-Control-Allow-Headers', '*');
    res.setHeader('Content-Type', 'application/json');
    res.statusCode = 200;
    res.end(json);

    //console.log(json);
});

// RUN
server.listen(port, '0.0.0.0', () => {
    // 0.0.0.0 = Todas. Specifies the IP address we want to listen to
    console.log(`API ${hostname} listen on port ${server.address().port}`);
});