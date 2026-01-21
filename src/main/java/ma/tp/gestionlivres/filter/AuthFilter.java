package ma.tp.gestionlivres.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String contextPath = req.getContextPath();
        String path = req.getRequestURI().substring(contextPath.length());

        if (isPublic(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        Object user = session == null ? null : session.getAttribute("user");
        String role = session == null ? null : (String) session.getAttribute("role");

        if (user == null) {
            resp.sendRedirect(contextPath + "/login");
            return;
        }

        if ("Visiteur".equalsIgnoreCase(role) && !isVisitorAllowed(path)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }

    private boolean isPublic(String path) {
        if (path.equals("/") || path.equals("/index.jsp")) {
            return true;
        }
        if (path.startsWith("/login") || path.startsWith("/logout")) {
            return true;
        }
        return path.endsWith(".css") || path.endsWith(".js")
                || path.endsWith(".png") || path.endsWith(".jpg")
                || path.endsWith(".jpeg") || path.endsWith(".gif");
    }

    private boolean isVisitorAllowed(String path) {
        return path.startsWith("/livres")
                || path.equals("/") || path.equals("/index.jsp")
                || path.startsWith("/logout")
                || path.startsWith("/login");
    }
}
