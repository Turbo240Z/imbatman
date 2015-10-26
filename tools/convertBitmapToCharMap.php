<?php
    $options = getopt("f:t:z");
    echo $options['t']." .byte ";
    $fh = fopen($options['f'], "rb");
    for($i=0;$i<filesize($options['f']);$i++){
        $char = fread($fh, 1);
        $val = unpack("c", $char);
        echo $val[1];
        if($i+1 != filesize($options['f'])){
            echo ", ";
        }
    }
    if(isset($options['z'])){
        echo ", 0";
    }
    echo "\n";
    fclose($fh);
    
?>