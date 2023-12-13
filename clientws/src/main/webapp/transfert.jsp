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
<link rel="stylesheet" href="css/style.css">
<%
BanqueService proxy=new BanqueWS().getBanqueServicePort();
int code=(Integer)session.getAttribute("codecin");
 Compte c=new Compte();
 c=proxy.getCompte(code);
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
        
        <a class="logout"  href="deconnecter.DAO">Logout</a>
    </nav>
    <div class="content">
         <h2>Welcome to Your Bank Account</h2>
        <p>This is the central area of your bank account where you can manage your finances.</p>
        
        <div class="balance">
            <form action="transfert.dao" method="post">
            <label for="amount">Enter the amount to transfer:</label>
            <input type="text" name="prix" placeholder="amount">
            <input type="hidden" name="codecin" value="<%=c.getCode() %>"><br>
            <label for="recipient">Recipient's Account Code:</label>
            <input type="text"  name="coderecip" placeholder="recipient code"><br>
            <input type="submit" value="transfert"><br>
            </form>
            <h3>Your Solde</h3>
            <p class="balance-amount">$<%=c.getSolde() %></p>
        </div>
    </div>
</body>
</html>