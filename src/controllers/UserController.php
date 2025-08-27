<?php
namespace Src\Controllers\User;

use Src\Models\User;

class UserController {
    public function getUserByUser($params) {
        header('Content-Type: application/json; charset=utf-8');
        $getUser = User::obtenerEstadisticasUsuario($params['userId']);
        die (
            json_encode(
                [
                    "status" => true,
                    "data"   => $getUser
                ],
                JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT
            )
        );
    }


}