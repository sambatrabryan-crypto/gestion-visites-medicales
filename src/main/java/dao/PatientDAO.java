package dao;
import model.Patient;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;
import java.util.List;
public class PatientDAO {
    public void save(Patient patient) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(patient);
            transaction.commit();
        } catch(Exception e) {
            if(transaction != null)
                transaction.rollback();
            e.printStackTrace();
        }
    }
    public void update(Patient patient) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(patient);
            transaction.commit();
        } catch(Exception e) {
            if(transaction != null)
                transaction.rollback();
            e.printStackTrace();
        }
    }
    public boolean delete(int id) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Patient patient = session.get(Patient.class,id);
            if(patient != null)
                session.delete(patient);
            transaction.commit();
            return true;
        } catch(Exception e) {
            if(transaction != null)
                transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }
    public Patient findById(int id) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Patient.class,id);
        }
    }
    public List<Patient> findAll() {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "from Patient",
                    Patient.class
            ).list();
        }
    }
    public List<Patient> findByNom(String nom) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Patient> query =
                    session.createQuery(
                            "from Patient where nom like :nom",
                            Patient.class
                    );
            query.setParameter("nom", "%" + nom + "%");
            return query.list();
        }
    }

    public List<Patient> findByCodeOrNom(String terme) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            String like = "%" + terme.toLowerCase() + "%";
            Query<Patient> query;
            try {
                int code = Integer.parseInt(terme);
                query = session.createQuery(
                        "from Patient where codepat = :code or lower(nom) like :terme or lower(prenom) like :terme",
                        Patient.class
                );
                query.setParameter("code", code);
                query.setParameter("terme", like);
            } catch (NumberFormatException e) {
                query = session.createQuery(
                        "from Patient where lower(nom) like :terme or lower(prenom) like :terme",
                        Patient.class
                );
                query.setParameter("terme", like);
            }
            return query.list();
        }
    }
}