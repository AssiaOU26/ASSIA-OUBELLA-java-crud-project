<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'fr'}" scope="session"/>
<fmt:setBundle basename="messages"/>
<html>
<head>
    <title><fmt:message key="app.title"/></title>
    <style>
        :root {
            --bg: #f6f3ef;
            --ink: #1e1b16;
            --muted: #6d6256;
            --card: #ffffff;
            --accent: #c46524;
            --shadow: 0 18px 40px rgba(30, 27, 22, 0.12);
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
            width: min(560px, 95vw);
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
            margin: 0 0 20px;
            color: var(--muted);
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 14px;
        }

        label {
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--muted);
        }

        input,
        textarea,
        select {
            font-size: 16px;
            padding: 10px 12px;
            border: 1px solid #e0d7cc;
            border-radius: 10px;
            background: #fffdfa;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(196, 101, 36, 0.15);
        }

        button {
            border: none;
            background: var(--accent);
            color: #fff;
            font-size: 16px;
            padding: 12px 18px;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.15s ease, box-shadow 0.2s ease;
        }

        button:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 18px rgba(196, 101, 36, 0.25);
        }

        .meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
            font-size: 14px;
            color: var(--muted);
        }

        .meta a {
            color: var(--muted);
            text-decoration: none;
            margin-left: 6px;
        }
    </style>
</head>
<body>

<div class="page">
    <div class="card">
        <div class="meta">
            <a href="livres"><fmt:message key="nav.backBooks"/></a>
            <span>
                <a href="livre?lang=fr">FR</a>
                <a href="livre?lang=en">EN</a>
            </span>
        </div>
        <c:choose>
            <c:when test="${livre == null}">
                <h2><fmt:message key="book.form.add"/></h2>
            </c:when>
            <c:otherwise>
                <h2><fmt:message key="book.form.edit"/></h2>
            </c:otherwise>
        </c:choose>
        <p class="subtitle"><fmt:message key="book.form.subtitle"/></p>

        <form method="post" action="livre">
            <input type="hidden" name="mode" value="${livre == null ? 'create' : 'update'}">
            <div class="field">
                <label for="isbn"><fmt:message key="book.form.isbn"/></label>
                <input type="number" id="isbn" name="isbn" required
                       value="${livre != null ? livre.isbn : ''}"
                       ${livre != null ? 'readonly' : ''}>
            </div>

            <div class="field">
                <label for="titre"><fmt:message key="book.form.title"/></label>
                <input type="text" id="titre" name="titre" required
                       value="${livre != null ? livre.titre : ''}">
            </div>

            <div class="field">
                <label for="description"><fmt:message key="book.form.description"/></label>
                <textarea id="description" name="description" rows="4">${livre != null ? livre.description : ''}</textarea>
            </div>

            <div class="field">
                <label for="dateEdition"><fmt:message key="book.form.dateEdition"/></label>
                <input type="date" id="dateEdition" name="dateEdition" required
                       value="${livre != null ? livre.dateEdition : ''}">
            </div>

            <div class="field">
                <label for="editeur"><fmt:message key="book.form.publisher"/></label>
                <select id="editeur" name="editeur" required>
                    <option value=""><fmt:message key="book.form.publisher.choose"/></option>
                    <option value="ENI" ${livre != null && livre.editeur == 'ENI' ? 'selected' : ''}>ENI</option>
                    <option value="DUNOD" ${livre != null && livre.editeur == 'DUNOD' ? 'selected' : ''}>DUNOD</option>
                    <option value="FIRST" ${livre != null && livre.editeur == 'FIRST' ? 'selected' : ''}>FIRST</option>
                </select>
            </div>

            <div class="field">
                <label for="matricule"><fmt:message key="book.form.author"/></label>
                <select id="matricule" name="matricule">
                    <option value=""><fmt:message key="book.form.author.none"/></option>
                    <c:forEach var="a" items="${auteurs}">
                        <option value="${a.matricule}"
                                ${livre != null && livre.matricule == a.matricule ? 'selected' : ''}>
                            ${a.nom} ${a.prenom}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <c:choose>
                <c:when test="${livre == null}">
                    <button type="submit"><fmt:message key="book.form.submit.add"/></button>
                </c:when>
                <c:otherwise>
                    <button type="submit"><fmt:message key="book.form.submit.edit"/></button>
                </c:otherwise>
            </c:choose>
        </form>
    </div>
</div>

</body>
</html>
