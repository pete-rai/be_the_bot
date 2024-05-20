<?php

include 'database.php';

DEFINE('QUERY', "SELECT area, name FROM subject ORDER BY CASE WHEN area = 'other' THEN 1 ELSE 0 END, area, name"); // other last
header('Content-Type: application/json');
echo json_encode(read(QUERY));
