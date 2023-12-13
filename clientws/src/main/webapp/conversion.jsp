	<%@page import="java.util.ArrayList"%>
	<%@page import="java.net.URL"%>
	<%@page import="org.json.JSONTokener"%>
	<%@page import="java.util.Scanner"%>
	<%@page import="java.util.Iterator"%>
	<%@page import="org.json.JSONObject"%>
	<%@page import="service.Compte"%>
	<%@page import="service.BanqueWS"%>
	<%@page import="service.BanqueService"%>
	<%@page import="java.net.HttpURLConnection" %>
	<%@page import="java.util.List"%> <!-- Import List -->
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
	    List<String> currency=new ArrayList<>();
	    Object res=request.getAttribute("result");
	    try {
	        URL url1 = new URL("https://api.apilayer.com/currency_data/list");
	        HttpURLConnection conn = (HttpURLConnection) url1.openConnection();
	        conn.setRequestMethod("GET");
	        conn.addRequestProperty("apikey", "EzMRdnN3HnmDRsHF1Jc5ThjmooO7ojKQ");
	        conn.connect();
	
	        int responseCode = conn.getResponseCode();
	        String responseMessage = conn.getResponseMessage();
	        System.out.println("Response Code: " + responseCode);
	        System.out.println("Response Message: " + responseMessage);
	        if (responseCode != 200) {
	            throw new RuntimeException("HttpResponseCode: " + responseCode);
	        } else {
	            StringBuilder informationString = new StringBuilder();
	            Scanner scanner = new Scanner(conn.getInputStream());
	
	            while (scanner.hasNext()) {
	                informationString.append(scanner.nextLine());
	            }
	            scanner.close();
	            JSONTokener jsonTokener = new JSONTokener(informationString.toString());
	            JSONObject jsonObject = new JSONObject(jsonTokener);
	            JSONObject currencies = jsonObject.getJSONObject("currencies");
	            Iterator<String> keys = currencies.keys();
	            //System.out.print(keys.toString());
	          
	            while (keys.hasNext()) {
	                String currencyCode = keys.next();
	                currency.add(currencyCode);
	               // System.out.println("Currency Code: " + currencyCode);
	            }
	
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	        
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
	            <form action="conversion.dao" method="post">
	                <label for="currency1">Select Currency 1:</label>
	                <select name="currency1">
	                <%for(String c:currency){ %>
	                        <option value="<%=c%>"><%=c %></option>
	                        <%} %>
	                </select>
	                <br>
	                <label for="currency2">Select Currency 2:</label>
	                <select name="currency2">
	                   <%for(String c:currency){ %>
	                        <option value="<%=c%>"><%=c %></option>
	                        <%} %>
	                   
	                </select><br>
	                <br>
	                <input type="text" name="amount" placeholder="amount"><br>
	                <input type="submit" value="convert">
	            </form>
	        </div>
	        <div <%if(res!=null){ %>>
	        <h1>Your result is</h1>
	        <%=res %>
	        
	        </div>
	        <%} %>
	    </div>
	</body>
	</html>
