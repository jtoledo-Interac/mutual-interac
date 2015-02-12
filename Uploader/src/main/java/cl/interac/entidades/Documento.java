package cl.interac.entidades;

import javax.persistence.*;
import java.math.BigInteger;
import java.util.Date;

/**
 * Created by claudio on 12-02-15.
 */
@Entity
public class Documento {
    private Integer idDocumento;
    private String nombre;
    private String numFolio;
    private String numAdherente;
    private String descripcion;
    private Integer idCartera;
    private BigInteger idProducto;
    private String codArea;
    private Date fecCreacion;
    private String ruta;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_documento", nullable = false, insertable = true, updatable = true)
    public Integer getIdDocumento() {
        return idDocumento;
    }

    public void setIdDocumento(Integer idDocumento) {
        this.idDocumento = idDocumento;
    }

    @Basic
    @Column(name = "nombre", nullable = true, insertable = true, updatable = true, length = 100)
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Basic
    @Column(name = "num_folio", nullable = true, insertable = true, updatable = true, length = 100)
    public String getNumFolio() {
        return numFolio;
    }

    public void setNumFolio(String numFolio) {
        this.numFolio = numFolio;
    }

    @Basic
    @Column(name = "num_adherente", nullable = true, insertable = true, updatable = true, length = 100)
    public String getNumAdherente() {
        return numAdherente;
    }

    public void setNumAdherente(String numAdherente) {
        this.numAdherente = numAdherente;
    }

    @Basic
    @Column(name = "descripcion", nullable = true, insertable = true, updatable = true, length = 1000)
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @Basic
    @Column(name = "cod_cartera", nullable = true, insertable = true, updatable = true, precision = 0)
    public Integer getIdCartera() {
        return idCartera;
    }

    public void setIdCartera(Integer idCartera) {
        this.idCartera = idCartera;
    }

    @Basic
    @Column(name = "id_producto", nullable = true, insertable = true, updatable = true, precision = 0)
    public BigInteger getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(BigInteger idProducto) {
        this.idProducto = idProducto;
    }

    @Basic
    @Column(name = "id_area", nullable = true, insertable = true, updatable = true, length = 100)
    public String getCodArea() {
        return codArea;
    }

    public void setCodArea(String codArea) {
        this.codArea = codArea;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "fec_creacion", nullable = true, insertable = true, updatable = true)
    public Date getFecCreacion() {
        return fecCreacion;
    }

    public void setFecCreacion(Date fecCreacion) {
        this.fecCreacion = fecCreacion;
    }

    @Basic
    @Column(name = "ruta", nullable = true, insertable = true, updatable = true, length = 200)
    public String getRuta() {
        return ruta;
    }

    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Documento documento = (Documento) o;

        if (this.getIdDocumento() == null || documento.getIdDocumento() == null) return false;
        else if (this.getIdDocumento().intValue() != documento.getIdDocumento().intValue()) return false;
        else return true;
    }

    @Override
    public int hashCode() {
        return idDocumento != null ? 31 * idDocumento.hashCode() : 0;
    }
}
