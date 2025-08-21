<?php
namespace Src\Config;

use PDO;
use PDOException;

class Database {
    private static $instance = null;
    public static function getConnection() {
        // var_dump(self::$instance);
        if (self::$instance === null) {
            // var_dump("se hizo la conexiòn");
            try {
                self::$instance = new PDO("mysql:host=tramway.proxy.rlwy.net;port=32486;dbname=instagram_clone", "root", "NpGulXAsbGcguCrILrNmvZFuBJvseVbV");
                self::$instance->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            } catch (PDOException $e) {
                die("Error DB: " . $e->getMessage());
            }
        }
        return self::$instance;
    }

}
