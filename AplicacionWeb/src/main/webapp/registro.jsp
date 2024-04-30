
<%@page import="java.sql.*"%>
<%@page import="org.postgresql.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Registro</title>
    </head>
    <body>

        <section class="vh-100">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col col-xl-10">
                        <div class="card" style="border-radius: 1rem;">
                            <div class="row g-0">
                                <div class="col-md-6 col-lg-5 d-none d-md-block">
                                    <img src="sources/register.jpg"
                                         alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;height: 720px" />
                                </div>
                                <div class="col-md-6 col-lg-7 d-flex align-items-center">
                                    <div class="card-body p-4 p-lg-5 text-black">

                                        <form action="registro.jsp" method="post">
                                            <div class="d-flex align-items-center mb-3 pb-1">
                                                <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                                                <img src="sources/login.png" class="login_logo"/>
                                            </div>

                                            <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Crear Cuenta</h5>

                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <input type="text" name="nombreUsuario" id="nombreUsuario" class="form-control form-control-lg" required="required"/>
                                                <label class="form-label" for="text">Nombre de Usuario</label>
                                            </div>

                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <input type="email" name="correo" id="correo" class="form-control form-control-lg" required="required"/>
                                                <label class="form-label" for="email">Correo Electrónico</label>
                                            </div>

                                            <div data-mdb-input-init class="form-outline mb-4">
                                                <input type="password" id="pass" name="pass" class="form-control form-control-lg" required="required"/>
                                                <label class="form-label" for="password">Contraseña</label>
                                            </div>

                                            <div class="pt-1 mb-4">
                                                <button data-mdb-button-init data-mdb-ripple-init class="btn btn-dark btn-lg btn-block"  type="submit" name="enviar"><i class="bi bi-box-arrow-in-right"></i> Registrarse</button>
                                            </div>

                                            <hr>
                                            <p class="mb-5 pb-lg-2" style="color: #393f81;">Ya tienes una Cuenta?<a href="index.jsp"
                                                                                                                    style="color: #393f81;"> Iniciar Sesión</a></p>

                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <br>
        <br>
        <%  
            /*Función que permite agregar un usuario a la base de Datos*/
            /*Obtener los parámetros especificados del formulario*/
            if (request.getParameter("enviar") != null) {
                String nombreUsuario = request.getParameter("nombreUsuario"); 
                String correo = request.getParameter("correo");
                String pass = request.getParameter("pass");
                try {
                /*Conexión a la Base de Datos*/
                    Statement st = null;
                    Class.forName("org.postgresql.Driver");
                    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/App", "postgres", "1234");
                    st=con.createStatement();
                    st.executeUpdate("INSERT INTO USUARIOS (NOMBREUSUARIO, PASS, EMAIL) VALUES ('" + nombreUsuario + "', '" + pass + "', '" + correo + "');");
                    request.getRequestDispatcher("index.jsp").forward(request, response); /*Regresa a la página de index pasando la solicitud y la respuesta*/
                } catch (Exception e) {
                    out.print("Error: " + e);
                }
            };


        %>
    </body>
</html>
