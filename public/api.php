<?php
header('Content-Type: application/json; charset=utf-8');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../src/config/EnvLoader.php';
require_once __DIR__ . '/../src/config/Database.php';
include_once '../src/config/EnvLoader.php';
require_once __DIR__ . '/../src/config/Database.php';
require_once __DIR__ . '/../src/models/User.php';
require_once __DIR__ . '/../src/controllers/UserController.php';

use Src\Controllers\User\UserController;

switch ($_SERVER['REQUEST_METHOD']) {
    case 'POST':
        $input = json_decode(file_get_contents('php://input'), true);
        if (!isset($input['action'])) {
            http_response_code(400);
            echo json_encode(["error" => "No se especificó ninguna acción en POST."]);
            exit();
        }
        routeRequest($input['action'], $input);
        break;

    case 'GET':
        if (!isset($_GET['action'])) {
            http_response_code(400);
            echo json_encode(["error" => "No se especificó ninguna acción en GET."]);
            exit();
        }
        routeRequest($_GET['action'], $_GET);
        break;

    default:
        http_response_code(405);
        echo json_encode(["error" => "Método HTTP no permitido."]);
        break;
}

function routeRequest($action, $params) {
    switch ($action) {
        case 'getUserByUser':
            $controller = new UserController();
            $controller->getUserByUser($params);
            break;

        default:
            http_response_code(404);
            echo json_encode(["error" => "Acción '$action' no reconocida."]);
            break;
    }
}
