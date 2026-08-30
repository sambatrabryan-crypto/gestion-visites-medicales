package servlet;

import dao.MedecinDAO;
import dao.VisiteDAO;
import model.Medecin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/MedecinServlet")
public class MedecinServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private MedecinDAO medecinDAO = new MedecinDAO();
    private VisiteDAO visiteDAO = new VisiteDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String codemedStr = request.getParameter("codemed");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String grade = request.getParameter("grade");

        Medecin medecin = new Medecin();
        medecin.setNom(nom);
        medecin.setPrenom(prenom);
        medecin.setGrade(grade);

        if (codemedStr != null && !codemedStr.isEmpty()) {
            medecin.setCodemed(Integer.parseInt(codemedStr));
            medecinDAO.update(medecin);
            response.sendRedirect("MedecinServlet?msg=updated");
        } else {
            medecinDAO.save(medecin);
            response.sendRedirect("MedecinServlet?msg=added");
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
                visiteDAO.deleteByMedecin(id);
            }
            medecinDAO.delete(id);
            response.sendRedirect("MedecinServlet?msg=deleted");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Medecin medecin = medecinDAO.findById(id);
            request.setAttribute("editMedecin", medecin);
        }

        List<Medecin> medecins = medecinDAO.findAll();

        Map<Integer, Integer> visiteCounts = new HashMap<>();
        for (Medecin m : medecins) {
            visiteCounts.put(m.getCodemed(), visiteDAO.countByMedecin(m.getCodemed()));
        }

        request.setAttribute("medecins", medecins);
        request.setAttribute("visiteCounts", visiteCounts);

        request.getRequestDispatcher("medecin.jsp").forward(request, response);
    }
}