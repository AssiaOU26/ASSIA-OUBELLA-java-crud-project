package ma.tp.gestionlivres.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.tp.gestionlivres.dao.LivreDAO;

import java.io.IOException;

@WebServlet("/livre/delete")
public class LivreDeleteServlet extends HttpServlet {

    private final LivreDAO dao = new LivreDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleDelete(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleDelete(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String isbnStr = req.getParameter("isbn");
        if (isbnStr != null && !isbnStr.isBlank()) {
            try {
                int isbn = Integer.parseInt(isbnStr);
                dao.delete(isbn);
            } catch (NumberFormatException ignored) {
                // Ignore invalid ISBN input.
            }
        }
        resp.sendRedirect(req.getContextPath() + "/livres");
    }
}
