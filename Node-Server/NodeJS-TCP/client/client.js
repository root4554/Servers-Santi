// const net = require("net");

// const options = {
//     port: 9000,
//     host: "10.10.17.140",
// }

// const client = net.createConnection(options);

// client.on("connect", () => {
//     console.log("client connected");
//     client.write("hello from anass client");
// });

// client.on("error", (err) => {
//     console.log("client error: ", err.message);
// });
const net = require("net");
const readline = require("readline")
const { stdin, stdout } = process;

const options = {
    port: process.argv[3] ?? 9000,
    host: process.argv[2] ?? "localhost",
}

const client = net.createConnection(options);
const rl = readline.createInterface({ input: stdin, output: stdout });

client.on("connect", () => {
    console.log("client connected");
    runPrompt()
});

client.on("error", (err) => {
    console.log("client error: ", err.message);
});

const runPrompt = async () => {
    while (true) {
        const input = await prompt()
        client.write(input)
    }
}

const prompt = () => new Promise(res => {
    rl.question("> ", res)
})