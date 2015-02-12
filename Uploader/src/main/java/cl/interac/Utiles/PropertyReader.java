package cl.interac.Utiles;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

/**
 * Created by claudio on 11-02-15.
 */
public class PropertyReader {
    private static Properties properties;

    public static String get(String llave) {
        if (properties == null) {
            try {
                FileInputStream fileInputStream = new FileInputStream("config.properties");
                properties = new Properties();
                properties.load(fileInputStream);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return properties.getProperty(llave);
    }
}
