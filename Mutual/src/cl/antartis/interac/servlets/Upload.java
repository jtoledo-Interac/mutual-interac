package cl.antartis.interac.servlets;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cl.antartis.interac.ejb.interfaces.EJBRemoto;

public class Upload extends HttpServlet{
	
	private static final long serialVersionUID = -224560897811693302L;
	@EJB(mappedName = "interac/EJB")
	private EJBRemoto ejbRemoto;

	public Upload() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		TreeMap<String, Object> query = new TreeMap<String, Object>();

		if (isMultipart) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(1000000);
			File repository = new File(System.getProperty("user.home"));
			factory.setRepository(repository);
			ServletFileUpload upload = new ServletFileUpload(factory);

			String fileName = "";
			String fieldName = "";

			try {

				List<FileItem> items = upload.parseRequest(request);

				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();

					fileName = item.getName();
					fieldName = item.getFieldName();

					System.out.println("fileName: " + fileName);
					System.out.println("fieldName: " + fieldName);
					System.out.println("Tamaño: " + items.size());
					System.out.println("Nombre: " + items.get(0).getName());

					//DESARROLLO
					//File archivo_server = new File("C://interac/imagenes.war/" + fileName);
					
					//PRODUCCION
					File archivo_server = new File("archivos/" + fileName);
					File hola = new File("hola.hola");
					hola.createNewFile();
					if (item.isFormField()) {
						String name = item.getFieldName();
						String value = item.getString();
						query.put(name, value);
					} 
					else // file object
					{
						System.out.println("No es form field");
					}

					try {
						item.write(archivo_server); //escribe archivo en servidor
						System.out.println("Nombre --> " + item.getName());
						System.out.println("<br> Tipo --> "+ item.getContentType());
						System.out.println("<br> Tamaño --> "+ (item.getSize() / 1240) + "KB");
						System.out.println("<br>");
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		} else {
			query = new TreeMap<String, Object>();
			Map tbl = request.getParameterMap();
			query.putAll(tbl);
		}
	}
	
	public static void main(String[] args) {
		System.out.println(System.getProperty("user.home"));
	}
}