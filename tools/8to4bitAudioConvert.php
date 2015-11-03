<?php
    $options = getopt("f:t:p");
    echo $options['t']." .byte ";
    $fh = fopen($options['f'], "rb");
    // Values are signed -128 - 128 convert to 0 - 16
    $upperNibble = true;
    $lastValue   = 0;
    for($i=0;$i<filesize($options['f']);$i++){
        $char = fread($fh, 1);
        $val  = unpack("c", $char);
        $val[1] = round(($val[1] + 128)/16);
        $val[1] = $val[1]==16?15:$val[1];

        if(isset($options['p'])){
            if($upperNibble){
                $lastValue   = (int)$val[1] << 4;
                $upperNibble = false;
            }else{
                //echo "Combining ".(int)$val[1]." and ".(int)$lastValue."\n";
                $combined    = (int)$val[1] | (int)$lastValue;
                $upperNibble = true;
                echo $combined;
                if($i+2 != filesize($options['f'])){
                    echo ", ";
                }
            }
        }else{
            echo $val[1];
            if($i+1 != filesize($options['f'])){
                echo ", ";
            }
        }

    }
    if(isset($options['z'])){
        echo ", 0";
    }
    echo "\n";
    echo $options['t']."_end\n";
    fclose($fh);
    
?>