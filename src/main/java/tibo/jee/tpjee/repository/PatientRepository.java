package tibo.jee.tpjee.repository;

import tibo.jee.tpjee.entity.Patient;

import java.util.List;

public class PatientRepository extends Repository<Patient> {

    public PatientRepository() {
        super(Patient.class);
    }

    public List<Patient> getByName(String name) {
        session = sessionFactory.openSession();
        List<Patient> patients = session.createQuery("SELECT p FROM Patient p WHERE p.firstName LIKE :name OR p.lastName LIKE :name", Patient.class)
                .setParameter("name", "%" + name + "%")
                .getResultList();
        session.close();

        return patients;
    }
}
