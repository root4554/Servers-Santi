import mysql from "mysql";
import express from "express";
import cors from "cors";

const app = express();
app.use(cors());
app.use(express.json());

// Conexión a la base de datos
const conexion = mysql.createConnection({
  host: "185.60.40.210",
  database: "gonzalo",
  user: "gonzalo",
  password: "12345678",
});
// Abrimos la conexión a la base de datos y la dejamos abierta
conexion.connect((err) => {
  if (err) {
    console.error("Error de conexion: " + err.stack);
    return;
  }
  console.log("Conectado con el identificador " + conexion.threadId);
});

app.get("/situacion", function (req, res) {
  conexion.query(`SELECT * FROM Entradas`, function (error, results, fields) {
    if (error) throw error;
    res.send(results);
  });
});

// establecemos nuestro puerto de escucha
const port = process.env.PORT || 8080;
// iniciamos el servidor
app.listen(port);
console.log("API escuchando en el puerto " + port);
