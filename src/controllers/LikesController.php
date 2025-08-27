<?php
namespace Src\Controllers\Like;

use Src\Models\User;

class LikesController {
    public function saveLike() {
        $input = json_decode(file_get_contents("php://input"), true);
        $save= User::SaveLike($input);
        if(!$save){
            echo json_encode([
                "status" => false,
                "message" => "no fue posible dar like"
            ]);
            exit;
        }
        echo json_encode([
                "status" => true,
                "message" => "exitoso"
            ]);
            exit;
    }
}