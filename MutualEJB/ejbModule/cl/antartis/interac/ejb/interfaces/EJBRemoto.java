package cl.antartis.interac.ejb.interfaces;

import java.util.Map;

import javax.ejb.Remote;

@Remote
public interface EJBRemoto {
	public Map<String, Object> logIn(Map<String, Object> mapaEntrada);

	public Map<String, Object> buscarPerfiles(Map<String, Object> mapaEntrada);

	public Map<String, Object> validarSesion(Map<String, Object> mapaEntrada);

	public Map<String, Object> logOut(Map<String, Object> mapaEntrada);
	
	public Map<String, Object> buscarUsuarios(Map<String, Object> mapaEntrada);
	
	public Map<String, Object> agregarUsuario(Map<String, Object> mapaEntrada);

	public Map<String, Object> cargarUsuario(Map<String, Object> mapaEntrada);

	public Map<String, Object> modificarUsuario(Map<String, Object> mapaEntrada);

	public Map<String, Object> eliminarUsuario(Map<String, Object> mapaEntrada);

	public Map<String, Object> buscarCarteras(Map<String, Object> mapaEntrada);

	public Map<String, Object> agregarCartera(Map<String, Object> mapaEntrada);

	public Map<String, Object> cargarCartera(Map<String, Object> mapaEntrada);

	public Map<String, Object> modificarCartera(Map<String, Object> mapaEntrada);

	public Map<String, Object> eliminarCartera(Map<String, Object> mapaEntrada);

	public Map<String, Object> buscarProductos(Map<String, Object> mapaEntrada);

	public Map<String, Object> agregarProducto(Map<String, Object> mapaEntrada);

	public Map<String, Object> cargarProducto(Map<String, Object> mapaEntrada);

	public Map<String, Object> modificarProducto(Map<String, Object> mapaEntrada);

	public Map<String, Object> eliminarProducto(Map<String, Object> mapaEntrada);
	
	public Map<String, Object> buscarReclamos(Map<String, Object> mapaEntrada);

	public Map<String, Object> agregarReclamo(Map<String, Object> mapaEntrada);

	public Map<String, Object> cargarReclamo(Map<String, Object> mapaEntrada);

	public Map<String, Object> modificarReclamo(Map<String, Object> mapaEntrada);

	public Map<String, Object> eliminarReclamo(Map<String, Object> mapaEntrada);
	
	public Map<String, Object> buscarDocumentos(Map<String, Object> mapaEntrada);

	public Map<String, Object> agregarDocumento(Map<String, Object> mapaEntrada);

	public Map<String, Object> cargarDocumento(Map<String, Object> mapaEntrada);

	public Map<String, Object> modificarDocumento(Map<String, Object> mapaEntrada);

	public Map<String, Object> eliminarDocumento(Map<String, Object> mapaEntrada);

	public Map<String, Object> buscarParametros(Map<String, Object> mapaEntrada);

	public Map<String, Object> buscarParametrosReclamo(Map<String, Object> mapaEntrada);

	public Map<String, Object> agregarEmpresa(Map<String, Object> mapaEntrada);

	public Map<String, Object> cargarEmpresa(Map<String, Object> mapaEntrada);

	public Map<String, Object> buscarEmpresas(Map<String, Object> mapaEntrada);

	public Map<String, Object> eliminarEmpresa(Map<String, Object> mapaEntrada);

	public Map<String, Object> modificarEmpresa(Map<String, Object> mapaEntrada);
	
	public Map<String, Object> subirArchivo(Map<String, Object> mapaEntrada);

}