<?php
namespace Src\Controllers\Post;

use Src\Models\User;

class PostController {

public function getPostsByUser() {
    header('Content-Type: application/json; charset=utf-8');

    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        http_response_code(405);
        echo json_encode([
            "status" => "error",
            "message" => "Método no permitido"
        ]);
        exit;
    }

    $findLikes = User::findLikes();
    $arrayLikes = array();
    for ($i=0; $i < count($findLikes); $i++) { 
        $id_usuario = $findLikes[$i]['id_usuario'];
        $id_publicacion = $findLikes[$i]['id_publicacion'];
        $arrayLikes[$id_usuario][$id_publicacion]=$findLikes[$i];
    }

    if (isset($_GET['userIdAll'])) {
        $posts = User::findPostAll($_GET['userIdAll']);
    }
    if (isset($_GET['userId'])){
        $posts = User::findByUser($_GET['userId']);
    }

    for ($i=0; $i < count($posts); $i++) { 
        $post = $posts[$i];
        if (isset($arrayLikes[$post['id_usuario']][$post['id']])) {
            $likes = $arrayLikes[$post['id_usuario']][$post['id']]['cantidad_like'];
            $posts[$i]['likes'] = $likes;
        }
    }

// array(
//     "123"=>[
//         "32"=>[
//             l.id_like
//             l.id_usuario,
//             l.id_publicacion,
//             l.cantidad_like
//         ],
//         "33"=>[
//             l.id_like
//             l.id_usuario,
//             l.id_publicacion,
//             l.cantidad_like
//         ],
//         "34"=>[
//             l.id_like
//             l.id_usuario,
//             l.id_publicacion,
//             l.cantidad_like
//         ],
//     ]
// )

    die (
        json_encode(
            [
                "status" => true,
                "data"   => $posts
            ],
             JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT
        )
    );
}

}
