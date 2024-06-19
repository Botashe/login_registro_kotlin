<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if(!empty($_POST['Nombre']) && !empty($_POST['Correo']) && !empty($_POST['Password'])){
        $con = mysqli_connect("localhost","root","","login_registro");
        
        if (mysqli_connect_errno()) {
            echo "Fallo en la conexión a la base de datos: " . mysqli_connect_error();
            exit();
        }
        
        $Nombre = $_POST['Nombre'];
        $Correo = $_POST['Correo'];
        $Password = password_hash($_POST['Password'], PASSWORD_DEFAULT);
        
        $sql = "INSERT INTO usuario (Nombre, Correo, Password) VALUES ('$Nombre', '$Correo', '$Password')";
        
        if(mysqli_query($con, $sql)){
            echo "Éxito en el registro";
        } else {
            echo "Error en la consulta: " . mysqli_error($con);
        }
        
        mysqli_close($con);
    } else {
        echo "Todos los campos son obligatorios";
    }
} else {
    echo "Acceso denegado";
}
?>


