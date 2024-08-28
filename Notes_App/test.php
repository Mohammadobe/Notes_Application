<?php

    $fileName = "image.png";
    $strArray = explode("." , $fileName);
    $allowExt = array("jpg" , "png" , "gif");
    $ext = end($strArray);

    if(in_array($ext , $allowExt)){
        echo "Yes";
    } else {
        echo "No";
    }
    
?>