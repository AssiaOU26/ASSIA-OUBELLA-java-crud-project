package ma.tp.gestionlivres.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.tp.gestionlivres.dao.LivreDAO;
import ma.tp.gestionlivres.model.Livre;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/livres")
public class listeLivres extends HttpServlet {

    private final LivreDAO dao = new LivreDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String titre = req.getParameter("titre");
        String auteur = req.getParameter("auteur");
        String dateEditionStr = req.getParameter("dateEdition");
        Date dateEdition = null;
        if (dateEditionStr != null && !dateEditionStr.isBlank()) {
            try {
                dateEdition = Date.valueOf(dateEditionStr);
            } catch (IllegalArgumentException ignored) {
                dateEdition = null;
            }
        }

        List<Livre> livres = dao.findAll(titre, auteur, dateEdition);
        req.setAttribute("livres", livres);
        req.setAttribute("titre", titre);
        req.setAttribute("auteur", auteur);
        req.setAttribute("dateEdition", dateEditionStr);
        req.getRequestDispatcher("/livres.jsp").forward(req, resp);
    }
}
