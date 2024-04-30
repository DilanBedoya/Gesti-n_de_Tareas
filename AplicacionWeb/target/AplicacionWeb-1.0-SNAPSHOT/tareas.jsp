<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <link rel="stylesheet" href="css/style_tareas.css">
        <!--jQuery y Popper.js -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>

        <title>Tareas</title>
    </head>
    <body>
        <br>
        <%
            /*Redireccionar a login si no hay un usuario logueado*/
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("logueado") == null || sesion.getAttribute("logueado").equals("0")) {
                response.sendRedirect("index.jsp");
            }
            Integer obtenerId = (Integer) session.getAttribute("usuarioid");
            String nombreusuario = (String) session.getAttribute("nombreusuario");

            int usuarioId;
            if (obtenerId != null) {
                /*Convertir a int si el valor no es null*/
                usuarioId = obtenerId.intValue();
            } else {
                /*Manejar el caso cuando el valor es null*/
                usuarioId = -1;
            }

            /*Conexion a la Base de datos*/
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/App", "postgres", "1234");
        %>

        <div class="container">
            <br>
            <div class="row">

                <div class="col">

                    <h1>¡Bienvenido! <%
                        out.print(nombreusuario);
                        %><i class="bi bi-person-check"></i></h1>
                </div>

                <div class="col" style="text-align: right">
                    <form action="cerrarSesion.jsp">
                        <button type="submit" class="btn btn-danger" name="cerrar">Cerrar Sesión</button>
                    </form>
                </div>
            </div>
            <hr>
            <%                /*Validar Cerrar Sesión*/
                if (request.getParameter("cerrar") != null) {
                    response.sendRedirect("cerrarSesion.jsp");
                }

            %>


            <h2 class="col pb-2 pt-2" style="text-align: center">RESUMEN DE LAS TAREAS</h2>
            
           
            
            <div class="row" style="text-align: center">
                
                <div class="col">

                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Agregar Tareas
                    </button>

                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModal" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModal">Agregar Tarea</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">


                                    <form action="tareas.jsp" method="post">
                                        <div class="mb-3">
                                            <label for="addTitulo" class="form-label">Título</label>
                                            <input type="text" class="form-control" id="addTitulo" name="addTitulo" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="addDescripcion" class="form-label">Descripción</label>
                                            <textarea class="form-control" id="addDescripcion" name="addDescripcion" rows="3" required></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="addFecha" class="form-label">Fecha</label>
                                            <input type="date" class="form-control" id="addFecha" name="addFecha" pattern="\d{4}-\d{2}-\d{2}" placeholder="aaaa-mm-dd">
                                        </div>
                                        <div class="mb-3">
                                            <label for="addPrioridad" class="form-label">Prioridad</label>
                                            <select class="form-select" id="addPrioridad" name="addPrioridad" required>
                                                <option value="Alta">Alta</option>
                                                <option value="Media">Media</option>
                                                <option value="Baja">Baja</option>
                                            </select>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            <button type="submit" class="btn btn-primary" name="agregarTarea">Guardar</button>
                                        </div>
                                    </form>

                                    <%                 if (request.getParameter("agregarTarea") != null) {

                                            String add_titulo = request.getParameter("addTitulo");
                                            String add_Descripcion = request.getParameter("addDescripcion");

                                            /*trasnformar de string a date*/
                                            String add_fechaLimiteStr = request.getParameter("addFecha");
                                            Date add_fechaLimite = Date.valueOf(add_fechaLimiteStr);

                                            String add_prioridad = request.getParameter("addPrioridad");

                                            try {
                                                PreparedStatement insertar = con.prepareStatement("INSERT INTO TAREAS (TITULO, DESCRIPCION, FECHALIMITE, PRIORIDAD, UsuarioID) VALUES (?, ?, ?, ?, ?)");

                                                insertar.setString(1, add_titulo);
                                                insertar.setString(2, add_Descripcion);
                                                insertar.setDate(3, add_fechaLimite);
                                                insertar.setString(4, add_prioridad);
                                                insertar.setInt(5, usuarioId);
                                                int camposActualizados = insertar.executeUpdate();
                                                if (camposActualizados > 0) {
                                                    out.print("Tarea Agregada Correctamente");
                                                    response.sendRedirect("tareas.jsp");
                                                } else {
                                                    out.print("No se pudo Agregar la tarea.");
                                                }
                                            } catch (Exception e) {
                                                out.print("Ha ocurrido un error" + e);
                                            }
                                        }

                                    %>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>
                <div class="col">


                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        Asignar Tareas
                    </button>


                    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">

                                    <form action="tareas.jsp" method="post">
                                        <div class="mb-3">
                                            <label for="usuarios" class="form-label">Usuarios</label>
                                            <select class="form-select" id="usuarios" name="usuarios" required>
                                                <%            try {
                                                        /*Buscar Nombre*/
                                                        String buscar = "SELECT nombreusuario FROM usuarios";
                                                        PreparedStatement statement = con.prepareStatement(buscar);
                                                        ResultSet result = statement.executeQuery();

                                                        /*Iterar los usuarios y reflejar en el menú*/
                                                        while (result.next()) {
                                                            String nombreUsuario = result.getString("nombreusuario");
                                                %>
                                                <option value="<%= nombreUsuario%>"><%= nombreUsuario%></option>
                                                <%

                                                        }
                                                    } catch (Exception e) {

                                                        out.print("Error: " + e.getMessage());
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="asigTitulo" class="form-label">Título</label>
                                            <input type="text" class="form-control" id="asigTitulo" name="asigTitulo" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="asigDescripcion" class="form-label">Descripción</label>
                                            <textarea class="form-control" id="asigDescripcion" name="asigDescripcion" rows="3" required></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="asigFecha" class="form-label">Fecha</label>
                                            <input type="date" class="form-control" id="asigFecha" name="asigFecha" pattern="\d{4}-\d{2}-\d{2}" placeholder="aaaa-mm-dd">
                                        </div>
                                        <div class="mb-3">
                                            <label for="asigPrioridad" class="form-label">Prioridad</label>
                                            <select class="form-select" id="asigPrioridad" name="asigPrioridad" required>
                                                <option value="Alta">Alta</option>
                                                <option value="Media">Media</option>
                                                <option value="Baja">Baja</option>
                                            </select>
                                        </div>



                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            <button type="submit" class="btn btn-primary" name="asigTarea">Guardar</button>
                                        </div>
                                    </form>




                                    <%                                        /*Funcion para asignar tareas*/
                                        if (request.getParameter("asigTarea") != null) {

                                            String asigTitulo = request.getParameter("asigTitulo");
                                            String asigDescripcion = request.getParameter("asigDescripcion");

                                            /*transformar de string a date*/
                                            String asigFechaLimiteStr = request.getParameter("asigFecha");
                                            Date asigFechaLimite = Date.valueOf(asigFechaLimiteStr);

                                            String asigPrioridad = request.getParameter("asigPrioridad");
                                            String asigUsuario = request.getParameter("usuarios");
                                            try {
                                                PreparedStatement buscarid = con.prepareStatement("SELECT USUARIOID FROM USUARIOS WHERE NOMBREUSUARIO=?");
                                                buscarid.setString(1, asigUsuario);
                                                ResultSet result = buscarid.executeQuery();

                                                while (result.next()) {
                                                    int obtenerIdBase = result.getInt("usuarioid");
                                                    try {
                                                        PreparedStatement insertar = con.prepareStatement("INSERT INTO TAREAS (TITULO, DESCRIPCION, FECHALIMITE, PRIORIDAD, UsuarioID) VALUES (?, ?, ?, ?, ?)");

                                                        insertar.setString(1, asigTitulo);
                                                        insertar.setString(2, asigDescripcion);
                                                        insertar.setDate(3, asigFechaLimite);
                                                        insertar.setString(4, asigPrioridad);
                                                        insertar.setInt(5, obtenerIdBase);
                                                        insertar.executeUpdate();

                                                    } catch (Exception e) {
                                                        out.print("Ha ocurrido un error" + e);
                                                    }
                                                }

                                            } catch (Exception e) {
                                                out.print("Ha ocurrido un error" + e);
                                            }

                                        }

                                    %>
                                </div>

                            </div>
                        </div>
                    </div>


                </div>
            </div>


            <table class="table table-striped">

                <thead>
                    <tr>
                        <th scope="col">TITULO</th>
                        <th scope="col">DESCRIPCION</th>
                        <th scope="col">FECHA LIMITE</th>
                        <th scope="col">PRIORIDAD</th>
                        <th scope="col">ESTADO</th>
                        <th scope="col">ACCIONES</th>


                    </tr>
                </thead>
                <%                    Statement st = null;
                    ResultSet rs = null;

                    try {

                        st = con.createStatement();
                        PreparedStatement statement = con.prepareStatement("SELECT * FROM TAREAS WHERE USUARIOID=?");
                        statement.setInt(1, obtenerId);
                        rs = statement.executeQuery();
                        while (rs.next()) {


                %>
                <tr>
                    <th scope="row"><%=(rs.getString(2))%></th>
                    <td><%=(rs.getString(3))%></td>
                    <td><%=(rs.getString(5))%></td>
                    <td><%=(rs.getString(6))%></td>
                    <td><%=(rs.getString(7))%></td>
                    <td>


                        <i class="bi bi-pencil-square fs-2 me-3" data-bs-toggle="modal" data-bs-target="#modalEditar<%=rs.getInt(1)%>"></i>             
                        <div class="modal fade" id="modalEditar<%=rs.getInt(1)%>" tabindex="-1" aria-labelledby="modalEditarLabel<%=rs.getInt(1)%>" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalEditarLabel<%=rs.getInt(1)%>">Editar tarea</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">


                                        <form action="tareas.jsp" method="post">

                                            <div class="mb-3">
                                                <input type="hidden" class="form-control" id="id" name="id" value="<%=rs.getInt(1)%>">
                                            </div>

                                            <div class="mb-3">
                                                <label for="titulo" class="form-label">Título</label>
                                                <input type="text" class="form-control" id="titulo" name="titulo" value="<%=rs.getString(2)%>">
                                            </div>
                                            <div class="mb-3">
                                                <label for="descripcion" class="form-label">Descripción</label>
                                                <textarea class="form-control" id="descripcion" name="descripcion" rows="3"><%=rs.getString(3)%></textarea>
                                            </div>

                                            <div class="mb-3">
                                                <label for="fecha" class="form-label">Fecha</label>
                                                <input type="date" class="form-control" id="fecha" name="fechaLimite" pattern="\d{4}-\d{2}-\d{2}" placeholder="aaaa-mm-dd">
                                            </div>





                                            <div class="mb-3">
                                                <label for="prioridad" class="form-label">Prioridad</label>
                                                <select class="form-select" id="prioridad" name="prioridad">
                                                    <option value="Alta" <%=rs.getString(6).equals("Alta") ? "selected" : ""%>>Alta</option>
                                                    <option value="Media" <%=rs.getString(6).equals("Media") ? "selected" : ""%>>Media</option>
                                                    <option value="Baja" <%=rs.getString(6).equals("Baja") ? "selected" : ""%>>Baja</option>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label for="estado" class="form-label">Estado</label>
                                                <select class="form-select" id="estado" name="estado">
                                                    <option value="Pendiente" <%=rs.getString(6).equals("Pendiente") ? "selected" : ""%>>Pendiente</option>
                                                    <option value="Completada" <%=rs.getString(6).equals("Completada") ? "selected" : ""%>>Completada</option>

                                                </select>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                                <button type="submit" class="btn btn-primary" name="actualizar">Guardar cambios</button>
                                            </div>
                                        </form>

                                    </div>


                                    <%
                                        /*Función de editar las tareas*/
                                        if (request.getParameter("actualizar") != null) {

                                            String new_titulo = request.getParameter("titulo");
                                            String obtenerIdString = request.getParameter("id");
                                            int obtenerid = Integer.parseInt(obtenerIdString);
                                            String new_Descripcion = request.getParameter("descripcion");

                                            /*trasnformar de string a date*/
                                            String new_fechaLimiteStr = request.getParameter("fechaLimite");
                                            Date new_fechaLimite = Date.valueOf(new_fechaLimiteStr);

                                            String new_prioridad = request.getParameter("prioridad");
                                            String new_estado = request.getParameter("estado");
                                            try {
                                                PreparedStatement editar = con.prepareStatement("UPDATE TAREAS SET TITULO = ?, DESCRIPCION = ?, FECHALIMITE = ?, PRIORIDAD = ?, ESTADO = ? WHERE TareaID = ? AND UsuarioID = ?");

                                                editar.setString(1, new_titulo);
                                                editar.setString(2, new_Descripcion);
                                                editar.setDate(3, new_fechaLimite);
                                                editar.setString(4, new_prioridad);
                                                editar.setString(5, new_estado);
                                                editar.setInt(6, obtenerid);
                                                editar.setInt(7, usuarioId);
                                                int camposActualizados = editar.executeUpdate();
                                                if (camposActualizados > 0) {
                                                    out.print("Tarea actualizada correctamente.");
                                                    response.sendRedirect("tareas.jsp");
                                                } else {
                                                    out.print("No se pudo actualizar la tarea.");
                                                }
                                            } catch (Exception e) {
                                                out.print("Ha ocurrido un error" + e);
                                            }

                                        }

                                    %>
                                </div>
                            </div>
                        </div>


                        <i class="bi bi-trash3-fill fs-2" data-bs-toggle="modal" data-bs-target="#modalEliminar<%=rs.getInt(1)%>"></i> 
                        <div class="modal fade" id="modalEliminar<%=rs.getInt(1)%>" tabindex="-1" aria-labelledby="modalEliminarLabel<%=rs.getInt(1)%>" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalEliminarLabel<%=rs.getInt(1)%>">Eliminar tarea</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">

                                        <h4>¿Estás seguro de que deseas eliminar esta tarea?</h4>

                                    </div>
                                    <form action="tareas.jsp" method="post">
                                        <div class="modal-footer">
                                            <div class="mb-3">

                                                <input type="hidden" class="form-control" id="IdEliminar" name="IdEliminar" value="<%=rs.getInt(1)%>">
                                            </div>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                            <button type="submit" class="btn btn-danger" name="eliminar">Eliminar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <%
                            /*Función de eliminar las tareas*/
                            if (request.getParameter("eliminar") != null) {
                                String obtenerIdStr = request.getParameter("IdEliminar");
                                int obtenerIdEli = Integer.parseInt(obtenerIdStr);
                                try {
                                    PreparedStatement eliminar = con.prepareStatement("DELETE FROM TAREAS WHERE TAREAID = ? AND USUARIOID = ?");
                                    eliminar.setInt(1, obtenerIdEli);
                                    eliminar.setInt(2, usuarioId);
                                    int eliminarActualizado = eliminar.executeUpdate();
                                    if (eliminarActualizado > 0) {
                                        response.sendRedirect("tareas.jsp");
                                    }
                                } catch (Exception e) {
                                    out.print("Ha ocurrido un error" + e);
                                }

                            }

                        %>
                    </td>


                </tr>

                <%                        }

                    } catch (Exception e) {
                        out.print("Error" + e);
                    }
                %>

            </table>




        </div>

         </body>
</html>