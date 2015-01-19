package cl.antartis.interac.funciones;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigUtils {
	
	private static String pathConfigFile = "/config/config.properties";
	
	/**
	 * Retorna valor de configuraci�n. <p>
	 * Retorna valor de configuraci�n correspondiente a la variable 'key', si no existe retorna null.
	 * @param key nombre de la variable de configuraci�n a buscar.
	 * @return String correspondiente al valor de configuraci�n de la llave key
	 */
	public static String loadProperties(String key) {
		Properties props = new Properties();
		InputStream is = null;
		try {
			is = Encriptador.class.getResourceAsStream(pathConfigFile);
			props.load(is);
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		
		return props.getProperty(key);
	}
}
