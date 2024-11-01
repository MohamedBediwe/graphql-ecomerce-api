<?php


require_once __DIR__ . '/../vendor/autoload.php';

use Dotenv\Dotenv;
use Config\JwtManager;
use Config\Database;

$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();


$output = shell_exec("openssl rand -base64 32");
echo $output;
echo "<br>";
$random_bytes = random_bytes(32);
$random_string = bin2hex($random_bytes);

echo $random_string;

$random_string1 = uniqid(64, true);
echo "<br>";
echo "<br>";
echo $random_string1;
echo "<br>";
echo "##################################################";
echo "<br>";
// var_dump($_ENV);
$data = JwtManager::verifyToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3Mjk4OTM3NzQsImV4cCI6MTcyOTg5NzM3NCwidXNlcl9pZCI6MjMsInVzZXJfZW1haWwiOiJtb2hhbWVkQHlhaG9vLmNvbSJ9.l4Zc5valY175F8NU1k6zuM_SjlPUtaPrOJt_OgDQv6E");
var_dump($data->user_id);
echo "<br>";
echo "##################################################";

echo "<br>";
$user_id = 4;
echo "<pre>";
$pdo = Database::getConnection();
$query = "SELECT * FROM orders WHERE user_id = :user_id";
$stmt = $pdo->prepare($query);
$stmt->bindParam(':user_id', $user_id);
$stmt->execute();
$orders = $stmt->fetchAll();
var_dump($orders);

echo "</pre>";
echo "<pre>";
var_dump(apache_request_headers());

echo "</pre>";
var_dump($_SERVER['HTTP_AUTHORIZATION']);
