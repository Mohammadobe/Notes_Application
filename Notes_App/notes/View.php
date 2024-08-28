<?php

    include "../Connect.php";

    $userId = filterRequest("id");

    $stmt = $connect->prepare("SELECT * FROM notes WHERE `notes_users` = ?");
    
    $stmt->execute(array($userId));

    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("Status" => "Success" , "data" => $data)); 
    } else{
        echo json_encode(array("Status" => "Failed"));
    }

?>