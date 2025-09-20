const jwt = require('jsonwebtoken');

function validarToken(req, res, next){
    const token = req.headers['authorization']?.split(' ')[1];
    if(!token) return res.status(403).json({error: 'token requerido'});

    jwt.verify(token, process.env.JWT_SECRET || 'secreto', (err, decoded) =>{
        if(err) return res.status(401).json({error: 'Token invalido' });

        req.user = decoded;
        next();
    });
}

module.exports = validarToken;