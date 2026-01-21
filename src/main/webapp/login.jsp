<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'fr'}" scope="session"/>
<fmt:setBundle basename="messages"/>
<html>
<head>
    <title><fmt:message key="login.title"/></title>
    <style>
        :root {
            --bg: #f6f3ef;
            --ink: #1e1b16;
            --muted: #6d6256;
            --card: #ffffff;
            --accent: #c46524;
            --shadow: 0 18px 40px rgba(30, 27, 22, 0.12);
            --danger: #b2352a;
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
            width: min(420px, 94vw);
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

        input {
            font-size: 16px;
            padding: 10px 12px;
            border: 1px solid #e0d7cc;
            border-radius: 10px;
            background: #fffdfa;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input:focus {
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
            width: 100%;
        }

        button:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 18px rgba(196, 101, 36, 0.25);
        }

        .error {
            color: var(--danger);
            margin-bottom: 12px;
        }

        .lang {
            text-align: right;
            margin-bottom: 10px;
        }

        .lang a {
            color: var(--muted);
            text-decoration: none;
            margin-left: 8px;
        }
    </style>
</head>
<body>

<div class="page">
    <div class="card">
        <div class="lang">
            <a href="login?lang=fr">FR</a>
            <a href="login?lang=en">EN</a>
        </div>
        <h2><fmt:message key="login.title"/></h2>
        <p class="subtitle"><fmt:message key="login.subtitle"/></p>

        <c:if test="${not empty errorKey}">
            <div class="error"><fmt:message key="${errorKey}"/></div>
        </c:if>

        <form method="post" action="login">
            <div class="field">
                <label for="login"><fmt:message key="login.email"/></label>
                <input type="email" id="login" name="login" required>
            </div>

            <div class="field">
                <label for="password"><fmt:message key="login.password"/></label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit"><fmt:message key="login.submit"/></button>
        </form>
    </div>
</div>

</body>
</html>
