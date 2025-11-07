package com.kelenpe.eni.m2.gesem.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "employe")
public class Employe {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", updatable = false, nullable = false, columnDefinition = "UUID")
    private UUID id;
    
    @Column(name = "nom", nullable = false)
    private String nom;
    
    @Column(name = "prenom", nullable = false)
    private String prenom;
    
    @Column(name = "poste", nullable = false)
    private String poste;
    
    @Column(name = "email", nullable = false, unique = true)
    private String email;
    
    @Column(name = "date_embauche", nullable = false)
    private LocalDate dateEmbauche;
    
    public Employe() {
    }
    
    public Employe(String nom, String prenom, String poste, String email, LocalDate dateEmbauche) {
        this.nom = nom;
        this.prenom = prenom;
        this.poste = poste;
        this.email = email;
        this.dateEmbauche = dateEmbauche;
    }
    
    public UUID getId() {
        return id;
    }
    
    public void setId(UUID id) {
        this.id = id;
    }
    
    public String getNom() {
        return nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public String getPrenom() {
        return prenom;
    }
    
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }
    
    public String getPoste() {
        return poste;
    }
    
    public void setPoste(String poste) {
        this.poste = poste;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public LocalDate getDateEmbauche() {
        return dateEmbauche;
    }
    
    public void setDateEmbauche(LocalDate dateEmbauche) {
        this.dateEmbauche = dateEmbauche;
    }
}

