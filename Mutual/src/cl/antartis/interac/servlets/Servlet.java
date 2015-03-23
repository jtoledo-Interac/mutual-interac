
package cl.antartis.interac.servlets;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.log4j.Logger;
import org.hibernate.ejb.packaging.Entry;

import cl.antartis.interac.beans.Cartera;
import cl.antartis.interac.beans.CategoriaLink;
import cl.antartis.interac.beans.Documento;
import cl.antartis.interac.beans.Empresa;
import cl.antartis.interac.beans.Estado;
import cl.antartis.interac.beans.Link;
import cl.antartis.interac.beans.Medio;
import cl.antartis.interac.beans.Motivo;
import cl.antartis.interac.beans.Perfil;
import cl.antartis.interac.beans.Prioridad;
import cl.antartis.interac.beans.Producto;
import cl.antartis.interac.beans.Reclamo;
import cl.antartis.interac.beans.Reporte;
import cl.antartis.interac.beans.Tipo;
import cl.antartis.interac.beans.Usuario;
import cl.antartis.interac.beans.Error;
import cl.antartis.interac.ejb.interfaces.EJBRemoto;
import cl.antartis.interac.funciones.ConfigUtils;
import cl.antartis.interac.funciones.EmailUtils;
import cl.antartis.interac.funciones.Encriptador;
import cl.antartis.interac.funciones.FileUtils;
import cl.antartis.interac.funciones.Utils;

public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 24805145326056582L;
	private Logger log = Logger.getLogger(Servlet.class);
	private String pagDestino = "";
	private Error error = null;
	ArrayList<String> permitidosSinLogin = new ArrayList<String>();
	//private Perfil perfiles = null; //TODO
	
	@EJB(mappedName = "mutual/EJB")
	private EJBRemoto ejbRemoto;

	public Servlet() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    Properties props = System.getProperties();  
	    String jbossServerHomeUrl = props.getProperty( "jboss.server.home.url");  
	    log.info("<<<<<<<"+jbossServerHomeUrl+">>>>>");
	    permitidosSinLogin.add("login");
	    permitidosSinLogin.add("recuperar");
	    permitidosSinLogin.add("verificaLinkContrasena");
	    permitidosSinLogin.add("actualizarContrasena");
	    
		try {
			log.info("Service controller");
			String accion = request.getParameter("accion");
			log.info("Accion service: "+accion);
			
			HttpSession session = request.getSession();
			if(accion==null) pagDestino = "login.jsp";
			else{
				if( session.getAttribute("user") == null && !permitidosSinLogin.contains(accion)){
					pagDestino = "login.jsp";
				}else{
					MethodUtils.invokeMethod(this, accion, new Object[]{request,response});
				}
			}
			request.setAttribute("error", error);
			log.info("Despachando a pag destino: "+pagDestino);
			despacha(request, response, pagDestino);

		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**********DESPACHADOR**************************************************************************/
	public void despacha(HttpServletRequest request, HttpServletResponse response, String destino) throws ServletException, IOException {
		RequestDispatcher despachador = request.getRequestDispatcher(destino);
		despachador.forward(request, response);
	}
	
	/**********SESION******************************************************************************/
	@SuppressWarnings("unchecked")
	public void login(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		ArrayList<String> perfiles = new ArrayList<String>();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Encriptador encriptador = new Encriptador();
		
		Usuario usuario = new Usuario();
		usuario.setNomUsuario(request.getParameter("sNomUsuario"));
		usuario.setContrasena1(encriptador.encriptar(request.getParameter("sContrasena")));
		usuario.setHost(request.getRemoteAddr());
		
		System.out.println("["+usuario.getNomUsuario()+" - "+usuario.getContrasena1()+"]");
		
		log.info("Usuario: "+usuario.getUsuario());
		
		mapaEntrada.put("usuario", usuario);
		mapaSalida = ejbRemoto.logIn(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		usuario = (Usuario)mapaSalida.get("usuario");
		perfiles = (ArrayList<String>)mapaSalida.get("perfiles");
		
		log.info("Num Error: "+error.getNumError());
		log.info("Msj Error: "+error.getMsjError());

		if(error.getNumError().equals("0")){
			System.out.println(ConfigUtils.loadProperties("sessionTime"));
			int sessionTime = Integer.parseInt(ConfigUtils.loadProperties("sessionTime"));
			
			//setting session to expiry in 30 mins.
			HttpSession session = request.getSession();
			session.setAttribute("nombre", usuario.getNombres()+" "+usuario.getApePaterno()+" "+usuario.getApeMaterno());
			session.setAttribute("user",usuario);
			session.setAttribute("perfiles", perfiles);
			session.setMaxInactiveInterval(sessionTime);
			
			//setting cookie to expiry in 30 mins.
			Cookie userName = new Cookie("user", request.getParameter("sNomUsuario"));
			userName.setMaxAge(sessionTime);
			response.addCookie(userName);
			
			mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
			
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			
			pagDestino = "contenedor.jsp";
		}
		else{
			System.out.println("Deber�a mandar a login.");
			pagDestino = "login.jsp";
		}
	}
	
	public void logOut(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html");
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
	        for(Cookie cookie : cookies){
	            if(cookie.getName().equals("JSESSIONID")){
	                System.out.println("JSESSIONID="+cookie.getValue());
	                break;
	            }
	        }
        }
        
        //invalidate the session if exists
        HttpSession session = request.getSession(false);
        if(session != null){
        	System.out.println("User="+session.getAttribute("user"));
            session.invalidate();
        }
		pagDestino = "login.jsp";
	}
	
	public void recuperar(HttpServletRequest request, HttpServletResponse response){
		String opcion = request.getParameter("op");
		log.info("rec");
		log.info(opcion);
		log.info(request.getParameter("_user"));
		if(opcion.equals("op1")){
			this.recuperarContrasena(request,response);
		}
		else{
			this.recuperarUsuario(request, response);
		}
	}
	
	public void recuperarContrasena(HttpServletRequest request, HttpServletResponse response){
		log.info("Entra a "+new Object(){}.getClass().getEnclosingMethod().getName());
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		mapaEntrada.put("usuario", request.getParameter("_user"));
		mapaSalida = ejbRemoto.recuperarContrasena(mapaEntrada);
		int id = (Integer)mapaSalida.get("id");
		if((Boolean)mapaSalida.get("valido")){
			Encriptador e = new Encriptador();
			String link= request.getParameter("_user")+" "+id+" "+new Date().getTime();
			link = e.encriptar(link);
			link = "<a href='"+ConfigUtils.loadProperties("dominio")+
					"Servlet?accion=verificaLinkContrasena&l="+link+"'>Recuperar contrase�a.</a>";
			String email = (String)mapaSalida.get("email");
			String subject = "Mutual - Recuperaci�n de contrase�a";
			String body = "Recibimos una solicitud de cambio de contrase�a. Para confirmar tu nueva contrase�a haz click en el siguiente enlace: .<br/>"
					+link+ "<br/>Si t� no has solicitado cambio de contrase�a ignora este email.<br/>";
			
			if(EmailUtils.sendMailHtml(email, subject, body)){
				request.setAttribute("msgHeader", "Recuperar contrase�a");
				request.setAttribute("msgBody", "Se ha enviado un link para recuperar su contrase�a a su cuenta de correo electr�nico " + email);
				request.setAttribute("msgRedirect", "index.jsp");
				this.pagDestino = "mensaje.jsp";
			}
			else{
				this.pagDestino = "error.jsp";
			}
		}
	}
	
	public void recuperarUsuario(HttpServletRequest request, HttpServletResponse response){
		log.info("Entra a "+new Object(){}.getClass().getEnclosingMethod().getName());
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		mapaEntrada.put("email", request.getParameter("email"));
		mapaSalida = ejbRemoto.recuperarUsername(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error.getNumError().equals("0")){
			String user = (String)mapaSalida.get("user");
			
			String email = request.getParameter("email");
			String subject = "Mutual - Recuperaci�n de nombre de usuario";
			String body = "Hemos recibido una solicitud para recuperar su nombre de usuario.<br>Su nombre de usuario es: "
					+ user;
			
			if(EmailUtils.sendMailHtml(email, subject, body)){
				request.setAttribute("msgHeader", "��xito!");
				request.setAttribute("msgBody", "Se ha env�ado un mail con su nombre de usuario.");
				request.setAttribute("msgRedirect", "index.jsp");
				this.pagDestino = "mensaje.jsp";
			}
			else{
				pagDestino = "error.jsp";
			}
		}
		else{
			this.pagDestino = "error.jsp";
		}
	}
	
	public void verificaLinkContrasena(HttpServletRequest request, HttpServletResponse response){
		Encriptador e = new Encriptador();
		String l = request.getParameter("l");
		String user = "";
		Date fecha = null;
		l = e.desencriptar(l);
		String aux[] = l.split(" ");
		user = aux[0];
		int id = Integer.parseInt(aux[1]);
		fecha = new Date(Long.parseLong(aux[2]));
		log.info("Fecha: "+fecha);
		log.info("Ahora: "+new Date());
		int horas = Utils.diferenciaEnHoras(fecha);
		log.info("diferencia en horas: "+horas);
		if(horas <Integer.parseInt(ConfigUtils.loadProperties("duracion_recovery")) ){
			request.setAttribute("user", user);
			request.setAttribute("id", id);
			this.pagDestino = "usuarios/cambiarContrasena.jsp";
		}
		else{
			request.setAttribute("msgHeader", "Link inv�lido");
			request.setAttribute("msgBody", "El link que intenta utilizar ha expirado. Si desea reestablecer su contrase�a, vuelva a solicitar el link a su correo electr�nico.");
			request.setAttribute("msgRedirect", "index.jsp");
			this.pagDestino = "mensaje.jsp";
		}
	}
	
	public void actualizarContrasena(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		Encriptador encript = new Encriptador();
		
		mapaEntrada.put("id", request.getParameter("id"));
		mapaEntrada.put("contrasena", encript.encriptar(request.getParameter("nuevaContrasena")));
		log.info(request.getParameter("nuevaContrasena"));
		mapaSalida = ejbRemoto.actualizarContrasena(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error.getNumError().equals("0")){
			request.setAttribute("msgHeader", "Contrase�a restablecida");
			request.setAttribute("msgBody", "Su contrase�a ha sido restablecida, inicie sesi�n con sus nuevos datos.");
			request.setAttribute("msgRedirect", "index.jsp");
			pagDestino = "mensaje.jsp";
		}
		else{
			pagDestino = "error.jsp";
		}
		
	}
	
	/**********ORGANIGRAMA****************************************************************************/	
	public void organigrama(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	/**********USUARIOS****************************************************************************/	
	public void usuarios(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void crearUsuario(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "usuarios/agregaUsuario.jsp";
	}

	
	public void buscarUsuarios(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Usuario usuario = new Usuario();
		usuario.setRut(Utils.getRutSinDV(request.getParameter("sRut")));
		usuario.setDv(request.getParameter("sDV"));
		usuario.setNombres(request.getParameter("sNombres"));
		usuario.setApePaterno(request.getParameter("sApePaterno"));
		usuario.setApeMaterno(request.getParameter("sApeMaterno"));
		usuario.setNomUsuario(request.getParameter("sNomUsuario"));
		
		mapaEntrada.put("usuario",usuario);
		
		mapaSalida = ejbRemoto.buscarUsuarios(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaUsuarios", mapaSalida.get("listaUsuarios"));
			pagDestino = "/usuarios/listaUsuariosXml.jsp";
		}
	}

	public void agregarUsuario(HttpServletRequest request, HttpServletResponse response) {
		Encriptador encriptador = new Encriptador();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("Comuna: "+request.getParameter("nIdComuna"));
		
		Usuario usuario = new Usuario();
		usuario.setRut(Utils.getRutSinDV(request.getParameter("sRut")));
		usuario.setDv(request.getParameter("sDV"));
		usuario.setNombres(request.getParameter("sNombres"));
		usuario.setApePaterno(request.getParameter("sApePaterno"));
		usuario.setApeMaterno(request.getParameter("sApeMaterno"));
		usuario.setNomUsuario(request.getParameter("sNomUsuario"));
		//TODO: Revisar pass1 y pass2 que sean iguales
		usuario.setContrasena1(encriptador.encriptar(request.getParameter("sContrasena1")));
		usuario.setCodGenero(request.getParameter("sCodGenero"));
		usuario.setFecNacimiento(request.getParameter("sFecNacimiento"));
		usuario.setTelefono(request.getParameter("sTelefono"));
		usuario.setCelular(request.getParameter("sCelular"));
		usuario.setEmail(request.getParameter("sEmail"));
		
		mapaEntrada.put("usuario",usuario);
		
		//log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarUsuario(mapaEntrada);
		
		log.info("ID Usuario: "+mapaSalida.get("nIdUsuario"));

error = (Error)mapaSalida.get("error");
if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=usuarios";
		}
	}
	
	public void cargarUsuario(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		long nIdUsuario = Utils.stringToNum(request.getParameter("nIdUsuario"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("nIdUsuario: "+nIdUsuario);
		
		mapaEntrada.put("nIdUsuario", nIdUsuario);
		
		mapaSalida = ejbRemoto.cargarUsuario(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("usuario", (Usuario)mapaSalida.get("usuario"));
			request.setAttribute("listaComunas", mapaSalida.get("listaComunas"));
			request.setAttribute("listaProvincias", mapaSalida.get("listaProvincias"));
			request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));
			pagDestino = "/usuarios/cargaUsuario.jsp";
		}
	}
	
	public void modificarUsuario(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Usuario usuario = (Usuario) request.getAttribute("usuario");
		log.info(usuario.getUsuario());
		mapaEntrada.put("usuario",usuario);
		mapaSalida = ejbRemoto.modificarUsuario(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=usuarios";
		}
	}
	
	public void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		long idUsuario = Utils.stringToNum(request.getParameter("nIdUsuario"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idUsuario: "+idUsuario);
		
		mapaEntrada.put("idUsuario", idUsuario);
		
		mapaSalida = ejbRemoto.eliminarUsuario(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "/usuarios/listaUsuariosXml.jsp";
		}
	}

	/**********PERFILES****************************************************************************/	
	public void perfiles(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void crearPerfil(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "perfiles/agregaPerfil.jsp";
	}

	
	public void buscarPerfiles(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Perfil perfil = new Perfil();
		
		log.info("!!!");
		
		perfil.setDesPerfil(request.getParameter("pNombres"));
		
		log.info("!!55!");
		
		mapaEntrada.put("perfil", perfil);
		
		log.info("3232");
		
		mapaSalida = ejbRemoto.buscarPerfiles(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaPerfiles", mapaSalida.get("listaPerfiles"));
			pagDestino = "/perfiles/listaPerfilesXml.jsp";
		}
	}

	public void agregarPerfil(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		Perfil perfil = new Perfil(); 
		perfil.setDesPerfil(request.getParameter("desPerfil"));
		mapaEntrada.put("perfil",perfil);
		mapaSalida = ejbRemoto.agregarPerfil(mapaEntrada);
		 
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=perfiles";
		}
	}
	
	public void cargarUPerfil(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		long nIdUsuario = Utils.stringToNum(request.getParameter("nIdUsuario"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("nIdUsuario: "+nIdUsuario);
		
		mapaEntrada.put("nIdUsuario", nIdUsuario);
		
		mapaSalida = ejbRemoto.cargarUsuario(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("usuario", (Usuario)mapaSalida.get("usuario"));
			request.setAttribute("listaComunas", mapaSalida.get("listaComunas"));
			request.setAttribute("listaProvincias", mapaSalida.get("listaProvincias"));
			request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));
			pagDestino = "/perfiles/cargaPerfil.jsp";
		}
	}
	
	public void modificaPerfil(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		
		Usuario usuario = new Usuario();
		//usuario.setIdUsuario(Utils.stringToNum(request.getParameter("nIdUsuario")));
		usuario.setRut(Utils.getRutSinDV(request.getParameter("sRut")));
		usuario.setDv(request.getParameter("sDV"));
		usuario.setNombres(request.getParameter("sNombres"));
		usuario.setApePaterno(request.getParameter("sApePaterno"));
		usuario.setApeMaterno(request.getParameter("sApeMaterno"));
		usuario.setNomUsuario(request.getParameter("sNomUsuario"));
		usuario.setCodGenero(request.getParameter("sCodGenero"));
		usuario.setFecNacimiento(request.getParameter("sFecNacimiento"));
		usuario.setTelefono(request.getParameter("sTelefono"));
		usuario.setCelular(request.getParameter("sCelular"));
		usuario.setEmail(request.getParameter("sEmail"));
		
		log.info(usuario.getUsuario());
		
		mapaEntrada.put("usuario",usuario);		
		mapaSalida = ejbRemoto.modificarUsuario(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=usuarios";
		}
	}
	
	public void eliminarPerfil(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idPerfil = Utils.stringToNum(request.getParameter("idPerfil"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		log.info("idPerfil: "+idPerfil);
		
		mapaEntrada.put("idPerfil", idPerfil);
		mapaSalida = ejbRemoto.eliminarPerfil(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "perfiles/listaPerfilesXml.jsp";
		}
	}
	
	
	/**********CARTERAS****************************************************************************/	
	public void carteras(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		pagDestino = "contenedor.jsp";
	}

	public void categorias(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		pagDestino = "contenedor.jsp";
	}
	
	public void crearCartera(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		pagDestino = "carteras/agregaCartera.jsp";
	}
	
	public void crearLink(HttpServletRequest request, HttpServletResponse response) 
	{
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		mapaSalida = ejbRemoto.buscarParametrosLink(mapaEntrada);
		
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		request.setAttribute("listaCategoriasLink",mapaSalida.get("listaCategoriasLink"));
		pagDestino = "link/agregaLink.jsp";
	}
	
	public void seleccionarEmpresa(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		pagDestino = "reclamos/seleccionarEmpresa.jsp";
	}
	
	public void seleccionarEmpresas(HttpServletRequest request, HttpServletResponse response) 
	{
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		Empresa empresa = new Empresa();
		empresa.setNumAdherente(request.getParameter("numAdherente"));
		empresa.setNombre(request.getParameter("nomEmpresa"));
		//empresa.setIdEmpresa(request.getParameter("idEmpresa"));

		log.info("Empresa:++" + empresa.getNumAdherente() + "\n"
				+ empresa.getNombre());

		mapaEntrada.put("empresa", empresa);

		mapaSalida = ejbRemoto.buscarEmpresas(mapaEntrada);
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if (!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			request.setAttribute("listaEmpresas",mapaSalida.get("listaEmpresas"));
			pagDestino = "/reclamos/listaEmpresasXml.jsp";
		}
	}
	
	public void crearTipo(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "tipos/agregaTipo.jsp";
	}
	
	public void crearCategoriaLink(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "categoria_link/agregaCategoria.jsp";
	}
	
	public void crearMotivo(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "motivos/agregaMotivo.jsp";
	}

	public void crearMedio(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "medios/agregaMedio.jsp";
	}
	
	public void buscarCarteras(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Cartera cartera = new Cartera();
		cartera.setDesCartera(request.getParameter("nomCartera"));
		
		mapaEntrada.put("cartera",cartera);
		
		mapaSalida = ejbRemoto.buscarCarteras(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{	
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			pagDestino = "/carteras/listaCarterasXml.jsp";
		}
	}
	
	public void buscarCategorias(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		CategoriaLink categoriaLink = new CategoriaLink();
		categoriaLink.setDesCategoriaLink(request.getParameter("nomCategoria"));
		
		mapaEntrada.put("categoriaLink",categoriaLink);
		
		mapaSalida = ejbRemoto.buscarCategoriasLink(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{	
			request.setAttribute("listaCategoriasLink", mapaSalida.get("listaCategoriasLink"));
			log.info("size of listaCategoriasLink: "+ ((ArrayList<CategoriaLink>)mapaSalida.get("listaCategoriasLink")).size());
			pagDestino = "/categoria_link/listaCategoriaXml.jsp";
		}
	}

	public void agregarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("Comuna: "+request.getParameter("nombre"));
		
		Cartera cartera = new Cartera();
		cartera.setDesCartera(request.getParameter("nombre"));

		log.info("nomCartera: " + request.getParameter("nombre") );
		
		mapaEntrada.put("cartera",cartera);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		mapaSalida = ejbRemoto.agregarCartera(mapaEntrada);
		
		log.info("ID Cartera: "+mapaSalida.get("idCartera"));

error = (Error)mapaSalida.get("error");
if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=carteras";
		}
	}
	
	public void agregarTipo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Tipo tipo = new Tipo();
		tipo.setDesTipo(request.getParameter("desTipo"));

		log.info("desTipo: " + request.getParameter("desTipo") );
		
		mapaEntrada.put("tipo",tipo);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarTipo(mapaEntrada);
		
		log.info("ID Cartera: "+mapaSalida.get("idCartera"));
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=tipos";
		}
	}

	public void agregarCategoriaLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		CategoriaLink categoriaLink = new CategoriaLink();
		categoriaLink.setDesCategoriaLink(request.getParameter("desCategoriaLink"));
		
		log.info("desCategoriaLink: " + request.getParameter("desCategoriaLink") );
		
		mapaEntrada.put("categoriaLink", categoriaLink);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarCategoriaLink(mapaEntrada);
		
		log.info("ID Categoria Link: "+mapaSalida.get("idCategoriaLink"));
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=categorias";
		}
	}
	
	public void agregarMotivo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Motivo motivo = new Motivo();
		motivo.setDesMotivo(request.getParameter("desMotivo"));

		log.info("desTipo: " + request.getParameter("desTipo") );
		
		mapaEntrada.put("motivo",motivo);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarMotivo(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=motivos";
		}
	}

	public void agregarLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Link link = new Link();
		link.setDesLink(request.getParameter("desLink"));
		link.setUrlLink(request.getParameter("urlLink"));
		link.setDesCategoriaLink(request.getParameter("desCategoriaLink"));
		link.setIdCategoriaLink(Utils.stringToNum(request.getParameter("idCategoriaLink")));
		
		log.info("desLink: " + request.getParameter("desLink") );
		
		mapaEntrada.put("link",link);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarLink(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=links";
		}
	}
	
	public void agregarMedio(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Medio medio = new Medio();
		medio.setDesMedio(request.getParameter("desMedio"));

		log.info("desMedio: " + request.getParameter("desMedio") );
		
		mapaEntrada.put("medio",medio);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarMedio(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=medios";
		}
	}
	
	public void cargarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idCartera = Utils.stringToNum(request.getParameter("idCartera"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idCartera: "+idCartera);
		
		mapaEntrada.put("idCartera", idCartera);
		
		mapaSalida = ejbRemoto.cargarCartera(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("cartera", (Cartera)mapaSalida.get("cartera"));
			pagDestino = "/carteras/cargaCartera.jsp";
		}
	}
	
	public void cargarCategoriaLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idCategoriaLink = Utils.stringToNum(request.getParameter("idCategoriaLink"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idCartera: "+idCategoriaLink);
		
		mapaEntrada.put("idCategoriaLink", idCategoriaLink);
		
		mapaSalida = ejbRemoto.cargarCategoriaLink(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("categoriaLink", (CategoriaLink)mapaSalida.get("categoriaLink"));
			pagDestino = "/categoria_link/cargaCategoria.jsp";
		}
	}
	
	public void cargarTipo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idTipo = Long.parseLong(request.getParameter("idTipo"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idCartera: "+idTipo);
		
		mapaEntrada.put("idTipo", idTipo);
		
		mapaSalida = ejbRemoto.cargarTipo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("tipo", (Tipo)mapaSalida.get("tipo"));
			pagDestino = "/tipos/cargaTipo.jsp";
		}
	}

	public void cargarMotivo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idMotivo = Utils.stringToNum(request.getParameter("idMotivo"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idMotivo: " + idMotivo);
		
		mapaEntrada.put("idMotivo", idMotivo);
		
		mapaSalida = ejbRemoto.cargarMotivo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("motivo", (Motivo)mapaSalida.get("motivo"));
			pagDestino = "/motivos/cargaMotivo.jsp";
		}
	}
	
	public void cargarMedio(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idMedio = Utils.stringToNum(request.getParameter("idMedio"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idMedio: "+idMedio);
		
		mapaEntrada.put("idMedio", idMedio);
		
		mapaSalida = ejbRemoto.cargarMedio(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("medio", (Medio)mapaSalida.get("medio"));
			pagDestino = "/medios/cargaMedio.jsp";
		}
	}
	
	public void modificarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Cartera cartera = new Cartera();
		cartera.setIdCartera(Utils.stringToNum(request.getParameter("idCartera")));
		cartera.setDesCartera(request.getParameter("desCartera"));

		mapaEntrada.put("cartera",cartera);
		
		mapaSalida = ejbRemoto.modificarCartera(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=carteras";
		}
	}

	public void modificarTipo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Tipo tipo = new Tipo();
		
		tipo.setIdTipo(Long.parseLong(request.getParameter("idTipo")));
		tipo.setDesTipo(request.getParameter("desTipo"));

		mapaEntrada.put("tipo",tipo);
		
		mapaSalida = ejbRemoto.modificarTipo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=tipos";
		}
	}
	
	public void modificarMotivo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Motivo motivo = new Motivo();
		
		motivo.setIdMotivo(Utils.stringToNum(request.getParameter("idMotivo")));
		motivo.setDesMotivo(request.getParameter("desMotivo"));

		mapaEntrada.put("motivo",motivo);
		
		mapaSalida = ejbRemoto.modificarMotivo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=motivos";
		}
	}

	public void modificarCategoriaLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		CategoriaLink categoriaLink= new CategoriaLink();
		categoriaLink.setIdCategoriaLink(Utils.stringToNum(request.getParameter("idCategoriaLink")));
		categoriaLink.setDesCategoriaLink(request.getParameter("desCategoriaLink"));
		mapaEntrada.put("categoriaLink", categoriaLink);
		mapaSalida = ejbRemoto.modificarCategoriaLink(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=categorias";
		}
	}
	
	public void modificarPrioridad(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		Prioridad p= new Prioridad();
		p.setIdPrioridad(Utils.stringToNum(request.getParameter("idPrioridad")));
		p.setDesPrioridad(request.getParameter("desPrioridad"));
		mapaEntrada.put("prioridad",p);
		mapaSalida = ejbRemoto.modificarPrioridad(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=prioridades";
		}
	}
	
	public void modificarMedio(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Medio medio = new Medio();
		
		medio.setIdMedio(Utils.stringToNum(request.getParameter("idMedio")));
		medio.setDesMedio(request.getParameter("desMedio"));

		mapaEntrada.put("medio",medio);
		
		mapaSalida = ejbRemoto.modificarMedio(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=medios";
		}
	}
	
	public void modificarLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Link link = new Link();
		
		link.setIdLink(Utils.stringToNum(request.getParameter("idLink")));
		link.setDesLink(request.getParameter("desLink"));
		link.setIdCategoriaLink(Utils.stringToNum(request.getParameter("idCategoriaLink")));
		link.setUrlLink(request.getParameter("urlLink"));
		mapaEntrada.put("link",link);
		
		mapaSalida = ejbRemoto.modificarLink(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=links";
		}
	}
	
	public void eliminarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String idCartera = request.getParameter("idCartera");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idCartera: "+idCartera);
		
		mapaEntrada.put("idCartera", idCartera);
		
		mapaSalida = ejbRemoto.eliminarCartera(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("cartera", (Usuario)mapaSalida.get("cartera"));
			pagDestino = "/carteras/listaCarterasXml.jsp";
		}
	}
	
	public void eliminarTipo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String idTipo = request.getParameter("idTipo");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idTipo: " + idTipo);
		
		mapaEntrada.put("idTipo", idTipo);
		
		mapaSalida = ejbRemoto.eliminarTipo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("tipo", (Tipo)mapaSalida.get("tipo"));
			pagDestino = "/tipos/listaTiposXml.jsp";
		}
	}
	
	public void eliminarPrioridad(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idPrioridad = Utils.stringToNum(request.getParameter("idPrioridad"));
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		log.info("idPrioridad: " + idPrioridad);
		
		mapaEntrada.put("idPrioridad", idPrioridad);
		mapaSalida = ejbRemoto.eliminarPrioridad(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("prioridad", (Prioridad)mapaSalida.get("prioridad"));
			pagDestino = "prioridades/listaPrioridadesXml.jsp";
		}
	}
	
	public void eliminarCategoriaLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idCategoriaLink = Utils.stringToNum(request.getParameter("idCategoriaLink"));
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		log.info("idCategoriaLInk: " + idCategoriaLink);
		
		mapaEntrada.put("idCategoriaLink", idCategoriaLink);
		mapaSalida = ejbRemoto.eliminarCategoriaLink(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("categoriaLink", (CategoriaLink)mapaSalida.get("categoriaLink"));
			pagDestino = "categoria_link/listaCategoriaXml.jsp";
		}
	}
	
	public void eliminarMotivo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idMotivo = Utils.stringToNum(request.getParameter("idMotivo"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idMotivo: " + idMotivo);
		
		mapaEntrada.put("idMotivo", idMotivo);
		
		mapaSalida = ejbRemoto.eliminarMotivo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("motivo", (Motivo)mapaSalida.get("motivo"));
	
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void eliminarMedio(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idMedio = Utils.stringToNum(request.getParameter("idMedio"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idMedio: " + idMedio);
		
		mapaEntrada.put("idMedio", idMedio);
		
		mapaSalida = ejbRemoto.eliminarMedio(mapaEntrada);
		
		request.setAttribute("medio", (Medio)mapaSalida.get("medio"));
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else
			pagDestino = "/medios/listaMediosXml.jsp";
	}
	
	public void eliminarLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idLink = Utils.stringToNum(request.getParameter("idLink"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idMedio: " + idLink);
		
		mapaEntrada.put("idLink", idLink);
		
		mapaSalida = ejbRemoto.eliminarLink(mapaEntrada);
		
		request.setAttribute("link", (Link)mapaSalida.get("link"));
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else
			pagDestino = "/link/listaLinksXml.jsp";
	}

	public void invalideces(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			request.setAttribute("title", "Invalideces");
	
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void sami(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			request.setAttribute("title", "SAMI");
	
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void fatales(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			request.setAttribute("title", "Fatales");
	
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void prodCartera(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			request.setAttribute("title", "Productos Cartera");
	
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void planesTrabajo(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			request.setAttribute("title", "Planes de Trabajo");
	
			pagDestino = "contenedor.jsp";
		}
	}
	
	
	/**********DOCUMENTOS****************************************************************************/	
	public void documentos(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			request.setAttribute("title", "Documentos de Trabajo");
	
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void crearDocumento(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			
			pagDestino = "documentos/agregaDocumento.jsp";
		}
	}
	
	public void buscarDocumentos(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
		
	
		
		Documento documento = new Documento();
		documento.setNombre(request.getParameter("nombre"));
		documento.setNumFolio(request.getParameter("numFolio"));
		documento.setNumAdherente(request.getParameter("numAdherente"));
		documento.setIdCartera(Utils.stringToNum(request.getParameter("idCartera")));
		documento.setIdProducto(Utils.stringToNum(request.getParameter("idProducto")));
		documento.setCodArea(request.getParameter("codArea"));
		mapaEntrada.put("documento", documento);
		mapaSalida = ejbRemoto.buscarDocumentos(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaDocumentos", mapaSalida.get("listaDocumentos"));
			pagDestino = "/documentos/listaDocumentosXml.jsp";
		}
	}

	public void agregarDocumento(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Documento documento = (Documento)request.getAttribute("documento");
		
		mapaEntrada.put("documento",documento);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarDocumento(mapaEntrada);
		
		log.info("ID Documento: "+mapaSalida.get("idDocumento"));
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=documentos";
		}
	}
	
	public void cargarDocumento(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		long idDocumento = Long.parseLong(request.getParameter("idDocumento"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idDocumento: "+idDocumento);
		
		mapaEntrada.put("idDocumento", idDocumento);
		
		mapaSalida = ejbRemoto.cargarDocumento(mapaEntrada);
		
		request.setAttribute("documento", (Documento)mapaSalida.get("documento"));
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
			pagDestino = "/documentos/cargaDocumento.jsp";
		}
	}
	
	public void modificarDocumento(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Documento documento = new Documento();
		documento.setIdDocumento(Utils.stringToNum(request.getParameter("idDocumento")));
		documento.setNombre(request.getParameter("nombre"));
		documento.setNumFolio(request.getParameter("numFolio"));
		documento.setNumAdherente(request.getParameter("numAdherente"));
		documento.setDescripcion(request.getParameter("descripcion"));
		documento.setCodArea(request.getParameter("codArea"));
		documento.setIdCartera(Utils.stringToNum(request.getParameter("idCartera")));
		documento.setIdProducto(Long.parseLong(request.getParameter("idProducto")));
		documento.setFecCreacion(request.getParameter("fecCreacion"));
		
		mapaEntrada.put("documento",documento);
		
		mapaSalida = ejbRemoto.modificarDocumento(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void eliminarDocumento(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		long idDocumento = Utils.stringToNum(request.getParameter("idDocumento"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idDocumento: "+idDocumento);
		
		mapaEntrada.put("idDocumento", idDocumento);
		
		mapaSalida = ejbRemoto.eliminarDocumento(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "/documentos/listaDocumentosXml.jsp";
		}
	}
	
	/**********EMPRESAS****************************************************************************/	
	public void empresas(HttpServletRequest request,
			HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0]
				.getMethodName();

		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}

	public void crearEmpresa(HttpServletRequest request,
			HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0]
				.getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if (!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			request.setAttribute("listaCarteras",
					mapaSalida.get("listaCarteras"));
			request.setAttribute("listaProductos",
					mapaSalida.get("listaProductos"));
			request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));

			pagDestino = "empresas/agregaEmpresa.jsp";
		}
	}

	public void buscarEmpresas(HttpServletRequest request,
		HttpServletResponse response) {
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		Empresa empresa = new Empresa();
		empresa.setNumAdherente(request.getParameter("numAdherente"));
		empresa.setNombre(request.getParameter("nomEmpresa"));
		empresa.setCodCartera(request.getParameter("codCartera"));

		log.info("Empresa:++" + empresa.getNumAdherente() + "\n"
				+ empresa.getNombre());

		mapaEntrada.put("empresa", empresa);

		mapaSalida = ejbRemoto.buscarEmpresas(mapaEntrada);
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if (!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			request.setAttribute("listaEmpresas",mapaSalida.get("listaEmpresas"));
			pagDestino = "/empresas/listaEmpresasXml.jsp";
		}
	}

	public void agregarEmpresa(HttpServletRequest request,
			HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0]
				.getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		Empresa empresa = new Empresa();
		
		empresa.setNombre(request.getParameter("nombre"));
		empresa.setCodCartera(request.getParameter("codCartera"));
		empresa.setNomExperto(request.getParameter("nomExperto"));
		empresa.setNumAdherente(request.getParameter("numAdherente"));
		empresa.setRazonSocial(request.getParameter("razonSocial"));
		empresa.setAnoDeAdhesion(request.getParameter("anoDeAdhesion"));
		empresa.setSegmentacion(request.getParameter("segmentacion"));
		empresa.setHolding(request.getParameter("holding"));
		empresa.setSituacion(request.getParameter("situacion"));
		empresa.setMultiRegion(request.getParameter("multiRegion"));
		empresa.setCasaMatriz(request.getParameter("casaMatriz"));
		empresa.setRegionCasaMatriz(request.getParameter("regionCasaMatriz"));
		empresa.setMasaSum(request.getParameter("masaSum"));
		empresa.setPlanesDeCuenta(request.getParameter("planesDeCuenta"));
		empresa.setPlanesDeTrabajo(request.getParameter("planesDeTrabajo"));
		empresa.setFirmaDePlanes(request.getParameter("firmaDePlanes"));
		empresa.setSistemaDeGestion(request.getParameter("sistemaDeGestion"));
		empresa.setConstitucionCphs(request.getParameter("constitucionCphs"));
		empresa.setCertificacionCphs(request.getParameter("certificacionCphs"));
		empresa.setMmc(request.getParameter("mmc"));
		empresa.setTmert(request.getParameter("tmert"));
		empresa.setPlanesi(request.getParameter("planesi"));
		empresa.setPlaguicida(request.getParameter("plaguicida"));
		empresa.setRadiacionUv(request.getParameter("radiacionUv"));
		empresa.setHipobaria(request.getParameter("hipobaria"));
		empresa.setPrexor(request.getParameter("prexor"));
		empresa.setPsicosociales(request.getParameter("psicosociales"));
		empresa.setProyectoInvestigacion(request.getParameter("proyectoInvestigacion"));
		empresa.setUltimaVisitaExperto(request.getParameter("ultimaVisitaExperto"));
		empresa.setUltimaVisitaDirector(request.getParameter("ultimaVisitaDirector"));
		empresa.setUltimaVisitaGtte(request.getParameter("ultimaVisitaGtte"));
		empresa.setUltimaVisitaAltaGerencia(request.getParameter("ultimaVisitaAltaGerencia"));
		empresa.setReporteVisita(request.getParameter("reporteVisita"));
		empresa.setRiesgoDeFuga(request.getParameter("riesgoDeFuga"));
		empresa.setReclamoUltimoPeriodo(request.getParameter("reclamoUltimoPeriodo"));
		empresa.setParticipaMesaTrabajo(request.getParameter("participaMesaTrabajo"));
		
		mapaEntrada.put("empresa", empresa);

		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		mapaSalida = ejbRemoto.agregarEmpresa(mapaEntrada);

		//	log.info("id empresa: " + mapaSalida.get("idEmpresa"));

		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if (!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			pagDestino = "contenedor.jsp?accion=empresas";
		}
	}

	public void cargarEmpresa(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		Long idEmpresa = Utils.stringToNum(request.getParameter("idEmpresa"));

		log.info("idEmpresa :" + idEmpresa);
		
		mapaEntrada.put("idEmpresa", idEmpresa);
		mapaSalida = ejbRemoto.cargarEmpresa(mapaEntrada);
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if(!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			request.setAttribute("empresa", (Empresa) mapaSalida.get("empresa"));
			pagDestino = "/empresas/cargaEmpresa.jsp";
		}
	}

	public void modificarEmpresa(HttpServletRequest request,
			HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0]
				.getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		Empresa empresa = new Empresa();

		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		empresa.setIdEmpresa(Utils.stringToNum(request.getParameter("idEmpresa")));
		empresa.setNombre(request.getParameter("nombre"));
		empresa.setCodCartera(request.getParameter("codCartera"));
		empresa.setNomExperto(request.getParameter("nomExperto"));
		empresa.setNumAdherente(request.getParameter("numAdherente"));
		empresa.setRazonSocial(request.getParameter("razonSocial"));
		empresa.setAnoDeAdhesion(request.getParameter("anoDeAdhesion"));
		empresa.setSegmentacion(request.getParameter("segmentacion"));
		empresa.setHolding(request.getParameter("holding"));
		empresa.setSituacion(request.getParameter("situacion"));
		empresa.setMultiRegion(request.getParameter("multiRegion"));
		empresa.setCasaMatriz(request.getParameter("casaMatriz"));
		empresa.setRegionCasaMatriz(request.getParameter("regionCasaMatriz"));
		empresa.setMasaSum(request.getParameter("masaSum"));
		empresa.setPlanesDeCuenta(request.getParameter("planesDeCuenta"));
		empresa.setPlanesDeTrabajo(request.getParameter("planesDeTrabajo"));
		empresa.setFirmaDePlanes(request.getParameter("firmaDePlanes"));
		empresa.setSistemaDeGestion(request.getParameter("sistemaDeGestion"));
		empresa.setConstitucionCphs(request.getParameter("constitucionCphs"));
		empresa.setCertificacionCphs(request.getParameter("certificacionCphs"));
		empresa.setMmc(request.getParameter("mmc"));
		empresa.setTmert(request.getParameter("tmert"));
		empresa.setPlanesi(request.getParameter("planesi"));
		empresa.setPlaguicida(request.getParameter("plaguicida"));
		empresa.setRadiacionUv(request.getParameter("radiacionUv"));
		empresa.setHipobaria(request.getParameter("hipobaria"));
		empresa.setPrexor(request.getParameter("prexor"));
		empresa.setPsicosociales(request.getParameter("psicosociales"));
		empresa.setProyectoInvestigacion(request.getParameter("proyectoInvestigacion"));
		empresa.setUltimaVisitaExperto(request.getParameter("ultimaVisitaExperto"));
		empresa.setUltimaVisitaDirector(request.getParameter("ultimaVisitaDirector"));
		empresa.setUltimaVisitaGtte(request.getParameter("ultimaVisitaGtte"));
		empresa.setUltimaVisitaAltaGerencia(request.getParameter("ultimaVisitaAltaGerencia"));
		empresa.setReporteVisita(request.getParameter("reporteVisita"));
		empresa.setRiesgoDeFuga(request.getParameter("riesgoDeFuga"));
		empresa.setReclamoUltimoPeriodo(request.getParameter("reclamoUltimoPeriodo"));
		empresa.setParticipaMesaTrabajo(request.getParameter("participaMesaTrabajo"));
		
		mapaEntrada.put("empresa", empresa);

		mapaSalida = ejbRemoto.modificarEmpresa(mapaEntrada);
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if (!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			pagDestino = "contenedor.jsp?accion=empresas";
		}
	}

	public void eliminarEmpresa(HttpServletRequest request,
			HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0]
				.getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		Long idEmpresa = Utils.stringToNum(request.getParameter("idEmpresa"));

		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("id empresas: " + idEmpresa);

		mapaEntrada.put("idEmpresa", idEmpresa);

		mapaSalida = ejbRemoto.eliminarEmpresa(mapaEntrada);
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if (!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			pagDestino = "/empresas/listaEmpresasXml.jsp";
		}
	}
	
	/**********REPORTES****************************************************************************/	
	public void reportes(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		pagDestino = "contenedor.jsp";
	}
	
	public void cargarReporte(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		Long idEmpresa = Utils.stringToNum(request.getParameter("idEmpresa"));
		String nombreEmpresa = request.getParameter("nombreEmpresa");
		
		log.info("Id Empresa :" + idEmpresa);
		log.info("Nombre Empresa :" + nombreEmpresa);
		
		mapaEntrada.put("idEmpresa", idEmpresa);
		mapaSalida = ejbRemoto.cargarReporte(mapaEntrada);
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if(!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			request.setAttribute("reporte", (Reporte) mapaSalida.get("reporte"));
			pagDestino = "/reportes/cargaReporte.jsp";
		}
	}
	
	public void agregarReporte(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaReportes", mapaSalida.get("listaReportes"));
		
		Reporte reporte = new Reporte();
		
		reporte.setIdEmpresa(Utils.stringToNum(request.getParameter("id_empresa")));
		reporte.setDiasAccidentabilidad(Utils.stringToNum(request.getParameter("accidentabilidad")));
		reporte.setDiasPerdidos(Utils.stringToNum(request.getParameter("diasPerdidos")));
		reporte.setIngresoDato(request.getParameter("fechaReporte"));
		
		log.info(request.getParameter("id_empresa"));
		
		mapaEntrada.put("reporte", reporte);
		mapaSalida = ejbRemoto.agregarReporte(mapaEntrada);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=reportes";
		}
	}
	
	public void crearReporte(HttpServletRequest request, HttpServletResponse response)
		{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarReporte(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaReportes", mapaSalida.get("listaReportes"));
			pagDestino = "reportes/agregaReporte.jsp";
		}
	}
	
	public void repAccidentados(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void repDias(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void graficar(HttpServletRequest request, HttpServletResponse response){
		File f = new File ("aqui.aqui");
		try {
			f.createNewFile();
			System.out.println("Se creo "+f.getAbsolutePath());
		} catch (IOException e) {
			System.out.println("no lo crea");
			pagDestino = "error.jsp";
			e.printStackTrace();
		}
		String pathIn = "graficar.xls";
		String [][] datosExcel = FileUtils.excelGraficoBarras(pathIn, 16, 2);
		String[] etiquetas = new String[16];
		String[] datos = new String[16];
		
		for(int i=0;i<16;i++){
			etiquetas[i] = datosExcel[i][0];
			datos[i] = datosExcel[i][1];
		}
		request.setAttribute("etiquetas", etiquetas);
		request.setAttribute("datos", datos);
		
		pagDestino = "contenedor.jsp";
	}
	
	/**********PRODUCTOS****************************************************************************/	
	public void productos(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void crearProducto(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "productos/agregaProducto.jsp";
	}
	
	public void buscarProductos(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Producto producto = new Producto();
		producto.setDesProducto(request.getParameter("nomProducto"));
		
		mapaEntrada.put("producto",producto);
		
		mapaSalida = ejbRemoto.buscarProductos(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
			pagDestino = "/productos/listaProductosXml.jsp";
		}
	}

	public void agregarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Producto producto = new Producto();
		producto.setDesProducto(request.getParameter("desProducto"));

		mapaEntrada.put("producto",producto);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarProducto(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=productos";
		}
	}
	
	public void cargarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idProducto = Long.parseLong(request.getParameter("idProducto"));
		log.info("parametro entrada servlet cargar producto"+request.getParameter("idProducto"));
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idProducto: "+idProducto);
		
		mapaEntrada.put("idProducto", idProducto);
		
		mapaSalida = ejbRemoto.cargarProducto(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("producto", (Producto)mapaSalida.get("producto"));
			pagDestino = "/productos/cargaProducto.jsp";
		}
	}
	
	public void cargarPrioridad(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idPrioridad = Utils.stringToNum(request.getParameter("idPrioridad"));
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		log.info("idPrioridad: "+idPrioridad);
		mapaEntrada.put("idPrioridad", idPrioridad);
		
		mapaSalida = ejbRemoto.cargarPrioridad(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("prioridad", (Prioridad)mapaSalida.get("prioridad"));
			pagDestino = "/prioridades/cargaPrioridad.jsp";
		}
	}
	
	public void modificarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Producto producto = new Producto();
		producto.setIdProducto(Long.parseLong(request.getParameter("idProducto")));
		producto.setDesProducto(request.getParameter("desProducto"));

		mapaEntrada.put("producto",producto);
		
		mapaSalida = ejbRemoto.modificarProducto(mapaEntrada);
		if(((Error)mapaSalida.get("error")).getNumError().equals("0")){
			
			pagDestino = "contenedor.jsp?accion=productos";
		}
		else{
			pagDestino = "error.jsp";
		}
	}
	
	public void eliminarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idProducto = Long.parseLong(request.getParameter("idProducto"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		log.info("idProducto: "+idProducto);
		
		mapaEntrada.put("idProducto", idProducto);
		mapaSalida = ejbRemoto.eliminarProducto(mapaEntrada);
		
		if(((Error)mapaSalida.get("error")).getNumError().equals("0")){
			
			pagDestino = "productos/listaProductosXml.jsp";
		}
		else{
			pagDestino = "error.jsp";
		}
	}
	
	/**********RECLAMOS****************************************************************************/	
	public void reclamos(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametrosReclamo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaTipos", mapaSalida.get("listaTipos"));
			request.setAttribute("listaEstados", mapaSalida.get("listaEstados"));
			request.setAttribute("listaPrioridades", mapaSalida.get("listaPrioridades"));
			request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));
			
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void links(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void crearReclamo(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametrosReclamo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaTipos", mapaSalida.get("listaTipos"));
			request.setAttribute("listaMotivos", mapaSalida.get("listaMotivos"));
			request.setAttribute("listaPrioridades", mapaSalida.get("listaPrioridades"));
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaEstados", mapaSalida.get("listaEstados"));
			request.setAttribute("listaMedios", mapaSalida.get("listaMedios"));
			request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));
			pagDestino = "reclamos/agregaReclamo.jsp";
		}
	}
	
	public void buscarReclamos(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		log.info("P�gina: " + request.getParameter("page"));
		log.info("Filas: " + request.getParameter("rows"));
	
		mapaSalida = ejbRemoto.buscarParametrosReclamo(mapaEntrada);
		request.setAttribute("listaTipos", mapaSalida.get("listaTipos"));
		request.setAttribute("listaMotivos", mapaSalida.get("listaMotivos"));
		request.setAttribute("listaPrioridades", mapaSalida.get("listaPrioridades"));
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaEstados", mapaSalida.get("listaEstados"));
		request.setAttribute("listaMedios", mapaSalida.get("listaMedios"));
		request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));
		
		Reclamo reclamo = new Reclamo();
		reclamo.setIdReclamo(Utils.stringToNum(request.getParameter("id_reclamo")));
		reclamo.setNombreSolicitante(request.getParameter("nombre_solicitante"));
		reclamo.setNumAdherente(request.getParameter("num_adherente"));
		reclamo.setIdCartera(Utils.stringToNum(request.getParameter("idCartera")));
		reclamo.setDiasBandeja(request.getParameter("diasBandeja"));
		reclamo.setIdTipo(Utils.stringToNum(request.getParameter("idTipo")));
		reclamo.setIdEstado(Utils.stringToNum(request.getParameter("idEstado")));
		reclamo.setIdPrioridad(Utils.stringToNum(request.getParameter("idPrioridad")));
					
		mapaEntrada.put("reclamo",reclamo);
		
		mapaSalida = ejbRemoto.buscarReclamos(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaReclamos", mapaSalida.get("listaReclamos"));
			pagDestino = "/reclamos/listaReclamosXml.jsp";
		}
	}

	public void agregarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		mapaSalida = ejbRemoto.buscarParametrosReclamo(mapaEntrada);
		
		request.setAttribute("listaTipos", mapaSalida.get("listaTipos"));
		request.setAttribute("listaMotivos", mapaSalida.get("listaMotivos"));
		request.setAttribute("listaPrioridades", mapaSalida.get("listaPrioridades"));
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaEstados", mapaSalida.get("listaEstados"));
		request.setAttribute("listaMedios", mapaSalida.get("listaMedios"));
		request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));
		
		Reclamo reclamo = new Reclamo();
		
		reclamo.setNumAdherente(request.getParameter("num_adherente"));
		reclamo.setNombreSolicitante(request.getParameter("nombre_solicitante") );
		reclamo.setEmailSolicitante(request.getParameter("email_solicitante") );
		reclamo.setFonoSolicitante(request.getParameter("fono_solicitante") );
		reclamo.setRegionSolicitante(request.getParameter("cod_region") );
		reclamo.setIdTipo(Utils.stringToNum(request.getParameter("id_tipo")));
		reclamo.setIdMotivo(Utils.stringToNum(request.getParameter("id_motivo")));
		reclamo.setIdPrioridad(Utils.stringToNum(request.getParameter("id_prioridad")));
		reclamo.setIdCartera(Utils.stringToNum(request.getParameter("id_cartera")));
		reclamo.setFecIngreso(request.getParameter("fec_ingreso"));
		reclamo.setGlosa(request.getParameter("glosa"));
		reclamo.setAdjunto(request.getParameter("adjunto"));
		reclamo.setObservaciones(request.getParameter("observaciones"));
		reclamo.setIdEstado(Utils.stringToNum(request.getParameter("id_estado")));
		reclamo.setResponsableIngreso(request.getParameter("responsable_ingreso"));
		reclamo.setResponsableActual(request.getParameter("responsable_actual"));
		reclamo.setDiasBandeja("");
		reclamo.setDiasSistema("");
		reclamo.setIdMedio(Utils.stringToNum(request.getParameter("id_medio_respuesta")));
		reclamo.setFecRespuesta(request.getParameter("fec_respuesta") );

		mapaEntrada.put("reclamo",reclamo);
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarReclamo(mapaEntrada);
		
		if(mapaSalida.get("reclamo")!=null){
			reclamo = (Reclamo)mapaSalida.get("reclamo");
			String to = ConfigUtils.loadProperties("reclamos_user");
			String subject = "Nuevo reclamo("+reclamo.getIdReclamo()+")";
			String body = reclamo.getEmailBody();
			String signature = "Firma de mutual..";
			EmailUtils.sendMail(to, subject, body, signature);
			to = reclamo.getEmailSolicitante();
			EmailUtils.sendMail(to, subject, body, signature);	
		}
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=reclamos";
		}
	}
	
	public void cargarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		mapaSalida = ejbRemoto.buscarParametrosReclamo(mapaEntrada);
		request.setAttribute("listaTipos", mapaSalida.get("listaTipos"));
		request.setAttribute("listaMotivos", mapaSalida.get("listaMotivos"));
		request.setAttribute("listaPrioridades", mapaSalida.get("listaPrioridades"));
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaEstados", mapaSalida.get("listaEstados"));
		request.setAttribute("listaMedios", mapaSalida.get("listaMedios"));
		request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));
		
		String idReclamo = request.getParameter("idReclamo");

		log.info("idReclamo: "+idReclamo);
		
		mapaEntrada.put("idReclamo", idReclamo);
		
		mapaSalida = ejbRemoto.cargarReclamo(mapaEntrada);
		request.setAttribute("reclamo", (Reclamo)mapaSalida.get("reclamo"));
		
		mapaSalida = ejbRemoto.buscarParametrosReclamo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaTipos", mapaSalida.get("listaTipos"));
			request.setAttribute("listaMotivos", mapaSalida.get("listaMotivos"));
			request.setAttribute("listaPrioridades", mapaSalida.get("listaPrioridades"));
			request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
			request.setAttribute("listaEstados", mapaSalida.get("listaEstados"));
			request.setAttribute("listaMedios", mapaSalida.get("listaMedios"));
			pagDestino = "/reclamos/cargaReclamo.jsp";
		}
	}
	
	public void modificarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		long idReclamo = Utils.stringToNum(request.getParameter("idReclamo"));
		
		Reclamo reclamo = new Reclamo();
		reclamo.setIdReclamo(idReclamo);
		reclamo.setNumAdherente(request.getParameter("num_adherente"));
		reclamo.setNombreSolicitante(request.getParameter("nombre_solicitante") );
		reclamo.setEmailSolicitante(request.getParameter("email_solicitante") );
		reclamo.setFonoSolicitante(request.getParameter("fono_solicitante") );
		reclamo.setRegionSolicitante(request.getParameter("cod_region") );
		reclamo.setIdTipo(Utils.stringToNum(request.getParameter("id_tipo")));
		reclamo.setIdMotivo(Utils.stringToNum(request.getParameter("id_motivo")));
		reclamo.setIdPrioridad(Utils.stringToNum(request.getParameter("id_prioridad")));
		reclamo.setIdCartera(Utils.stringToNum(request.getParameter("id_cartera")));
		reclamo.setFecIngreso(request.getParameter("fec_ingreso"));
		reclamo.setGlosa(request.getParameter("glosa"));
		reclamo.setAdjunto(request.getParameter("adjunto"));
		reclamo.setObservaciones(request.getParameter("observaciones"));
		reclamo.setIdEstado(Utils.stringToNum(request.getParameter("id_estado")));
		reclamo.setResponsableIngreso(request.getParameter("responsable_ingreso"));
		reclamo.setResponsableActual(request.getParameter("responsable_actual"));
		reclamo.setDiasBandeja("");
		reclamo.setDiasSistema("");
		reclamo.setIdMedio(Utils.stringToNum(request.getParameter("id_medio_respuesta")));
		reclamo.setFecRespuesta(request.getParameter("fec_respuesta") );
		mapaEntrada.put("reclamo",reclamo);		
		mapaSalida = ejbRemoto.modificarReclamo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp";
		}
	}
	
	public void eliminarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		long idReclamo = Utils.stringToNum(request.getParameter("idReclamo"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idReclamo: "+idReclamo);
		
		mapaEntrada.put("idReclamo", idReclamo);
		
		mapaSalida = ejbRemoto.eliminarReclamo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "/reclamos/listaReclamosXml.jsp";
		}
	}
	
	public void cargarArchivo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String path = "C:\\archivos";
		//path = request.getParameter("rescatar");
		System.out.println("xxxxxx");
		System.out.println(path);
		File archivo = new File(path);
		String[] ficheros = archivo.list();
		
		for(int i=0;i < ficheros.length;i++){
			System.out.println("+ F I L E S + : " + ficheros[i]);
		}
	
		mapaEntrada.put("path", archivo.getAbsolutePath());
		mapaEntrada.put("ficheros", ficheros);
		mapaSalida = ejbRemoto.subirArchivo(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp";
		}
	}
	
	
	/***************PRIORIDAD************************************************/
	public void prioridades(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void crearPrioridad(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
				
		pagDestino = "prioridades/agregaPrioridad.jsp";
	}
	
	public void agregarPrioridad(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Prioridad p = new Prioridad();
		p.setDesPrioridad(request.getParameter("desPrioridad"));

		mapaEntrada.put("prioridad",p);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarPrioridad(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=prioridades";
		}
	}
	
	public void buscarPrioridades(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Prioridad p = new Prioridad();
		p.setDesPrioridad(request.getParameter("nomPrioridad"));
		
		mapaEntrada.put("prioridad",p);
		
		mapaSalida = ejbRemoto.buscarPrioridades(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaPrioridades", mapaSalida.get("listaPrioridades"));
			pagDestino = "/prioridades/listaPrioridadesXml.jsp";
		}
	}
	
	
	public void tipos(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void motivos(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}

	public void medios(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void buscarTipos(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Tipo tipo = new Tipo();
		tipo.setDesTipo(request.getParameter("nomTipo"));
		
		log.info("[[ROW]]: " + request.getParameter("rowNum"));
		
		mapaEntrada.put("tipo",tipo);
		
		mapaSalida = ejbRemoto.buscarTipos(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaTipos", mapaSalida.get("listaTipos"));
			
			pagDestino = "/tipos/listaTiposXml.jsp";	
		}
	}
	
	public void buscarMotivos(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Motivo motivo = new Motivo();
		motivo.setDesMotivo(request.getParameter("nomMotivo"));
		
		mapaEntrada.put("motivo",motivo);
		
		mapaSalida = ejbRemoto.buscarMotivos(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaMotivos", mapaSalida.get("listaMotivos"));
			pagDestino = "/motivos/listaMotivosXml.jsp";
		}
	}
	
	public void buscarLinks(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametrosLink(mapaEntrada);
		request.setAttribute("listaCategoriasLink", mapaSalida.get("listaCategoriasLink"));
		
		Link link=new Link();
		link.setIdCategoriaLink(Utils.stringToNum(request.getParameter("id_categorialink")));

	
		mapaEntrada.put("link",link);		
		
	
		link.setDesLink(request.getParameter("nomLink"));
		//link.setIdCategoriaLink(Utils.stringToNum(request.getParameter("categoriaLink")));
		mapaEntrada.put("link",link);
		
		mapaSalida = ejbRemoto.buscarLinks(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaLinks", mapaSalida.get("listaLinks"));
			pagDestino = "/link/listaLinksXml.jsp";
		}
	}
	
	public void buscarMedios(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Medio medio = new Medio();
		medio.setDesMedio(request.getParameter("nomMedio"));
		
		mapaEntrada.put("medio",medio);
		
		mapaSalida = ejbRemoto.buscarMedios(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaMedios", mapaSalida.get("listaMedios"));
			pagDestino = "/medios/listaMediosXml.jsp";
		}
	}
	/**********************************Estados*******************************************/
	
	public void estados(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void crearEstado(HttpServletRequest request, HttpServletResponse response) {
			String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
			log.info("[Metodo: " + nombreMetodo + "] Iniciando");
			pagDestino = "estados/agregaEstado.jsp";
		}
	
	public void buscarEstados(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Estado estado = new Estado();
		estado.setDesEstado(request.getParameter("nomEstado"));
		
		mapaEntrada.put("estado",estado);
		
		mapaSalida = ejbRemoto.buscarEstados(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("listaEstados", mapaSalida.get("listaEstados"));
			pagDestino = "/estados/listaEstadosXml.jsp";
		}
	}

	public void agregarEstado(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		Estado estado = new Estado(); 
		estado.setDesEstado(request.getParameter("desEstado"));
		mapaEntrada.put("estado",estado);
		mapaSalida = ejbRemoto.agregarEstado(mapaEntrada);
		 
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "contenedor.jsp?accion=estados";
		}
	}
	
	public void cargarEstado(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idEstado = Utils.stringToNum(request.getParameter("idEstado"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idEstado: "+idEstado);
		
		mapaEntrada.put("idEstado", idEstado);
		
		mapaSalida = ejbRemoto.cargarEstado(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("estado", (Estado)mapaSalida.get("estado"));
			pagDestino = "/estados/cargaEstado.jsp";
		}
	}
	
	public void cargarLink(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idLink = Utils.stringToNum(request.getParameter("idLink"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idLink: "+ idLink);
		
		mapaEntrada.put("idLink", idLink);
		
		mapaSalida = ejbRemoto.cargarLink(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			
			request.setAttribute("link", (Link)mapaSalida.get("link"));
			
			mapaSalida = ejbRemoto.buscarParametrosLink(mapaEntrada);
			request.setAttribute("listaCategoriasLink",mapaSalida.get("listaCategoriasLink"));
			
			pagDestino = "/link/cargaLink.jsp";
		}
	}
	
	public void cargarPerfil(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idPerfil = Utils.stringToNum(request.getParameter("idPerfil"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("idPerfil: "+idPerfil);
		
		mapaEntrada.put("idPerfil", idPerfil);
		
		mapaSalida = ejbRemoto.cargarPerfil(mapaEntrada);
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			request.setAttribute("perfil", (Perfil)mapaSalida.get("perfil"));
			pagDestino = "/perfiles/cargaPerfil.jsp";
		}
	}
	
	public void modificarEstado(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Estado estado = new Estado();
		estado.setIdEstado(Utils.stringToNum(request.getParameter("idEstado")));
		estado.setDesEstado(request.getParameter("desEstado"));

		mapaEntrada.put("estado",estado);
		
		mapaSalida = ejbRemoto.modificarEstado(mapaEntrada);
		if(((Error)mapaSalida.get("error")).getNumError().equals("0")){
			
			pagDestino = "contenedor.jsp?accion=estados";
		}
		else{
			pagDestino = "error.jsp";
		}
	}
	
	public void modificarPerfil(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Perfil perfil = new Perfil();
		perfil.setIdPerfil(Utils.stringToNum(request.getParameter("idPerfil")));
		perfil.setDesPerfil(request.getParameter("desPerfil"));

		mapaEntrada.put("perfil",perfil);
		
		mapaSalida = ejbRemoto.modificarPerfil(mapaEntrada);
		if(((Error)mapaSalida.get("error")).getNumError().equals("0")){
			pagDestino = "contenedor.jsp?accion=perfiles";
		}
		else{
			pagDestino = "error.jsp";
		}
	}
	
	public void eliminarEstado(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Long idEstado = Utils.stringToNum(request.getParameter("idEstado"));
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		log.info("idEstado: "+idEstado);
		
		mapaEntrada.put("idEstado", idEstado);
		mapaSalida = ejbRemoto.eliminarEstado(mapaEntrada);
		
		error = (Error)mapaSalida.get("error");
		if(error == null) error = new Error();
		if(!error.getNumError().equals("0")){
			pagDestino = "error.jsp";
		}
		else{
			pagDestino = "estados/listaEstadosXml.jsp";
		}
	}
	
	public void ayuda(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		switch(Integer.parseInt(request.getParameter("v"))){
			case 1:
				request.setAttribute("video", "documento");
				break;
			case 2:
				request.setAttribute("video", "empresa");
				break;
			case 3:
				request.setAttribute("video", "reclamo");
				break;
			case 4:
				request.setAttribute("video", "usuario");
				break;
			case 5:
				request.setAttribute("video", "administracion");
				break;
		}
		pagDestino = "contenedor.jsp";
	}
	
	public void manual(HttpServletRequest request, HttpServletResponse response){
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		pagDestino = "contenedor.jsp";
	}
	
	public void buscarReportes(HttpServletRequest request, HttpServletResponse response){
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();

		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Reporte reporte = new Reporte();
		reporte.setNombreEmpresa(request.getParameter("nombreEmpresa"));
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		request.setAttribute("listaReportes", mapaSalida.get("listaReportes"));
		
		mapaEntrada.put("reporte", reporte);
		mapaSalida = ejbRemoto.buscarReportes(mapaEntrada);
		
		error = (Error) mapaSalida.get("error");
		if (error == null)
			error = new Error();
		if (!error.getNumError().equals("0")) {
			pagDestino = "error.jsp";
		} else {
			request.setAttribute("listaReportes",mapaSalida.get("listaReportes"));
			pagDestino = "/reportes/listaReportesXml.jsp";
		}
	}
}