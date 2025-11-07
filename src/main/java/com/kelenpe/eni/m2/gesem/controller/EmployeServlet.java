package com.kelenpe.eni.m2.gesem.controller;

import com.kelenpe.eni.m2.gesem.dao.EmployeDAO;
import com.kelenpe.eni.m2.gesem.model.Employe;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.UUID;

@WebServlet(name = "EmployeServlet", value = "/employes")
public class EmployeServlet extends HttpServlet {
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        EmployeDAO employeDAO = new EmployeDAO();
        
        try {
            if (action == null || action.isEmpty()) {
                // Lister tous les employés
                request.setAttribute("employes", employeDAO.findAll());
                request.getRequestDispatcher("/WEB-INF/views/employes/liste.jsp").forward(request, response);
            } else if ("add".equals(action)) {
                // Afficher le formulaire d'ajout
                request.getRequestDispatcher("/WEB-INF/views/employes/formulaire.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                // Afficher le formulaire de modification
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    try {
                        UUID id = UUID.fromString(idStr);
                        Employe employe = employeDAO.findById(id);
                        if (employe != null) {
                            request.setAttribute("employe", employe);
                            request.setAttribute("action", "edit");
                            request.getRequestDispatcher("/WEB-INF/views/employes/formulaire.jsp").forward(request, response);
                        } else {
                            request.setAttribute("error", "Employé non trouvé");
                            request.setAttribute("employes", employeDAO.findAll());
                            request.getRequestDispatcher("/WEB-INF/views/employes/liste.jsp").forward(request, response);
                        }
                    } catch (IllegalArgumentException e) {
                        request.setAttribute("error", "ID invalide");
                        request.setAttribute("employes", employeDAO.findAll());
                        request.getRequestDispatcher("/WEB-INF/views/employes/liste.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "ID manquant");
                    request.setAttribute("employes", employeDAO.findAll());
                    request.getRequestDispatcher("/WEB-INF/views/employes/liste.jsp").forward(request, response);
                }
            } else if ("delete".equals(action)) {
                // Supprimer un employé
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    try {
                        UUID id = UUID.fromString(idStr);
                        employeDAO.delete(id);
                        request.setAttribute("success", "Employé supprimé avec succès");
                    } catch (Exception e) {
                        request.setAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
                    }
                }
                request.setAttribute("employes", employeDAO.findAll());
                request.getRequestDispatcher("/WEB-INF/views/employes/liste.jsp").forward(request, response);
            }
        } finally {
            employeDAO.close();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String poste = request.getParameter("poste");
        String email = request.getParameter("email");
        String dateEmbaucheStr = request.getParameter("dateEmbauche");
        
        // Validation des champs
        if (nom == null || prenom == null || poste == null || email == null || dateEmbaucheStr == null ||
            nom.trim().isEmpty() || prenom.trim().isEmpty() || poste.trim().isEmpty() || 
            email.trim().isEmpty() || dateEmbaucheStr.trim().isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires");
            if ("edit".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    try {
                        UUID id = UUID.fromString(idStr);
                        EmployeDAO employeDAO = new EmployeDAO();
                        try {
                            Employe employe = employeDAO.findById(id);
                            if (employe != null) {
                                request.setAttribute("employe", employe);
                            }
                        } finally {
                            employeDAO.close();
                        }
                    } catch (IllegalArgumentException e) {
                        // Ignore
                    }
                }
            }
            request.setAttribute("action", action);
            request.getRequestDispatcher("/WEB-INF/views/employes/formulaire.jsp").forward(request, response);
            return;
        }
        
        LocalDate dateEmbauche;
        try {
            dateEmbauche = LocalDate.parse(dateEmbaucheStr, DATE_FORMATTER);
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Format de date invalide (yyyy-MM-dd)");
            request.setAttribute("action", action);
            request.getRequestDispatcher("/WEB-INF/views/employes/formulaire.jsp").forward(request, response);
            return;
        }
        
        EmployeDAO employeDAO = new EmployeDAO();
        try {
            if ("add".equals(action)) {
                // Vérifier si l'email existe déjà
                Employe existing = employeDAO.findByEmail(email);
                if (existing != null) {
                    request.setAttribute("error", "Un employé avec cet email existe déjà");
                    request.setAttribute("action", "add");
                    request.getRequestDispatcher("/WEB-INF/views/employes/formulaire.jsp").forward(request, response);
                    return;
                }
                
                Employe employe = new Employe(nom.trim(), prenom.trim(), poste.trim(), email.trim(), dateEmbauche);
                employeDAO.create(employe);
                request.setAttribute("success", "Employé ajouté avec succès");
            } else if ("edit".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    try {
                        UUID id = UUID.fromString(idStr);
                        Employe employe = employeDAO.findById(id);
                        if (employe != null) {
                            // Vérifier si l'email existe déjà pour un autre employé
                            Employe existing = employeDAO.findByEmail(email);
                            if (existing != null && !existing.getId().equals(id)) {
                                request.setAttribute("error", "Un employé avec cet email existe déjà");
                                request.setAttribute("employe", employe);
                                request.setAttribute("action", "edit");
                                request.getRequestDispatcher("/WEB-INF/views/employes/formulaire.jsp").forward(request, response);
                                return;
                            }
                            
                            employe.setNom(nom.trim());
                            employe.setPrenom(prenom.trim());
                            employe.setPoste(poste.trim());
                            employe.setEmail(email.trim());
                            employe.setDateEmbauche(dateEmbauche);
                            employeDAO.update(employe);
                            request.setAttribute("success", "Employé modifié avec succès");
                        } else {
                            request.setAttribute("error", "Employé non trouvé");
                        }
                    } catch (IllegalArgumentException e) {
                        request.setAttribute("error", "ID invalide");
                    }
                } else {
                    request.setAttribute("error", "ID manquant");
                }
            }
            
            request.setAttribute("employes", employeDAO.findAll());
            request.getRequestDispatcher("/WEB-INF/views/employes/liste.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur : " + e.getMessage());
            request.setAttribute("action", action);
            request.getRequestDispatcher("/WEB-INF/views/employes/formulaire.jsp").forward(request, response);
        } finally {
            employeDAO.close();
        }
    }
}

