package cl.antartis.interac.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

import cl.antartis.interac.beans.Documento;
import cl.antartis.interac.beans.Usuario;
import cl.antartis.interac.ejb.interfaces.EJBRemoto;

public class UploadImage extends HttpServlet{
	
	private static final long serialVersionUID = 8679793548134407867L;
	@EJB(mappedName = "interac/EJB")
	private EJBRemoto ejbRemoto;
	private String pagDestino = "";
	private Logger log = Logger.getLogger(UploadImage.class);
	
	public UploadImage() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		TreeMap<String, Object> query = new TreeMap<String, Object>();
		HashMap<String, String> map = new HashMap<String, String>();
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
					fieldName = item.getFieldName();
					fileName = item.getName();
					System.out.println("fileName: " + fileName);
					System.out.println("fieldName: " + fieldName);
					System.out.println("Tamaño: " + items.size());
					System.out.println("Nombre: " + items.get(0).getName());

					//DESARROLLO
					//File archivo_server = new File("C://interac/imagenes.war/" + fileName);
					
					//PRODUCCION
					String relativeWebPath = "WebContent/img/user";
					String absoluteFilePath = getServletContext().getRealPath(relativeWebPath);
					System.out.println("CAMINOOO: " + absoluteFilePath);
					File archivo_server = new File(absoluteFilePath, fieldName + ".jpg");
					//info.log("CAMINOOO: " + filePath + "/img/user/ "+ fieldName + ".jpg");
					if (item.isFormField()) {
						map.put(item.getFieldName(), item.getString());
						log.info("fieldvalue = "+item.getString());
					}
					else // file object
					{
						String fieldname = item.getFieldName();
		                String filename = FilenameUtils.getName(item.getFieldName());
		                InputStream filecontent = item.getInputStream();
						System.out.println("No es form field");
					
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
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		} else {
			query = new TreeMap<String, Object>();
			Map tbl = request.getParameterMap();
			query.putAll(tbl);
		}
		pagDestino="Servlet?accion=modificarUsuario";
		System.out.println("Despachando a pag destino: "+pagDestino);
		Usuario d = new Usuario(map);	
		log.info(d.getUsuario());
		request.setAttribute("usuario",d);
		despacha(request, response, pagDestino);
	}
	
	public static void main(String[] args) {
		System.out.println(System.getProperty("user.home"));
	}
	
	/**********DESPACHADOR**************************************************************************/
	public void despacha(HttpServletRequest request, HttpServletResponse response, String destino) throws ServletException, IOException {
		RequestDispatcher despachador = request.getRequestDispatcher(destino);
		despachador.forward(request, response);
	}
}