package cl.antartis.interac.funciones;

import java.util.Date;

public class Main {

	public static void main(String[] args) {
		
		String a = "Hola chao";
		String b;
		Encriptador e = new Encriptador();
		b = e.encriptar(a);
		System.out.println(a);
		System.out.println(b);
		System.out.println(e.encriptar(a));
		System.out.println(e.desencriptar(b));
		
		System.out.println(new Date().toString());
	}

}
