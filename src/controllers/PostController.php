<?php
namespace Src\Controllers\Post;

use Src\Models\User;

class PostController {

    public function getPostsByUser() {
        header('Content-Type: application/json; charset=utf-8');
            $posts = [];
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
            $id_usuario_like = $findLikes[$i]['id_usuario_like'];
            $arrayLikes[$id_usuario][$id_publicacion][$id_usuario_like]=$findLikes[$i];
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
                $likes = $arrayLikes[$post['id_usuario']][$post['id']];
                $posts[$i]['likes'] = count($likes);
            }else{
                $posts[$i]['likes'] = 0;
            }
        }
        // var_dump($posts);
        // die;
        
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

