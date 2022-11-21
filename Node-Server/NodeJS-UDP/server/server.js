const udp = require('dgram');

const client = udp.createSocket('udp4');
client.on('message', (msg, rinfo) => {
    console.log(`server got: ${msg} from ${rinfo.address}:${rinfo.port}`);
});