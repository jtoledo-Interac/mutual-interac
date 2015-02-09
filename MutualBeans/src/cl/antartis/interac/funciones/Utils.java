package cl.antartis.interac.funciones;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.Date;

public class Utils {

	public static String left(String texto, int largo) {
		return (texto.length() < largo) ? texto : texto.substring(0, largo);
	}

	public static String right(String texto, int largo) {
		return (texto.length() < largo) ? texto : texto.substring(texto
				.length() - largo);
	}

	public static String mid(String texto, int inicio, int fin) {
		return (texto.length() < fin + 1) ? texto.substring(inicio,
				texto.length()) : texto.substring(inicio, fin);
	}

	public static String mid(String texto, int inicio) {
		return (texto.length() < inicio + 1) ? "" : texto.substring(inicio,
				texto.length() - inicio);
	}

	public static String midL(String texto, int inicio, int largo) {
		return mid(texto, inicio, inicio + largo);
	}

	public static String repeat(String str, int iCantVeces) {
		String tst = "";
		for (int j = 0; j < iCantVeces; j++) {
			tst += str;
		}
		return tst;
	}
	
	public static java.sql.Date stringToDate(String fecha)
	{
		java.sql.Date fechaDate = null;
		try {
		      SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy", new Locale("es", "ES"));
		      fechaDate = new java.sql.Date(sdf.parse(fecha).getTime());
		} catch (Exception ex) {
		      System.out.println("Error al obtener el formato de la fecha/hora: " + ex.getMessage());
		}
		return fechaDate;
	}
	
	public static String formateaFecha(String fecha)
	{
		if(fecha != null && !fecha.equals("")){
			String ano = fecha.substring(0, 4);
			String mes = fecha.substring(5, 7);
			String dia = fecha.substring(8, 10);
			
			fecha = dia + "/" + mes + "/" +ano;
		}
		return fecha;
	}

	// *******************************************
	// String a fecha formato DD/MM/AAAA
	// *******************************************
	public static String stringToFecha(String fecha) {
		String strFecha = new String("");
		if (fecha != null) {
			if (!fecha.trim().equals("") && fecha.length() >= 8) {
				strFecha = Utils.midL(fecha, 6, 2) + "/"
						+ Utils.midL(fecha, 4, 2) + "/"
						+ Utils.midL(fecha, 0, 4);
			}
		} else {
			strFecha = "";
		}
		return strFecha;
	}

	// *******************************************
	// Decimal a String XX,0 -> XX
	// *******************************************
	public static String decimalToString(String decimal) {
		String strString = new String("");

		strString = decimal.split(",")[1];

		if (strString.equals("0"))
			strString = decimal.split(",")[0];
		else
			strString = decimal;

		return strString;
	}

	// *******************************************
	// String a fecha formato DD/MM/AAAA HH:MMh --> Formato Alert
	// *******************************************
	public static String stringToFechaHora(String fecha) {

		String strFecha = new String("");
		if (fecha != null) {
			if (!fecha.trim().equals("") && fecha.length() >= 8) {
				strFecha = Utils.midL(fecha, 6, 2) + "/" // dia
						+ Utils.midL(fecha, 4, 2) + "/" // mes
						+ Utils.midL(fecha, 0, 4) + "  " // a�o
						+ Utils.midL(fecha, 8, 2) + ":" // hora
						+ Utils.midL(fecha, 10, 2) + "h"; // minuto
				// + Utils.midL(fecha, 12, 2); //segundo
			}
		} else {
			strFecha = "";
		}

		return strFecha;
	}

	// *******************************************
	// Fecha Formateada(00/00/0000) a String8
	// *******************************************
	public static String FechaToStr8(String fechaFormat) {
		String fecha = new String("");

		// if (!fechaFormat.trim().equals("") && fechaFormat != null) {
		if (fechaFormat != null && (fechaFormat.trim().length() >= 10)) {
			// fecha =
			// fechaFormat.substring(6,10)+fechaFormat.substring(3,5)+fechaFormat.substring(0,2)+
			// "00000000";
			fecha = fechaFormat.replaceAll("/", "");
			if (fechaFormat.trim().length() >= 8) {
				fecha = Utils.left(fecha, 8);
			} else {
				fecha = "";
			}
		}
		return fecha;
	}

	// *******************************************
	// Fecha Formateada(00/00/0000) a String8
	// *******************************************
	public static int diferenciaEnHoras(Date fecha){
		Date actual = new Date();
		long difEnMiliSegundos = actual.getTime()-fecha.getTime();
		long horas = difEnMiliSegundos / (1000 * 60 * 60 );
		return (int)horas;
	}
	
	// **************************************************************
	// String tipo numero a String tipo numero formateado n.nnn.nnn
	// **************************************************************
	public static String strNumeroToMskNumero(String valorNumero) {
		String numeroFormat = new String("");

		valorNumero = String.valueOf(Long.parseLong(valorNumero));
		int posString = valorNumero.length();

		for (posString = posString - 3; posString > 0; posString = posString - 3) {
			numeroFormat = "." + Utils.midL(valorNumero, posString, 3)
					+ numeroFormat;
		}
		numeroFormat = Utils.midL(valorNumero, 0, posString + 3) + numeroFormat;

		return numeroFormat;
	}

	// *******************************************
	// String a Int
	// *******************************************
	public static int mskNumeroToInt(String numero) {
		String numeroLimpio = numero.replaceAll("\\.", "");
		numeroLimpio = numeroLimpio.replaceAll(",", ".");

		if (!numeroLimpio.trim().equals(""))
			return Integer.parseInt(numeroLimpio, 10);
		else
			return 0;
	}

	// *******************************************
	// String a Long
	// *******************************************
	public static long mskNumeroToLong(String numero) {
		String numeroLimpio = numero.replaceAll("\\.", "");
		numeroLimpio = numeroLimpio.replaceAll(",", ".");

		if (!numeroLimpio.trim().equals(""))
			return Long.parseLong(numeroLimpio, 10);
		else
			return 0;
	}

	// *******************************************
	// String a Double
	// *******************************************
	public static double mskNumeroToDouble(String numero) {
		String numeroLimpio = numero.replaceAll("\\.", "");
		numeroLimpio = numeroLimpio.replaceAll(",", ".");

		if (!numeroLimpio.trim().equals(""))
			return Double.parseDouble(numeroLimpio);
		else
			return 0;
	}

	// *******************************************
	// String a Float
	// *******************************************
	public static float mskNumeroToFloat(String numero) {
		String numeroLimpio = numero.replaceAll("\\.", "");
		numeroLimpio = numeroLimpio.replaceAll(",", ".");

		if (!numeroLimpio.trim().equals(""))
			return Float.parseFloat(numeroLimpio);
		else
			return 0;
	}

	// *******************************************
	// String a Run 00.000.000-X
	// *******************************************
	public static String getRutFormat(String run) {
		String runFormat = new String("");
		run = (run == null) ? "" : run.trim();
		if (run.length() > 1) {
			runFormat = strNumeroToMskNumero(Utils.left(run, run.length() - 1))
					+ "-" + Utils.right(run, 1);
		}
		return runFormat;
	}

	// *******************************************
	// Run(nn.nnn.nnn-X) a String(000000000X)
	// *******************************************
	public static String RunToStr10(String runFormateado) {
		String run10 = (runFormateado == null) ? "" : runFormateado.replaceAll(
				"\\.", "");
		run10 = run10.replaceAll("[-]", "");

		if (run10.length() > 0) {
			run10 = Utils.repeat("0", 10 - run10.length()) + run10;
		}
		return run10;
	}

	public static String devuelveFechaActual(String fecha) {
		if (fecha != "") {
			String ano = fecha.substring(0, 4);
			String mes = fecha.substring(4, 6);
			String dia = fecha.substring(6, 8);

			return (dia + " " + devuelveMes(Integer.parseInt(mes)) + " " + ano);
		} else {
			return ("");
		}
	}

	public static String getRutSinDV(String rut) 
	{
		return rut.replace(".", "").split("-")[0];
	}

	public static String devuelveSoloFechaActual(String fecha) {
		if (fecha != "") {
			String ano = fecha.substring(0, 4);
			String mes = fecha.substring(4, 6);
			String dia = fecha.substring(6, 8);

			return (ano + "" + mes + "" + dia);
		} else {
			return ("");
		}

	}

	// *******************************************
	// FECHA y HORA DESFORMATEADA AAAAMMDDHoraMin
	// *******************************************
	public static String devuelveFechaHoraActual(String fecha) {
		String strFecha = new String("");
		if (fecha != null) {
			if (!fecha.trim().equals("") && fecha.length() >= 8) {
				strFecha = Utils.midL(fecha, 0, 4) // a�o
						+ Utils.midL(fecha, 4, 2) // mes
						+ Utils.midL(fecha, 6, 2) // dia
						+ Utils.midL(fecha, 8, 2) // hora
						+ Utils.midL(fecha, 10, 2); // minuto
			}
		} else {
			strFecha = "";
		}
		return strFecha;
	}

	public static String devuelveFechaConHora(String fechain) {
		String ano = fechain.substring(0, 4);
		String mes = fechain.substring(4, 6);
		String dia = fechain.substring(6, 8);
		String hora = Utils.midL(fechain, 8, 2) + ":"
				+ Utils.midL(fechain, 10, 2) + "h"; // minuto
		String str_date = dia + "/" + mes + "/" + ano;
		String fechades[] = null;

		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date date;
		try {
			date = (Date) formatter.parse(str_date);
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);

			Date fecha = cal.getTime();
			SimpleDateFormat formatoDeFecha = new SimpleDateFormat(
					"EEEE/MM/yyyy");

			str_date = formatoDeFecha.format(fecha).substring(0, 1)
					.toUpperCase()
					+ formatoDeFecha.format(fecha).substring(1,
							formatoDeFecha.format(fecha).length());
			fechades = str_date.split("/");

			return devuelveDia(fechades[0]) + ", " + dia + " de "
					+ devuelveMesCompleto(Integer.parseInt(mes)) + " del "
					+ ano + " a las " + hora;
		} catch (ParseException e) {
			e.printStackTrace();
			return "";
		}
	}

	public static String devuelveFecha(String fechain) {
		String anio = fechain.substring(0, 4);
		String mes = fechain.substring(4, 6);
		String dia = fechain.substring(6, 8);
		String str_date = dia + "/" + mes + "/" + anio;
		String fechades[] = null;

		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date date;
		try {
			date = (Date) formatter.parse(str_date);
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);

			Date fecha = cal.getTime();
			SimpleDateFormat formatoDeFecha = new SimpleDateFormat(
					"EEEE/MM/yyyy");

			str_date = formatoDeFecha.format(fecha).substring(0, 1)
					.toUpperCase()
					+ formatoDeFecha.format(fecha).substring(1,
							formatoDeFecha.format(fecha).length());
			fechades = str_date.split("/");

			return devuelveDia(fechades[0]) + ", " + dia + " de "
					+ devuelveMesCompleto(Integer.parseInt(mes)) + " del "
					+ anio;
		} catch (ParseException e) {
			e.printStackTrace();
			return "";
		}
	}

	public static Long stringToNum(String numero)
	{
		if(numero == null) return new Long(0);
		return numero.isEmpty()?0:Long.parseLong(numero);	
	}
	
	public static String devuelveMes(int numMes) {
		String mes = "";

		switch (numMes) {
		case 1:
			mes = "Ene";
			break;
		case 2:
			mes = "Feb";
			break;
		case 3:
			mes = "Mar";
			break;
		case 4:
			mes = "Abr";
			break;
		case 5:
			mes = "May";
			break;
		case 6:
			mes = "Jun";
			break;
		case 7:
			mes = "Jul";
			break;
		case 8:
			mes = "Ago";
			break;
		case 9:
			mes = "Sep";
			break;
		case 10:
			mes = "Oct";
			break;
		case 11:
			mes = "Nov";
			break;
		case 12:
			mes = "Dic";
			break;
		}
		return mes;
	}
	
	public static ArrayList<String> devuelveListaString(String valor){

		System.out.println("Lista: "+valor);
		List<String> items = Arrays.asList(valor.split("\\|"));
		ArrayList<String> lista = new ArrayList<String>();
		
		for(int i=0;i<items.size();i++){
			if(!items.get(i).equals("|") && !items.get(i).equals("")){
				lista.add(items.get(i));
			}
		}
		
		return lista;
	}
	
	public static ArrayList<Long> devuelveListaNum(String valor){

		System.out.println("Lista: "+valor);
		List<String> items = Arrays.asList(valor.split("\\|"));
		ArrayList<Long> lista = new ArrayList<Long>();
		
		for(int i=0;i<items.size();i++){
			if(!items.get(i).equals("|") && !items.get(i).equals("")){
				lista.add(Long.parseLong(items.get(i)));
			}
		}
		
		return lista;
	}
	
	public static void main(String[] args) {
		System.out.println(devuelveListaString("p1|p2|p3|"));
	}
	
	public static String devuelveMesCompleto(int numMes) {
		String mes = "";

		switch (numMes) {
		case 1:
			mes = "Enero";
			break;
		case 2:
			mes = "Febrero";
			break;
		case 3:
			mes = "Marzo";
			break;
		case 4:
			mes = "Abril";
			break;
		case 5:
			mes = "Mayo";
			break;
		case 6:
			mes = "Junio";
			break;
		case 7:
			mes = "Julio";
			break;
		case 8:
			mes = "Agosto";
			break;
		case 9:
			mes = "Septiembre";
			break;
		case 10:
			mes = "Octubre";
			break;
		case 11:
			mes = "Noviembre";
			break;
		case 12:
			mes = "Diciembre";
			break;
		}
		return mes;
	}

	public static String devuelveDia(String dia) {
		if (dia.equals("Monday"))
			dia = "Lunes";

		else if (dia.equals("Tuesday"))
			dia = "Martes";

		else if (dia.equals("Wednesday"))
			dia = "Mi&eacute;rcoles";

		else if (dia.equals("Thursday"))
			dia = "Jueves";

		else if (dia.equals("Friday"))
			dia = "Viernes";

		else if (dia.equals("Saturday"))
			dia = "Sabado";

		else if (dia.equals("Sunday"))
			dia = "Domingo";

		return dia;
	}

	public static String getLabel(String key, String sCodIdioma) {
		Properties props = new Properties();
		InputStream is = null;

		try {
			// Agregar mas plantillas de idioma
			if (sCodIdioma.equals("spa"))
				// is =
				// Fmt.class.getResourceAsStream("/idiomas/tyc_config_spa.properties");
				is = new FileInputStream("C:/tyc_config_spa.properties");
			else if (sCodIdioma.equals("eng"))
				// is =
				// Fmt.class.getResourceAsStream("/idiomas/tyc_config_eng.properties");
				is = new FileInputStream("C:/tyc_config_eng.properties");

			props.load(is);
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}

		return props.getProperty(key);
	}
}
