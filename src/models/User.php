<?php
namespace Src\Models;

use Src\Config\Database;

class User {

    public static function SearchUser($user, $phone_email) {
        $db = Database::getConnection();
        $result = $db->prepare('SELECT * FROM usuarios WHERE usuario = ? OR telefono_o_correo = ?');
        $result->execute([$user,$phone_email]);
        return $result->fetch(\PDO::FETCH_ASSOC);
    }

    public static function SaveUser($dataRegister) {
        $db = Database::getConnection();
        $query = "INSERT INTO usuarios (telefono_o_correo, contrasena, nombre_completo, usuario, fecha_nacimiento, id_tipo_usuario)
          VALUES (?, ?, ?, ?, ?, ?)";

        $hashedPassword =password_hash($dataRegister['password'], PASSWORD_DEFAULT); 
        $result = $db->prepare($query);
        // var_dump($hashedPassword);
        // die;
        return $result->execute([$dataRegister['phone_email'],
            $hashedPassword,
            $dataRegister['fullName'],
            $dataRegister['userName'],
            $dataRegister['date'],
            1]
        );
    }

    public static function FindWithProfile($userOrEmail) {
        $db = Database::getConnection();
        $sql = 'SELECT  
                    u.id_usuario       AS id,          
                    u.usuario          AS username,
                    u.telefono_o_correo,
                    u.nombre_completo,
                    u.contrasena,                      
                    p.foto      AS foto,
                    p.biografia AS biografia
                FROM usuarios u
                LEFT JOIN perfiles p ON p.id_usuario = u.id_usuario
                WHERE u.usuario = ? OR u.telefono_o_correo = ?
                LIMIT 1';
        $stmt = $db->prepare($sql);
        $stmt->execute([$userOrEmail, $userOrEmail]);
        return $stmt->fetch(\PDO::FETCH_ASSOC);
    }

    public static function findLikes() {
        $db = Database::getConnection();
        $stmt = $db->prepare("
            SELECT
                id_like,
                id_usuario,
                id_publicacion,
                cantidad_like
            FROM likes
        ");
        $stmt->execute();
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $result;
    }

    public static function findPostAll($userId) {
        $db = Database::getConnection();
        $stmt = $db->prepare("
								SELECT 
                                    p.id_publicacion AS id, 
                                    u.usuario AS username,
                                    p.id_usuario,
                                    per.foto AS profilePic,
                                    p.media_url AS postImage, 
                                    p.descripcion AS caption, 
                                    p.fecha_publicacion AS date
                                FROM publicaciones p
                                LEFT JOIN usuarios u ON u.id_usuario = p.id_usuario
                                LEFT JOIN perfiles per ON per.id_usuario = p.id_usuario
                                WHERE p.id_usuario != ?
                                ORDER BY p.fecha_publicacion DESC
                            ");
        $stmt->execute([$userId]);
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $result;
    }

    public static function findByUser($userId) {
        $db = Database::getConnection();
        $stmt = $db->prepare("
                                SELECT 
                                    FLOOR(1 + (RAND() * 9)) as  comments,
                                    FLOOR(1 + (RAND() * 9)) as likes, 
                                    id_publicacion, 
                                    id_usuario, 
                                    media_url, 
                                    descripcion, 
                                    fecha_publicacion 
                                FROM publicaciones 
                                WHERE id_usuario= ? 
                                ORDER BY fecha_publicacion DESC
                            ");
        $stmt->execute([$userId]);
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $result;
    }

    public static function CreateUser() {
        $db = Database::getConnection();
    }
}