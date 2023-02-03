const http = require('http');
const fs = require("fs");
const os = require('os');

const hostname = os.hostname();
const port = process.argv[2] || 3000;
const api = process.env.API || 'http://localhost:4000'

// PreProcesado para la formación de la SPA
var html = `<pre>${api}</pre>`; //Aquí iría el contenido de asp.html, si no queremos usar require("fs")
html = fs.readFileSync(__dirname + '/spa.html', 'utf8');
html = html.replaceAll("${api}", api);
html = "SPA created by " + __filename + html;

// GET
const server = http.createServer((req, res) => {
    res.setHeader('Content-Type', 'text/html');
    if (req.url == '/getapi') html = api; //SPA nos pide la API y api pasado como variable de entorno
    res.statusCode = 200;
    res.end(html);
});

// '0.0.0.0' Escuchamos por todos las interfaces
server.listen(port, '0.0.0.0', () => {
    console.log(`WEB ${hostname} listen on port ${port}`);
    console.log(`API fetch from ${api}/`);
});