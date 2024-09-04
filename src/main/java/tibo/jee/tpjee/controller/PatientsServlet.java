package tibo.jee.tpjee.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import tibo.jee.tpjee.entity.Consultation;
import tibo.jee.tpjee.entity.Patient;
import tibo.jee.tpjee.repository.PatientRepository;
import tibo.jee.tpjee.repository.Repository;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@WebServlet("/patients")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class PatientsServlet extends HttpServlet {
    private PatientRepository patientRepo;
    private Map<String, String> users;
    private String loggedAs;

    @Override
    public void init() throws ServletException {
        patientRepo = new PatientRepository();
        users = Map.of("admin", "admin");
        loggedAs = "";

        // Add some test patients
        patientRepo.merge(
                Patient.builder()
                        .firstName("John")
                        .lastName("Doe")
                        .gender(Patient.Gender.MALE)
                        .birthDate(LocalDate.of(1980, 1, 1))
                        .phone("01 23 45 67 89")
                        .build()
        );
        patientRepo.merge(
                Patient.builder()
                        .firstName("Jane")
                        .lastName("Doe")
                        .gender(Patient.Gender.FEMALE)
                        .birthDate(LocalDate.of(1980, 1, 1))
                        .phone("01 23 45 67 89")
                        .build()
        );
        patientRepo.merge(
                Patient.builder()
                        .firstName("Tibo")
                        .gender(Patient.Gender.MALE)
                        .birthDate(LocalDate.of(1996, 7, 5))
                        .phone("01 23 45 67 89")
                        .photo("images/patients/cat.jpg")
                        .build()
        );

        new Repository<>(Consultation.class).merge(
                Consultation.builder()
                        .patient(patientRepo.get(3))
                        .dateConsultation(LocalDate.now().minusDays(30))
                        .build()
        );
        new Repository<>(Consultation.class).merge(
                Consultation.builder()
                        .patient(patientRepo.get(3))
                        .dateConsultation(LocalDate.now().minusDays(1))
                        .build()
        );
        new Repository<>(Consultation.class).merge(
                Consultation.builder()
                        .patient(patientRepo.get(3))
                        .dateConsultation(LocalDate.now())
                        .build()
        );
        new Repository<>(Consultation.class).merge(
                Consultation.builder()
                        .patient(patientRepo.get(3))
                        .dateConsultation(LocalDate.now().plusDays(1))
                        .build()
        );
        new Repository<>(Consultation.class).merge(
                Consultation.builder()
                        .patient(patientRepo.get(3))
                        .dateConsultation(LocalDate.now().plusDays(7))
                        .build()
        );
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            try {
                Patient patient = patientRepo.get(Integer.parseInt(id));
                req.setAttribute("patient", patient);
                req.getRequestDispatcher("WEB-INF/detail.jsp").forward(req, resp);
                return;
            } catch (NumberFormatException ignored) {
            }
        }

        String search = req.getParameter("search");
        List<Patient> patients;
        if (search != null) {
            patients = patientRepo.getByName(search);
        } else {
            patients = patientRepo.getAll();
        }
        req.setAttribute("patients", patients);
        req.setAttribute("loggedAs", loggedAs);
        req.getRequestDispatcher("WEB-INF/patients.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String password = req.getParameter("password");

        if (login != null && password != null) {
            if (users.containsKey(login) && users.get(login).equals(password)) {
                loggedAs = login;
                resp.sendRedirect(req.getContextPath() + "/patients");
            } else {
                req.setAttribute("error", "Login ou mot de passe incorrect");
                req.getRequestDispatcher("login").forward(req, resp);
            }
        } else {
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            Patient.Gender gender = Patient.Gender.valueOf(req.getParameter("gender"));
            LocalDate birthDate = LocalDate.parse(req.getParameter("birthDate"));
            String phone = req.getParameter("phone");
            String path = String.format("%simages", getServletContext().getRealPath("/"));
            File dir = new File(path);

            if (!dir.exists()) {
                dir.mkdir();
            }
            Part image = req.getPart("photo");
            String filename = image.getSubmittedFileName();
            System.out.println(path);
            System.out.println(filename);
            image.write(String.format("%s%s%s",
                    path,
                    File.separator,
                    filename));

            patientRepo.merge(
                    Patient.builder()
                            .firstName(firstName)
                            .lastName(lastName)
                            .gender(gender)
                            .birthDate(birthDate)
                            .phone(phone)
                            .photo(String.format("images%spatients%s%s",
                                    File.separator,
                                    File.separator,
                                    filename))
                            .build()
            );

            resp.sendRedirect(req.getContextPath() + "/patients");
        }
    }
}