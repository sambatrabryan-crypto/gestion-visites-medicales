package servlet;

import dao.PatientDAO;
import dao.VisiteDAO;
import model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PatientDAO patientDAO = new PatientDAO();
    private VisiteDAO visiteDAO = new VisiteDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String codepatStr = request.getParameter("codepat");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String sexe = request.getParameter("sexe");
        String adresse = request.getParameter("adresse");

        Patient patient = new Patient();
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setSexe(sexe);
        patient.setAdresse(adresse);

        if (codepatStr != null && !codepatStr.isEmpty()) {
            patient.setCodepat(Integer.parseInt(codepatStr));
            patientDAO.update(patient);
            response.sendRedirect("PatientServlet?msg=updated");
        } else {
            patientDAO.save(patient);
            response.sendRedirect("PatientServlet?msg=added");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String cascade = request.getParameter("cascade");
            if ("true".equals(cascade)) {
                visiteDAO.deleteByPatient(id);
            }
            patientDAO.delete(id);
            response.sendRedirect("PatientServlet?msg=deleted");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Patient patient = patientDAO.findById(id);
            request.setAttribute("editPatient", patient);
        }

        String recherche = request.getParameter("recherche");
        List<Patient> patients;
        if (recherche != null && !recherche.trim().isEmpty()) {
            patients = patientDAO.findByCodeOrNom(recherche.trim());
            request.setAttribute("recherche", recherche);
        } else {
            patients = patientDAO.findAll();
        }

        Map<Integer, Integer> visiteCounts = new HashMap<>();
        for (Patient p : patients) {
            visiteCounts.put(p.getCodepat(), visiteDAO.countByPatient(p.getCodepat()));
        }

        List<Patient> allPatients = patientDAO.findAll();

        request.setAttribute("patients", patients);
        request.setAttribute("visiteCounts", visiteCounts);
        request.setAttribute("allPatients", allPatients);

        request.getRequestDispatcher("patient.jsp").forward(request, response);
    }
}