package servlet;

import dao.MedecinDAO;
import dao.PatientDAO;
import dao.VisiteDAO;
import model.Medecin;
import model.Patient;
import model.Visite;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/VisiteServlet")
public class VisiteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private VisiteDAO visiteDAO = new VisiteDAO();
    private MedecinDAO medecinDAO = new MedecinDAO();
    private PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String idStr = request.getParameter("id");
            int codemed = Integer.parseInt(request.getParameter("codemed"));
            int codepat = Integer.parseInt(request.getParameter("codepat"));
            String date = request.getParameter("dateVisite");

            Medecin medecin = medecinDAO.findById(codemed);
            Patient patient = patientDAO.findById(codepat);

            Visite visite = new Visite();
            visite.setMedecin(medecin);
            visite.setPatient(patient);
            visite.setDateVisite(new SimpleDateFormat("yyyy-MM-dd").parse(date));

            if (idStr != null && !idStr.isEmpty()) {
                visite.setId(Integer.parseInt(idStr));
                visiteDAO.update(visite);
                response.sendRedirect("VisiteServlet?msg=updated");
            } else {
                visiteDAO.save(visite);
                response.sendRedirect("VisiteServlet?msg=added");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            visiteDAO.delete(id);
            response.sendRedirect("VisiteServlet?msg=deleted");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Visite visite = visiteDAO.findById(id);
            request.setAttribute("editVisite", visite);
        }

        List<Visite> visites = visiteDAO.findAll();
        List<Medecin> medecins = medecinDAO.findAll();
        List<Patient> patients = patientDAO.findAll();

        request.setAttribute("visites", visites);
        request.setAttribute("medecins", medecins);
        request.setAttribute("patients", patients);

        request.getRequestDispatcher("visite.jsp").forward(request, response);
    }
}