package com.xworkz.eventDeligation.repository.impl;

import com.xworkz.eventDeligation.entity.AdminLoginEntity;
import com.xworkz.eventDeligation.repository.AdminLoginRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

@Repository
public class AdminLoginRepoImpl  implements AdminLoginRepo {

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public boolean saveAdminLogin(AdminLoginEntity login) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            entityManager.getTransaction().begin();
            entityManager.persist(login);
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
}
