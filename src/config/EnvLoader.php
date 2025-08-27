<?php
namespace Src\ConfigEnv;

use Exception;

class EnvLoader {
    // Cargar el archivo .env
    public static function loadEnv($path)
    {
        if (!file_exists($path)) {
            throw new Exception(".env file not found at $path");
        }

        $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        foreach ($lines as $line) {
            // Ignorar comentarios
            if (strpos(trim($line), '#') === 0) {
                continue;
            }

            // Separar por "="
            list($key, $value) = explode('=', $line, 2);

            $key = trim($key);
            $value = trim($value);

            // Eliminar comillas si existen
            $value = trim($value, '"\'');

            // Asignar las variables al entorno
            putenv("$key=$value");
            $_ENV[$key] = $value;
            $_SERVER[$key] = $value;
        }
    }
    public static function getEnv($environment_var){
        // Es necesario usar esta variable super global para acceder a atributos archivo de configuración .env
        if( !isset($_ENV[ $environment_var ]) ){
            return NULL;
        }
        // Es necesario usar esta variable super global para acceder a atributos archivo de configuración .env
        return $_ENV[ $environment_var ];
    }
}