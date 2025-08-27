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

    public static function SaveLike($input) {
        $db = Database::getConnection();

        if ($input['liked']) {
            $query = "INSERT INTO likes (id_usuario, id_usuario_like, id_publicacion) VALUES (?, ?, ?)";    
        }else{
            $query = "DELETE FROM likes WHERE id_usuario = ? AND id_usuario_like = ? AND id_publicacion = ?";
        }
        $result = $db->prepare($query);
        return $result->execute([$input['id_usuario'],$input['id_usuario_like'],$input['id_publicacion']]);
    }

    public static function SaveUser($dataRegister) {
        $db = Database::getConnection();
        $query = "INSERT INTO usuarios (telefono_o_correo, contrasena, nombre_completo, usuario, fecha_nacimiento, id_tipo_usuario)
                    VALUES (?, ?, ?, ?, ?, ?)";

        $hashedPassword =password_hash($dataRegister['password'], PASSWORD_DEFAULT); 
        $result = $db->prepare($query);

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
                id_usuario_like,
                id_publicacion
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
                                    lk.id_like,
                                    per.foto AS profilePic,
                                    p.media_url AS postImage, 
                                    p.descripcion AS caption, 
                                    p.fecha_publicacion AS date
                                FROM publicaciones p
                                LEFT JOIN usuarios u ON u.id_usuario = p.id_usuario
                                LEFT JOIN perfiles per ON per.id_usuario = p.id_usuario
                                LEFT JOIN likes lk ON lk.id_usuario = p.id_usuario 
								AND lk.id_publicacion = p.id_publicacion AND lk.id_usuario_like = ?
                                WHERE p.id_usuario != ?
                                ORDER BY p.fecha_publicacion DESC
                            ");
        $stmt->execute([$userId, $userId]);
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $result;
    }

    public static function findByUser($userId) {
        $db = Database::getConnection();
        $stmt = $db->prepare("
                                SELECT 
                                    FLOOR(1 + (RAND() * 9)) as  comments,
                                    FLOOR(1 + (RAND() * 9)) as likes, 
                                    id_publicacion AS id, 
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

    public static function getUser($userId) {
        $db = Database::getConnection();
        $stmt = $db->prepare("
                                SELECT
                                    FALSE AS borderActive,
                                    us.id_usuario_seguido AS id_user,
                                    u.usuario AS username,
                                    p.foto AS profilePic
                                FROM usuarios_seguidos us
                                LEFT JOIN usuarios u ON us.id_usuario_seguido = u.id_usuario 
                                LEFT JOIN perfiles p ON u.id_usuario = p.id_usuario
                                WHERE us.id_usuario = ?
        ");
        $stmt -> execute([$userId]);
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $result;
    }

    public static function storiesByUser() {
        $db = Database::getConnection();
        $stmt = $db->prepare("
                                SELECT
                                    FALSE AS vista,
                                    h.id_historia AS id,
                                    h.media_url AS url,
                                    h.fecha_publicacion,
                                    h.id_usuario AS id_user
                                FROM historias h
        ");
        $stmt -> execute();
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $result;
    }
}