package server;

import javax.xml.ws.Endpoint;

import Service.Banque_Service;

public class server {
public static void main(String args[]) {
	Endpoint.publish("http://localhost:8081/", new Banque_Service());
	
	System.out.print("yess");
}
}
