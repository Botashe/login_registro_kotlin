<?php
if(!empty($_POST['Correo']) && !empty($_POST['Password'])){
    $Correo = $_POST['Correo'];
    $Password = $_POST['Password'];
    $result = array();
    $con = mysqli_connect("localhost","root","","login_registro");
    if ($con){
        $sql = "SELECT * FROM usuario WHERE Correo = '$Correo'";
        $res = mysqli_query($con, $sql);
        if(mysqli_num_rows($res) != 0){
            $row = mysqli_fetch_assoc($res);
            if($Correo == $row['Correo'] && password_verify($Password, $row['Password'])){
                try{
                    $apiKey = bin2hex(random_bytes(23));
                } catch (Exception $e) {
                    $apiKey = bin2hex(uniqid($Correo, true));
                }
                $sqlUpdate = "UPDATE usuario SET apikey = '$apiKey' WHERE Correo = '$Correo'";
                if (mysqli_query($con, $sqlUpdate)){
                    $result = array(
                        "status" => "success",
                        "message" => "Inicio de sesión exitoso",
                        "Nombre" => $row['Nombre'],
                        "Correo" => $row['Correo'],
                        "apiKey" => $apiKey
                    );
                } else {
                    $result = array(
                        "status" => "failed",
                        "message" => "Error al iniciar sesión, por favor intente de nuevo"
                    );
                }
            } else {
                $result = array(
                    "status" => "failed",
                    "message" => "Vuelva a intentarlo con el correo electrónico y la contraseña correctos"
                );
            }
        } else {
            $result = array(
                "status" => "failed",
                "message" => "Usuario no encontrado"
            );
        }
    } else {
        $result = array(
            "status" => "failed",
            "message" => "Error de conexión a la base de datos"
        );
    }
} else {
    $result = array(
        "status" => "failed",
        "message" => "Todos los campos son obligatorios"
    );
}

echo json_encode($result, JSON_PRETTY_PRINT);
?>
