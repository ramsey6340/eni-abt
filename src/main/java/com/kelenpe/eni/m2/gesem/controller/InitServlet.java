package com.kelenpe.eni.m2.gesem.controller;

import com.kelenpe.eni.m2.gesem.dao.UserDAO;
import com.kelenpe.eni.m2.gesem.model.User;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener
public class InitServlet implements ServletContextListener {
    
    private ScheduledExecutorService scheduler;
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Utiliser un scheduler pour retry après un délai, permettant à JPA de créer les tables
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.schedule(() -> {
            initializeAdminUser();
        }, 2, TimeUnit.SECONDS);
    }
    
    private void initializeAdminUser() {
        UserDAO userDAO = null;
        int maxRetries = 5;
        int retryCount = 0;
        
        while (retryCount < maxRetries) {
            userDAO = new UserDAO();
            try {
                // Vérifier si l'utilisateur admin existe déjà
                User admin = userDAO.findByLogin("admin");
                if (admin == null) {
                    // Créer l'utilisateur administrateur par défaut
                    admin = new User("admin", "admin123", "admin");
                    userDAO.create(admin);
                    System.out.println("Utilisateur administrateur créé : admin / admin123");
                } else {
                    System.out.println("Utilisateur administrateur existe déjà");
                }
                break; // Succès, sortir de la boucle
            } catch (Exception e) {
                retryCount++;
                if (retryCount < maxRetries) {
                    System.out.println("Tentative " + retryCount + " échouée, nouvelle tentative dans 2 secondes...");
                    try {
                        Thread.sleep(2000); // Attendre 2 secondes avant de réessayer
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        break;
                    }
                } else {
                    System.err.println("Erreur lors de l'initialisation de l'utilisateur admin après " + maxRetries + " tentatives : " + e.getMessage());
                    e.printStackTrace();
                }
            } finally {
                if (userDAO != null) {
                    userDAO.close();
                }
            }
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            try {
                if (!scheduler.awaitTermination(5, TimeUnit.SECONDS)) {
                    scheduler.shutdownNow();
                }
            } catch (InterruptedException e) {
                scheduler.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
    }
}

