<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'fr'}" scope="session"/>
<fmt:setBundle basename="messages"/>
<fmt:message key="books.searchTitle" var="searchTitleLabel"/>
<fmt:message key="books.searchAuthor" var="searchAuthorLabel"/>

<html>
<head>
    <title><fmt:message key="books.title"/></title>
    <style>
        :root {
            --bg: #f6f3ef;
            --ink: #1e1b16;
            --muted: #6d6256;
            --card: #ffffff;
            --accent: #c46524;
            --shadow: 0 18px 40px rgba(30, 27, 22, 0.12);
            --line: #e7ddd1;
        }

        body {
            margin: 0;
            font-family: "Georgia", "Times New Roman", serif;
            color: var(--ink);
            background: radial-gradient(circle at top left, #fdf8f2, var(--bg));
        }

        .page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px 16px;
        }

        .card {
            width: min(980px, 96vw);
            background: var(--card);
            border-radius: 16px;
            padding: 28px;
            box-shadow: var(--shadow);
        }

        h2 {
            margin: 0 0 8px;
            font-size: 28px;
            letter-spacing: 0.5px;
        }

        .subtitle {
            margin: 0 0 18px;
            color: var(--muted);
        }

        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
            gap: 12px;
            flex-wrap: wrap;
        }

        .search {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin: 12px 0 18px;
        }

        .search input {
            font-size: 14px;
            padding: 10px 12px;
            border: 1px solid var(--line);
            border-radius: 10px;
            background: #fffdfa;
            min-width: 160px;
        }

        .search button {
            border: none;
            background: var(--accent);
            color: #fff;
            padding: 10px 14px;
            border-radius: 10px;
            cursor: pointer;
        }

        .cta {
            display: inline-block;
            text-decoration: none;
            background: var(--accent);
            color: #fff;
            padding: 10px 14px;
            border-radius: 10px;
            transition: transform 0.15s ease, box-shadow 0.2s ease;
        }

        .cta:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 18px rgba(196, 101, 36, 0.25);
        }

        .user {
            color: var(--muted);
            font-size: 14px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .logout {
            color: var(--accent);
            text-decoration: none;
        }

        .lang a {
            color: var(--muted);
            text-decoration: none;
            margin-left: 6px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        th,
        td {
            text-align: left;
            padding: 12px 10px;
            border-bottom: 1px solid var(--line);
            vertical-align: top;
        }

        th {
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--muted);
            background: #fbf8f4;
        }

        tr:hover td {
            background: #fffcf8;
        }

        .actions {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .link {
            color: var(--accent);
            text-decoration: none;
        }

        .delete {
            border: none;
            background: #efe7de;
            color: var(--ink);
            padding: 6px 10px;
            border-radius: 8px;
            cursor: pointer;
        }

        .empty {
            color: var(--muted);
            padding: 16px 0 4px;
        }
    </style>
</head>
<body>

<div class="page">
    <div class="card">
        <h2><fmt:message key="books.title"/></h2>
        <p class="subtitle"><fmt:message key="books.subtitle"/></p>

        <div class="toolbar">
            <div class="empty">
                <c:if test="${empty livres}"><fmt:message key="books.empty"/></c:if>
            </div>
            <div class="user">
                <span>${sessionScope.user.login} (${sessionScope.user.role})</span>
                <span class="lang">
                    <a href="livres?lang=fr">FR</a>
                    <a href="livres?lang=en">EN</a>
                </span>
                <a class="logout" href="logout"><fmt:message key="nav.logout"/></a>
                <c:if test="${sessionScope.role == 'Admin'}">
                    <a class="cta" href="livre"><fmt:message key="nav.addBook"/></a>
                    <a class="cta" href="users"><fmt:message key="nav.users"/></a>
                </c:if>
            </div>
        </div>

        <form class="search" method="get" action="livres">
            <input type="text" name="titre" placeholder="${searchTitleLabel}" value="${titre}">
            <input type="text" name="auteur" placeholder="${searchAuthorLabel}" value="${auteur}">
            <input type="date" name="dateEdition" value="${dateEdition}">
            <button type="submit"><fmt:message key="books.search"/></button>
        </form>

        <table>
            <tr>
                <th><fmt:message key="books.isbn"/></th>
                <th><fmt:message key="books.titleCol"/></th>
                <th><fmt:message key="books.description"/></th>
                <th><fmt:message key="books.author"/></th>
                <th><fmt:message key="books.publisher"/></th>
                <th><fmt:message key="books.date"/></th>
                <c:if test="${sessionScope.role == 'Admin'}">
                    <th><fmt:message key="books.actions"/></th>
                </c:if>
            </tr>

            <c:forEach var="l" items="${livres}">
                <tr>
                    <td>${l.isbn}</td>
                    <td>${l.titre}</td>
                    <td>${l.description}</td>
                    <td>
                        <c:choose>
                            <c:when test="${l.auteur != null}">
                                ${l.auteur.nom} ${l.auteur.prenom}
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${l.editeur}</td>
                    <td>${l.dateEdition}</td>
                    <c:if test="${sessionScope.role == 'Admin'}">
                        <td>
                            <div class="actions">
                                <a class="link" href="livre?isbn=${l.isbn}"><fmt:message key="books.edit"/></a>
                                <form method="post" action="livre/delete">
                                    <input type="hidden" name="isbn" value="${l.isbn}">
                                    <button class="delete" type="submit"><fmt:message key="books.delete"/></button>
                                </form>
                            </div>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

</body>
</html>
