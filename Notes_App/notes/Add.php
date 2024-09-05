<?php

    include "../Connect.php";

    $title      = filterRequest("title");
    $content    = filterRequest("content");
    $userId     = filterRequest("id");
    $imagename   = imageUpload("file");

    if($imagename != 'Faild'){

        $stmt = $connect->prepare("INSERT INTO `notes`(`notes_title` , `notes_content` , `notes_users` , `notes_image`) 
                               VALUES (?,?,?,?)");
    
        $stmt->execute(array($title , $content , $userId , $imagename));

        $count = $stmt->rowCount();

        if($count > 0){
            echo json_encode(array("Status" => "Success")); 
        } else{
            echo json_encode(array("Status" => "Failed"));
        }

    } else {
        echo json_encode(array("Status" => "Failed"));
    }

?>