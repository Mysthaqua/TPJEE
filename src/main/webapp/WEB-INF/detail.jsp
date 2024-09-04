<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="patient" scope="request" type="tibo.jee.tpjee.entity.Patient"/>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.lang.Math" %>
<%@ page import="tibo.jee.tpjee.entity.Consultation" %>
<%@ page import="java.util.Comparator" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/patients">Liste des patients</a>
            </li>
        </ul>
    </header>

    <main class="px-3">
        <div>
            <h1 class="d-flex justify-content-start">Infos du patient :</h1>
            <img class="d-flex justify-content-start" src="${patient.photo}"
                 alt="${patient.firstName} ${patient.lastName}" width="200px"/>
            <h4 class="d-flex justify-content-start">Nom : ${patient.firstName} ${patient.lastName}</h4>
            <h4 class="d-flex justify-content-start">Date de naissance : ${patient.birthDate}</h4>
            <h4 class="d-flex justify-content-start">Téléphone : ${patient.phone}</h4>
        </div>

        <br>

        <div>
            <h2 class="d-flex justify-content-start">Ajouter une consultation</h2>
            <button class="btn btn-primary d-flex justify-content-start">Valider</button>
        </div>

        <br>

        <div>
            <h2 class="d-flex justify-content-start">Liste des consultations</h2>
            <div class="d-flex flex-column flex-md-row gap-4 py-md-2 justify-content-start">
                <div class="list-group">
                    <% patient.getConsultations().sort(Comparator.comparing(Consultation::getDateConsultation).reversed()); %>
                    <c:forEach var="consultation" items="${patient.consultations}">
                        <a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3"
                           aria-current="true">
                            <img src="images/consultation.png" alt="${consultation.id}" width="32" height="32"
                                 class="rounded-circle flex-shrink-0">
                            <div class="d-flex gap-2 w-100 justify-content-between">
                                <div>
                                    <h6 class="mb-0 d-flex justify-content-start">Consultation n°${consultation.id}</h6>
                                    <p class="mb-0 opacity-75">${consultation.dateConsultation}</p>
                                </div>
                                <small class="opacity-50 text-nowrap">
                                        ${ChronoUnit.DAYS.between(LocalDate.now(), consultation.dateConsultation) == 0 ?
                                                "aujourd\'hui" :
                                                String.format("%s %d jour%s",
                                                        ChronoUnit.DAYS.between(LocalDate.now(), consultation.dateConsultation) < 0 ?
                                                                "il y a" :
                                                                "dans",
                                                        Math.abs(ChronoUnit.DAYS.between(LocalDate.now(), consultation.dateConsultation)),
                                                        Math.abs(ChronoUnit.DAYS.between(LocalDate.now(), consultation.dateConsultation)) > 1 ? "s" : "")}
                                </small>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>

    <footer class="mt-auto text-white-50">
        <%--        <p>Cover template for <a href="https://getbootstrap.com/" class="text-white">Bootstrap</a>, by <a--%>
        <%--                href="https://twitter.com/mdo" class="text-white">@mdo</a>.</p>--%>
        <p>@ 2024 Hôpital Velpeau. Tous droits réservés.</p>
    </footer>
</div>

</body>
</html>