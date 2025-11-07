package com.kelenpe.eni.m2.gesem.dao;

import com.kelenpe.eni.m2.gesem.model.Employe;
import com.kelenpe.eni.m2.gesem.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.UUID;

public class EmployeDAO {
    
    private EntityManager entityManager;
    
    public EmployeDAO() {
        this.entityManager = JPAUtil.getEntityManager();
    }
    
    public EmployeDAO(EntityManager entityManager) {
        this.entityManager = entityManager;
    }
    
    public Employe findById(UUID id) {
        return entityManager.find(Employe.class, id);
    }
    
    public List<Employe> findAll() {
        TypedQuery<Employe> query = entityManager.createQuery(
            "SELECT e FROM Employe e ORDER BY e.nom, e.prenom", Employe.class);
        return query.getResultList();
    }
    
    public Employe findByEmail(String email) {
        TypedQuery<Employe> query = entityManager.createQuery(
            "SELECT e FROM Employe e WHERE e.email = :email", Employe.class);
        query.setParameter("email", email);
        List<Employe> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }
    
    public void create(Employe employe) {
        entityManager.getTransaction().begin();
        try {
            entityManager.persist(employe);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            throw e;
        }
    }
    
    public Employe update(Employe employe) {
        entityManager.getTransaction().begin();
        try {
            Employe updated = entityManager.merge(employe);
            entityManager.getTransaction().commit();
            return updated;
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            throw e;
        }
    }
    
    public void delete(UUID id) {
        entityManager.getTransaction().begin();
        try {
            Employe employe = findById(id);
            if (employe != null) {
                entityManager.remove(employe);
            }
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            throw e;
        }
    }
    
    public void close() {
        if (entityManager != null && entityManager.isOpen()) {
            entityManager.close();
        }
    }
}

