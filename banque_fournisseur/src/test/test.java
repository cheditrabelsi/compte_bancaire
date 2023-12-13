package test;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import Service.Banque_Service;
import connexion.SingletonConnection;
import metier.compte;
import metier.historique;

public class test {

	public static void main(String[] args) {
		//Date currentDate = new Date(2008-02-02);
		//back_service us=new back_service();
		SingletonConnection s=new SingletonConnection();
		
		Banque_Service b=new Banque_Service();
		//System.out.print(b.conversion("EUR", "TND", 300.50));
		//System.out.print(b.setHistorique(1, 1));
		List<historique> timestamp = b.getHist(1);
		System.out.print(timestamp.get(1).toString());
		System.out.print(b.getActe(2));
		

	}

}
