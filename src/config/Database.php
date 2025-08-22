<?php
namespace Src\Config;

use PDO;
use PDOException;

class Database {
    private static $instance = null;
    public static function getConnection() {
        $DB_HOST = $_ENV['DB_HOST'];
        $DB_USER = $_ENV['DB_USER'];
        $DB_PASSWORD = $_ENV['DB_PASSWORD'];
        $DB_NAME = $_ENV['DB_NAME'];
        $DB_PORT = $_ENV['DB_PORT'];
        // var_dump(self::$instance);
        if (self::$instance === null) {
            // var_dump("se hizo la conexiòn");
            try {
                // self::$instance = new PDO("mysql:host=tramway.proxy.rlwy.net;port=32486;dbname=instagram_clone", "root", "NpGulXAsbGcguCrILrNmvZFuBJvseVbV");
                self::$instance = new PDO("mysql:$DB_HOST;port=$DB_PORT;dbname=$DB_NAME", "$DB_USER", "$DB_PASSWORD");
                self::$instance->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            } catch (PDOException $e) {
                die("Error DB: " . $e->getMessage());
            }
        }
        return self::$instance;
    }

}
