package cl.interac.negocio;

import cl.interac.Utiles.PropertyReader;
import cl.interac.dao.DocumentoDAO;
import cl.interac.entidades.Documento;

import java.io.*;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

/**
 * Created by claudio on 11-02-15.
 */
public class UploaderMain {

    public static void main(String[] args) {
        UploaderMain uploaderMain = new UploaderMain();
        uploaderMain.subirArchivo(PropertyReader.get("pathLectura"), null);
        System.err.println("TERMINE!");
    }

    public void subirArchivo(String ruta, String area) {
        File subirRuta = new File(ruta);
        DocumentoDAO documentoDAO = new DocumentoDAO();
        for (File f : subirRuta.listFiles()) {
            System.err.println("LLEGA: " + f.getName() + " AREA: " + area);
            if (f.isFile() && area != null) {
                try {
                    documentoDAO.beginTransaction();
                    Documento d = new Documento();
                    d.setNombre(f.getName());
                    d.setCodArea(area);
                    d.setFecCreacion(new Date());
                    d.setIdCartera(Integer.parseInt(PropertyReader.get("carteraPorDefecto")));
                    documentoDAO.guardarArchivo(d);
                    System.err.println("SE HA GUARDADO: "+d.getNombre()+" ID: "+d.getIdDocumento());
                    Path origen = Paths.get(f.getAbsolutePath());
                    File temp = new File(PropertyReader.get("pathUpload") + d.getIdDocumento());
                    temp.createNewFile();
                    Path destino = Paths.get(PropertyReader.get("pathUpload") + d.getIdDocumento());
                    d.setRuta(PropertyReader.get("pathUpload") + d.getIdDocumento());
                    documentoDAO.guardarArchivo(d);
                    Files.copy(origen, destino);
                    documentoDAO.commitTransaction();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (f.isDirectory()) subirArchivo(f.getAbsolutePath(), f.getName());
        }
    }

    private String obtenerMimeType(File f) {
        try {
            return URLConnection.guessContentTypeFromStream(
                    new BufferedInputStream(new FileInputStream(f))
            );
        } catch (FileNotFoundException e) {
            return null;
        } catch (IOException e) {
            return null;
        }
    }
}
