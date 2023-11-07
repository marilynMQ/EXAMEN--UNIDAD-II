const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const app = express();

app.use(function(req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', '*');
    next();
});

app.use(bodyParser.json());

const PUERTO = 8080;

const conexion = mysql.createConnection(
    {
        host: 'localhost',
        database: 'services',
        user: 'root',
        password: ''
    }
);

app.listen(PUERTO, () => {
    console.log(`Servidor corriendo en el puerto ${PUERTO}`);
});

conexion.connect(error => {
    if (error) throw error;
    console.log('Conexión exitosa a la base de datos');
});

app.get('/', (req, res) => {
    res.send('API');
});

// Ruta para obtener todos los estados de pago
app.get('/estadospago', (req, res) => {
    const query = 'SELECT * FROM estadopago;';
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message);

        if (resultado.length > 0) {
            res.json(resultado);
        } else {
            res.json([]);
        }
    });
});

// Ruta para obtener un estado de pago por ID
app.get('/estadospago/:id', (req, res) => {
    const { id } = req.params;
    const query = `SELECT * FROM estadopago WHERE id_estadop=${id};`;
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message);

        if (resultado.length > 0) {
            res.json(resultado);
        } else {
            res.json([]);
        }
    });
});

// Ruta para agregar un estado de pago
app.post('/estadospago', (req, res) => {
    const estadoPago = {
        nombre: req.body.nombre,
        descripcion: req.body.descripcion
    };

    const query = 'INSERT INTO estadopago SET ?';
    conexion.query(query, estadoPago, (error) => {
        if (error) {
            console.error(error.message);
            res.status(500).json({ mensaje: "Error al agregar el estado de pago" });
        } else {
            res.status(200).json({ mensaje: "Se insertó correctamente el estado de pago" });
        }
    });
});

// Ruta para actualizar un estado de pago por ID
app.put('/estadospago/:id', (req, res) => {
    const { id } = req.params;
    const { nombre, descripcion } = req.body;

    const query = `UPDATE estadopago SET
        nombre='${nombre}',
        descripcion='${descripcion}'
        WHERE id_estadop=${id};`;

    conexion.query(query, (error) => {
        if (error) {
            console.error(error.message);
            res.status(500).json({ mensaje: "Error al actualizar el estado de pago" });
        } else {
            res.status(200).json({ mensaje: "Se actualizó correctamente el estado de pago" });
        }
    });
});

// Ruta para eliminar un estado de pago por ID
app.delete('/estadospago/:id', (req, res) => {
    const { id } = req.params;

    const query = `DELETE FROM estadopago WHERE id_estadop=${id};`;
    conexion.query(query, (error) => {
        if (error) {
            console.error(error.message);
            res.status(500).json({ mensaje: "Error al eliminar el estado de pago" });
        } else {
            res.status(200).json({ mensaje: "Se eliminó correctamente el estado de pago" });
        }
    });
});
