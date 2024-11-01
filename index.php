<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');

require_once __DIR__ . '/vendor/autoload.php';
require_once __DIR__ . '/schema.php';

use GraphQL\GraphQL;
use GraphQL\Error\DebugFlag;
use Dotenv\Dotenv;



if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
  exit;
}

$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

try {
  $rawInput = file_get_contents('php://input');
  $input = json_decode($rawInput, true);
  $query = $input['query'];
  $variableValues = isset($input['variables']) ? $input['variables'] : null;

  $result = GraphQL::executeQuery(
    $schema,
    $query,
    null,
    null,
    $variableValues
  );

  $output = $result->toArray(DebugFlag::INCLUDE_DEBUG_MESSAGE);
} catch (\Exception $e) {
  $output = [
    'errors' => [
      [
        'message' => $e->getMessage()
      ]
    ]
  ];
}

header('Content-Type: application/json');
echo json_encode($output);
