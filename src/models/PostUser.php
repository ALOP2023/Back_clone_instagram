<?php
namespace Src\Models\Post;

use Src\Config\Database;
class PostUser {
    public static function findByUser($userId) {
        $db = Database::getConnection();
        $stmt = $db->prepare("SELECT id_publicacion, id_usuario, media_url, descripcion, fecha_publicacion 
                              FROM publicaciones 
                              WHERE id_usuario= ? 
                              ORDER BY fecha_publicacion DESC");
        $stmt->execute([$userId]);
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        return $result;
    }
}