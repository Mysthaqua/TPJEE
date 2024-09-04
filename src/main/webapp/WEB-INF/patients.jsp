<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="defaultImage" class="java.lang.String"/>
<!DOCTYPE html>
<html lang="en" class="h-100" data-bs-theme="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Bienvenue à l'Hôpital Velpeau">
    <meta name="author" content="Tibo">
    <title>Bienvenue à l'Hôpital Velpeau</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
    <%--    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/accueil.css"/>--%>

    <script defer
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script defer src="https://getbootstrap.com/docs/5.3/assets/js/color-modes.js"></script>

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            width: 100%;
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        .btn-bd-primary {
            --bd-violet-bg: #712cf9;
            --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

            --bs-btn-font-weight: 600;
            --bs-btn-color: var(--bs-white);
            --bs-btn-bg: var(--bd-violet-bg);
            --bs-btn-border-color: var(--bd-violet-bg);
            --bs-btn-hover-color: var(--bs-white);
            --bs-btn-hover-bg: #6528e0;
            --bs-btn-hover-border-color: #6528e0;
            --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
            --bs-btn-active-color: var(--bs-btn-hover-color);
            --bs-btn-active-bg: #5a23c8;
            --bs-btn-active-border-color: #5a23c8;
        }

        .bd-mode-toggle {
            z-index: 1500;
        }

        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
    </style>
</head>
<body class="d-flex h-100 text-center text-bg-dark">

<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
    <header class="mb-auto">
        <div>
            <h3 class="float-md-none mb-0">Bienvenue à l'Hôpital Velpeau</h3>
        </div>
        <br/>
        <ul class="nav nav-tabs justify-content-center">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Accueil</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/patients">Liste des patients</a>
            </li>
        </ul>
    </header>

    <main class="px-3">
        <h1>Rechercher un patient</h1>
        <form action="${pageContext.request.contextPath}/login" method="get">
            <input type="text" name="search">
            <button class="btn btn-primary">Valider</button>
        </form>
        <br/>
        <h1>Ajouter un patient</h1>
        <c:choose>
            <c:when test="${loggedAs.isBlank()}">
                <form action="${pageContext.request.contextPath}/login" method="get">
                    <button class="btn btn-primary">Se connecter</button>
                </form>
            </c:when>
            <c:otherwise>
                <form class="w-25 mx-auto" action="patients" method="post" enctype="multipart/form-data">
                    <div class="mb-3 mt-3">
                        <label for="firstName" class="form-label d-flex justify-content-start">Prénom :</label>
                        <input type="text" class="form-control" id="firstName" name="firstName">
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="lastName" class="form-label d-flex justify-content-start">Nom :</label>
                        <input type="text" class="form-control" id="lastName" name="lastName">
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="phone" class="form-label d-flex justify-content-start">Téléphone :</label>
                        <input type="text" class="form-control" id="phone" name="phone">
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="birthDate" class="form-label d-flex justify-content-start">Date de naissance :</label>
                        <input type="date" class="form-control" id="birthDate" name="birthDate">
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="gender" class="form-label d-flex justify-content-start">Genre :</label>
                        <select class="form-control" name="gender" id="gender">
                            <option value="MALE">Homme</option>
                            <option value="FEMALE">Femme</option>
                            <option value="OTHER">Autre</option>
                        </select>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="photo" class="form-label d-flex justify-content-start">Photo :</label>
                        <input type="file" accept="image/*" class="form-control" id="photo" name="photo">
                    </div>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </c:otherwise>
        </c:choose>
    </main>

    <c:if test="${!patients.isEmpty()}">
        <hr/>

        <div>
            <h1>Liste des patients</h1>
            <c:forEach items="${patients}" var="patient">
                <div class="card d-inline-block" style="width:250px">
                    <img class="card-img-top" src="${patient.photo}"
                                             alt="${patient.firstName} ${patient.lastName}">
                    <div class="card-body">
                        <h4 class="card-title">${patient.firstName} ${patient.lastName}</h4>
                        <p class="card-text">Téléphone : ${patient.phone}</p>
                        <a href="?id=${patient.id}" class="btn btn-primary">Détails</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <footer class="mt-auto text-white-50">
        <%--        <p>Cover template for <a href="https://getbootstrap.com/" class="text-white">Bootstrap</a>, by <a--%>
        <%--                href="https://twitter.com/mdo" class="text-white">@mdo</a>.</p>--%>
        <p>@ 2024 Hôpital Velpeau. Tous droits réservés.</p>
    </footer>
</div>

</body>
</html>