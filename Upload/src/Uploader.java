import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.PrintStream;
import java.util.Date;

public class Uploader {

	static final String rutaDirLocal = "/Volumes/Respaldo/docs/";
	static final String rutaDirServerAWS = "/home/ec2-user/DOCS/";
	static final String rutaDirServerMutual = "";
	
	static final String rutaScript = "/Volumes/Respaldo/script.sql";
	static final String numFolio="0";
	static final String numAdherente="0";
	static final String descripcion="CARGA MASIVA INICIAL";
	static final int idCartera = 4;
	static final String idProducto="0";
	static final String fecCreacion = new Date().toString();
	static String codArea = "";
	static String nomDocumento = "";
	static int idDocumento = 0;
	static 	FileWriter script = null;
	
	public static void main(String[] args) {
		
		genera(rutaDirLocal);
	}
	
	public static void genera(String ruta) {

		File documento = new File(ruta);

		for(File file: documento.listFiles()){
			
			if(file.isFile()){
				idDocumento++;
				file.renameTo(new File(ruta+limpiaNombres(file.getName())));
				nomDocumento = file.getName();
				generaScript(idDocumento, nomDocumento, idCartera, codArea, ruta);
			}else if(file.isDirectory()){
				//System.out.println("Nombre Dir: "+file.getName());
				codArea = file.getName();
				//System.out.println("Path: "+file.getAbsolutePath());
				genera(file.getAbsolutePath());
			}
		}
	}
	
	public static String limpiaNombres(String input) {
	 
	    String original = "‡ˆŠ‘’“•—˜šœu–çË€ƒéèêíìîñ…òô†„‚";
	    String ascii = "aaaeeeiiiooouuunAAAEEEIIIOOOUUUNcC";
	    String output = input;
	    for (int i=0; i<original.length(); i++) {
	        output = output.replace(original.charAt(i), ascii.charAt(i));
	    }
	    return output.toUpperCase();
	}
	
	public static void generaScript(int id_documento, String nombre, int idCartera, String cod_area, String ruta){
		
		String sql = "INSERT INTO DOCUMENTO(";
		sql =	sql	+ "ID_DOCUMENTO,"
				+ "NOMBRE,"
				+ "NUM_FOLIO,"
				+ "NUM_ADHERENTE,"
				+ "DESCRIPCION,"
				+ "ID_CARTERA,"
				+ "ID_PRODUCTO,"
				+ "COD_AREA,"
				+ "RUTA,"
				+ "FEC_CREACION"
				+ ")";
		sql = 	sql	+ "VALUES("
				+id_documento+","
				+"'"+nombre+"',"
				+"'"+numFolio+"',"
				+"'"+numAdherente+"',"
				+"'"+descripcion+"',"
				+idCartera+","
				+idProducto+","
				+"'"+cod_area+"',"
				+"'"+ruta+"',"
				+"now()"+
				");";
		
		System.out.println(sql);
		
		PrintStream out;
		try {
			out = new PrintStream(new FileOutputStream(rutaScript));
			System.setOut(out);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
}