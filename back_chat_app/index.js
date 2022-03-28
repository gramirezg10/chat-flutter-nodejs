const express = require('express');
const path = require('path');
require('dotenv').config();

// db config
const { dbConnection } = require('./database/config');
dbConnection();

// App de Express
const app = express();

// Lectura y parseo del body
app.use(express.json());

// Node Server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/socket');




// Path público
const publicPath = path.resolve( __dirname, 'public' );
app.use( express.static( publicPath ) );

//Rutas
app.use('/api/login', require('./routes/auth'));


const port = process.env.PORT || 3000

server.listen( port, ( err ) => {

    if ( err ) throw new Error(err);

    console.log('Servidor corriendo en puerto', port );

});


