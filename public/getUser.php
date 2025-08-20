<?php
// Habilitar CORS
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *"); // Permite solicitudes desde cualquier dominio
header("Access-Control-Allow-Methods: POST, OPTIONS"); // Métodos permitidos (POST y OPTIONS)
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Cabeceras permitidas

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200); // Responde con un código de éxito
    exit();
}
require_once __DIR__ . '/../src/config/Database.php';
require_once __DIR__ . '/../src/models/User.php';
require_once __DIR__ . '/../src/controllers/AuthController.php';
use Src\Controllers\AuthController;

$controller = new AuthController();
$controller->getUserExist();