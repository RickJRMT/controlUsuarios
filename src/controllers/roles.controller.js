const db = require ('../config/conexion_db'); 

class RolesController {
    async obtener(req, res) {
        try {
            const [roles] = await db.query (`
                SELECT r.id_rol, r.nombre, 
                COUNT (u.id_usuario) AS cantidad_usuarios
                FROM roles r
                LEFT JOIN usuarios u ON u.id_rol = r.id_rol
                GROUP BY r.id_rol, r.nombre
                `); 
                res.json(roles)
        }catch (error) {
            res.status(500).json({error: 'erroor al obtener roles'}); 
        }
    }
async obtenerRolPorId(req, res) {
        const { id } = req.params;
        try {
            const [rolRows] = await db.query(
                'SELECT * FROM roles WHERE id_rol = ?',
                [id]
            );

            if (rolRows.length === 0) {
                return res.status(404).json({ error: 'Rol no encontrado' });
            }

            const rol = rolRows[0];

            // Traemos los permisos de ese rol
            const [permisos] = await db.query(
                `SELECT p.id_permiso, p.nombre 
                 FROM rol_permiso rp
                 JOIN permisos p ON rp.permiso_id = p.id_permiso
                 WHERE rp.id_rol = ?`,
                [rol.id_rol]
            );

            rol.permisos = permisos.map(p => ({
                id: p.id_permiso,
                nombre: p.nombre
            }));

            res.json(rol);
        } catch (error) {
            console.error(error);
            res.status(500).json({ error: 'Error al obtener rol con permisos' });
        }
    }



}