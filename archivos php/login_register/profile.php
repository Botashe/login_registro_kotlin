<?php
if (!empty($_POST['Correo']) && !empty($_POST['apiKey'])){
    $Correo = $_POST["Correo"];
    $apiKey = $_POST["apiKey"];
    $result = array();
    $con = mysqli_connect("localhost","root","","login_registro");
    if($con){
        $sql = "SELECT * FROM usuarios WHERE Correo = '$Correo' AND apiKey = '$apiKey'";
        $res = mysqli_query($con, $sql);
        if (mysqli_num_rows($res) != 0){
            $row = mysqli_fetch_assoc($res);
            $result = array(
                "status" => "success",
                "message" => "Datos obtenidos exitosamente",
                "Nombre" => $row['Nombre'],
                "Correo" => $row['Correo'],
                "apiKey" => $apiKey
            );
        } else {
            $result = array(
                "status" => "failed",
                "message" => "Vuelva a intentarlo con el correo electrónico y la contraseña correctos"
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