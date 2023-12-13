

<%@page import="java.util.List"%>
<%@page import="service.Historique"%>
<%@page import="service.Compte"%>
<%@page import="service.BanqueWS"%>
<%@page import="service.BanqueService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<style>
    .table-container {
         text-align: center;
    margin: 0 auto; /* Center horizontally */
    max-width: 800px;

    }

    table {
        width: 50%;
        border-collapse: collapse;
        border: 1px solid #ddd;
        margin: 0 auto;
    }

    th, td {
        border: 5px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #ddd;
    }
</style>


<%
BanqueService proxy=new BanqueWS().getBanqueServicePort();
int code=(Integer)session.getAttribute("codecin");
Compte c = new Compte();
c = proxy.getCompte(code);
List<Historique> ListHisto = proxy.getHist(code); 
%>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <img src="./image/logo.jpg" alt="Logo">
        </div>
        <ul class="nav-links">
            <li><a href="home.jsp">Home</a></li>
            <li><a href="versement.jsp">versement</a></li>
            <li><a href="retrait.jsp">retrait</a></li>
            <li><a href="transfert.jsp">transfert</a></li>
            <li><a href="conversion.jsp">conversion</a></li>
            <li><a href="historique.jsp">historique</a></li>
        </ul>
        <a class="logout" href="deconnecter.DAO">Logout</a>
    </nav>
    <div class="table-container">
    <table>
        <tr>
            <th>action</th>
            <th>date</th>
        </tr>
        <% for (Historique h : ListHisto) { %>
        <tr>
            <td><%= proxy.getActe(h.getIdActe()) %></td>
            <td><%=h.getDate() %></td>
        </tr>
        <% } %>
    </table>
    </div>
</body>
</html>
