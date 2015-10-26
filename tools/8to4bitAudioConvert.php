<?php
    $options = getopt("f:t:");
    echo $options['t']." .byte ";
    $fh = fopen($options['f'], "rb");
    // Values are signed -128 - 128 convert to 0 - 16
    for($i=0;$i<filesize($options['f']);$i++){
        $char = fread($fh, 1);
        $val  = unpack("c", $char);
        $val[1] = round(($val[1] + 128)/16);
        echo $val[1];
        if($i+1 != filesize($options['f'])){
            echo ", ";
        }
    }
    if(isset($options['z'])){
        echo ", 0";
    }
    echo "\n";
    echo $options['t']."_end\n";
    fclose($fh);
    
?>