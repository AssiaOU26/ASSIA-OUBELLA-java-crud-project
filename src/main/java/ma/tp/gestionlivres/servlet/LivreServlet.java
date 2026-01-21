package ma.tp.gestionlivres.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.tp.gestionlivres.dao.AuteurDAO;
import ma.tp.gestionlivres.dao.LivreDAO;
import ma.tp.gestionlivres.model.Livre;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/livre")
public class LivreServlet extends HttpServlet {

    private final LivreDAO dao = new LivreDAO();
    private final AuteurDAO auteurDAO = new AuteurDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String isbnStr = req.getParameter("isbn");
        if (isbnStr != null && !isbnStr.isBlank()) {
            try {
                int isbn = Integer.parseInt(isbnStr);
                Livre livre = dao.findByIsbn(isbn);
                req.setAttribute("livre", livre);
            } catch (NumberFormatException ignored) {
                // Ignore invalid ISBN input.
            }
        }

        req.setAttribute("auteurs", auteurDAO.findAll());
        req.getRequestDispatcher("/addLivre.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Livre l = new Livre();
        l.setIsbn(Integer.parseInt(req.getParameter("isbn")));
        l.setTitre(req.getParameter("titre"));
        l.setDescription(req.getParameter("description"));

        // Convert String -> java.sql.Date
        String dateStr = req.getParameter("dateEdition");
        l.setDateEdition(Date.valueOf(dateStr));

        l.setEditeur(req.getParameter("editeur"));
        String matriculeStr = req.getParameter("matricule");
        if (matriculeStr != null && !matriculeStr.isBlank()) {
            l.setMatricule(Integer.parseInt(matriculeStr));
        } else {
            l.setMatricule(null);
        }

        String mode = req.getParameter("mode");
        if ("update".equalsIgnoreCase(mode)) {
            dao.update(l);
        } else {
            dao.insert(l);
        }

        resp.sendRedirect(req.getContextPath() + "/livres");
    }
}
