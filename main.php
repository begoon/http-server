<?php

function version() {
    $response = ["version" => "1.0.0"];

    header('Content-Type: application/json');
    http_response_code(200);

    echo json_encode($response);
}

$requestUri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

switch ($requestUri) {
    case '/version':
        version();
        break;
    default:
        http_response_code(404);
        echo json_encode(["error" => "Not Found"]);
        break;
}
