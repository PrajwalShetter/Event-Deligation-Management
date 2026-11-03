package com.xworkz.eventDeligation.repository.impl;

import com.xworkz.eventDeligation.constants.CompanyReviewStatus;
import com.xworkz.eventDeligation.entity.CompanyEntity;
import com.xworkz.eventDeligation.repository.CompanyRepo;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Repository
public class CompanyRepoImpl implements CompanyRepo {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public boolean saveCompany(CompanyEntity companyEntity) {
        entityManager.persist(companyEntity);
        return true;
    }

    @Override
    public CompanyEntity findByEmail(String email) {
        try {
            TypedQuery<CompanyEntity> query = entityManager.createQuery(
                    "SELECT c FROM CompanyEntity c WHERE c.email = :email",
                    CompanyEntity.class
            );
            query.setParameter("email", email);
            return query.getSingleResult();

        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public CompanyEntity findByContactNumber(String contactNumber) {
        try {
            TypedQuery<CompanyEntity> query = entityManager.createQuery(
                    "SELECT c FROM CompanyEntity c WHERE c.contactNumber = :contactNumber",
                    CompanyEntity.class
            );
            query.setParameter("contactNumber", contactNumber);
            return query.getSingleResult();

        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public CompanyEntity findByGstinNumber(String gstinNumber) {
        try {
            TypedQuery<CompanyEntity> query = entityManager.createQuery(
                    "SELECT c FROM CompanyEntity c WHERE c.gstinNumber = :gstinNumber",
                    CompanyEntity.class
            );
            query.setParameter("gstinNumber", gstinNumber);
            return query.getSingleResult();

        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public CompanyEntity findById(Integer id) {
        return entityManager.find(CompanyEntity.class, id);
    }

    @Override
    public CompanyEntity updateCompany(CompanyEntity companyEntity) {
        return entityManager.merge(companyEntity);
    }

    @Override
    public List<CompanyEntity> findAllCompanies() {
        TypedQuery<CompanyEntity> query = entityManager.createQuery(
                "SELECT c FROM CompanyEntity c",
                CompanyEntity.class
        );

        return query.getResultList();
    }

    @Override
    public List<CompanyEntity> findFilteredCompanies(String search, String status) {
        StringBuilder jpql = new StringBuilder("SELECT c FROM CompanyEntity c WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            jpql.append(" AND (LOWER(c.companyName) LIKE LOWER(:search) OR LOWER(c.email) LIKE LOWER(:search) OR c.contactNumber LIKE :search OR c.city LIKE :search)");
        }

        if (status != null && !status.trim().isEmpty()) {
            jpql.append(" AND c.reviewStatus = :statusEnum");
        }

        TypedQuery<CompanyEntity> query = entityManager.createQuery(jpql.toString(), CompanyEntity.class);

        if (search != null && !search.trim().isEmpty()) {
            query.setParameter("search", "%" + search.trim() + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            try {
                // Convert the incoming String parameter to your Enum type
                CompanyReviewStatus enumStatus = CompanyReviewStatus.valueOf(status.trim());
                query.setParameter("statusEnum", enumStatus);
            } catch (IllegalArgumentException e) {
                // Fallback if an invalid status string is passed
                query.setParameter("statusEnum", null);
            }
        }

        return query.getResultList();
    }

    @Override
    public CompanyEntity findByUpdateToken(String updateToken) {
        try {
            return entityManager.createQuery(
                            "SELECT c FROM CompanyEntity c WHERE c.updateToken = :token",
                            CompanyEntity.class)
                    .setParameter("token", updateToken)
                    .getSingleResult();

        } catch (NoResultException e) {
            return null;
        }

    }

    @Override
    public List<CompanyEntity> findCompaniesByPagination(int page, int size) {

        return entityManager.createQuery(
                        "SELECT c FROM CompanyEntity c ORDER BY c.id DESC",
                        CompanyEntity.class)
                .setFirstResult(page * size)
                .setMaxResults(size)
                .getResultList();
    }

    @Override
    public long countAllCompanies() {

        return entityManager.createQuery(
                        "SELECT COUNT(c) FROM CompanyEntity c",
                        Long.class)
                .getSingleResult();
    }

    @Override
    public List<CompanyEntity> findFilteredCompaniesByPagination(
            String search, String status, int page, int size) {

        StringBuilder jpql =
                new StringBuilder("SELECT c FROM CompanyEntity c WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            jpql.append(" AND (LOWER(c.companyName) LIKE :search " +
                    "OR LOWER(c.email) LIKE :search " +
                    "OR c.contactNumber LIKE :search " +
                    "OR LOWER(c.city) LIKE :search)");
        }

        if (status != null && !status.trim().isEmpty()) {
            jpql.append(" AND c.reviewStatus = :statusEnum");
        }

        jpql.append(" ORDER BY c.id DESC");

        TypedQuery<CompanyEntity> query =
                entityManager.createQuery(jpql.toString(), CompanyEntity.class);

        if (search != null && !search.trim().isEmpty()) {
            query.setParameter("search", "%" + search.trim().toLowerCase() + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            CompanyReviewStatus enumStatus =
                    CompanyReviewStatus.valueOf(status.trim().toUpperCase());

            query.setParameter("statusEnum", enumStatus);
        }

        return query.setFirstResult(page * size)
                .setMaxResults(size)
                .getResultList();
    }

    @Override
    public long countFilteredCompanies(String search, String status) {

        StringBuilder jpql =
                new StringBuilder("SELECT COUNT(c) FROM CompanyEntity c WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            jpql.append(" AND (LOWER(c.companyName) LIKE :search " +
                    "OR LOWER(c.email) LIKE :search " +
                    "OR c.contactNumber LIKE :search " +
                    "OR LOWER(c.city) LIKE :search)");
        }

        if (status != null && !status.trim().isEmpty()) {
            jpql.append(" AND c.reviewStatus = :statusEnum");
        }

        TypedQuery<Long> query =
                entityManager.createQuery(jpql.toString(), Long.class);

        if (search != null && !search.trim().isEmpty()) {
            query.setParameter("search", "%" + search.trim().toLowerCase() + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            CompanyReviewStatus enumStatus =
                    CompanyReviewStatus.valueOf(status.trim().toUpperCase());

            query.setParameter("statusEnum", enumStatus);
        }

        return query.getSingleResult();
    }
}
