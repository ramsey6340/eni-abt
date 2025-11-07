package com.kelenpe.eni.m2.gesem.controller;

import com.kelenpe.eni.m2.gesem.dao.UserDAO;
import com.kelenpe.eni.m2.gesem.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/employes");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        
        if (login == null || password == null || login.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.findByLoginAndPassword(login, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userLogin", user.getLogin());
                response.sendRedirect(request.getContextPath() + "/employes");
            } else {
                request.setAttribute("error", "Identifiants incorrects");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } finally {
            userDAO.close();
        }
    }
}

