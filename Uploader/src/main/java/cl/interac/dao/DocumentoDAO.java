package cl.interac.dao;

import cl.interac.entidades.Documento;

/**
 * Created by claudio on 11-02-15.
 */
public class DocumentoDAO extends MainDAO {
    public void guardarArchivo(Documento documento) {
        if (documento.getIdDocumento() == null) em.persist(documento);
        else em.merge(documento);
    }
}
