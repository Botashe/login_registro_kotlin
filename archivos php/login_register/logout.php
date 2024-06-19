<?php
if (!empty($_POST['Correo']) && !empty($_POST['apiKey'])){
    $Correo= $_POST['Correo'];
    $apiKey= $_POST['apiKey'];
    $con = mysqli_connect("localhost","root","","login_registro");
    if ($con) {
        $sql = "SELECT * FROM Usuario WHERE Correo = '$Correo' AND apiKey = '$apiKey'";
        $res = mysqli_query($con, $sql);
        if (mysqli_num_rows($res) != 0) {
            $sqlUpdate = "UPDATE usuario SET apiKey = '' WHERE Correo = '" . $Correo . "'";
            if (mysqli_query($con, $sqlUpdate)) {
                echo "Éxito";
            } else {
                echo "Error al cerrar sesión";
            }
        } else {
            echo "No autorizado para acceder";
        }
    } else {
        echo "Error de conexión a la base de datos";
    }
} else {
    echo "Todos los campos son obligatorios";
}
?>
