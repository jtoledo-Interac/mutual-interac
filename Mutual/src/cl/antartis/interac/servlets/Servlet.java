
package cl.antartis.interac.servlets;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

import cl.antartis.interac.beans.Cartera;
import cl.antartis.interac.beans.Documento;
import cl.antartis.interac.beans.Empresa;
import cl.antartis.interac.beans.Producto;
import cl.antartis.interac.beans.Reclamo;
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
	//private Perfil perfiles = null; //TODO
	
	@EJB(mappedName = "mutual/EJB")
	private EJBRemoto ejbRemoto;

	public Servlet() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			log.info("Service controller");
			String accion = request.getParameter("accion");
			log.info("Accion service: "+accion);
			MethodUtils.invokeMethod(this, accion, new Object[]{request,response});

			//TODO: controlar sesion y error cuando servlet no llama ejb
			//request.setAttribute("sesion", sesion);
			request.setAttribute("error", error);
			//request.setAttribute("perfiles", perfiles);
			
			//if(!error.getNumError().equals("0")){
				//pagDestino = "error.jsp";
			//}
			
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
	public void login(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Encriptador encriptador = new Encriptador();
		
		Usuario usuario = new Usuario();
		usuario.setsNomUsuario(request.getParameter("sNomUsuario"));
		usuario.setsContrasena(encriptador.encriptar(request.getParameter("sContrasena")));
		usuario.setsHost(request.getRemoteAddr());
		
		System.out.println("["+usuario.getsNomUsuario()+" - "+usuario.getsContrasena()+"]");
		
		log.info("Usuario: "+usuario.getUsuario());
		
		mapaEntrada.put("usuario", usuario);
		mapaSalida = ejbRemoto.logIn(mapaEntrada);
		
		/*
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
		*/
		//TODO: buscar lista perfiles disponibles y devolverla
		
		error = (Error)mapaSalida.get("error");
		
		log.info("Num Error: "+error.getNumError());
		log.info("Msj Error: "+error.getMsjError());

		if(error.getNumError().equals("0")){
			int sessionTime = Integer.parseInt(ConfigUtils.loadProperties("timeSession"));
			System.out.println("sessionTime: "+sessionTime+"[seg]");
			
			//setting session to expiry in 30 mins.
			HttpSession session = request.getSession();
			session.setAttribute("user", request.getParameter("sNomUsuario"));
			session.setMaxInactiveInterval(sessionTime);
			
			//setting cookie to expiry in 30 mins.
			Cookie userName = new Cookie("user", request.getParameter("sNomUsuario"));
			userName.setMaxAge(sessionTime);
			response.addCookie(userName);
			
			pagDestino = "contenedor.jsp";
		}
		else{
			System.out.println("Debería mandar a login.");
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
		usuario.setsRut(Utils.getRutSinDV(request.getParameter("sRut")));
		usuario.setsDV(request.getParameter("sDV"));
		usuario.setsNombres(request.getParameter("sNombres"));
		usuario.setsApePaterno(request.getParameter("sApePaterno"));
		usuario.setsApeMaterno(request.getParameter("sApeMaterno"));
		usuario.setsNomUsuario(request.getParameter("sNomUsuario"));
		
		mapaEntrada.put("usuario",usuario);
		
		mapaSalida = ejbRemoto.buscarUsuarios(mapaEntrada);
		
		request.setAttribute("listaUsuarios", mapaSalida.get("listaUsuarios"));
		
		pagDestino = "/usuarios/listaUsuariosXml.jsp";	
	}

	public void agregarUsuario(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("Comuna: "+request.getParameter("nIdComuna"));
		
		Usuario usuario = new Usuario();
		usuario.setsRut(Utils.getRutSinDV(request.getParameter("sRut")));
		usuario.setsDV(request.getParameter("sDV"));
		usuario.setsNombres(request.getParameter("sNombres"));
		usuario.setsApePaterno(request.getParameter("sApePaterno"));
		usuario.setsApeMaterno(request.getParameter("sApeMaterno"));
		usuario.setsNomUsuario(request.getParameter("sNomUsuario"));
		usuario.setsContrasena(request.getParameter("sContrasena"));
		usuario.setsCodGenero(request.getParameter("sCodGenero"));
		usuario.setsFecNacimiento(request.getParameter("sFecNacimiento"));
		usuario.setsTelefono(request.getParameter("sTelefono"));
		usuario.setsCelular(request.getParameter("sCelular"));
		usuario.setsEmail(request.getParameter("sEmail"));
		
		mapaEntrada.put("usuario",usuario);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarUsuario(mapaEntrada);
		
		log.info("ID Usuario: "+mapaSalida.get("nIdUsuario"));

		pagDestino = "/usuarios/listaUsuarios.jsp";
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
		
		request.setAttribute("usuario", (Usuario)mapaSalida.get("usuario"));
		request.setAttribute("listaComunas", mapaSalida.get("listaComunas"));
		request.setAttribute("listaProvincias", mapaSalida.get("listaProvincias"));
		request.setAttribute("listaRegiones", mapaSalida.get("listaRegiones"));

		pagDestino = "/usuarios/cargaUsuario.jsp";
	}
	
	public void modificarUsuario(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Usuario usuario = new Usuario();
		usuario.setnIdUsuario(Utils.stringToNum(request.getParameter("nIdUsuario")));
		usuario.setsRut(Utils.getRutSinDV(request.getParameter("sRut")));
		usuario.setsDV(request.getParameter("sDV"));
	
		log.info("rut: "+usuario.getsRut());
		log.info("DV: "+usuario.getsDV());
		usuario.setsNombres(request.getParameter("sNombres"));
		usuario.setsApePaterno(request.getParameter("sApePaterno"));
		usuario.setsApeMaterno(request.getParameter("sApeMaterno"));
		usuario.setsNomUsuario(request.getParameter("sNomUsuario"));
		usuario.setsContrasena(request.getParameter("sContrasena"));
		usuario.setsCodGenero(request.getParameter("sCodGenero"));
		usuario.setsFecNacimiento(request.getParameter("sFecNacimiento"));
		usuario.setsTelefono(request.getParameter("sTelefono"));
		usuario.setsCelular(request.getParameter("sCelular"));
		usuario.setsEmail(request.getParameter("sEmail"));
		log.info("aca");
		log.info(usuario.getUsuario());
		
		mapaEntrada.put("usuario",usuario);
		
		mapaSalida = ejbRemoto.modificarUsuario(mapaEntrada);

		pagDestino = "/usuarios/listaUsuarios.jsp";
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
		
		request.setAttribute("usuario", (Usuario)mapaSalida.get("usuario"));

		pagDestino = "/usuarios/listaUsuariosXml.jsp";
	}
	
	
	/**********CARTERAS****************************************************************************/	
	public void carteras(HttpServletRequest request, HttpServletResponse response) 
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
	
	public void buscarCarteras(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Cartera cartera = new Cartera();
		cartera.setDesCartera(request.getParameter("nomCartera"));
		
		mapaEntrada.put("cartera",cartera);
		
		mapaSalida = ejbRemoto.buscarCarteras(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		
		pagDestino = "/carteras/listaCarterasXml.jsp";	
	}

	public void agregarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("Comuna: "+request.getParameter("nIdComuna"));
		
		Cartera cartera = new Cartera();
		cartera.setDesCartera(request.getParameter("nomCartera"));

		mapaEntrada.put("cartera",cartera);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarCartera(mapaEntrada);
		
		log.info("ID Cartera: "+mapaSalida.get("codCartera"));

		pagDestino = "/carteras/listaCarteras.jsp";
	}
	
	public void cargarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String codCartera = request.getParameter("codCartera");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("codCartera: "+codCartera);
		
		mapaEntrada.put("codCartera", codCartera);
		
		mapaSalida = ejbRemoto.cargarCartera(mapaEntrada);
		
		request.setAttribute("cartera", (Cartera)mapaSalida.get("cartera"));

		pagDestino = "/carteras/cargaCartera.jsp";
	}
	
	public void modificarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Cartera cartera = new Cartera();
		cartera.setCodCartera(request.getParameter("codCartera"));
		cartera.setDesCartera(request.getParameter("desCartera"));

		mapaEntrada.put("cartera",cartera);
		
		mapaSalida = ejbRemoto.modificarCartera(mapaEntrada);

		pagDestino = "/carteras/listaCarteras.jsp";
	}
	
	public void eliminarCartera(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String codCartera = request.getParameter("codCartera");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("codCartera: "+codCartera);
		
		mapaEntrada.put("codCartera", codCartera);
		
		mapaSalida = ejbRemoto.eliminarCartera(mapaEntrada);
		
		request.setAttribute("cartera", (Usuario)mapaSalida.get("cartera"));

		pagDestino = "/carteras/listaCarterasXml.jsp";
	}
	
	
	/**********DOCUMENTOS****************************************************************************/	
	public void documentos(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));

		pagDestino = "contenedor.jsp";
	}
	
	public void crearDocumento(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
		
		pagDestino = "documentos/agregaDocumento.jsp";
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
		documento.setCodCartera(request.getParameter("codCartera"));
		documento.setCodProducto(request.getParameter("codProducto"));
		documento.setCodArea(request.getParameter("codArea"));
		
		mapaEntrada.put("documento", documento);
		
		mapaSalida = ejbRemoto.buscarDocumentos(mapaEntrada);
		
		request.setAttribute("listaDocumentos", mapaSalida.get("listaDocumentos"));
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
		
		pagDestino = "/documentos/listaDocumentosXml.jsp";	
	}

	public void agregarDocumento(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Documento documento = new Documento();
		documento.setNombre(request.getParameter("nombre"));
		documento.setNumFolio(request.getParameter("numFolio"));
		documento.setNumAdherente(request.getParameter("numAdherente"));
		documento.setDescripcion(request.getParameter("descripcion"));
		documento.setCodArea(request.getParameter("codArea"));
		documento.setCodCartera(request.getParameter("codCartera"));
		documento.setCodProducto(request.getParameter("codProducto"));

		mapaEntrada.put("documento",documento);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarDocumento(mapaEntrada);
		
		log.info("ID Documento: "+mapaSalida.get("idDocumento"));
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));

		pagDestino = "contenedor.jsp";
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
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));

		pagDestino = "/documentos/cargaDocumento.jsp";
	}
	
	public void modificarDocumento(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Documento documento = new Documento();
		/*documento.setIdDocumento(Utils.stringToNum(request.getParameter("nIdUsuario"));
		
		usuario.setnIdUsuario(Utils.stringToNum(request.getParameter("nIdUsuario")));
		usuario.setsRut(Utils.getRutSinDV(request.getParameter("sRut")));
		usuario.setsDV(request.getParameter("sDV"));
	*/
		
		mapaEntrada.put("documento",documento);
		
		mapaSalida = ejbRemoto.modificarDocumento(mapaEntrada);

		pagDestino = "contenedor.jsp";
	}
	
	public void eliminarDocumento(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String codProducto = request.getParameter("codProducto");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("codProducto: "+codProducto);
		
		mapaEntrada.put("codProducto", codProducto);
		
		mapaSalida = ejbRemoto.eliminarProducto(mapaEntrada);
		
		request.setAttribute("producto", (Producto)mapaSalida.get("producto"));

		pagDestino = "/documentos/listaDocumentosXml.jsp";
	}
	
	/**********EMPRESAS****************************************************************************/	
	public void empresas(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void crearEmpresa(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.buscarParametros(mapaEntrada);
		
		request.setAttribute("listaCarteras", mapaSalida.get("listaCarteras"));
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		request.setAttribute("listaAreas", mapaSalida.get("listaAreas"));
	
		pagDestino = "empresas/agregaEmpresa.jsp";
	}
	
	public void buscarEmpresas(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		mapaSalida = ejbRemoto.buscarEmpresas(mapaEntrada);
		log.info("N¼ Empresas: "+((ArrayList<Empresa>)mapaSalida.get("listaEmpresas")).size());
		
		request.setAttribute("listaEmpresas", mapaSalida.get("listaEmpresas"));
		
		pagDestino = "/empresas/listaEmpresasXml.jsp";	
	}

	public void agregarEmpresa(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Empresa empresa = new Empresa();
		
		empresa.setNombre("nombreExp");
		empresa.setNumAdherente("numAdherente");

		mapaEntrada.put("empresa",empresa);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarEmpresa(mapaEntrada);
		
		log.info("Cod Producto: "+mapaSalida.get("codProducto"));

		pagDestino = "/empresas/listaEmpresas.jsp";
	}
	
	public void cargarEmpresa(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String numAd = request.getParameter("numAd");
		
		mapaEntrada.put("numAd", numAd);
		
		mapaSalida = ejbRemoto.cargarEmpresa(mapaEntrada);
		
		request.setAttribute("empresa", (Empresa)mapaSalida.get("empresa"));

		pagDestino = "/empresas/cargaEmpresa.jsp";
	}
	
	public void modificarEmpresa(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Empresa empresa = new Empresa();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		empresa.setNombre(request.getParameter("nombre"));
		empresa.setNumAdherente(request.getParameter("numAd"));

		mapaEntrada.put("empresa",empresa);
		
		mapaSalida = ejbRemoto.modificarEmpresa(mapaEntrada);

		pagDestino = "/empresas/listaEmpresas.jsp";
	} 
	
	public void eliminarEmpresa(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String numAd = request.getParameter("numAd");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("Número de adherente: " + numAd);
		
		mapaEntrada.put("numAd", numAd);
		
		mapaSalida = ejbRemoto.eliminarEmpresa(mapaEntrada);
		
		pagDestino = "/empresas/listaEmpresasXml.jsp";
	}
	
	/**********REPORTES****************************************************************************/	
	public void reportes(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
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
		
		request.setAttribute("listaProductos", mapaSalida.get("listaProductos"));
		
		pagDestino = "/productos/listaProductosXml.jsp";	
	}

	public void agregarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Producto producto = new Producto();
		producto.setDesProducto(request.getParameter("nomProducto"));

		mapaEntrada.put("producto",producto);
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarCartera(mapaEntrada);
		
		log.info("Cod Producto: "+mapaSalida.get("codProducto"));

		pagDestino = "/productos/listaProductos.jsp";
	}
	
	public void cargarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String codProducto = request.getParameter("codProducto");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("codProducto: "+codProducto);
		
		mapaEntrada.put("codProducto", codProducto);
		
		mapaSalida = ejbRemoto.cargarProducto(mapaEntrada);
		
		request.setAttribute("producto", (Cartera)mapaSalida.get("producto"));

		pagDestino = "/productos/cargaProducto.jsp";
	}
	
	public void modificarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Producto producto = new Producto();
		producto.setCodProducto(request.getParameter("codProducto"));
		producto.setDesProducto(request.getParameter("desProducto"));

		mapaEntrada.put("producto",producto);
		
		mapaSalida = ejbRemoto.modificarProducto(mapaEntrada);

		pagDestino = "/productos/listaProductos.jsp";
	}
	
	public void eliminarProducto(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String codProducto = request.getParameter("codProducto");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("codProducto: "+codProducto);
		
		mapaEntrada.put("codProducto", codProducto);
		
		mapaSalida = ejbRemoto.eliminarProducto(mapaEntrada);
		
		request.setAttribute("producto", (Producto)mapaSalida.get("producto"));

		pagDestino = "/productos/listaProductosXml.jsp";
	}
	
	/**********RECLAMOS****************************************************************************/	
	public void reclamos(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		pagDestino = "contenedor.jsp";
	}
	
	public void crearReclamo(HttpServletRequest request, HttpServletResponse response) 
	{
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
	
		pagDestino = "reclamos/agregaReclamo.jsp";
	}
	
	public void buscarReclamos(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();

		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
	
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Reclamo reclamo = new Reclamo();
		//reclamo.setDesReclamo(request.getParameter("nomReclamo"));
		
		mapaEntrada.put("reclamo",reclamo);
		
		mapaSalida = ejbRemoto.buscarReclamos(mapaEntrada);
		
		request.setAttribute("listaReclamos", mapaSalida.get("listaReclamos"));
		
		pagDestino = "/reclamos/listaReclamosXml.jsp";		
	}

	public void agregarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		Reclamo reclamo = new Reclamo();
		
		reclamo.setNumAdherente(request.getParameter("num_adherente"));
		reclamo.setNombreSolicitante(request.getParameter("nombre_solicitante") );
		reclamo.setEmailSolicitante(request.getParameter("email_solicitante") );
		reclamo.setFonoSolicitante(request.getParameter("fono_solicitante") );
		reclamo.setRegionSolicitante(request.getParameter("region_solicitante") );
		reclamo.setCodTipo(request.getParameter("cod_tipo"));
		reclamo.setCodMotivo(request.getParameter("cod_motivo"));
		reclamo.setCodPrioridad(request.getParameter("cod_prioridad"));
		reclamo.setCodCartera(request.getParameter("cod_cartera"));
		reclamo.setFecIngreso(request.getParameter("fec_ingreso"));
		reclamo.setGlosa(request.getParameter("glosa"));
		reclamo.setAdjunto(request.getParameter("adjunto"));
		reclamo.setObservaciones(request.getParameter("observaciones"));
		reclamo.setCodEstado(request.getParameter("cod_estado"));
		reclamo.setResponsableIngreso(request.getParameter("responsable_ingreso"));
		reclamo.setResponsableActual(request.getParameter("responsable_actual"));
		reclamo.setDiasBandeja("");
		reclamo.setDiasSistema("");
		reclamo.setCodMedioRespuesta(request.getParameter("cod_medio_respuesta"));
		reclamo.setFecRespuesta(request.getParameter("fec_respuesta") );

		mapaEntrada.put("reclamo",reclamo);
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		mapaSalida = ejbRemoto.agregarReclamo(mapaEntrada);
		
		if(mapaSalida!=null){
			reclamo = (Reclamo)mapaSalida.get("reclamo");
			
			//send emails
			//encargado reclamos
			String to = ConfigUtils.loadProperties("reclamos_user");
			String subject = "Nuevo reclamo("+reclamo.getIdReclamo()+")";
			String body = reclamo.getEmailBody();
			String signature = "Firma de mutual..";
			EmailUtils.sendMail(to, subject, body, signature);
			to = reclamo.getEmailSolicitante();
			EmailUtils.sendMail(to, subject, body, signature);
			pagDestino = "contenedor.jsp";
		}
		else pagDestino = "error.jsp";
	}
	
	public void cargarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String codReclamo = request.getParameter("codReclamo");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("codReclamo: "+codReclamo);
		
		mapaEntrada.put("codReclamo", codReclamo);
		
		mapaSalida = ejbRemoto.cargarReclamo(mapaEntrada);
		
		request.setAttribute("reclamo", (Cartera)mapaSalida.get("reclamo"));

		pagDestino = "/reclamos/cargaReclamo.jsp";
	}
	
	public void modificarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();
		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");
		
		Reclamo reclamo = new Reclamo();
		reclamo.setIdReclamo(Long.parseLong(request.getParameter("idReclamo")));
		//reclamo.setDesReclamo(request.getParameter("desReclamo"));

		mapaEntrada.put("reclamo",reclamo);
		
		mapaSalida = ejbRemoto.modificarReclamo(mapaEntrada);

		pagDestino = "contenedor.jsp";
	}
	
	public void eliminarReclamo(HttpServletRequest request, HttpServletResponse response) {
		String nombreMetodo = new Exception().getStackTrace()[0].getMethodName();		
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		String codReclamo = request.getParameter("idReclamo");
		
		log.info("[Metodo: " + nombreMetodo + "] Iniciando");

		log.info("codReclamo: "+codReclamo);
		
		mapaEntrada.put("codReclamo", codReclamo);
		
		mapaSalida = ejbRemoto.eliminarReclamo(mapaEntrada);

		pagDestino = "/reclamos/listaReclamos.jsp";
	}
	
	public void cargarArchivo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> mapaEntrada = new HashMap<String, Object>();
		Map<String, Object> mapaSalida = new HashMap<String, Object>();
		
		
		
		String path = "";
		path = request.getParameter("rescatar");
		System.out.println("xxxxxx");
		System.out.println(path);
		File archivo = new File(path);
	
		mapaEntrada.put("path", archivo.getAbsolutePath());
		mapaEntrada.put("nombre", archivo.getName());
		
		mapaSalida = ejbRemoto.subirArchivo(mapaEntrada);
		
		pagDestino = "contenedor.jsp";
	}
}