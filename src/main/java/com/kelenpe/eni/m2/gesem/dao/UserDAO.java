package com.kelenpe.eni.m2.gesem.dao;

import com.kelenpe.eni.m2.gesem.model.User;
import com.kelenpe.eni.m2.gesem.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.UUID;

public class UserDAO {
    
    private EntityManager entityManager;
    
    public UserDAO() {
        this.entityManager = JPAUtil.getEntityManager();
    }
    
    public UserDAO(EntityManager entityManager) {
        this.entityManager = entityManager;
    }
    
    public User findById(UUID id) {
        return entityManager.find(User.class, id);
    }
    
    public User findByLogin(String login) {
        TypedQuery<User> query = entityManager.createQuery(
            "SELECT u FROM User u WHERE u.login = :login", User.class);
        query.setParameter("login", login);
        List<User> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }
    
    public User findByLoginAndPassword(String login, String password) {
        TypedQuery<User> query = entityManager.createQuery(
            "SELECT u FROM User u WHERE u.login = :login AND u.password = :password", User.class);
        query.setParameter("login", login);
        query.setParameter("password", password);
        List<User> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }
    
    public List<User> findAll() {
        TypedQuery<User> query = entityManager.createQuery(
            "SELECT u FROM User u", User.class);
        return query.getResultList();
    }
    
    public void create(User user) {
        entityManager.getTransaction().begin();
        try {
            entityManager.persist(user);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            throw e;
        }
    }
    
    public User update(User user) {
        entityManager.getTransaction().begin();
        try {
            User updated = entityManager.merge(user);
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
            User user = findById(id);
            if (user != null) {
                entityManager.remove(user);
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

