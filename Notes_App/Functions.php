<?php

    function filterRequest($requestName){
        return htmlspecialchars(strip_tags($_POST[$requestName]));
    }

    define("MB" , 1048576);

    function imageUpload($imageRequest){
        global $msgError;
        $imageName = rand(1000 , 10000) . $_FILES[$imageRequest]['name'];
        $imageSize = $_FILES[$imageRequest]['size'];
        $imageType = $_FILES[$imageRequest]['type'];
        $imageTemp = $_FILES[$imageRequest]['tmp_name'];

        $allowExt   = array("jpg" , "png" , "gif" , "mp3" , "pdf");
        $strToArray = explode("." , $imageName);
        $ext        = end($strToArray);
        $ext        = strtolower($ext);
        if(!empty($imageName) && !in_array($ext , $allowExt)){
            $msgError[] = "EXT";
        }
        if($imageSize > 16 * MB){
            $msgError[] = "SIZE";
        }
        if(empty($msgError)){
            move_uploaded_file($imageTemp , "../upload/" . $imageName);
            return $imageName;
        } else {
            return "Failed";
        }
    }

    function deleteFile($dir , $imageName){
        if(file_exists($dir . "/" . $imageName)){
            unlink($dir . "/" . $imageName);
        }
    }

    function checkAuthenticate(){
        if(isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW'])){
            if($_SERVER['PHP_AUTH_USER'] != "mohammad" || $_SERVER['PHP_AUTH_PW'] != "123321"){
                header('WWW-Authenticate: Basic realm="My Realm"');
                header("HTTP/1.0 401 Unauthorized");
                echo 'Page Not Found';
                exit;
            }
        } else {
            exit;
        }
    }

?>