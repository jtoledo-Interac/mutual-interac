package cl.antartis.interac.ejb;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import cl.antartis.interac.beans.Area;
import cl.antartis.interac.beans.Cartera;
import cl.antartis.interac.beans.Constantes;
import cl.antartis.interac.beans.Documento;
import cl.antartis.interac.beans.Empresa;
import cl.antartis.interac.beans.Producto;
import cl.antartis.interac.beans.Reclamo;
import cl.antartis.interac.beans.Usuario;
import cl.antartis.interac.beans.Sesion;
import cl.antartis.interac.beans.Error;
import cl.antartis.interac.ejb.interfaces.EJBRemoto;
import cl.antartis.interac.funciones.Utils;

@Stateless(mappedName = "mutual/EJB")
public class MutualEJB implements EJBRemoto {

	private Logger log = Logger.getLogger(MutualEJB.class);

	@Resource(mappedName = "java:/MutualPro")
	private DataSource interacDS;
	private Connection dbConeccion;

	public MutualEJB() {
		super();
	}
	
	/**********USUARIOS****************************************************************************/
	public Map<String, Object> buscarUsuarios(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Usuario> listaUsuarios = null;
		Usuario usuario = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Usuarios");
			
			usuario = (Usuario)mapaEntrada.get("usuario");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_usuarios(?,?,?,?,?,?,?,?,?) }");
			
			cStmt.setString(1, usuario.getsRut());
			cStmt.setString(2, usuario.getsDV());
			cStmt.setString(3, usuario.getsNombres());
			cStmt.setString(4, usuario.getsApePaterno());
			cStmt.setString(5, usuario.getsApeMaterno());
			cStmt.setString(6, usuario.getsNomUsuario());
			cStmt.registerOutParameter(7, Types.OTHER);// cursor$
			cStmt.registerOutParameter(8, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(9, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(7);
			numError = cStmt.getString(8);
			msjError = cStmt.getString(9);
		
			listaUsuarios = new ArrayList<Usuario>();

			if(rs !=null){
				while (rs.next()) {
					usuario = new Usuario();
					usuario.setnIdUsuario(rs.getLong("idusuario"));
					usuario.setsRut(rs.getString("rut"));
					usuario.setsDV(rs.getString("dv"));
					usuario.setsRutFormat(Utils.getRutFormat(usuario.getsRut()+usuario.getsDV()));
					usuario.setsNombres(rs.getString("nombres"));
					usuario.setsApePaterno(rs.getString("apepaterno"));
					usuario.setsApeMaterno(rs.getString("apematerno"));
					usuario.setsNomUsuario(rs.getString("nomusuario"));
					usuario.setsContrasena(rs.getString("contrasena"));
					usuario.setsCodGenero(rs.getString("codgenero"));
					usuario.setsFecNacimiento(Utils.formateaFecha(rs.getString("fecnacimiento")));
					usuario.setsTelefono(rs.getString("telefono"));
					usuario.setsCelular(rs.getString("celular"));
					usuario.setsEmail(rs.getString("email"));
					usuario.setnCantIntentos(rs.getInt("cantintentos"));
					usuario.setsFecCreacion(Utils.formateaFecha(rs.getString("feccreacion")));
					usuario.setsFecContrasena(Utils.formateaFecha(rs.getString("feccontrasena")));
					usuario.setsIndVigencia(rs.getString("indvigencia"));
					listaUsuarios.add(usuario);
				}
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+numError);
		log.info("Msj Error: "+msjError);
		
		mapaSalida.put("listaUsuarios",listaUsuarios);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}
	
	public Map<String, Object> agregarUsuario(Map<String, Object> mapaEntrada){
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Usuario usuario = null;
		String numError = "0";
		String msjError = "";
		long idUsuario = 0;
		
		try {
			log.info("Agregar usuario");

			usuario = (Usuario)mapaEntrada.get("usuario");
			
			log.info(usuario.getUsuario());
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_usuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
			cStmt.setString(1, usuario.getsRut());
			cStmt.setString(2, usuario.getsDV());
			cStmt.setString(3, usuario.getsNombres());
			cStmt.setString(4, usuario.getsApePaterno());
			cStmt.setString(5, usuario.getsApeMaterno());
			cStmt.setString(6, usuario.getsNomUsuario());
			cStmt.setString(7, usuario.getsContrasena());
			cStmt.setString(8, usuario.getsCodGenero());
			cStmt.setDate(9, Utils.stringToDate(usuario.getsFecNacimiento()));
			cStmt.setString(10, usuario.getsTelefono());
			cStmt.setString(11, usuario.getsCelular());
			cStmt.setString(12, usuario.getsEmail());
			cStmt.registerOutParameter(13, Types.BIGINT);// nidusuario$
			cStmt.registerOutParameter(14, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(15, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			idUsuario = cStmt.getLong(13);
			numError = cStmt.getString(14);
			msjError = cStmt.getString(15);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		
		mapaSalida.put("idUsuario", idUsuario);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}
	
	public Map<String, Object> modificarUsuario(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Usuario usuario = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Modificar usuario");

			usuario = (Usuario)mapaEntrada.get("usuario");
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_usuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
			cStmt.setLong(1, usuario.getnIdUsuario());
			cStmt.setString(2, usuario.getsRut());
			cStmt.setString(3, usuario.getsDV());
			cStmt.setString(4, usuario.getsNombres());
			cStmt.setString(5, usuario.getsApePaterno());
			cStmt.setString(6, usuario.getsApeMaterno());
			cStmt.setString(7, usuario.getsNomUsuario());
			cStmt.setString(8, usuario.getsContrasena());
			cStmt.setString(9, usuario.getsCodGenero());
			cStmt.setDate(10, Utils.stringToDate(usuario.getsFecNacimiento()));
			cStmt.setString(11, usuario.getsTelefono());
			cStmt.setString(12, usuario.getsCelular());
			cStmt.setString(13, usuario.getsEmail());
			cStmt.registerOutParameter(14, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(15, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			numError = cStmt.getString(14);
			msjError = cStmt.getString(15);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}
	
	public Map<String, Object> cargarUsuario(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		long idUsuario = 0;
		Usuario usuario = null;
		
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Cargar usuario");

			idUsuario = (Long)mapaEntrada.get("idUsuario");
			
			log.info("ID usuario: "+idUsuario);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call cargar_usuario(?,?,?,?) }");
			cStmt.setLong(1, idUsuario);
			cStmt.registerOutParameter(2, Types.OTHER);// usuarios$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			ResultSet rsUsuarios = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
			
			while (rsUsuarios.next()) {
				usuario = new Usuario();
				usuario.setnIdUsuario(rsUsuarios.getLong("idusuario"));
				usuario.setsRut(rsUsuarios.getString("rut"));
				usuario.setsDV(rsUsuarios.getString("dv"));
				usuario.setsRutFormat(Utils.getRutFormat(usuario.getsRut()+usuario.getsDV()));
				usuario.setsNombres(rsUsuarios.getString("nombres"));
				usuario.setsApePaterno(rsUsuarios.getString("apepaterno"));
				usuario.setsApeMaterno(rsUsuarios.getString("apematerno"));
				usuario.setsNomUsuario(rsUsuarios.getString("nomusuario"));
				usuario.setsContrasena(rsUsuarios.getString("contrasena"));
				usuario.setsCodGenero(rsUsuarios.getString("codgenero"));
				usuario.setsFecNacimiento(Utils.formateaFecha(rsUsuarios.getString("fecnacimiento")));
				usuario.setsTelefono(rsUsuarios.getString("telefono"));
				usuario.setsCelular(rsUsuarios.getString("celular"));
				usuario.setsEmail(rsUsuarios.getString("email"));
				usuario.setnCantIntentos(rsUsuarios.getInt("cantintentos"));
				usuario.setsFecCreacion(Utils.formateaFecha(rsUsuarios.getString("feccreacion")));
				usuario.setsFecContrasena(Utils.formateaFecha(rsUsuarios.getString("feccontrasena")));
				usuario.setsIndVigencia(rsUsuarios.getString("indvigencia"));
			}
			
			rsUsuarios.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info(usuario.getUsuario());
		mapaSalida.put("usuario",usuario);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}
	
	public Map<String, Object> eliminarUsuario(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		long idUsuario = 0;
		
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Eliminar usuario");

			idUsuario = (Long)mapaEntrada.get("idUsuario");
			
			log.info("ID usuario: "+idUsuario);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_usuario(?,?,?) }");
			cStmt.setLong(1, idUsuario);
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			cStmt.execute();
			numError = cStmt.getString(2);
			msjError = cStmt.getString(3);			
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}
	
	public Map<String, Object> buscarCarteras(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Cartera> listaCarteras = null;
		Cartera cartera = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Carteras");
			
			cartera = (Cartera)mapaEntrada.get("cartera");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_carteras(?,?,?) }");
			
			cStmt.registerOutParameter(1, Types.OTHER);// cursor$
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(1);
			numError = cStmt.getString(2);
			msjError = cStmt.getString(3);
		
			listaCarteras = new ArrayList<Cartera>();

			if(rs !=null){
				while (rs.next()) {
					cartera = new Cartera();
					cartera.setCodCartera(rs.getString("cod_cartera"));
					cartera.setDesCartera(rs.getString("des_cartera"));
					listaCarteras.add(cartera);
				}
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+numError);
		log.info("Msj Error: "+msjError);
		
		mapaSalida.put("listaCarteras",listaCarteras);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}
	
	public Map<String, Object> buscarProductos(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Producto> listaProductos = null;
		Producto producto = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Productos");
			
			producto = (Producto)mapaEntrada.get("producto");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_productos(?,?,?) }");
			
		
			
			cStmt.registerOutParameter(1, Types.OTHER);// cursor$
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(1);
			numError = cStmt.getString(2);
			msjError = cStmt.getString(3);
		
			listaProductos = new ArrayList<Producto>();

			if(rs !=null){
				while (rs.next()) {
					producto = new Producto();
					producto.setCodProducto(rs.getString("cod_producto"));
					producto.setDesProducto(rs.getString("des_producto"));
					listaProductos.add(producto);
				}
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+numError);
		log.info("Msj Error: "+msjError);
		
		mapaSalida.put("listaProductos",listaProductos);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}
	

	public Map<String, Object> logIn(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Sesion sesion = null;
		Map<String, Object> mapaSalida = null;
		Usuario usuario = null;
		Error error = new Error();

		try {
			log.info("Login");

			mapaSalida = new HashMap<String, Object>();
			usuario = (Usuario) mapaEntrada.get("usuario");

			log.info(usuario.getUsuario());

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call login(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
			cStmt.setString(1, usuario.getsNomUsuario());
			cStmt.setString(2, usuario.getsContrasena());
			cStmt.setString(3, usuario.getsHost());
			cStmt.setString(4, Constantes.codAplicacion);
			cStmt.setString(5, usuario.getsCodIdioma());
			cStmt.registerOutParameter(6, Types.VARCHAR);// ses_idsesion$
			cStmt.registerOutParameter(7, Types.VARCHAR);// ses_fhologueo$
			cStmt.registerOutParameter(8, Types.VARCHAR);// ses_fhoultimaconsulta$
			cStmt.registerOutParameter(9, Types.VARCHAR);// ses_scodaplicacion$
			cStmt.registerOutParameter(10, Types.VARCHAR);// ses_snumusuario$
			cStmt.registerOutParameter(11, Types.VARCHAR);// ses_srutusuario$
			cStmt.registerOutParameter(12, Types.VARCHAR);// ses_snomusuario$
			cStmt.registerOutParameter(13, Types.VARCHAR);// ses_scodidioma$
			cStmt.registerOutParameter(14, Types.VARCHAR);// ses_data01$
			cStmt.registerOutParameter(15, Types.VARCHAR);// ses_data02$
			cStmt.registerOutParameter(16, Types.VARCHAR);// ses_data03$
			cStmt.registerOutParameter(17, Types.VARCHAR);// ses_data04$
			cStmt.registerOutParameter(18, Types.VARCHAR);// ses_data05$
			cStmt.registerOutParameter(19, Types.VARCHAR);// expiracontrasena$
			cStmt.registerOutParameter(20, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(21, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			System.out.println("["+usuario.getsNomUsuario()+" - "+usuario.getsContrasena()+"]");
			cStmt.execute();
			error.setNumError(cStmt.getString(20));
			error.setMsjError(cStmt.getString(21));
			System.out.println(error.getError()+"<----");
			
		} catch (SQLException e) {
			//e.printStackTrace();
			log.info("Error code: "+e.getErrorCode());
			log.info("Error mesaje: "+e.getMessage());
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} finally {
			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		mapaSalida.put("error", error);

		return mapaSalida;
	}

	public Map<String, Object> buscarPerfiles(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> validarSesion(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> logOut(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> agregarCartera(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> cargarCartera(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> modificarCartera(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> eliminarCartera(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> agregarProducto(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> cargarProducto(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> modificarEmpresa(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Empresa empresa = null;
		Error error = new Error();

		try {
			log.info("Modificar Empresa");
			
			empresa = (Empresa)mapaEntrada.get("empresa");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_empresa(?,?,?,?) }");
			cStmt.setString(1,empresa.getNombre());
			cStmt.setString(2,empresa.getNumAdherente());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			error.setNumError(cStmt.getString(8));
			error.setMsjError(cStmt.getString(9));
		
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+ error.getNumError());
		log.info("Msj Error: "+ error.getMsjError());

		return mapaSalida;
	}
	
	public Map<String, Object> modificarProducto(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> eliminarProducto(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> buscarDocumentos(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Documento> listaDocumentos = null;
		Documento documento = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Documentos");
			
			documento = (Documento)mapaEntrada.get("documento");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_documentos(?,?,?,?,?,?,?,?,?) }");
			cStmt.setString(1,documento.getNombre());
			cStmt.setString(2,documento.getNumFolio());
			cStmt.setString(3,documento.getNumAdherente());
			cStmt.setString(4,documento.getCodCartera());
			cStmt.setString(5,documento.getCodProducto());
			cStmt.setString(6,documento.getCodArea());
			cStmt.registerOutParameter(7, Types.OTHER);// cursor$
			cStmt.registerOutParameter(8, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(9, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(7);
			numError = cStmt.getString(8);
			msjError = cStmt.getString(9);
		
			listaDocumentos = new ArrayList<Documento>();

			if(rs !=null){
				while (rs.next()) {
					documento = new Documento();
					documento.setIdDocumento(rs.getLong("id_documento"));
					documento.setNombre(rs.getString("nombre"));
					documento.setNumFolio(rs.getString("num_folio"));
					documento.setNumAdherente(rs.getString("num_adherente"));
					documento.setCodCartera(rs.getString("cod_cartera"));
					documento.setDesCartera(rs.getString("des_cartera"));
					documento.setCodProducto(rs.getString("cod_producto"));
					documento.setDesProducto(rs.getString("des_producto"));
					documento.setDesArea(rs.getString("des_area"));
					listaDocumentos.add(documento);
				}
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+numError);
		log.info("Msj Error: "+msjError);
		
		mapaSalida.put("listaDocumentos",listaDocumentos);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}

	public Map<String, Object> agregarDocumento(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Documento documento = null;
		String numError = "0";
		String msjError = "";
		long idDocumento = 0;
		
		try {
			log.info("Agregar documento");

			documento = (Documento)mapaEntrada.get("documento");
			
			log.info(documento.getDocumento());
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_documento(?,?,?,?,?,?,?,?,?,?) }");
			cStmt.setString(1, documento.getNombre());
			cStmt.setString(2, documento.getNumFolio());
			cStmt.setString(3, documento.getNumAdherente());
			cStmt.setString(4, documento.getDescripcion());
			cStmt.setString(5, documento.getCodCartera());
			cStmt.setString(6, documento.getCodProducto());
			cStmt.setString(7, documento.getCodArea());
			cStmt.registerOutParameter(8, Types.BIGINT);// nidusuario$
			cStmt.registerOutParameter(9, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(10, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			idDocumento = cStmt.getLong(8);
			numError = cStmt.getString(9);
			msjError = cStmt.getString(10);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		
		mapaSalida.put("idDocumento", idDocumento);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}

	public Map<String, Object> cargarDocumento(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		long idDocumento = 0;
		Documento documento = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Cargar documento");

			idDocumento = (Long)mapaEntrada.get("idDocumento");
			
			log.info("ID documento: "+idDocumento);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call cargar_documento(?,?,?,?) }");
			cStmt.setLong(1, idDocumento);
			cStmt.registerOutParameter(2, Types.OTHER);// documento$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
			
			while (rs.next()) {
				documento = new Documento();
				documento.setIdDocumento(rs.getLong("id_documento"));
				documento.setNombre(rs.getString("nombre"));
				documento.setNumFolio(rs.getString("num_folio"));
				documento.setNumAdherente(rs.getString("num_adherente"));
				documento.setCodCartera(rs.getString("cod_cartera"));
				documento.setCodProducto(rs.getString("cod_producto"));
			}
			
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		//log.info(documento.getDocumento());
		mapaSalida.put("documento",documento);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}

	public Map<String, Object> modificarDocumento(
			Map<String, Object> mapaEntrada) {

		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Documento documento = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Modificar documento");

			documento = (Documento)mapaEntrada.get("documento");
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_documento(?,?,?,?,?,?,?,?,?,?)}");

			cStmt.setLong(1, documento.getIdDocumento());
			cStmt.setString(2, documento.getNombre());
			cStmt.setString(3, documento.getNumFolio());
			cStmt.setString(4, documento.getNumAdherente());
			cStmt.setString(5, documento.getDescripcion());
			cStmt.setString(6, documento.getCodCartera());
			cStmt.setString(7, documento.getCodProducto());
			cStmt.setString(8, documento.getCodArea());
			cStmt.registerOutParameter(9, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(10, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			numError = cStmt.getString(9);
			msjError = cStmt.getString(10);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}

	public Map<String, Object> eliminarDocumento(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> buscarParametros(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Producto> listaProductos = null;
		ArrayList<Cartera> listaCarteras = null;
		ArrayList<Area> listaAreas = null;
		Producto producto = null;
		Cartera cartera = null;
		Area area = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Parametros");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_parametros(?,?,?,?,?) }");
			
			cStmt.registerOutParameter(1, Types.OTHER);// cursor$
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.OTHER);// cursor$
			cStmt.registerOutParameter(4, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(5, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rsCarteras = (ResultSet) cStmt.getObject(1);
			ResultSet rsProductos = (ResultSet) cStmt.getObject(2);
			ResultSet rsAreas = (ResultSet) cStmt.getObject(3);
			numError = cStmt.getString(4);
			msjError = cStmt.getString(5);
			
			listaCarteras = new ArrayList<Cartera>();

			if(rsCarteras !=null){
				while (rsCarteras.next()) {
					cartera = new Cartera();
					cartera.setCodCartera(rsCarteras.getString("cod_cartera"));
					cartera.setDesCartera(rsCarteras.getString("des_cartera"));
					listaCarteras.add(cartera);
				}
				rsCarteras.close();
			}
		
			listaProductos = new ArrayList<Producto>();

			if(rsProductos !=null){
				while (rsProductos.next()) {
					producto = new Producto();
					producto.setCodProducto(rsProductos.getString("cod_producto"));
					producto.setDesProducto(rsProductos.getString("des_producto"));
					listaProductos.add(producto);
				}
				rsProductos.close();
			}
			
			listaAreas = new ArrayList<Area>();

			if(rsAreas !=null){
				while (rsAreas.next()) {
					area = new Area();
					area.setCodArea(rsAreas.getString("cod_area"));
					area.setDesArea(rsAreas.getString("des_area"));
					listaAreas.add(area);
				}
				rsAreas.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+numError);
		log.info("Msj Error: "+msjError);
		
		mapaSalida.put("listaCarteras", listaCarteras);
		mapaSalida.put("listaProductos",listaProductos);
		mapaSalida.put("listaAreas",listaAreas);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}

	public Map<String, Object> buscarReclamos(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Reclamo> listaReclamos = null;
		Reclamo reclamo = null;
		Error error = new Error();

		try {
			log.info("Buscar Reclamos");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_reclamos(?,?,?,?,?,?,?,?,?) }");
			
			cStmt.setString(1,"");
			cStmt.setString(2,"");
			cStmt.setString(3,"");
			cStmt.setString(4,"");
			cStmt.setString(5,"");
			cStmt.setString(6,"");
			
			cStmt.registerOutParameter(7, Types.OTHER);// cursor$
			cStmt.registerOutParameter(8, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(9, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(7);
			error.setNumError(cStmt.getString(8));
			error.setMsjError(cStmt.getString(9));
		
			listaReclamos = new ArrayList<Reclamo>();

			if(rs !=null){
				while (rs.next()) {
					reclamo = new Reclamo();
	                reclamo.setNombreSolicitante(rs.getString("nombre_solicitante") );
	                reclamo.setEmailSolicitante(rs.getString("email_solicitante") );
	                reclamo.setFonoSolicitante(rs.getString("fono_solicitante") );
	                reclamo.setRegionSolicitante(rs.getString("region_solicitante") );
	                reclamo.setCodTipo(rs.getString("cod_tipo"));
	                reclamo.setCodMotivo(rs.getString("cod_motivo"));
	                reclamo.setCodPrioridad(rs.getString("cod_prioridad"));
	                reclamo.setCodCartera(rs.getString("cod_cartera"));
	                reclamo.setFecIngreso(rs.getString("fec_ingreso"));
	                reclamo.setGlosa(rs.getString("glosa"));
	                reclamo.setAdjunto(rs.getString("adjunto"));
	                reclamo.setObservaciones(rs.getString("observaciones"));
	                reclamo.setCodEstado(rs.getString("cod_estado"));
	                reclamo.setResponsableIngreso(rs.getString("responsable_ingreso"));
	                reclamo.setResponsableActual(rs.getString("responsable_actual"));
	                //reclamo.setDiasBandeja( );
	                //reclamo.setDiasSistema( );
	                reclamo.setCodMedioRespuesta(rs.getString("cod_medio_respuesta"));
	                reclamo.setFecRespuesta(rs.getString("fec_respuesta") );
					listaReclamos.add(reclamo);
				}
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+ error.getNumError());
		log.info("Msj Error: "+ error.getMsjError());
		
		mapaSalida.put("listaReclamos",listaReclamos);
		mapaSalida.put("numError", error.getNumError());
		mapaSalida.put("msjError", error.getMsjError());

		return mapaSalida;
	}

	public Map<String, Object> agregarReclamo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Reclamo reclamo = null;
		Error error = new Error();
		
		try {
			log.info("Agregar reclamo");
			reclamo = (Reclamo)mapaEntrada.get("reclamo");
			log.info(reclamo.getReclamo());
			System.out.println(reclamo.getEmailBody());
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_reclamo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

			cStmt.setString(1, reclamo.getNumAdherente());
			cStmt.setString(2, reclamo.getNombreSolicitante());
			cStmt.setString(3, reclamo.getEmailSolicitante());
			cStmt.setString(4, reclamo.getFonoSolicitante());
			cStmt.setString(5, reclamo.getRegionSolicitante());
			cStmt.setString(6, reclamo.getCodTipo());
			cStmt.setString(7, reclamo.getCodMotivo());
			cStmt.setString(8, reclamo.getCodPrioridad());
			cStmt.setString(9, reclamo.getCodCartera());
			cStmt.setDate(10, Utils.stringToDate(reclamo.getFecIngreso()));
			cStmt.setString(11, reclamo.getGlosa());
			cStmt.setString(12, reclamo.getAdjunto());
			cStmt.setString(13, reclamo.getObservaciones());
			cStmt.setString(14, reclamo.getCodEstado());
			cStmt.setString(15, reclamo.getResponsableIngreso());
			cStmt.setString(16, reclamo.getResponsableActual());
			cStmt.setString(17, reclamo.getDiasBandeja());
			cStmt.setString(18, reclamo.getDiasSistema());
			cStmt.setString(19, reclamo.getCodMedioRespuesta());
			cStmt.setDate(20, Utils.stringToDate(reclamo.getFecRespuesta()));
			
			cStmt.registerOutParameter(21, Types.BIGINT);// nidreclamo$
			cStmt.registerOutParameter(22, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(23, Types.VARCHAR);// msjerror$
			
			log.info("N° Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			reclamo.setIdReclamo(cStmt.getLong(21));
			error.setNumError(cStmt.getString(22));
			error.setMsjError(cStmt.getString(23));
			
			log.info("Num Error: " + error.getNumError());
			log.info("Msj Error: " + error.getMsjError());
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
			return null;
		} finally {
			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
				return null;
			}
		}
		
		mapaSalida.put("reclamo", reclamo);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> cargarReclamo(Map<String, Object> mapaEntrada) {
		// TODO Auto-generated method stub
		return null;
	}

	public Map<String, Object> modificarReclamo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Reclamo reclamo = null;
		Error error = new Error();
		
		try {
			log.info("Modificar reclamo");
			reclamo = (Reclamo)mapaEntrada.get("reclamo");
			log.info(reclamo.getReclamo());
			System.out.println(reclamo.getEmailBody());
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_reclamo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

			cStmt.setLong(1, reclamo.getIdReclamo());
			cStmt.setString(2, reclamo.getNumAdherente());
			cStmt.setString(3, reclamo.getNombreSolicitante());
			cStmt.setString(4, reclamo.getEmailSolicitante());
			cStmt.setString(5, reclamo.getFonoSolicitante());
			cStmt.setString(6, reclamo.getRegionSolicitante());
			cStmt.setString(7, reclamo.getCodTipo());
			cStmt.setString(8, reclamo.getCodMotivo());
			cStmt.setString(9, reclamo.getCodPrioridad());
			cStmt.setString(10, reclamo.getCodCartera());
			cStmt.setDate(11, Utils.stringToDate(reclamo.getFecIngreso()));
			cStmt.setString(12, reclamo.getGlosa());
			cStmt.setString(13, reclamo.getAdjunto());
			cStmt.setString(14, reclamo.getObservaciones());
			cStmt.setString(15, reclamo.getCodEstado());
			cStmt.setString(16, reclamo.getResponsableIngreso());
			cStmt.setString(17, reclamo.getResponsableActual());
			cStmt.setString(18, reclamo.getDiasBandeja());
			cStmt.setString(19, reclamo.getDiasSistema());
			cStmt.setString(20, reclamo.getCodMedioRespuesta());
			cStmt.setDate(21, Utils.stringToDate(reclamo.getFecRespuesta()));
			
			cStmt.registerOutParameter(22, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(23, Types.VARCHAR);// msjerror$
			
			log.info("N° Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			reclamo.setIdReclamo(cStmt.getLong(21));
			error.setNumError(cStmt.getString(22));
			error.setMsjError(cStmt.getString(23));
			
			log.info("Num Error: " + error.getNumError());
			log.info("Msj Error: " + error.getMsjError());
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
			return null;
		} finally {
			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
				return null;
			}
		}
		
		mapaSalida.put("reclamo", reclamo);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}

	public Map<String, Object> eliminarReclamo(Map<String, Object> mapaEntrada) {
		Map<String, Object> mapaSalida = null;
		Error error = new Error();
		CallableStatement cStmt = null;
		
		try {
			log.info("Eliminar reclamo");
						
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_reclamo(?,?,?) }");

			cStmt.setLong(1, ((Reclamo)mapaEntrada.get("reclamo")).getIdReclamo());
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();
			
			error.setNumError(cStmt.getString(2));
			error.setMsjError(cStmt.getString(3));
			
			log.info("Num Error: "+ error.getNumError());
			log.info("Msj Error: "+ error.getMsjError());
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		
		mapaSalida.put("error", error);
		
		return null;
	}

	public Map<String, Object> buscarParametrosReclamo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Producto> listaProductos = null;
		ArrayList<Cartera> listaCarteras = null;
		ArrayList<Area> listaAreas = null;
		Producto producto = null;
		Cartera cartera = null;
		Area area = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Parametros");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_parametros(?,?,?,?,?) }");
			
			cStmt.registerOutParameter(1, Types.OTHER);// cursor$
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.OTHER);// cursor$
			cStmt.registerOutParameter(4, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(5, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rsCarteras = (ResultSet) cStmt.getObject(1);
			ResultSet rsProductos = (ResultSet) cStmt.getObject(2);
			ResultSet rsAreas = (ResultSet) cStmt.getObject(3);
			numError = cStmt.getString(4);
			msjError = cStmt.getString(5);
			
			listaCarteras = new ArrayList<Cartera>();

			if(rsCarteras !=null){
				while (rsCarteras.next()) {
					cartera = new Cartera();
					cartera.setCodCartera(rsCarteras.getString("cod_cartera"));
					cartera.setDesCartera(rsCarteras.getString("des_cartera"));
					listaCarteras.add(cartera);
				}
				rsCarteras.close();
			}
		
			listaProductos = new ArrayList<Producto>();

			if(rsProductos !=null){
				while (rsProductos.next()) {
					producto = new Producto();
					producto.setCodProducto(rsProductos.getString("cod_producto"));
					producto.setDesProducto(rsProductos.getString("des_producto"));
					listaProductos.add(producto);
				}
				rsProductos.close();
			}
			
			listaAreas = new ArrayList<Area>();

			if(rsAreas !=null){
				while (rsAreas.next()) {
					area = new Area();
					area.setCodArea(rsAreas.getString("cod_area"));
					area.setDesArea(rsAreas.getString("des_area"));
					listaAreas.add(area);
				}
				rsAreas.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+numError);
		log.info("Msj Error: "+msjError);
		
		mapaSalida.put("listaCarteras", listaCarteras);
		mapaSalida.put("listaProductos",listaProductos);
		mapaSalida.put("listaAreas",listaAreas);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}
	
	public Map<String, Object> agregarEmpresa(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Error error = new Error();
		Map<String, Object> mapaSalida = null;
		Empresa empresa = new Empresa();
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Parametros");
			
			empresa = (Empresa)mapaEntrada.get("empresa");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_empresa(?,?,?,?) }");
			
			cStmt.setString(1, empresa.getNumAdherente());// cursor$
			cStmt.setString(2, empresa.getNombre());// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));

		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+ error.getNumError());
		log.info("Msj Error: "+ error.getMsjError());

		return mapaSalida;
	}
	
	public Map<String, Object> cargarEmpresa(Map<String, Object> mapaEntrada){
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Empresa empresa = new Empresa();
		
		Error error = new Error();
		
		try {
			log.info("Cargar empresas");
						
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call cargar_empresa(?,?,?,?) }");
			cStmt.setString(1, (String)mapaEntrada.get("numAd"));
			cStmt.registerOutParameter(2, Types.OTHER);// empresas$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			ResultSet rsEmpresa = (ResultSet) cStmt.getObject(2);
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
						
			while (rsEmpresa.next()) {
				empresa = new Empresa();
				empresa.setNombre(rsEmpresa.getString("nombre"));
				empresa.setNumAdherente(rsEmpresa.getString("enp_nidencuesta"));
			}
			
			rsEmpresa.close();			

		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		mapaSalida.put("empresa",empresa);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> buscarEmpresas(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Empresa> listaEmpresas = null;
		Empresa empresa = null;
		Error error = new Error();

		try {
			log.info("Buscar Empresas");
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_empresas(?,?,?) }");
			cStmt.registerOutParameter(1, Types.OTHER);// cursor$
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			log.info("N¼ Parametros: "+ cStmt.getParameterMetaData().getParameterCount());
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(1);
			error.setNumError(cStmt.getString(8));
			error.setMsjError(cStmt.getString(9));
		
			listaEmpresas = new ArrayList<Empresa>();

			if(rs !=null){
				while (rs.next()) {
					empresa = new Empresa();
					empresa.setNombre(rs.getString("nombre"));
					empresa.setNumAdherente(rs.getString("num_adherente"));
					listaEmpresas.add(empresa);
				}
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}

		log.info("Num Error: "+ error.getNumError());
		log.info("Msj Error: "+ error.getMsjError());
		
		mapaSalida.put("listaEmpresas",listaEmpresas);
		mapaSalida.put("error", error);

		return mapaSalida;
	}
	
	public Map<String, Object> eliminarEmpresa(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		String numAd = "";
		
		Error error = new Error();
		
		try {
			log.info("Eliminar usuario");

			numAd = (String)mapaEntrada.get("numAd");
			
			log.info("Número de adherente: " + numAd);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ eliminar_empresa(?,?,?) }");
			cStmt.setString(1, numAd);
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			error.setNumError(cStmt.getString(2));
			error.setMsjError(cStmt.getString(3));	
			
		} catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
			// controlar error sql, (de conexion, por ej)
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
		} finally {

			try {
				log.info("Cerrando la conexion");
				dbConeccion.close();
				cStmt.close();
				dbConeccion = null;
			} catch (SQLException e) {
				log.info("Error al cerrar la conexion");
				e.printStackTrace();
			}
		}
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
}