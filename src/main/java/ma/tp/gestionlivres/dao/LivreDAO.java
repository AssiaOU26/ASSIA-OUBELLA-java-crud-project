package ma.tp.gestionlivres.dao;

import ma.tp.gestionlivres.model.Auteur;
import ma.tp.gestionlivres.model.Livre;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class LivreDAO {

    private Connection getConnection() throws SQLException {
        try {
            return DBConnection.getConnection();
        } catch (Exception e) {
            throw new SQLException("Unable to open DB connection", e);
        }
    }

    public void ajouter(Livre l) {
        insert(l);
    }

    public void insert(Livre l) {
        String sql = "INSERT INTO livre (ISBN, titre, description, date_edition, editeur, matricule) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, l.getIsbn());
            ps.setString(2, l.getTitre());
            ps.setString(3, l.getDescription());
            ps.setDate(4, l.getDateEdition());
            ps.setString(5, l.getEditeur());
            if (l.getMatricule() == null) {
                ps.setNull(6, Types.INTEGER);
            } else {
                ps.setInt(6, l.getMatricule());
            }

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Livre l) {
        String sql = "UPDATE livre SET titre = ?, description = ?, date_edition = ?, editeur = ?, matricule = ? " +
                "WHERE ISBN = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, l.getTitre());
            ps.setString(2, l.getDescription());
            ps.setDate(3, l.getDateEdition());
            ps.setString(4, l.getEditeur());
            if (l.getMatricule() == null) {
                ps.setNull(5, Types.INTEGER);
            } else {
                ps.setInt(5, l.getMatricule());
            }
            ps.setInt(6, l.getIsbn());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int isbn) {
        String sql = "DELETE FROM livre WHERE ISBN = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, isbn);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Livre findByIsbn(int isbn) {
        String sql = "SELECT l.ISBN, l.titre, l.description, l.date_edition, l.editeur, l.matricule, " +
                "a.nom, a.prenom, a.genre " +
                "FROM livre l LEFT JOIN auteur a ON l.matricule = a.matricule " +
                "WHERE l.ISBN = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, isbn);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapLivre(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Livre> findAll(String titre, String auteur, java.sql.Date dateEdition) {
        List<Livre> livres = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT l.ISBN, l.titre, l.description, l.date_edition, l.editeur, l.matricule, ");
        sql.append("a.nom, a.prenom, a.genre ");
        sql.append("FROM livre l LEFT JOIN auteur a ON l.matricule = a.matricule ");
        sql.append("WHERE 1=1 ");

        List<Object> params = new ArrayList<>();
        if (titre != null && !titre.isBlank()) {
            sql.append("AND l.titre LIKE ? ");
            params.add("%" + titre + "%");
        }
        if (auteur != null && !auteur.isBlank()) {
            sql.append("AND (a.nom LIKE ? OR a.prenom LIKE ?) ");
            params.add("%" + auteur + "%");
            params.add("%" + auteur + "%");
        }
        if (dateEdition != null) {
            sql.append("AND l.date_edition = ? ");
            params.add(dateEdition);
        }
        sql.append("ORDER BY l.date_edition DESC, l.titre ASC");

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    livres.add(mapLivre(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return livres;
    }

    public List<Livre> findAll() {
        return findAll(null, null, null);
    }

    private Livre mapLivre(ResultSet rs) throws SQLException {
        Livre l = new Livre();
        l.setIsbn(rs.getInt("ISBN"));
        l.setTitre(rs.getString("titre"));
        l.setDescription(rs.getString("description"));
        l.setDateEdition(rs.getDate("date_edition"));
        l.setEditeur(rs.getString("editeur"));
        int matricule = rs.getInt("matricule");
        l.setMatricule(rs.wasNull() ? null : matricule);

        String nom = rs.getString("nom");
        if (nom != null) {
            Auteur a = new Auteur();
            a.setMatricule(matricule);
            a.setNom(nom);
            a.setPrenom(rs.getString("prenom"));
            a.setGenre(rs.getString("genre"));
            l.setAuteur(a);
        }
        return l;
    }
}
