package ma.tp.gestionlivres.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Locale;

@WebFilter("/*")
public class LocaleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(true);

        String lang = req.getParameter("lang");
        if (lang != null && !lang.isBlank()) {
            session.setAttribute("lang", lang);
        }
        Object sessionLang = session.getAttribute("lang");
        if (sessionLang != null) {
            String language = sessionLang.toString();
            if ("fr".equalsIgnoreCase(language) || "en".equalsIgnoreCase(language)) {
                Locale locale = Locale.forLanguageTag(language);
                req.setAttribute("lang", language);
                req.setAttribute("locale", locale);
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
