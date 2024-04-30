<%-- 
    Document   : cerrarSesion
    Created on : 28 abr 2024, 22:34:12
    Author     : Dilan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cerrar Sesión</title>
    </head>
    <body>
            <%/*Funcion que devuelve la sesión como inválida*/
            HttpSession sesion=request.getSession();
            sesion.invalidate();
            response.sendRedirect("index.jsp");
            %>
    </body>
</html>
