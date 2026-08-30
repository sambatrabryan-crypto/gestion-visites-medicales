package dao;

import model.Medecin;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class MedecinDAO {

    public void save(Medecin medecin) {

        Transaction transaction = null;

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            session.save(medecin);

            transaction.commit();

        } catch(Exception e) {

            if(transaction != null)
                transaction.rollback();

            e.printStackTrace();
        }
    }

    public void update(Medecin medecin) {

        Transaction transaction = null;

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            session.update(medecin);

            transaction.commit();

        } catch(Exception e) {

            if(transaction != null)
                transaction.rollback();

            e.printStackTrace();
        }
    }

    public void delete(int id) {

        Transaction transaction = null;

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            Medecin medecin = session.get(Medecin.class, id);

            if(medecin != null)
                session.delete(medecin);

            transaction.commit();

        } catch(Exception e) {

            if(transaction != null)
                transaction.rollback();

            e.printStackTrace();
        }
    }

    public Medecin findById(int id) {

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.get(Medecin.class, id);
        }
    }

    public List<Medecin> findAll() {

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.createQuery("from Medecin", Medecin.class).list();
        }
    }
}