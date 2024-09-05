<?php

    include "Connect.php";

    $stmt = $connect->prepare("DELETE from `users` WHERE id = 3");
    $stmt->execute();

    $count = $stmt->rowCount();

    if($count > 0){
        echo "User Delete Successfully";
    } else{
        echo "Failed to Delete User";
    }

?>