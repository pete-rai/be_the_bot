<?php

// --- constants

define('HOST'  , '127.0.0.1' );
define('SCHEMA', 'be_the_bot');
define('UID'   , 'be_the_bot');
define('PWD'   , 'be_the_bot');

// --- very basic multi row database reader

function read($sql, $params = []) {
    $out = [];
    $db  = mysqli_connect(HOST, UID, PWD, SCHEMA);

    if ($db) {
        mysqli_set_charset($db, 'utf8');

        foreach ($params as $key => $val) {
            $safe = mysqli_real_escape_string($db, $val);
            $sql  = str_replace("[$key]", $safe, $sql);
        }

        $res = mysqli_query($db, $sql);

        if ($res) {
            $out = mysqli_fetch_all($res, MYSQLI_ASSOC);
            mysqli_free_result($res);
        }

        mysqli_close($db);
    }

    return $out;
}
