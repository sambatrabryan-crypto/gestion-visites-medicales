package dao;

import model.Visite;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class VisiteDAO {

    public void save(Visite visite) {

        Transaction transaction = null;

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            session.save(visite);

            transaction.commit();

        } catch(Exception e) {

            if(transaction != null)
                transaction.rollback();

            e.printStackTrace();
        }
    }

    public void update(Visite visite) {

        Transaction transaction = null;

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();

            session.update(visite);

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

            Visite visite = session.get(Visite.class,id);

            if(visite != null)
                session.delete(visite);

            transaction.commit();

        } catch(Exception e) {

            if(transaction != null)
                transaction.rollback();

            e.printStackTrace();
        }
    }

    public Visite findById(int id) {

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.get(Visite.class,id);
        }
    }

    public List<Visite> findAll() {

        try(Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.createQuery(
                    "from Visite",
                    Visite.class
            ).list();
        }
    }

    public int countByMedecin(int codemed) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = (Long) session.createQuery(
                    "select count(v) from Visite v where v.medecin.codemed = :id")
                    .setParameter("id", codemed)
                    .uniqueResult();
            return count.intValue();
        }
    }

    public int countByPatient(int codepat) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = (Long) session.createQuery(
                    "select count(v) from Visite v where v.patient.codepat = :id")
                    .setParameter("id", codepat)
                    .uniqueResult();
            return count.intValue();
        }
    }

    public void deleteByMedecin(int codemed) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.createQuery("delete from Visite where medecin.codemed = :id")
                    .setParameter("id", codemed)
                    .executeUpdate();
            transaction.commit();
        } catch(Exception e) {
            if(transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public void deleteByPatient(int codepat) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.createQuery("delete from Visite where patient.codepat = :id")
                    .setParameter("id", codepat)
                    .executeUpdate();
            transaction.commit();
        } catch(Exception e) {
            if(transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }
}