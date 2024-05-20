<?php

include 'database.php';

// --- constants

define('QUERY', 'SELECT m.*, s.* FROM multichoice m, subject s WHERE m.subject_id = s.id AND [WHICH] ORDER BY RAND() LIMIT 1');

// --- returns a random question

function question() {
    $params = [];
    $query  = QUERY;

    if (isset($_GET['area'])) {
        $params['area'] = strtolower(str_replace(' ', '_', $_GET['area']));
        $query = str_replace('[WHICH]', "s.area = '[area]'", $query);
    }

    else if (isset($_GET['subject'])) {
        $params['subject'] = strtolower(str_replace(' ', '_', $_GET['subject']));
        $query = str_replace('[WHICH]', "s.name = '[subject]'", $query);
    }

    else {
        $query = str_replace('[WHICH]', 'TRUE', $query); // all categories
    }

    $q = read($query, $params);

    if (count($q)) {
        $q = $q[0]; // get first question

        $q['area'    ] = ucwords(str_replace('_', ' ', $q['area']));
        $q['subject' ] = ucwords(str_replace('_', ' ', $q['name']));

        $q['question'] = preg_replace('/Scenario ([1-9])\s*\|/' , '<br/><br/><b>Scenario $1</b>:' , $q['question'] );
        $q['question'] = preg_replace('/Statement ([1-9])\s*\|/', '<br/><br/><b>Statement $1</b>:', $q['question'] );
        $q['question'] = preg_replace('/:$/', '...', $q['question']);
        $q['question'] = str_replace("\n", '<br/>' , $q['question']);
        $q['question'] = str_replace('. . .', ' ...', $q['question']);

        $q['option_a'] = rtrim($q['option_a'], '.');
        $q['option_b'] = rtrim($q['option_b'], '.');
        $q['option_c'] = rtrim($q['option_c'], '.');
        $q['option_d'] = rtrim($q['option_d'], '.');

        $q['answer'  ] = 'option_' . strtolower($q['answer']);

        unset($q['name']);
        unset($q['subject_id']);
    }

    return $q;
}

// --- entry point

$now = date('Y-m-d H:i:s');
$ctx = http_build_query($_GET);
file_put_contents('uses.log', "$now - $ctx\n", FILE_APPEND); // analytics baby!

header('Content-Type: application/json');
echo json_encode(question());
