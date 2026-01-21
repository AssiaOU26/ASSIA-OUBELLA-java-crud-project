package ma.tp.gestionlivres.model;

import java.sql.Date;

public class Livre {
    private int isbn;
    private String titre;
    private String description;
    private Date dateEdition;
    private String editeur;
    private Integer matricule;
    private Auteur auteur;

    // getters et setters
    public int getIsbn() { return isbn; }
    public void setIsbn(int isbn) { this.isbn = isbn; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getDateEdition() { return dateEdition; }
    public void setDateEdition(Date dateEdition) { this.dateEdition = dateEdition; }

    public String getEditeur() { return editeur; }
    public void setEditeur(String editeur) { this.editeur = editeur; }

    public Integer getMatricule() { return matricule; }
    public void setMatricule(Integer matricule) { this.matricule = matricule; }

    public Auteur getAuteur() { return auteur; }
    public void setAuteur(Auteur auteur) { this.auteur = auteur; }
}
