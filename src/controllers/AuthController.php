<?php
namespace Src\Controllers;

use Src\Models\User;

class AuthController{
    // public function login(){
    //     $input = json_decode(file_get_contents("php://input"), true);
    //     $result= User::SearchUser($input['username'],$input['username']);
    //     $password = $input['password'];
    //     $usernameOrEmail = $input['username'] ?? '';
    //     $row = User::FindWithProfile($usernameOrEmail);

    //     if ($result === false ) {
    //         echo json_encode([
    //             "status" => false,
    //             "message" => "La contraseña no es correcta. Compruébala."
    //         ]);
    //         exit;
    //     }
    //     if (password_verify($password, $result["contrasena"])) {
    //         echo json_encode([
    //             "status" => true,
    //             "message" => "Inicio de sesión exitoso"
    //         ]);    
    //     } else {
    //         echo json_encode([
    //             "status" => false,
    //             "message" => "La contraseña no es correcta. Compruébala."
    //         ]);
    //         exit;
    //     }
    //     echo json_encode([
    //         "status"  => true,
    //         "message" => "Inicio de sesión exitoso",
    //         "user"    => [
    //             "id"             => (int)$row["id"],
    //             "username"       => $row["username"],
    //             "foto_perfil"    => $row["foto"] ?? null
    //         ]
    //     ]);
    //     exit;

    // }

    public function login() {
        $input = json_decode(file_get_contents("php://input"), true);
        $usernameOrEmail = $input['username'] ?? '';
        $password = $input['password'] ?? '';

        // Traemos el usuario junto con el perfil
        $row = User::FindWithProfile($usernameOrEmail);

        // Si no existe el usuario
        if (!$row) {
            echo json_encode([
                "status" => false,
                "message" => "Usuario no encontrado."
            ]);
            exit;
        }

        // Verificamos contraseña
        if (!password_verify($password, $row["contrasena"])) {
            echo json_encode([
                "status" => false,
                "message" => "La contraseña no es correcta. Compruébala."
            ]);
            exit;
        }

        // Si todo es correcto
        echo json_encode([
            "status"  => true,
            "message" => "Inicio de sesión exitoso",
            "user"    => [
                "id"          => (int)$row["id"],
                "username"    => $row["username"],
                "nombre_completo"=> $row["nombre_completo"],
                "foto_perfil"    => $row["foto"] ?? null,
                "bio"            => $row["biografia"] ?? null,
            ]
        ]);
        exit;
    }


    public function register(){
        $input = json_decode(file_get_contents("php://input"), true);
        $result= User::SearchUser($input["dataRegister"]['userName'],$input["dataRegister"]['phone_email']);
        if($result){
            echo json_encode([
                "status" => false,
                "message" => "De acuerdo con la información que proporcionaste, no puedes registrarte en Instagram."
            ]);
            exit;
        }
        $save= User::SaveUser($input["dataRegister"]);
        if(!$save){
            echo json_encode([
                "status" => false,
                "message" => "De acuerdo con la información que proporcionaste, no puedes registrarte en Instagram."
            ]);
            exit;
        }
        echo json_encode([
                "status" => true,
                "message" => "exitoso"
            ]);
            exit;
        // var_dump($result);
        // die;
        // if (!$result){
        //     if(is_numeric($input['phone_email'])){
        //         if (strlen($input['phone_email']) < 10){
        //             echo json_encode([
        //                 "status" => false,
        //                 "message" => "Parece que tu número de teléfono es incorrecto. Ingresa el número completo, incluido el código de país."
        //             ]);
        //             exit;
        //         }
        //     } else if(filter_var($input['phone_email'], FILTER_VALIDATE_EMAIL)){
        //         echo json_encode([
        //             "status" => true,
        //             "message" => "Email válido."
        //         ]);
        //         exit;
        //     } elseif (strlen($input['password']) < 6) {
        //         echo json_encode([
        //             "status" => false,
        //             "message" => "Crea una contraseña que tenga al menos 6 caracteres."
        //         ]);
        //     } 
        //     else {
        //         echo json_encode([
        //             "status" => false,
        //             "message" => "Enter a valid email address."
        //         ]);
        //         exit;
        //     }
            
        //     // $phone_email = $input['phone_email'];
            
        // } else{
        //     echo json_encode([
        //         "status" => false,
        //         "message" => "Este nombre de usuario no está disponible. Prueba con otro."
        //     ]);
        // }
    }

    public function getUserExist(){
        $input = json_decode(file_get_contents("php://input"), true);
        $result= User::SearchUser($input['userName'],$input['userName']);
        if ($result === false ) {
            echo json_encode([
                "status" => false,
            ]);
            exit;
        }
        echo json_encode([
                "status" => true,
            ]);
    }
}