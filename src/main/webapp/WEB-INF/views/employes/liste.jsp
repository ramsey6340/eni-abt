<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kelenpe.eni.m2.gesem.model.Employe" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Employés - Gesem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Gesem - Gestion des Employés</h1>
            <div class="user-info">
                <span>Connecté en tant que : <%= session.getAttribute("userLogin") %></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Déconnexion</a>
            </div>
        </header>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/employes?action=add" class="btn btn-primary">Ajouter un employé</a>
        </div>
        
        <table class="table">
            <thead>
                <tr>
                    <!-- <th>ID</th> -->
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Poste</th>
                    <th>Email</th>
                    <th>Date d'embauche</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Employe> employes = (List<Employe>) request.getAttribute("employes");
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    if (employes != null && !employes.isEmpty()) {
                        for (Employe employe : employes) {
                %>
                    <tr>
                        <!-- <td><%= employe.getId() %></td> -->
                        <td><%= employe.getNom() %></td>
                        <td><%= employe.getPrenom() %></td>
                        <td><%= employe.getPoste() %></td>
                        <td><%= employe.getEmail() %></td>
                        <td><%= employe.getDateEmbauche().format(formatter) %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/employes?action=edit&id=<%= employe.getId() %>" 
                               class="btn btn-small btn-edit">Modifier</a>
                            <a href="${pageContext.request.contextPath}/employes?action=delete&id=<%= employe.getId() %>" 
                               class="btn btn-small btn-delete" 
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet employé ?')">Supprimer</a>
                        </td>
                    </tr>
                <% 
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="text-center">Aucun employé enregistré</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>

