<?php
namespace Src\Controllers;

use Src\Models\User;

class AuthController{
    
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