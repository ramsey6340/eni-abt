package com.kelenpe.eni.m2.gesem.model;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "utilisateur")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", updatable = false, nullable = false, columnDefinition = "UUID")
    private UUID id;
    
    @Column(name = "login", nullable = false, unique = true)
    private String login;
    
    @Column(name = "password", nullable = false)
    private String password;
    
    @Column(name = "role", nullable = false)
    private String role;
    
    public User() {
    }
    
    public User(String login, String password, String role) {
        this.login = login;
        this.password = password;
        this.role = role;
    }
    
    public UUID getId() {
        return id;
    }
    
    public void setId(UUID id) {
        this.id = id;
    }
    
    public String getLogin() {
        return login;
    }
    
    public void setLogin(String login) {
        this.login = login;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
}

