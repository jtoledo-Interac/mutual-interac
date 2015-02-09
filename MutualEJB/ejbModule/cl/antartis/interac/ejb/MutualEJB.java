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
import cl.antartis.interac.beans.Documento;
import cl.antartis.interac.beans.Empresa;
import cl.antartis.interac.beans.Error;
import cl.antartis.interac.beans.Estado;
import cl.antartis.interac.beans.Medio;
import cl.antartis.interac.beans.Motivo;
import cl.antartis.interac.beans.Prioridad;
import cl.antartis.interac.beans.Producto;
import cl.antartis.interac.beans.Reclamo;
import cl.antartis.interac.beans.Region;
import cl.antartis.interac.beans.Tipo;
import cl.antartis.interac.beans.Usuario;
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
			
			cStmt.setString(1, usuario.getRut());
			cStmt.setString(2, usuario.getDv());
			cStmt.setString(3, usuario.getNombres());
			cStmt.setString(4, usuario.getApePaterno());
			cStmt.setString(5, usuario.getApeMaterno());
			cStmt.setString(6, usuario.getNomUsuario());
			cStmt.registerOutParameter(7, Types.OTHER);// cursor$
			cStmt.registerOutParameter(8, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(9, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(7);
			numError = cStmt.getString(8);
			msjError = cStmt.getString(9);
		
			listaUsuarios = new ArrayList<Usuario>();

			if(rs !=null){
				while (rs.next()) {
					usuario = new Usuario();
					usuario.setIdUsuario(rs.getLong("idusuario"));
					usuario.setRut(rs.getString("rut"));
					usuario.setDv(rs.getString("dv"));
					usuario.setRutFormat(Utils.getRutFormat(usuario.getRut()+usuario.getDv()));
					usuario.setNombres(rs.getString("nombres"));
					usuario.setApePaterno(rs.getString("apepaterno"));
					usuario.setApeMaterno(rs.getString("apematerno"));
					usuario.setNomUsuario(rs.getString("nomusuario"));
					usuario.setContrasena1(rs.getString("contrasena"));
					usuario.setCodGenero(rs.getString("codgenero"));
					usuario.setFecNacimiento(Utils.formateaFecha(rs.getString("fecnacimiento")));
					usuario.setTelefono(rs.getString("telefono"));
					usuario.setCelular(rs.getString("celular"));
					usuario.setEmail(rs.getString("email"));
					usuario.setCantIntentos(rs.getInt("cantintentos"));
					usuario.setFecCreacion(Utils.formateaFecha(rs.getString("feccreacion")));
					usuario.setFecContrasena(Utils.formateaFecha(rs.getString("feccontrasena")));
					usuario.setIndVigencia(rs.getString("indvigencia"));
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
			cStmt.setString(1, usuario.getRut());
			cStmt.setString(2, usuario.getDv());
			cStmt.setString(3, usuario.getNombres());
			cStmt.setString(4, usuario.getApePaterno());
			cStmt.setString(5, usuario.getApeMaterno());
			cStmt.setString(6, usuario.getNomUsuario());
			cStmt.setString(7, usuario.getContrasena1());
			cStmt.setString(8, usuario.getCodGenero());
			cStmt.setDate(9, Utils.stringToDate(usuario.getFecNacimiento()));
			cStmt.setString(10, usuario.getTelefono());
			cStmt.setString(11, usuario.getCelular());
			cStmt.setString(12, usuario.getEmail());
			cStmt.registerOutParameter(13, Types.BIGINT);// nidusuario$
			cStmt.registerOutParameter(14, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(15, Types.VARCHAR);// msjerror$

			
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
			
			cStmt = dbConeccion.prepareCall("{ call modificar_usuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
			cStmt.setLong(1, usuario.getIdUsuario());
			cStmt.setString(2, usuario.getRut());
			cStmt.setString(3, usuario.getDv());
			cStmt.setString(4, usuario.getNombres());
			cStmt.setString(5, usuario.getApePaterno());
			cStmt.setString(6, usuario.getApeMaterno());
			cStmt.setString(7, usuario.getNomUsuario());
			cStmt.setString(8, usuario.getCodGenero());
			cStmt.setDate(9, Utils.stringToDate(usuario.getFecNacimiento()));
			log.info("fecha antes -> "+usuario.getFecNacimiento());
			log.info("fecha despues -> "+Utils.stringToDate(usuario.getFecNacimiento()));
			cStmt.setString(10, usuario.getTelefono());
			cStmt.setString(11, usuario.getCelular());
			cStmt.setString(12, usuario.getEmail());
			cStmt.registerOutParameter(13, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(14, Types.VARCHAR);// msjerror$

			
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

			idUsuario = (Long) mapaEntrada.get("nIdUsuario");
			
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
			
			log.info("??????");
			
			while (rsUsuarios.next()) {
				usuario = new Usuario();
				usuario.setIdUsuario(rsUsuarios.getLong("idusuario"));
				usuario.setRut(rsUsuarios.getString("rut"));
				usuario.setDv(rsUsuarios.getString("dv"));
				usuario.setRutFormat(Utils.getRutFormat(usuario.getRut()+usuario.getDv()));
				usuario.setNombres(rsUsuarios.getString("nombres"));
				usuario.setApePaterno(rsUsuarios.getString("apepaterno"));
				usuario.setApeMaterno(rsUsuarios.getString("apematerno"));
				usuario.setNomUsuario(rsUsuarios.getString("nomusuario"));
				usuario.setContrasena1(rsUsuarios.getString("contrasena"));
				usuario.setCodGenero(rsUsuarios.getString("codgenero"));
				usuario.setFecNacimiento(Utils.formateaFecha(rsUsuarios.getString("fecnacimiento")));
				usuario.setTelefono(rsUsuarios.getString("telefono"));
				usuario.setCelular(rsUsuarios.getString("celular"));
				usuario.setEmail(rsUsuarios.getString("email"));
				usuario.setCantIntentos(rsUsuarios.getInt("cantintentos"));
				usuario.setFecCreacion(Utils.formateaFecha(rsUsuarios.getString("feccreacion")));
				usuario.setFecContrasena(Utils.formateaFecha(rsUsuarios.getString("feccontrasena")));
				usuario.setIndVigencia(rsUsuarios.getString("indvigencia"));
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

			cStmt = dbConeccion.prepareCall("{ call buscar_carteras(?,?,?,?) }");
			
			cStmt.setString(1,cartera.getDesCartera());
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
		
			listaCarteras = new ArrayList<Cartera>();

			if(rs !=null){
				while (rs.next()) {
					cartera = new Cartera();
					cartera.setIdCartera(rs.getLong("id_cartera"));
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

			cStmt = dbConeccion.prepareCall("{ call buscar_productos(?,?,?,?) }");
			
		
			cStmt.setString(1,producto.getDesProducto());
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
		
			listaProductos = new ArrayList<Producto>();

			if(rs !=null){
				while (rs.next()) {
					producto = new Producto();
					producto.setIdProducto(rs.getLong("id_producto"));
					producto.setDesProducto(rs.getString("des_producto"));
					log.info(producto.getProducto());
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
		Map<String, Object> mapaSalida = null;
		Usuario usuario = null;
		Error error = new Error();

		try {
			log.info("Login");
			usuario = (Usuario)mapaEntrada.get("usuario");
			mapaSalida = new HashMap<String, Object>();
			//log.info(usuario.getUsuario());

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call login(?,?,?,?,?,?,?,?,?)}");
			cStmt.setString(1, usuario.getNomUsuario());
			cStmt.setString(2, usuario.getContrasena1());
			cStmt.registerOutParameter(3, Types.INTEGER);// id$
			cStmt.registerOutParameter(4, Types.VARCHAR);// email$
			cStmt.registerOutParameter(5, Types.VARCHAR);// nombre$
			cStmt.registerOutParameter(6, Types.VARCHAR);// apellidoP$
			cStmt.registerOutParameter(7, Types.VARCHAR);// apellidoM$
			cStmt.registerOutParameter(8, Types.VARCHAR);
			cStmt.registerOutParameter(9, Types.VARCHAR);
		
			
			log.info("["+usuario.getNomUsuario()+" - "+usuario.getContrasena1()+"]");
			cStmt.execute();
			usuario.setIdUsuario(cStmt.getInt(3));
			usuario.setEmail(cStmt.getString(4));
			usuario.setNombres(cStmt.getString(5));
			usuario.setApePaterno(cStmt.getString(6));
			usuario.setApeMaterno(cStmt.getString(7));
			error.setNumError(cStmt.getString(8));
			error.setMsjError(cStmt.getString(9));
			mapaSalida.put("error", error);
			mapaSalida.put("usuario",usuario);
			log.info(error.getError()+"<----");
			
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
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Cartera cartera = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Agregar cartera");

			cartera = (Cartera)mapaEntrada.get("cartera");
			
			log.info(cartera.getCartera());
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_cartera(?,?,?) }"); //falta SP, posibles cambios aqui
			cStmt.setString(1, cartera.getDesCartera());
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			
			cStmt.execute();
			
	
			numError = cStmt.getString(2);
			msjError = cStmt.getString(3);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
			
		}
		finally {

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
	
	public Map<String, Object> agregarTipo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Tipo tipo = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Agregar tipo");

			tipo = (Tipo)mapaEntrada.get("tipo");
			
			log.info(tipo.getTipo());
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_tipo(?,?,?) }");
			cStmt.setString(1, tipo.getDesTipo());
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			
			cStmt.execute();
			
	
			numError = cStmt.getString(2);
			msjError = cStmt.getString(3);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
			
		}
		finally {

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
	
	public Map<String, Object> agregarMotivo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Motivo motivo = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Agregar motivo");

			motivo = (Motivo)mapaEntrada.get("motivo");
			
			log.info(motivo.getMotivo());
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_motivo(?,?,?) }"); //falta SP, posibles cambios aqui
			cStmt.setString(1, motivo.getDesMotivo());			
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			
			cStmt.execute();
			
	
			numError = cStmt.getString(2);
			msjError = cStmt.getString(3);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
			
		}
		finally {

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

	public Map<String, Object> agregarMedio(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Medio medio = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Agregar tipo");

			medio = (Medio)mapaEntrada.get("medio");
			
			log.info(medio.getMedio());
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_medio(?,?,?,?) }"); //falta SP, posibles cambios aqui
			cStmt.setString(1, medio.getCodMedio());
			cStmt.setString(2, medio.getDesMedio());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
			
			log.info("Num Error: "+numError);
			log.info("Msj Error: "+msjError);
	
		}catch (SQLException e) {
			e.printStackTrace();
			log.info("SQL Exception");
		} catch (Exception e) {
			e.printStackTrace();
			log.info("SQL Exception 2");
			
		}
		finally {

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
	
	public Map<String, Object> cargarCartera(Map<String, Object> mapaEntrada) {
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Cartera cartera = new Cartera();
		
		Error error = new Error();
		
		try {
			log.info("Cargar carteras");
						
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();
			cStmt = dbConeccion.prepareCall("{ call cargar_cartera(?,?,?,?) }");
			cStmt.setLong(1, (Long)mapaEntrada.get("idCartera")); 
			cStmt.registerOutParameter(2, Types.OTHER);// carteras$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			ResultSet rsCartera = (ResultSet) cStmt.getObject(2);
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
						
			while (rsCartera.next()) {
				cartera = new Cartera();
				cartera.setIdCartera(rsCartera.getLong("id_cartera"));
				cartera.setDesCartera(rsCartera.getString("des_cartera"));
				log.info(cartera.getCartera());
			}
			
			rsCartera.close();			

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
		mapaSalida.put("cartera",cartera);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}

	public Map<String, Object> cargarTipo(Map<String, Object> mapaEntrada) {
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Tipo tipo = new Tipo();
		
		Error error = new Error();
		
		try {
			log.info("Cargar tipos");
						
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();
			
			cStmt = dbConeccion.prepareCall("{ call cargar_tipo(?,?,?,?) }");
			cStmt.setLong(1,(Long)mapaEntrada.get("idTipo")); 
			cStmt.registerOutParameter(2, Types.OTHER);// carteras$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			ResultSet rsCartera = (ResultSet) cStmt.getObject(2);
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
						
			while (rsCartera.next()) {
				tipo = new Tipo();
				tipo.setIdTipo(Long.parseLong(rsCartera.getString("id_tipo")));
				tipo.setDesTipo(rsCartera.getString("des_tipo"));
				log.info(tipo.getTipo());
			}
			
			rsCartera.close();			

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
		mapaSalida.put("tipo",tipo);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> cargarMotivo(Map<String, Object> mapaEntrada) {
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Motivo motivo = new Motivo();
		Error error = new Error();
		
		try {
			log.info("Cargar motivos");
						
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();
			
			cStmt = dbConeccion.prepareCall("{ call cargar_motivo(?,?,?,?) }");
			cStmt.setLong(1, (Long)mapaEntrada.get("idMotivo")); 
			cStmt.registerOutParameter(2, Types.OTHER);// carteras$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			ResultSet rsCartera = (ResultSet) cStmt.getObject(2);
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
						
			while (rsCartera.next()) {
				motivo = new Motivo();
				motivo.setIdMotivo(rsCartera.getLong("id_motivo"));
				motivo.setDesMotivo(rsCartera.getString("des_motivo"));
				log.info(motivo.getMotivo());
			}
			
			rsCartera.close();			

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
		mapaSalida.put("motivo",motivo);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> cargarMedio(Map<String, Object> mapaEntrada) {
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Medio medio = new Medio();
		
		Error error = new Error();
		
		try {
			log.info("Cargar medios");
						
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();
			
			cStmt = dbConeccion.prepareCall("{ call cargar_medio(?,?,?,?) }");
			cStmt.setString(1, (String)mapaEntrada.get("codMedio")); 
			cStmt.registerOutParameter(2, Types.OTHER);// carteras$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			ResultSet rsCartera = (ResultSet) cStmt.getObject(2);
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
						
			while (rsCartera.next()) {
				medio = new Medio();
				medio.setCodMedio(rsCartera.getString("cod_medio_respuesta"));
				medio.setDesMedio(rsCartera.getString("des_medio_respuesta"));
				log.info(medio.getMedio());
			}
			
			rsCartera.close();			

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
		mapaSalida.put("medio",medio);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> modificarCartera(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Cartera cartera = null;
		Error error = new Error();

		try {
			log.info("Modificar cartera");
			
			cartera = (Cartera)mapaEntrada.get("cartera");

			mapaSalida = new HashMap<String, Object>();

			log.info(cartera.getCartera());
			
			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_cartera(?,?,?,?) }");
			cStmt.setLong(1,cartera.getIdCartera());
			cStmt.setString(2,cartera.getDesCartera());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
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

	public Map<String, Object> modificarTipo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Tipo tipo = null;
		Error error = new Error();

		try {
			log.info("Modificar cartera");
			
			tipo = (Tipo)mapaEntrada.get("tipo");

			mapaSalida = new HashMap<String, Object>();

			log.info(tipo.getTipo());
			
			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_tipo(?,?,?,?) }");
			cStmt.setLong(1,tipo.getIdTipo());
			cStmt.setString(2,tipo.getDesTipo());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
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
	
	public Map<String, Object> modificarMotivo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Motivo motivo = null;
		Error error = new Error();

		try {
			log.info("Modificar motivo");
			
			motivo = (Motivo)mapaEntrada.get("motivo");

			mapaSalida = new HashMap<String, Object>();

			log.info(motivo.getMotivo());
			
			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_motivo(?,?,?,?) }");
			cStmt.setLong(1,motivo.getIdMotivo());
			cStmt.setString(2,motivo.getDesMotivo());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
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
	
	public Map<String, Object> modificarMedio(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Medio medio = null;
		Error error = new Error();

		try {
			log.info("Modificar medio");
			
			medio = (Medio)mapaEntrada.get("medio");

			mapaSalida = new HashMap<String, Object>();

			log.info(medio.getMedio());
			
			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_medio(?,?,?,?) }");
			cStmt.setString(1,medio.getCodMedio());
			cStmt.setString(2,medio.getDesMedio());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
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
	
	public Map<String, Object> eliminarCartera(Map<String, Object> mapaEntrada) {
		
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_cartera = null;
		
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Eliminar cartera");

			id_cartera = Utils.stringToNum((String)mapaEntrada.get("idCartera"));
			
			log.info("cod_cartera: "+id_cartera);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_cartera(?,?,?) }");
			cStmt.setLong(1, id_cartera);
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
	
	public Map<String, Object> eliminarTipo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_tipo;
		
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Eliminar tipo");

			id_tipo = Long.parseLong((String)mapaEntrada.get("idTipo"));
			log.info("idtipo: "+id_tipo);
			log.info("id_tipo: "+ id_tipo);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_tipo(?,?,?) }");
			cStmt.setLong(1, id_tipo);
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
	
	public Map<String, Object> eliminarMotivo(Map<String, Object> mapaEntrada) {
		
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_motivo;
		
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Eliminar motivo");

			id_motivo = (Long)mapaEntrada.get("idMotivo");
			
			log.info("id_motivo: "+ id_motivo);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_motivo(?,?,?) }");
			cStmt.setLong(1, id_motivo);
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

	public Map<String, Object> eliminarMedio(Map<String, Object> mapaEntrada) {
		
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		String cod_medio = "";
		
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Eliminar medio");

			cod_medio = (String)mapaEntrada.get("codMedio");
			
			log.info("cod_medio: "+ cod_medio);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_medio(?,?,?) }");
			cStmt.setString(1, cod_medio);
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
	
	public Map<String, Object> agregarProducto(Map<String, Object> mapaEntrada) {
	
		CallableStatement cStmt = null;
		Error error = new Error();
		Map<String, Object> mapaSalida = null;
		Producto producto = new Producto();

		try {
			log.info("Buscar Produtos");
			
			producto = (Producto)mapaEntrada.get("producto");
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_producto(?,?,?) }"); //cambiar segun SP
			int i=1;
			cStmt.setString(i++, producto.getDesProducto());// cursor$			
			cStmt.registerOutParameter(i++, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(i++, Types.VARCHAR);// msjerror$

			
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

		log.info("Num Error: "+ error.getNumError());
		log.info("Msj Error: "+ error.getMsjError());

		mapaSalida.put("producto", producto);
		mapaSalida.put("error", error);
		
		return mapaSalida;		
		
		
	}

	public Map<String, Object> cargarProducto(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_producto;
		Producto producto = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Cargar producto");

			id_producto = (Long)mapaEntrada.get("idProducto");
			
			log.info("id_producto: "+id_producto);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call cargar_producto(?,?,?,?) }");
			cStmt.setLong(1, id_producto);
			cStmt.registerOutParameter(2, Types.OTHER);// documento$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
			
			while (rs.next()) {
				
				producto= new Producto();
				producto.setIdProducto(rs.getLong("id_producto"));
				producto.setDesProducto(rs.getString("des_producto"));
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
		mapaSalida.put("producto",producto);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
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
			cStmt.setString(1,empresa.getNumAdherente());
			cStmt.setString(2,empresa.getNombre());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$
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
	
	public Map<String, Object> modificarProducto(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = new HashMap<String, Object>();;
		Producto producto = null;
		Error error = new Error();

		try {
			log.info("Modificar Producto");
			
			producto = (Producto)mapaEntrada.get("producto");

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_producto(?,?,?,?) }");
			cStmt.setLong(1,producto.getIdProducto());
			cStmt.setString(2,producto.getDesProducto());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$
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
		mapaSalida.put("error",error);
		
		return mapaSalida;
	}

	public Map<String, Object> eliminarProducto(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_producto;
		Error error = new Error();
		
		try {
			log.info("Eliminar cartera");
			id_producto = (Long)mapaEntrada.get("idProducto");
			log.info("id_producto: "+id_producto);
			mapaSalida = new HashMap<String, Object>();
			
			dbConeccion = interacDS.getConnection();
			cStmt = dbConeccion.prepareCall("{ call eliminar_PRODUCTO(?,?,?) }");
			cStmt.setLong(1, id_producto);
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
			cStmt.setLong(4,documento.getIdCartera());
			cStmt.setLong(5,documento.getIdProducto());
			cStmt.setString(6,documento.getCodArea());
			cStmt.registerOutParameter(7, Types.OTHER);// cursor$
			cStmt.registerOutParameter(8, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(9, Types.VARCHAR);// msjerror$

			
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
					documento.setIdCartera(rs.getLong("id_cartera"));
					documento.setDesCartera(rs.getString("des_cartera"));
					documento.setIdProducto(Long.parseLong(rs.getString("id_producto")));
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
			cStmt.setLong(5, documento.getIdCartera());
			cStmt.setLong(6, documento.getIdProducto());
			cStmt.setString(7, documento.getCodArea());
			cStmt.registerOutParameter(8, Types.BIGINT);// nidusuario$
			cStmt.registerOutParameter(9, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(10, Types.VARCHAR);// msjerror$

			
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
				documento.setDescripcion(rs.getString("descripcion"));
				documento.setIdCartera(Utils.stringToNum(rs.getString("id_cartera")));
				documento.setIdProducto(Long.parseLong(rs.getString("id_producto")));
				documento.setCodArea(rs.getString("cod_area"));
				documento.setFecCreacion(Utils.formateaFecha(rs.getString("fec_creacion")));
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

	public Map<String, Object> modificarDocumento(Map<String, Object> mapaEntrada) {

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
			cStmt.setLong(6, documento.getIdCartera());
			cStmt.setLong(7, documento.getIdProducto());
			cStmt.setString(8, documento.getCodArea());
			cStmt.registerOutParameter(9, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(10, Types.VARCHAR);// msjerror$

			
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
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		long idDocumento = 0;
		
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("no entra??");
			
			log.info("Eliminar documento");

			idDocumento = (Long)mapaEntrada.get("idDocumento");
			
			log.info("ID documento: "+idDocumento);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_documento(?,?,?) }");
			cStmt.setLong(1, idDocumento);
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
					cartera.setIdCartera(Utils.stringToNum(rsCarteras.getString("id_cartera")));
					cartera.setDesCartera(rsCarteras.getString("des_cartera"));
					listaCarteras.add(cartera);
				}
				rsCarteras.close();
			}
		
			listaProductos = new ArrayList<Producto>();

			if(rsProductos !=null){
				while (rsProductos.next()) {
					producto = new Producto();
					producto.setIdProducto(rsProductos.getLong("id_producto"));
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

			cStmt = dbConeccion.prepareCall("{ call buscar_reclamos_paginacion(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
			
			reclamo = new Reclamo();
			reclamo = (Reclamo)mapaEntrada.put("reclamo",reclamo);
			
			cStmt.setString(1,reclamo.getNombreSolicitante());
			cStmt.setString(2,reclamo.getNumAdherente());
			cStmt.setLong(3,reclamo.getIdCartera());
			cStmt.setLong(4,reclamo.getIdTipo());
			cStmt.setLong(5,reclamo.getIdEstado());
			cStmt.setLong(6,reclamo.getIdPrioridad());
			cStmt.setLong(7,reclamo.getIdReclamo());
			cStmt.registerOutParameter(8, Types.OTHER);// cursor$
			cStmt.registerOutParameter(9, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(10, Types.VARCHAR);// msjerror$
			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(8);
			error.setNumError(cStmt.getString(9));
			error.setMsjError(cStmt.getString(10));
		
			listaReclamos = new ArrayList<Reclamo>();

			int i=0;
			if(rs !=null){
				while (rs.next()) {
					log.info(i++);
					reclamo = new Reclamo();
					reclamo.setIdReclamo(rs.getLong("id_reclamo"));
					reclamo.setNumAdherente(rs.getString("num_adherente"));
	                reclamo.setNombreSolicitante(rs.getString("nombre_solicitante"));
	                reclamo.setEmailSolicitante(rs.getString("email_solicitante"));
	                reclamo.setFonoSolicitante(rs.getString("fono_solicitante"));
	                reclamo.setRegionSolicitante(rs.getString("region_solicitante"));
	                reclamo.setIdTipo(Long.parseLong(rs.getString("id_tipo")));
					reclamo.setDesTipo(rs.getString("des_tipo"));
	                reclamo.setIdMotivo(Utils.stringToNum(rs.getString("id_motivo")));
					reclamo.setDesMotivo(rs.getString("des_motivo"));
	                reclamo.setIdPrioridad(rs.getLong("id_prioridad"));
					reclamo.setDesPrioridad(rs.getString("des_prioridad"));
	                reclamo.setIdCartera(rs.getLong("id_cartera"));
	                reclamo.setFecIngreso(Utils.formateaFecha(rs.getString("fec_ingreso")));
	                reclamo.setGlosa(rs.getString("glosa"));
	                reclamo.setAdjunto(rs.getString("adjunto"));
	                reclamo.setObservaciones(rs.getString("observaciones"));
	                reclamo.setIdEstado(Utils.stringToNum(rs.getString("id_estado")));
					reclamo.setDesEstado(rs.getString("des_estado"));
	                reclamo.setResponsableIngreso(rs.getString("responsable_ingreso"));
	                reclamo.setResponsableActual(rs.getString("responsable_actual"));
	                reclamo.setDiasBandeja(rs.getString("dias_bandeja") );
	                reclamo.setDiasSistema(rs.getString("dias_sistema") );
	                reclamo.setCodMedio(rs.getString("cod_medio_respuesta"));
					reclamo.setDesMedio(rs.getString("des_medio_respuesta"));
	                reclamo.setFecRespuesta(Utils.formateaFecha(rs.getString("fec_respuesta")));
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
			log.info(reclamo.getEmailBody());
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_reclamo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");

			cStmt.setString(1, reclamo.getNumAdherente());
			cStmt.setString(2, reclamo.getNombreSolicitante());
			cStmt.setString(3, reclamo.getEmailSolicitante());
			cStmt.setString(4, reclamo.getFonoSolicitante());
			cStmt.setString(5, reclamo.getRegionSolicitante());
			cStmt.setLong(6, reclamo.getIdTipo());
			cStmt.setLong(7, reclamo.getIdMotivo());
			cStmt.setLong(8, reclamo.getIdPrioridad());
			cStmt.setLong(9, reclamo.getIdCartera());
			cStmt.setDate(10, Utils.stringToDate(reclamo.getFecIngreso()));
			cStmt.setString(11, reclamo.getGlosa());
			cStmt.setString(12, reclamo.getAdjunto());
			cStmt.setString(13, reclamo.getObservaciones());
			cStmt.setLong(14, reclamo.getIdEstado());
			cStmt.setString(15, reclamo.getResponsableIngreso());
			cStmt.setString(16, reclamo.getResponsableActual());
			cStmt.setString(17, reclamo.getDiasBandeja());
			cStmt.setString(18, reclamo.getDiasSistema());
			cStmt.setString(19, reclamo.getCodMedio());
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
		
		log.info(reclamo);
		mapaSalida.put("reclamo", reclamo);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> cargarReclamo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		long idReclamo = 0;
		Reclamo reclamo = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Cargar reclamo");

			idReclamo = Long.parseLong((String)mapaEntrada.get("idReclamo"));
			
			log.info("ID reclamo: "+idReclamo);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call cargar_reclamo(?,?,?,?) }");
			cStmt.setLong(1, idReclamo);
			cStmt.registerOutParameter(2, Types.OTHER);// documento$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
			
			while (rs.next()) {
				reclamo = new Reclamo();
				reclamo.setIdReclamo(rs.getLong("id_reclamo"));
				reclamo.setNumAdherente(rs.getString("num_adherente"));
                reclamo.setNombreSolicitante(rs.getString("nombre_solicitante") );
                reclamo.setEmailSolicitante(rs.getString("email_solicitante") );
                reclamo.setFonoSolicitante(rs.getString("fono_solicitante") );
                reclamo.setRegionSolicitante(rs.getString("region_solicitante") );
                reclamo.setIdTipo(Long.parseLong(rs.getString("id_tipo")));
                reclamo.setIdMotivo(Utils.stringToNum(rs.getString("id_motivo")));
                reclamo.setIdPrioridad(rs.getLong("id_prioridad"));
                reclamo.setIdCartera(Utils.stringToNum(rs.getString("id_cartera")));
                reclamo.setFecIngreso(Utils.formateaFecha(rs.getString("fec_ingreso")));
                reclamo.setGlosa(rs.getString("glosa"));
                reclamo.setAdjunto(rs.getString("adjunto"));
                reclamo.setObservaciones(rs.getString("observaciones"));
                reclamo.setIdEstado(Utils.stringToNum(rs.getString("id_estado")));
                reclamo.setResponsableIngreso(rs.getString("responsable_ingreso"));
                reclamo.setResponsableActual(rs.getString("responsable_actual"));
                reclamo.setDiasBandeja(rs.getString("dias_bandeja") );
                reclamo.setDiasSistema(rs.getString("dias_sistema") );
                reclamo.setCodMedio(rs.getString("cod_medio_respuesta"));
                reclamo.setFecRespuesta(Utils.formateaFecha(rs.getString("fec_respuesta")));
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

		mapaSalida.put("reclamo",reclamo);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}

	public Map<String, Object> modificarReclamo(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Reclamo reclamo = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Modificar reclamos");
	
			reclamo = (Reclamo)mapaEntrada.get("reclamo");
			
			mapaSalida = new HashMap<String, Object>();
	
			dbConeccion = interacDS.getConnection();
	
			cStmt = dbConeccion.prepareCall("{ call modificar_reclamo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)	}");
	
			cStmt.setInt(1, (int) reclamo.getIdReclamo());
			cStmt.setString(2, reclamo.getNumAdherente());
			cStmt.setString(3, reclamo.getNombreSolicitante());
			cStmt.setString(4, reclamo.getEmailSolicitante());
			cStmt.setString(5, reclamo.getFonoSolicitante());
			cStmt.setString(6, reclamo.getRegionSolicitante());
			cStmt.setLong(7, reclamo.getIdTipo());
			cStmt.setLong(8, reclamo.getIdReclamo());
			cStmt.setLong(9, reclamo.getIdPrioridad());
			cStmt.setLong(10, reclamo.getIdCartera());
			cStmt.setDate(11, Utils.stringToDate(reclamo.getFecIngreso()));
			cStmt.setString(12, reclamo.getGlosa());
			cStmt.setString(13, reclamo.getAdjunto());
			cStmt.setString(14, reclamo.getObservaciones());
			cStmt.setLong(15, reclamo.getIdEstado());
			cStmt.setString(16, reclamo.getResponsableIngreso());
			cStmt.setString(17, reclamo.getResponsableActual());
			cStmt.setString(18, reclamo.getDiasBandeja());
			cStmt.setString(19, reclamo.getDiasSistema());
			cStmt.setString(20, reclamo.getCodMedio());
			cStmt.setDate(21, Utils.stringToDate(reclamo.getFecRespuesta()));
			
			cStmt.registerOutParameter(22, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(23, Types.VARCHAR);// msjerror$
	
			
			cStmt.execute();
			
			numError = cStmt.getString(22);
			msjError = cStmt.getString(23);
			
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

	public Map<String, Object> eliminarReclamo(Map<String, Object> mapaEntrada) {
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Error error = new Error();
		long idReclamo = 0;
		
		try {
			log.info("Eliminar reclamo");

			idReclamo = (Long)mapaEntrada.get("idReclamo"); // recupero el Long idReclamo desde el servlet
			
			log.info("ID reclamo: "+idReclamo);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_reclamo(?,?,?) }");

			cStmt.setLong(1, idReclamo); 
			cStmt.registerOutParameter(2, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(3, Types.VARCHAR);// msjerror$

			
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
		ArrayList<Tipo> listaTipos = null;
		ArrayList<Motivo> listaMotivos = null;
		ArrayList<Prioridad> listaPrioridades = null;
		ArrayList<Estado> listaEstados = null;
		ArrayList<Medio> listaMedios = null;
		ArrayList<Cartera> listaCarteras = null;
		ArrayList<Region> listaRegiones = null;
		Tipo tipo = null;
		Motivo motivo = null;
		Prioridad prioridad = null;
		Estado estado = null;
		Medio medio = null;
		Cartera cartera = null;
		Region region = null;
		
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Parametros");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_par_reclamos(?,?,?,?,?,?,?,?,?) }");
			
			cStmt.registerOutParameter(1, Types.OTHER);// cursor$
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.OTHER);// cursor$
			cStmt.registerOutParameter(4, Types.OTHER);// cursor$
			cStmt.registerOutParameter(5, Types.OTHER);// cursor$
			cStmt.registerOutParameter(6, Types.OTHER);// cursor$
			cStmt.registerOutParameter(7, Types.OTHER);// cursos$
			cStmt.registerOutParameter(8, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(9, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			
			ResultSet rsTipos = (ResultSet) cStmt.getObject(1);
			ResultSet rsMotivos = (ResultSet) cStmt.getObject(2);
			ResultSet rsPrioridades = (ResultSet) cStmt.getObject(3);
			ResultSet rsCarteras = (ResultSet) cStmt.getObject(4);
			ResultSet rsEstados = (ResultSet) cStmt.getObject(5);
			ResultSet rsMedios = (ResultSet) cStmt.getObject(6);
			ResultSet rsRegiones = (ResultSet) cStmt.getObject(7);
			numError = cStmt.getString(8);
			msjError = cStmt.getString(9);
			
			listaRegiones = new ArrayList<Region>();
			
			if(rsRegiones != null){
				while (rsRegiones.next()){
					region = new Region();
					region.setCodRegion(rsRegiones.getString("cod_region"));
					region.setDesRegion(rsRegiones.getString("des_region"));
					listaRegiones.add(region);
				}
				rsRegiones.close();
			}
			
			listaTipos = new ArrayList<Tipo>();

			log.info("++++++++++++++++++");
			
			if(rsTipos !=null){
				while (rsTipos.next()) {
					tipo = new Tipo();
					tipo.setIdTipo(Long.parseLong(rsTipos.getString("id_tipo")));
					tipo.setDesTipo(rsTipos.getString("des_tipo"));
					listaTipos.add(tipo);
				}
				rsTipos.close();
			}
		
			listaMotivos = new ArrayList<Motivo>();

			if(rsMotivos !=null){
				while (rsMotivos.next()) {
					motivo = new Motivo();
					motivo.setIdMotivo(Utils.stringToNum(rsMotivos.getString("id_motivo")));
					motivo.setDesMotivo(rsMotivos.getString("des_motivo"));
					listaMotivos.add(motivo);
				}
				rsMotivos.close();
			}
			
			listaPrioridades = new ArrayList<Prioridad>();

			if(rsPrioridades !=null){
				while (rsPrioridades.next()) {
					prioridad = new Prioridad();
					prioridad.setIdPrioridad(rsPrioridades.getLong("id_prioridad"));
					prioridad.setDesPrioridad(rsPrioridades.getString("des_prioridad"));
					listaPrioridades.add(prioridad);
				}
				rsPrioridades.close();
			}
			
			listaCarteras = new ArrayList<Cartera>();
			
			if(rsCarteras != null){
				while (rsCarteras.next()){
					cartera = new Cartera();
					cartera.setIdCartera(Utils.stringToNum(rsCarteras.getString("id_cartera")));
					cartera.setDesCartera(rsCarteras.getString("des_cartera"));
					listaCarteras.add(cartera);
				}
				rsCarteras.close();
			}
			
			listaEstados = new ArrayList<Estado>();
			
			if(rsEstados != null){
				while (rsEstados.next()){
					estado = new Estado();
					estado.setIdEstado(rsEstados.getLong("id_estado"));
					estado.setDesEstado(rsEstados.getString("des_estado"));
					listaEstados.add(estado);
				}
				rsEstados.close();
			}
			
			listaMedios = new ArrayList<Medio>();
			
			if(rsMedios != null){
				while (rsMedios.next()){
					medio = new Medio();
					medio.setDesMedio(rsMedios.getString("des_medio_respuesta"));
					medio.setCodMedio(rsMedios.getString("cod_medio_respuesta"));
					listaMedios.add(medio);
				}
				rsMedios.close();
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
		
		mapaSalida.put("listaTipos", listaTipos);
		mapaSalida.put("listaMotivos", listaMotivos);
		mapaSalida.put("listaPrioridades", listaPrioridades);
		mapaSalida.put("listaCarteras", listaCarteras);
		mapaSalida.put("listaEstados", listaEstados);
		mapaSalida.put("listaMedios", listaMedios);
		mapaSalida.put("listaRegiones", listaRegiones);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}
	
	public Map<String, Object> agregarEmpresa(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Error error = new Error();
		Map<String, Object> mapaSalida = null;
		Empresa empresa = new Empresa();

		try {
			log.info("Agregar Empresa");
			
			empresa = (Empresa)mapaEntrada.get("empresa");

			log.info("nombre:" + empresa.getNombre());
			log.info("num_adherente: " + empresa.getNumAdherente());
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_empresa(?,?,?,?) }");
			
			cStmt.setString(1, empresa.getNumAdherente());// cursor$
			cStmt.setString(2, empresa.getNombre());// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
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
		String numAdherente = null;
		
		Error error = new Error();
		
		try {
			log.info("Cargar empresas");
						
			numAdherente = (String)mapaEntrada.get("numAdherente");
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call cargar_empresa(?,?,?,?) }");
			cStmt.setString(1, numAdherente);
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
				empresa.setNumAdherente(rsEmpresa.getString("num_adherente"));
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

			empresa = (Empresa)mapaEntrada.get("empresa");
			
			cStmt = dbConeccion.prepareCall("{ call buscar_empresas(?,?,?,?,?) }");
			
			cStmt.setString(1, empresa.getNombre());
			cStmt.setString(2, empresa.getNumAdherente());
			cStmt.registerOutParameter(3, Types.OTHER);// cursor$
			cStmt.registerOutParameter(4, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(5, Types.VARCHAR);// msjerror$

			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(3);
			error.setNumError(cStmt.getString(4));
			error.setMsjError(cStmt.getString(5));
		
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
		String numAdherente = "";
		
		Error error = new Error();
		
		try {
			log.info("Eliminar usuario");

			numAdherente = (String)mapaEntrada.get("numAdherente");
			
			log.info("Número de adherente: " + numAdherente);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call eliminar_empresa(?,?,?) }");
			cStmt.setString(1, numAdherente);
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
	
	public Map<String, Object> subirArchivo(Map<String, Object> mapaEntrada){
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Error error = new Error();
		String path = (String)mapaEntrada.get("path");
		String[] ficheros = (String[])mapaEntrada.get("ficheros");		
		try {
			log.info("Subir Archivo");
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			for(int i=0; i < ficheros.length; i++){
				cStmt = dbConeccion.prepareCall("{ call subir_archivo(?,?,?,?) }");
				cStmt.setString(1, path);
				cStmt.setString(2, ficheros[i]);
				cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
				cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$
	
				cStmt.execute();
				
				error.setNumError(cStmt.getString(3));
				error.setMsjError(cStmt.getString(4));	
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
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> recuperarUsername(Map<String, Object> mapaEntrada){
		Map<String, Object> mapaSalida = null;
		CallableStatement cStmt = null;
		Error error = new Error();
		String email = (String)mapaEntrada.get("email");
		
		try {
			log.info("Verificar E-Mail");
			
			mapaSalida = new HashMap<String, Object>();
			dbConeccion = interacDS.getConnection();
			
			log.info("validar email, "+email);
			cStmt = dbConeccion.prepareCall("{ call validar_email(?,?,?,?,?) }");
			cStmt.setString(1, email);
			cStmt.registerOutParameter(2, Types.VARCHAR);// user?$
			cStmt.registerOutParameter(3, Types.BOOLEAN);// esvalido?$
			cStmt.registerOutParameter(4, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(5, Types.VARCHAR);// msjerror$
			cStmt.execute();
			
			error.setNumError(cStmt.getString(4));
			error.setMsjError(cStmt.getString(5));
			
			if (error.getNumError().equals("0")) {
				mapaSalida.put("user",cStmt.getString(2));
				mapaSalida.put("email", email);
				mapaSalida.put("valido", true);
				mapaSalida.put("error",error);
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
		return mapaSalida;
	}
	
	public Map<String, Object> recuperarContrasena(Map<String, Object> mapaEntrada){
		Map<String, Object> mapaSalida = null;
		CallableStatement cStmt = null;
		Error error = new Error();
		String email = (String)mapaEntrada.get("email");
		try {
			log.info("Verificar E-Mail");
			
			mapaSalida = new HashMap<String, Object>();
			dbConeccion = interacDS.getConnection();
			
			cStmt = dbConeccion.prepareCall("{ call validar_usuario(?,?,?,?,?) }");
			log.info("validar usuario, "+(String)mapaEntrada.get("usuario"));
			cStmt.setString(1, (String)mapaEntrada.get("usuario"));
			cStmt.registerOutParameter(2, Types.INTEGER);// id?$
			cStmt.registerOutParameter(3, Types.VARCHAR);// email?$
			cStmt.registerOutParameter(4, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(5, Types.VARCHAR);// msjerror$
			cStmt.execute();
			email = cStmt.getString(3);
			
			error.setNumError(cStmt.getString(4));
			error.setMsjError(cStmt.getString(5));
			
			if (error.getNumError().equals("0")) {
				mapaSalida.put("id",cStmt.getInt(2));
				mapaSalida.put("email", email);
				mapaSalida.put("valido", true);
				mapaSalida.put("error",error);
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
		return mapaSalida;
	}

	public Map<String, Object> actualizarContrasena(Map<String, Object> mapaEntrada){
		Map<String, Object> mapaSalida = null;
		CallableStatement cStmt = null;
		Error error = new Error();
		try {
			log.info("Actualizar contraseña");
			mapaSalida = new HashMap<String, Object>();
			dbConeccion = interacDS.getConnection();
			
			cStmt = dbConeccion.prepareCall("{ call modificar_contrasena(?,?,?,?) }");
			log.info("validar usuario, id:"+(String)mapaEntrada.get("id"));
			cStmt.setInt(1, Integer.parseInt((String)(mapaEntrada.get("id"))));
			cStmt.setString(2, (String)mapaEntrada.get("contrasena"));
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$
			cStmt.execute();
			
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
			
			if (error.getNumError().equals("0")) {
				mapaSalida.put("error",error);
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
		
		
		return mapaSalida;
	}
	
	public Map<String, Object> buscarTipos(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Tipo> listaTipos = null;
		Tipo tipo = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Tipos");
			
			tipo = (Tipo)mapaEntrada.get("tipo");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_tipos(?,?,?,?) }");
			
			cStmt.setString(1, tipo.getDesTipo());
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
		
			listaTipos = new ArrayList<Tipo>();

			if(rs !=null){
				while (rs.next()) {
					tipo = new Tipo();
					tipo.setIdTipo(Long.parseLong(rs.getString("id_tipo")));
					log.info("idTipo: "+ tipo.getIdTipo());
					tipo.setDesTipo(rs.getString("des_tipo"));
					log.info("desTipo: "+ tipo.getDesTipo());
					listaTipos.add(tipo);
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
		
		mapaSalida.put("listaTipos",listaTipos);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}

	public Map<String, Object> buscarMedios(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Medio> listaMedios = null;
		Medio medio = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Medios");
			
			medio = (Medio)mapaEntrada.get("medio");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_medios(?,?,?,?) }");
			
			cStmt.setString(1, medio.getDesMedio());
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
		
			listaMedios = new ArrayList<Medio>();

			if(rs !=null){
				while (rs.next()) {
					medio = new Medio();
					medio.setCodMedio(rs.getString("cod_medio_respuesta"));
					log.info("codMedio: "+ medio.getCodMedio());
					medio.setDesMedio(rs.getString("des_medio_respuesta"));
					log.info("desMedio: "+ medio.getDesMedio());
					listaMedios.add(medio);
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
		
		mapaSalida.put("listaMedios",listaMedios);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}
	
	public Map<String, Object> buscarMotivos(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Motivo> listaMotivos = null;
		Motivo motivo = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Motivos");
			
			motivo = (Motivo)mapaEntrada.get("motivo");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_motivos(?,?,?,?) }");
			
			cStmt.setString(1, motivo.getDesMotivo());
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
		
			listaMotivos = new ArrayList<Motivo>();

			if(rs !=null){
				while (rs.next()) {
					motivo = new Motivo();
					
					motivo.setIdMotivo(Utils.stringToNum(rs.getString("id_motivo")));
					log.info("codMedio: "+ motivo.getIdMotivo());
					motivo.setDesMotivo(rs.getString("des_motivo"));
					log.info("desMedio: "+ motivo.getDesMotivo());
					listaMotivos.add(motivo);
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
		
		mapaSalida.put("listaMotivos",listaMotivos);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}
	
	/*  Prioridades */
	public Map<String, Object> agregarPrioridad(Map<String, Object> mapaEntrada){
		CallableStatement cStmt = null;
		Error error = new Error();
		Map<String, Object> mapaSalida = null;
		Prioridad p = new Prioridad();
		
		try {
			p = (Prioridad)mapaEntrada.get("prioridad");
			mapaSalida = new HashMap<String, Object>();
			
			dbConeccion = interacDS.getConnection();
			cStmt = dbConeccion.prepareCall("{ call agregar_prioridad(?,?,?) }");
			cStmt.setString(1, p.getDesPrioridad());
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

		log.info("Num Error: "+ error.getNumError());
		log.info("Msj Error: "+ error.getMsjError());

		mapaSalida.put("prioridad", p);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
public Map<String, Object> cargarPrioridad(Map<String, Object> mapaEntrada) {
		
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Prioridad p = new Prioridad();
		
		Error error = new Error();
		
		try {
			log.info("Cargar prioridades");
						
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();
			
			cStmt = dbConeccion.prepareCall("{ call cargar_prioridad(?,?,?,?) }");
			cStmt.setLong(1, (Long)mapaEntrada.get("idPrioridad")); 
			cStmt.registerOutParameter(2, Types.OTHER);// carteras$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			
			ResultSet rsCartera = (ResultSet) cStmt.getObject(2);
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
						
			while (rsCartera.next()) {
				p = new Prioridad();
				p.setIdPrioridad(rsCartera.getLong("id_prioridad"));
				p.setDesPrioridad(rsCartera.getString("des_prioridad"));
				log.info(p.getPrioridad());
			}
			
			rsCartera.close();			

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
		mapaSalida.put("prioridad",p);
		mapaSalida.put("error", error);
		
		return mapaSalida;
	}
	
	public Map<String, Object> eliminarPrioridad(Map<String, Object> mapaEntrada){
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_prioridad;
		Error error = new Error();
		
		try {
			log.info("Eliminar Prioridad");
			id_prioridad = (Long)mapaEntrada.get("idPrioridad");
			log.info("id_prioridad: "+ id_prioridad);
			mapaSalida = new HashMap<String, Object>();
			
			dbConeccion = interacDS.getConnection();
			cStmt = dbConeccion.prepareCall("{ call eliminar_prioridad(?,?,?) }");
			cStmt.setLong(1, id_prioridad);
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
	
	public Map<String, Object> buscarPrioridades(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Prioridad> listaPrioridades = null;
		Prioridad p = null;
		Error error = new Error();
		try {
			log.info("Buscar Prioridades");
			p = (Prioridad)mapaEntrada.get("prioridad");
			mapaSalida = new HashMap<String, Object>();
			dbConeccion = interacDS.getConnection();
			cStmt = dbConeccion.prepareCall("{ call buscar_prioridades(?,?,?,?) }");
			cStmt.setString(1, p.getDesPrioridad());
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(2);
			error.setNumError(cStmt.getString(3));
			error.setMsjError(cStmt.getString(4));
		
			listaPrioridades = new ArrayList<Prioridad>();

			if(rs !=null){
				while (rs.next()) {
					p= new Prioridad();
					p.setIdPrioridad(rs.getLong("id_prioridad"));
					p.setDesPrioridad(rs.getString("des_prioridad"));
					listaPrioridades.add(p);
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

		log.info("Num Error: "+error.getNumError());
		log.info("Msj Error: "+error.getMsjError());
		
		mapaSalida.put("listaPrioridades",listaPrioridades);
		mapaSalida.put("error", error);

		return mapaSalida;
	}
	/****************estados************************/
	
	
	public Map<String, Object> agregarEstado(Map<String, Object> mapaEntrada) {
		
		CallableStatement cStmt = null;
		Error error = new Error();
		Map<String, Object> mapaSalida = null;
		Estado estado = new Estado();

		try {
			log.info("Buscar Produtos");
			
			estado = (Estado)mapaEntrada.get("estado");
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call agregar_estado(?,?,?) }"); //cambiar segun SP
			
			cStmt.setString(1, estado.getDesEstado());// cursor$			
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

		log.info("Num Error: "+ error.getNumError());
		log.info("Msj Error: "+ error.getMsjError());

		mapaSalida.put("estado", estado);
		mapaSalida.put("error", error);
		
		return mapaSalida;		
		
		
	}

	public Map<String, Object> cargarEstado(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_estado;
		Estado estado = null;
		String numError = "0";
		String msjError = "";
		
		try {
			log.info("Cargar estado");

			id_estado = (Long)mapaEntrada.get("idEstado");
			
			log.info("id_estado: "+id_estado);
			
			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call cargar_estado(?,?,?,?) }");
			cStmt.setLong(1, id_estado);
			cStmt.registerOutParameter(2, Types.OTHER);// documento$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			cStmt.execute();
			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
			
			while (rs.next()) {
				
				estado= new Estado();
				estado.setIdEstado(rs.getLong("id_estado"));
				estado.setDesEstado(rs.getString("des_estado"));
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
		mapaSalida.put("estado",estado);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);
		
		return mapaSalida;
	}

	
	public Map<String, Object> modificarEstado(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = new HashMap<String, Object>();;
		Estado estado = null;
		Error error = new Error();

		try {
			log.info("Modificar Estado");
			
			estado = (Estado)mapaEntrada.get("estado");

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_estado(?,?,?,?) }");
			cStmt.setLong(1,estado.getIdEstado());
			cStmt.setString(2,estado.getDesEstado());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$
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
		mapaSalida.put("error",error);
		
		return mapaSalida;
	}

	public Map<String, Object> eliminarEstado(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Long id_estado;
		Error error = new Error();
		
		try {
			log.info("Eliminar cartera");
			id_estado = (Long)mapaEntrada.get("idEstado");
			log.info("id_estado: "+id_estado);
			mapaSalida = new HashMap<String, Object>();
			
			dbConeccion = interacDS.getConnection();
			cStmt = dbConeccion.prepareCall("{ call eliminar_Estado(?,?,?) }");
			cStmt.setLong(1, id_estado);
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


	public Map<String, Object> buscarEstados(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		ArrayList<Estado> listaEstados = null;
		Estado estado = null;
		String numError = "0";
		String msjError = "";

		try {
			log.info("Buscar Estados");
			
			estado = (Estado)mapaEntrada.get("estado");

			mapaSalida = new HashMap<String, Object>();

			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call buscar_estados(?,?,?,?) }");
			
		
			cStmt.setString(1,estado.getDesEstado());
			cStmt.registerOutParameter(2, Types.OTHER);// cursor$
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$

			
			cStmt.execute();

			ResultSet rs = (ResultSet) cStmt.getObject(2);
			numError = cStmt.getString(3);
			msjError = cStmt.getString(4);
		
			listaEstados = new ArrayList<Estado>();

			if(rs !=null){
				while (rs.next()) {
					estado = new Estado();
					estado.setIdEstado(rs.getLong("id_estado"));
					estado.setDesEstado(rs.getString("des_estado"));
					log.info(estado.getEstado());
					listaEstados.add(estado);
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
		
		mapaSalida.put("listaEstados",listaEstados);
		mapaSalida.put("numError", numError);
		mapaSalida.put("msjError", msjError);

		return mapaSalida;
	}

	public Map<String, Object> modificarPrioridad(Map<String, Object> mapaEntrada) {
		CallableStatement cStmt = null;
		Map<String, Object> mapaSalida = null;
		Prioridad p = null;
		Error error = new Error();

		try {
			log.info("Modificar prioridad");
			
			p = (Prioridad)mapaEntrada.get("prioridad");

			mapaSalida = new HashMap<String, Object>();

			log.info(p.getPrioridad());
			
			dbConeccion = interacDS.getConnection();

			cStmt = dbConeccion.prepareCall("{ call modificar_prioridad(?,?,?,?) }");
			cStmt.setLong(1,p.getIdPrioridad());
			cStmt.setString(2,p.getDesPrioridad());
			cStmt.registerOutParameter(3, Types.VARCHAR);// numerror$
			cStmt.registerOutParameter(4, Types.VARCHAR);// msjerror$
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
	
	
	
/**********************************/	
}