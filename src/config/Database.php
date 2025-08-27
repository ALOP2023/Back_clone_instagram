<?php
namespace Src\Config;
use Src\ConfigEnv\EnvLoader; 
use PDO;
use PDOException;
EnvLoader::loadEnv(__DIR__ . '/../../public/.env');

class Database {
    private static $instance = null;
    public static function getConnection() {
        $DB_HOST = EnvLoader::getEnv('DB_HOST'); 
        $DB_USER = EnvLoader::getEnv('DB_USER');
        $DB_PASSWORD = EnvLoader::getEnv('DB_PASSWORD'); 
        $DB_NAME = EnvLoader::getEnv('DB_NAME'); 
        $DB_PORT = EnvLoader::getEnv('DB_PORT'); 
        if (self::$instance === null) {
            try {
                self::$instance = new PDO("mysql:host=$DB_HOST;port=$DB_PORT;dbname=$DB_NAME","$DB_USER","$DB_PASSWORD");
                self::$instance->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            } catch (PDOException $e) {
                die("Error DB: " . $e->getMessage());
            }
        }
        return self::$instance;
    }

}
