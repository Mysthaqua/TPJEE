package tibo.jee.tpjee.util;

import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class SessionFactorySingleton {
    private static SessionFactory sessionFactory;

    public static synchronized SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try (StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build()) {
                sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
            }
        }
        return sessionFactory;
    }

    public static void close() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}
