require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json({limit: '20mb'}));
app.use(express.urlencoded({ extended: true, limit: '20mb'}));

app.use('/api/auth', require('./routes/auth.routes'));
app.use('/api/permisos', require('./routes/permisos.routes'));
app.use('/api/rol-permiso', require('./routes/roles_permisos.routes'));
app.use('/api/roles', require('./routes/roles.routes'));
app.use('/api/usuarios', require('./routes/usuarios.routes'));

module.exports = app;