<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.kelenpe.eni.m2.gesem.model.Employe" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("action") != null && "edit".equals(request.getAttribute("action")) ? "Modifier" : "Ajouter" %> un Employé - Gesem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Gesem - <%= request.getAttribute("action") != null && "edit".equals(request.getAttribute("action")) ? "Modifier" : "Ajouter" %> un Employé</h1>
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
        
        <div class="form-container">
            <form method="post" action="${pageContext.request.contextPath}/employes">
                <% 
                    String action = (String) request.getAttribute("action");
                    if (action == null) action = "add";
                    Employe employe = (Employe) request.getAttribute("employe");
                %>
                <input type="hidden" name="action" value="<%= action %>">
                <% if (employe != null) { %>
                    <input type="hidden" name="id" value="<%= employe.getId() %>">
                <% } %>
                
                <div class="form-group">
                    <label for="nom">Nom * :</label>
                    <input type="text" id="nom" name="nom" 
                           value="<%= employe != null ? employe.getNom() : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="prenom">Prénom * :</label>
                    <input type="text" id="prenom" name="prenom" 
                           value="<%= employe != null ? employe.getPrenom() : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="poste">Poste * :</label>
                    <input type="text" id="poste" name="poste" 
                           value="<%= employe != null ? employe.getPoste() : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email * :</label>
                    <input type="email" id="email" name="email" 
                           value="<%= employe != null ? employe.getEmail() : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="dateEmbauche">Date d'embauche * :</label>
                    <input type="date" id="dateEmbauche" name="dateEmbauche" 
                           value="<%= employe != null ? employe.getDateEmbauche().toString() : "" %>" required>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <%= "edit".equals(action) ? "Modifier" : "Ajouter" %>
                    </button>
                    <a href="${pageContext.request.contextPath}/employes" class="btn btn-secondary">Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>

