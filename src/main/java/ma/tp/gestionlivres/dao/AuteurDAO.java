package ma.tp.gestionlivres.dao;

import ma.tp.gestionlivres.model.Auteur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AuteurDAO {

    private Connection getConnection() throws SQLException {
        try {
            return DBConnection.getConnection();
        } catch (Exception e) {
            throw new SQLException("Unable to open DB connection", e);
        }
    }

    public List<Auteur> findAll() {
        List<Auteur> auteurs = new ArrayList<>();
        String sql = "SELECT matricule, nom, prenom, genre FROM auteur ORDER BY nom, prenom";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Auteur a = new Auteur();
                a.setMatricule(rs.getInt("matricule"));
                a.setNom(rs.getString("nom"));
                a.setPrenom(rs.getString("prenom"));
                a.setGenre(rs.getString("genre"));
                auteurs.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return auteurs;
    }
}
