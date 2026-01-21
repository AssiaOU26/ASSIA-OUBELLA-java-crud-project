package ma.tp.gestionlivres.dao;

import ma.tp.gestionlivres.model.Livre;

import java.sql.Date;

public class TestLivreDAO {

    public static void main(String[] args) {

        LivreDAO dao = new LivreDAO();

        Livre l = new Livre();
        l.setIsbn(123456);
        l.setTitre("Livre test");
        l.setDescription("Insertion de test depuis TestLivreDAO");
        l.setDateEdition(Date.valueOf("2024-01-01"));
        l.setEditeur("ENI");
        l.setMatricule(null);

        dao.ajouter(l);
        System.out.println("Livre ajoute.");
    }
}
