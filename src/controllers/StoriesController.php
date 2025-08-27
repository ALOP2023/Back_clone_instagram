<?php
namespace Src\Controllers\Stories;

use Src\Models\User;

class StoriesController {
    public function getStoriesByUser() {
        header('Content-Type: application/json; charset=utf-8');
        $getUser = User::getUser($_GET['userId']);
        $storiesByUser = User::storiesByUser();
        // var_dump($getUser);
        // die;
        for ($i=0; $i < count($getUser); $i++) {
            $stories = []; 
            $getUser[$i]["borderActive"]= false;
            for ($s=0; $s < count($storiesByUser) ; $s++) { 
                if ($getUser[$i]["id_user"] === $storiesByUser[$s]["id_user"] ) {
                    $storiesByUser[$s]["vista"]= false;
                    array_push($stories,$storiesByUser[$s]);
                }
            }
            $getUser[$i]['stories'] = $stories;
        }
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