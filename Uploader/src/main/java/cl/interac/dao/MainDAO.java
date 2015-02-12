package cl.interac.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Created by claudio on 11-02-15.
 */
public class MainDAO {
    protected static EntityManager em;

    public MainDAO() {
        this.crearUnidadPersistencia();
    }

    private void crearUnidadPersistencia() {
        if (em == null) {
            EntityManagerFactory factory = Persistence.createEntityManagerFactory("principal");
            em = factory.createEntityManager();
        }
    }
}
