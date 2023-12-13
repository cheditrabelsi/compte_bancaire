package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import service.BanqueService;
import service.BanqueWS;
import service.Compte;

@WebServlet("*.dao")
public class operations extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public operations() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        PrintWriter out = response.getWriter();
        BanqueService proxy = new BanqueWS().getBanqueServicePort();

        if (path.equals("/verser.dao")) {
        	
          try {
        	  String prixParam = request.getParameter("prix");
        	  float prix = Float.parseFloat(prixParam);
              int code = Integer.parseInt(request.getParameter("code"));
              Compte c = proxy.getCompte(code);
              proxy.verser(c, prix);
              proxy.setHistorique(code,1);
              request.getRequestDispatcher("versement.jsp").forward(request, response);
        	  
          }catch(Exception e) {
        	  out.println("<script>");
              out.println("alert('there is an issue!');");
              out.println("window.location = 'versement.jsp';");
              out.println("</script>");
          }
        } else {
            if (path.equals("/retirer.dao")) {
            	try {
            		String prixParam = request.getParameter("prix");
            		float prix = Float.parseFloat(prixParam);
                    int code = Integer.parseInt(request.getParameter("code"));
                    Compte c = proxy.getCompte(code);
                    if (c.getSolde() > prix) {
                    	proxy.setHistorique(code,2);
                        proxy.retirer(c, prix);
                        request.getRequestDispatcher("retrait.jsp").forward(request, response);
                    } else {
                        out.println("<script>");
                        out.println("alert('Please enter a price less than your balance!');");
                        out.println("window.location = 'retrait.jsp';");
                        out.println("</script>");
                    }	
            	}catch(Exception e) {
            		 out.println("<script>");
                     out.println("alert('there is an issue!');");
                     out.println("window.location = 'retrait.jsp';");
                     out.println("</script>");
            	}
               
            } else {
                if (path.equals("/transfert.dao")) {
                	try {
                		 String prixParam = request.getParameter("prix");
                         String codeParam = request.getParameter("coderecip");
                         float prix = Float.parseFloat(prixParam);
                         int coderecip = Integer.parseInt(codeParam);
                         int codecin = Integer.parseInt(request.getParameter("codecin"));
                         Compte c = proxy.getCompte(coderecip);
                         Compte c1 = proxy.getCompte(codecin);
                         System.out.print(c1.toString());
                         if ((codecin != coderecip) && (c1.getSolde() > prix)&&(proxy.exist(c1))) {
                         	proxy.setHistorique(codecin,3);
                             proxy.transfert(c, prix);
                             proxy.retirer(c1, prix);
                             request.getRequestDispatcher("transfert.jsp").forward(request, response);
                         } else {
                             out.println("<script>");
                             out.println("alert('there is an issue!');");
                             out.println("window.location = 'transfert.jsp';");
                             out.println("</script>");
                         }
                	}catch(Exception e) {
                		out.println("<script>");
                        out.println("alert('there is an issue!');");
                        out.println("window.location = 'transfert.jsp';");
                        out.println("</script>");
                	}
                   
                } else {
                    if (path.equals("/conversion.dao")) {
                        try {
                        	String from=request.getParameter("currency1");
                        	String to=request.getParameter("currency2");
                        	Float amount=Float.parseFloat(request.getParameter("amount"));
                        	
                            URL url = new URL("https://api.apilayer.com/currency_data/convert?"+"to="+to+"&from="+from+"&amount="+amount);
                            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
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
                                Object result=jsonObject.get("result");
                          System.out.print(result)	;
                                request.setAttribute("result",result);
                                request.getRequestDispatcher("conversion.jsp").forward(request, response);
                                
                            }
                        } catch (Exception e) {
                        	out.println("<script>");
                            out.println("alert('there is an issue!');");
                            out.println("window.location = 'conversion.jsp';");
                            out.println("</script>");
                        }
                    }
                }
            }
        }
    }
}