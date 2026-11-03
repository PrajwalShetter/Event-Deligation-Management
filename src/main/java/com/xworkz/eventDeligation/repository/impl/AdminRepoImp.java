package com.xworkz.eventDeligation.repository.impl;
import com.xworkz.eventDeligation.entity.AdminEntity;
import com.xworkz.eventDeligation.repository.AdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

@Repository
public class AdminRepoImp  implements AdminRepo {

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public boolean saveAdmin(AdminEntity adminEntity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            entityManager.getTransaction().begin();
            entityManager.persist(adminEntity);
            entityManager.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if(entityManager.getTransaction().isActive()){
                entityManager.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }finally{
            entityManager.close();
        }
    }

    @Override
    public AdminEntity findByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            AdminEntity admin = (AdminEntity) entityManager.createNamedQuery("findByEmail").setParameter("email",email).getSingleResult();
            return admin;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public AdminEntity findByPhone(String phone) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            AdminEntity admin = (AdminEntity) entityManager.createNamedQuery("findByPhone").setParameter("phone", phone).getSingleResult();
            return  admin;
        } catch (Exception e) {
            return  null;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateAdmin(AdminEntity adminEntity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            entityManager.getTransaction().begin();
            entityManager.merge(adminEntity);
            entityManager.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if(entityManager.getTransaction().isActive()){
                entityManager.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public AdminEntity findById(Integer id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        if (id == null) {
            return null;
        }
        return entityManager.find(AdminEntity.class, id);
    }
}
