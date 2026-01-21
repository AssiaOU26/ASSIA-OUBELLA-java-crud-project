<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'fr'}" scope="session"/>
<fmt:setBundle basename="messages"/>
<html>
<head>
    <title><fmt:message key="users.title"/></title>
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
            width: min(900px, 96vw);
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

        .form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 12px;
            margin-bottom: 18px;
        }

        label {
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--muted);
        }

        input,
        select {
            font-size: 15px;
            padding: 10px 12px;
            border: 1px solid var(--line);
            border-radius: 10px;
            background: #fffdfa;
        }

        button {
            border: none;
            background: var(--accent);
            color: #fff;
            font-size: 15px;
            padding: 10px 14px;
            border-radius: 10px;
            cursor: pointer;
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

        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 14px;
        }

        .link {
            color: var(--accent);
            text-decoration: none;
        }

        .lang a {
            color: var(--muted);
            text-decoration: none;
            margin-left: 6px;
        }
    </style>
</head>
<body>

<div class="page">
    <div class="card">
        <div class="toolbar">
            <div>
                <h2><fmt:message key="users.title"/></h2>
                <p class="subtitle"><fmt:message key="users.subtitle"/></p>
            </div>
            <div class="lang">
                <a class="link" href="livres"><fmt:message key="nav.backBooks"/></a>
                <a href="users?lang=fr">FR</a>
                <a href="users?lang=en">EN</a>
            </div>
        </div>

        <form class="form" method="post" action="users">
            <div>
                <label for="login"><fmt:message key="users.login"/></label>
                <input type="email" id="login" name="login" required>
            </div>
            <div>
                <label for="password"><fmt:message key="users.password"/></label>
                <input type="text" id="password" name="password" required>
            </div>
            <div>
                <label for="role"><fmt:message key="users.role"/></label>
                <select id="role" name="role" required>
                    <option value="Admin"><fmt:message key="role.admin"/></option>
                    <option value="Visiteur"><fmt:message key="role.visiteur"/></option>
                </select>
            </div>
            <div>
                <label>&nbsp;</label>
                <button type="submit"><fmt:message key="users.add"/></button>
            </div>
        </form>

        <table>
            <tr>
                <th><fmt:message key="users.login"/></th>
                <th><fmt:message key="users.role"/></th>
            </tr>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td>${u.login}</td>
                    <td>${u.role}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

</body>
</html>
