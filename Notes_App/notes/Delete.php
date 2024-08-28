<?php

    include "../Connect.php";

    $noteId      = filterRequest("id");
    $imagename   = filterRequest("imagename");

    $stmt = $connect->prepare("DELETE FROM `notes` WHERE notes_id = ?");
    
    $stmt->execute(array($noteId));

    $count = $stmt->rowCount();

    if($count > 0){
        deleteFile("../upload" , $imagename);
        echo json_encode(array("Status" => "Success")); 
    } else{
        echo json_encode(array("Status" => "Failed"));
    }

?>