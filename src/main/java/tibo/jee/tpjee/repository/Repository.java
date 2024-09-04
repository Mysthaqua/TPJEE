package tibo.jee.tpjee.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import tibo.jee.tpjee.util.SessionFactorySingleton;

import java.util.List;

public class Repository<T> {
    protected Class<T> clazz;
    protected final SessionFactory sessionFactory;
    protected Session session;

    public Repository(Class<T> clazz) {
        this.clazz = clazz;
        sessionFactory = SessionFactorySingleton.getSessionFactory();
    }

    public T merge(T entity) {
        try {
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            entity = session.merge(entity);
            transaction.commit();
            return entity;
        } catch (Exception e) {
            session.getTransaction().rollback();
            return null;
        } finally {
            session.close();
        }
    }

    public boolean remove(T entity) {
        try {
            session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();
            session.remove(entity);
            transaction.commit();
            return true;
        } catch (Exception e) {
            session.getTransaction().rollback();
            return false;
        } finally {
            session.close();
        }
    }

    public T get(int id) {
        session = sessionFactory.openSession();
        T entity = session.get(clazz, id);
        session.close();
        return entity;
    }

    public List<T> getAll() {
        session = sessionFactory.openSession();
        List<T> entities = session.createQuery(String.format("from %s", clazz.getSimpleName()), clazz).list();
        session.close();
        return entities;
    }
}
