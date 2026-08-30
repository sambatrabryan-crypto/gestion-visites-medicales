<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Visite, model.Medecin, model.Patient, java.util.List, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Visites · MediGest</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet" />
<style>
    :root {
        --color-primary: #22c55e;
        --color-primary-dark: #16a34a;
        --color-primary-light: #dcfce7;
        --color-secondary: #2563eb;
        --color-success: #22c55e;
        --color-danger: #ef4444;
        --color-gray-50: #f8fafc;
        --color-gray-100: #f1f5f9;
        --color-gray-200: #e2e8f0;
        --color-gray-300: #cbd5e1;
        --color-gray-400: #94a3b8;
        --color-gray-500: #64748b;
        --color-gray-600: #475569;
        --color-gray-700: #334155;
        --color-gray-900: #0b1e33;
        --font-primary: 'Inter', -apple-system, sans-serif;
        --radius-md: 16px;
        --radius-lg: 24px;
        --radius-xl: 32px;
        --radius-full: 9999px;
        --shadow-sm: 0 1px 3px rgba(0,0,0,0.04);
        --shadow-md: 0 4px 14px rgba(0,0,0,0.06);
        --shadow-xl: 0 20px 50px rgba(0,0,0,0.12);
    }

    * { margin:0; padding:0; box-sizing:border-box; }

    body {
        font-family: var(--font-primary);
        background: var(--color-gray-50);
        color: var(--color-gray-900);
        display:flex;
        justify-content:center;
        padding:24px;
        line-height:1.6;
        min-height:100vh;
    }

    .app-container {
        max-width: 900px;
        width:100%;
        background:white;
        border-radius: var(--radius-xl);
        box-shadow: var(--shadow-xl);
        overflow:hidden;
        height:fit-content;
    }

    .app-header {
        padding: 20px 32px;
        background: linear-gradient(145deg, var(--color-primary), var(--color-secondary));
        display:flex;
        align-items:center;
        gap:16px;
        color:white;
    }

    .back-btn {
        width:44px; height:44px;
        border-radius: var(--radius-full);
        background: rgba(255,255,255,0.15);
        color:white;
        display:flex;
        align-items:center;
        justify-content:center;
        font-size:17px;
        text-decoration:none;
        transition: all 0.2s;
        flex-shrink:0;
    }

    .back-btn:hover {
        background: rgba(255,255,255,0.28);
        transform: translateX(-3px);
    }

    .logo-icon {
        width:48px; height:48px;
        background:rgba(255,255,255,0.15);
        border-radius: var(--radius-md);
        display:flex; align-items:center; justify-content:center;
        font-size:22px;
    }

    .app-header h1 { font-size:20px; font-weight:700; }
    .app-header p { font-size:13px; opacity:0.85; margin-top:2px; }

    .content-area { padding: 28px 32px; }

    .section-header {
        display:flex;
        justify-content:space-between;
        align-items:center;
        margin-bottom:20px;
        flex-wrap:wrap;
        gap:12px;
    }

    .section-header h2 {
        font-size:18px;
        font-weight:700;
        display:flex;
        align-items:center;
        gap:10px;
    }

    .section-header h2 i { color: var(--color-primary-dark); }

    .btn {
        display:inline-flex;
        align-items:center;
        gap:10px;
        padding:11px 24px;
        border-radius: var(--radius-full);
        font-weight:600;
        font-size:14px;
        border:none;
        cursor:pointer;
        transition: all 0.25s ease;
        text-decoration:none;
    }

    .btn-primary {
        background: linear-gradient(145deg, var(--color-primary), var(--color-primary-dark));
        color:white;
        box-shadow: 0 8px 20px -6px rgba(34,197,94,0.4);
    }

    .btn-primary:hover { transform: translateY(-2px); }

    .btn-secondary {
        background: var(--color-gray-100);
        color: var(--color-gray-700);
        border: 1px solid var(--color-gray-200);
    }

    .btn-secondary:hover { background: var(--color-gray-200); }

    .btn-danger {
        background: linear-gradient(145deg, #ef4444, #dc2626);
        color:white;
    }

    .btn-danger:hover { transform: translateY(-2px); }

    .appointment-list { display:flex; flex-direction:column; gap:14px; }

    .appointment-card {
        background:white;
        border-radius: var(--radius-lg);
        padding:18px 22px;
        display:flex;
        justify-content:space-between;
        align-items:center;
        flex-wrap:wrap;
        border: 1px solid var(--color-gray-200);
        transition: all 0.2s;
        box-shadow: var(--shadow-sm);
    }

    .appointment-card:hover {
        border-color: var(--color-gray-300);
        box-shadow: var(--shadow-md);
        transform: translateY(-2px);
    }

    .appointment-info {
        display:flex;
        align-items:center;
        gap:18px;
        flex-wrap:wrap;
    }

    .avatar-md {
        width:50px; height:50px;
        border-radius: var(--radius-md);
        display:flex; align-items:center; justify-content:center;
        font-weight:700;
        font-size:18px;
        background: var(--color-primary-light);
        color: var(--color-primary-dark);
        flex-shrink:0;
    }

    .patient-details h4 { font-weight:700; font-size:16px; color: var(--color-gray-900); }

    .patient-details .sub {
        font-size:13px;
        color: var(--color-gray-600);
        display:flex;
        align-items:center;
        gap:14px;
        flex-wrap:wrap;
        margin-top:2px;
    }

    .patient-details .sub i { color: var(--color-gray-400); width:14px; }

    .badge {
        display:inline-flex;
        align-items:center;
        gap:6px;
        padding:4px 14px;
        border-radius: var(--radius-full);
        font-size:12px;
        font-weight:600;
        background: var(--color-primary-light);
        color: var(--color-primary-dark);
    }

    .appointment-actions { display:flex; align-items:center; gap:8px; }

    .action-icon {
        width:38px; height:38px;
        border-radius: var(--radius-full);
        border:none;
        background: var(--color-gray-100);
        color: var(--color-gray-500);
        cursor:pointer;
        transition: all 0.2s;
        display:flex;
        align-items:center;
        justify-content:center;
        font-size:14px;
        text-decoration:none;
    }

    .action-icon:hover { background: var(--color-gray-200); color: var(--color-gray-800); }
    .action-icon.danger:hover { background:#fee2e2; color: var(--color-danger); }

    /* MODAL */
    .modal-overlay {
        display:none;
        position:fixed;
        top:0; left:0;
        width:100%; height:100%;
        background: rgba(15,23,42,0.5);
        backdrop-filter: blur(8px);
        align-items:center;
        justify-content:center;
        z-index:999;
        padding:20px;
    }

    .modal-overlay.open { display:flex; }

    .modal-box {
        background:white;
        border-radius: var(--radius-xl);
        max-width:480px;
        width:100%;
        padding:32px;
        animation: fadeIn 0.3s ease;
        max-height:90vh;
        overflow-y:auto;
    }

    @keyframes fadeIn {
        from { opacity:0; transform: scale(0.95) translateY(10px); }
        to { opacity:1; transform: scale(1) translateY(0); }
    }

    .modal-header {
        display:flex;
        justify-content:space-between;
        align-items:center;
        margin-bottom:16px;
    }

    .modal-header h3 {
        font-size:20px;
        font-weight:700;
        display:flex;
        align-items:center;
        gap:10px;
    }

    .modal-header h3 i { color: var(--color-primary-dark); }

    .modal-close {
        width:40px; height:40px;
        border-radius: var(--radius-full);
        border: 1px solid var(--color-gray-200);
        background:transparent;
        cursor:pointer;
        transition:0.2s;
        font-size:18px;
        color: var(--color-gray-500);
        text-decoration:none;
        display:flex;
        align-items:center;
        justify-content:center;
    }

    .modal-close:hover { background:#fee2e2; color: var(--color-danger); }

    .form-group { margin-bottom:16px; }

    .form-group label {
        display:block;
        font-size:13px;
        font-weight:600;
        color: var(--color-gray-700);
        margin-bottom:4px;
    }

    .form-group input,
    .form-group select {
        width:100%;
        padding:12px 16px;
        border:1.5px solid var(--color-gray-200);
        border-radius: var(--radius-md);
        font-size:14px;
        outline:none;
        transition:0.2s;
        font-family: var(--font-primary);
        background:white;
    }

    .form-group input:focus,
    .form-group select:focus {
        border-color: var(--color-primary);
        box-shadow: 0 0 0 4px rgba(34,197,94,0.1);
    }

    .modal-actions {
        display:flex;
        gap:12px;
        margin-top:20px;
        justify-content:flex-end;
        border-top: 1px solid var(--color-gray-200);
        padding-top:20px;
    }

    /* MODAL AVERTISSEMENT SUPPRESSION */
    .warning-modal-overlay {
        display:none;
        position:fixed;
        top:0; left:0;
        width:100%; height:100%;
        background: rgba(15,23,42,0.5);
        backdrop-filter: blur(8px);
        align-items:center;
        justify-content:center;
        z-index:1100;
        padding:20px;
    }

    .warning-modal-overlay.open { display:flex; }

    .warning-modal {
        background:white;
        border-radius: var(--radius-xl);
        max-width:420px;
        width:100%;
        padding:28px;
        text-align:center;
    }

    .warning-modal .icon {
        width:60px; height:60px;
        border-radius: var(--radius-full);
        background:#fef3c7;
        color:#d97706;
        display:flex;
        align-items:center;
        justify-content:center;
        font-size:26px;
        margin:0 auto 16px;
    }

    .warning-modal h3 {
        font-size:17px;
        font-weight:700;
        margin-bottom:8px;
    }

    .warning-modal p {
        font-size:14px;
        color: var(--color-gray-600);
        margin-bottom:22px;
    }

    .warning-modal p strong { color: var(--color-danger); }

    .warning-modal-actions {
        display:flex;
        gap:10px;
    }

    .warning-modal-actions .btn { flex:1; justify-content:center; }

    /* ALERTE SUCCES ANIMEE */
    .success-alert-overlay {
        display:none;
        position: fixed;
        top:0; left:0;
        width:100%; height:100%;
        background: rgba(15,23,42,0.35);
        backdrop-filter: blur(4px);
        z-index: 1300;
        align-items:center;
        justify-content:center;
    }

    .success-alert-overlay.show { display:flex; }

    .success-alert-box {
        background: white;
        border-radius: var(--radius-lg);
        padding: 40px 52px;
        display:flex;
        flex-direction:column;
        align-items:center;
        gap:18px;
        box-shadow: var(--shadow-xl);
        transform: scale(0.7);
        opacity:0;
        transition: all 0.4s cubic-bezier(.34,1.56,.64,1);
        max-width: 420px;
        text-align:center;
    }

    .success-alert-box.animate-in { transform: scale(1); opacity:1; }
    .success-alert-box.animate-out { transform: scale(0.9) translateY(-10px); opacity:0; }

    .success-alert-icon {
        width:84px; height:84px;
        border-radius: var(--radius-full);
        display:flex;
        align-items:center;
        justify-content:center;
        font-size:40px;
        animation: pop-icon 0.5s cubic-bezier(.34,1.56,.64,1) 0.1s both;
    }

    @keyframes pop-icon {
        0% { transform: scale(0); }
        70% { transform: scale(1.15); }
        100% { transform: scale(1); }
    }

    .success-alert-box.success .success-alert-icon { background:#dcfce7; color: var(--color-success); }
    .success-alert-box.error .success-alert-icon { background:#fee2e2; color: var(--color-danger); }

    .success-alert-text {
        font-size:18px;
        font-weight:600;
        color: var(--color-gray-900);
    }

    @media (max-width:640px) {
        .appointment-card { flex-direction:column; align-items:flex-start; gap:14px; }
        .appointment-actions { width:100%; justify-content:flex-start; }
        .modal-box { padding:24px; }
        .modal-actions { flex-direction:column-reverse; }
        .modal-actions .btn { justify-content:center; }
    }
</style>
</head>
<body>

<%
    Visite editVisite = (Visite) request.getAttribute("editVisite");
    boolean openModal = (editVisite != null);
    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
    List<Medecin> medecinsList = (List<Medecin>) request.getAttribute("medecins");
    List<Patient> patientsList = (List<Patient>) request.getAttribute("patients");
%>

<div class="app-container">

    <header class="app-header">
        <a href="index.jsp" class="back-btn" title="Retour à l'accueil"><i class="fas fa-arrow-left"></i></a>
        <div class="logo-icon"><i class="fas fa-calendar-check"></i></div>
        <div>
            <h1>Gestion des Visites</h1>
            <p>Centre Médical</p>
        </div>
    </header>

    <div class="content-area">

        <div class="section-header">
            <h2><i class="fas fa-list"></i> Liste des visites</h2>
            <button class="btn btn-primary" id="newBtn"><i class="fas fa-calendar-plus"></i> Nouvelle visite</button>
        </div>

        <div class="appointment-list">
            <%
                List<Visite> visites = (List<Visite>) request.getAttribute("visites");
                if (visites == null || visites.isEmpty()) {
            %>
                <div style="text-align:center; padding:40px 0; color:var(--color-gray-400); background:white; border-radius:var(--radius-lg); border:1px dashed var(--color-gray-300);">
                    <i class="fas fa-calendar-times" style="font-size:32px; margin-bottom:10px; display:block; opacity:0.5;"></i>
                    Aucune visite enregistrée
                </div>
            <%
                } else {
                    for (Visite v : visites) {
                        String initiales = (v.getPatient().getNom() != null && !v.getPatient().getNom().isEmpty() ? v.getPatient().getNom().substring(0,1) : "") +
                                            (v.getPatient().getPrenom() != null && !v.getPatient().getPrenom().isEmpty() ? v.getPatient().getPrenom().substring(0,1) : "");
            %>
            <div class="appointment-card">
                <div class="appointment-info">
                    <div class="avatar-md"><%= initiales.toUpperCase() %></div>
                    <div class="patient-details">
                        <h4><%= v.getPatient().getNom() %> <%= v.getPatient().getPrenom() %></h4>
                        <div class="sub">
                            <span><i class="fas fa-hashtag"></i> #<%= v.getId() %></span>
                            <span><i class="fas fa-user-md"></i> Dr. <%= v.getMedecin().getNom() %> <%= v.getMedecin().getPrenom() %></span>
                            <span><i class="fas fa-calendar-alt"></i> <%= sdfDisplay.format(v.getDateVisite()) %></span>
                        </div>
                    </div>
                    <span class="badge"><i class="fas fa-calendar-day"></i> <%= sdfDisplay.format(v.getDateVisite()) %></span>
                </div>
                <div class="appointment-actions">
                    <a href="VisiteServlet?action=edit&id=<%= v.getId() %>" class="action-icon" title="Modifier"><i class="fas fa-edit"></i></a>
                    <button type="button" class="action-icon danger" title="Supprimer"
                            onclick="confirmDelete(<%= v.getId() %>, '<%= v.getPatient().getNom() %> <%= v.getPatient().getPrenom() %>')">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>

    </div>

</div>

<!-- MODAL -->
<div class="modal-overlay <%= openModal ? "open" : "" %>" id="modalOverlay">
    <div class="modal-box">
        <div class="modal-header">
            <h3><i class="fas <%= (editVisite != null) ? "fa-edit" : "fa-calendar-plus" %>"></i>
                <%= (editVisite != null) ? "Modifier la visite" : "Nouvelle visite" %>
            </h3>
            <a href="VisiteServlet" class="modal-close"><i class="fas fa-times"></i></a>
        </div>

        <form action="VisiteServlet" method="post" id="visiteForm">

            <% if (editVisite != null) { %>
                <input type="hidden" name="id" value="<%= editVisite.getId() %>">
            <% } %>

            <div class="form-group">
                <label><i class="fas fa-user-md"></i> Médecin</label>
                <select name="codemed" required>
                    <option value="">-- Sélectionner un médecin --</option>
                    <%
                        if (medecinsList != null) {
                            for (Medecin m : medecinsList) {
                                boolean selected = (editVisite != null && editVisite.getMedecin().getCodemed() == m.getCodemed());
                    %>
                        <option value="<%= m.getCodemed() %>" <%= selected ? "selected" : "" %>>
                            #<%= m.getCodemed() %> — Dr. <%= m.getNom() %> <%= m.getPrenom() %> (<%= m.getGrade() %>)
                        </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label><i class="fas fa-user-injured"></i> Patient</label>
                <select name="codepat" required>
                    <option value="">-- Sélectionner un patient --</option>
                    <%
                        if (patientsList != null) {
                            for (Patient p : patientsList) {
                                boolean selected = (editVisite != null && editVisite.getPatient().getCodepat() == p.getCodepat());
                    %>
                        <option value="<%= p.getCodepat() %>" <%= selected ? "selected" : "" %>>
                            #<%= p.getCodepat() %> — <%= p.getNom() %> <%= p.getPrenom() %>
                        </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label><i class="fas fa-calendar-alt"></i> Date de visite</label>
                <input type="date" name="dateVisite" id="dateVisite" required
                       min="<%= java.time.LocalDate.now() %>"
                       value="<%= (editVisite != null) ? sdfInput.format(editVisite.getDateVisite()) : "" %>">
            </div>

            <div class="modal-actions">
                <a href="VisiteServlet" class="btn btn-secondary">Annuler</a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas <%= (editVisite != null) ? "fa-check" : "fa-save" %>"></i>
                    <%= (editVisite != null) ? "Modifier" : "Créer" %>
                </button>
            </div>

        </form>
    </div>
</div>

<!-- MODAL AVERTISSEMENT SUPPRESSION -->
<div class="warning-modal-overlay" id="warningModalOverlay">
    <div class="warning-modal">
        <div class="icon"><i class="fas fa-triangle-exclamation"></i></div>
        <h3>Supprimer cette visite ?</h3>
        <p id="warningText"></p>
        <div class="warning-modal-actions">
            <button type="button" class="btn btn-secondary" onclick="closeWarning()">Annuler</button>
            <a href="#" id="confirmDeleteLink" class="btn btn-danger"><i class="fas fa-trash-alt"></i> Supprimer</a>
        </div>
    </div>
</div>

<!-- ALERTE SUCCES -->
<div class="success-alert-overlay" id="successAlertOverlay">
    <div class="success-alert-box" id="successAlertBox">
        <div class="success-alert-icon" id="successAlertIcon"><i class="fas fa-check-circle"></i></div>
        <div class="success-alert-text" id="successAlertText"></div>
    </div>
</div>

<script>
    document.getElementById('newBtn').addEventListener('click', function() {
        document.getElementById('modalOverlay').classList.add('open');
    });

    document.getElementById('modalOverlay').addEventListener('click', function(e) {
        if (e.target === this) {
            window.location.href = 'VisiteServlet';
        }
    });

    // Validation de la date future
    document.getElementById('visiteForm').addEventListener('submit', function(e) {
        const dateInput = document.getElementById('dateVisite');
        const selectedDate = new Date(dateInput.value + 'T00:00:00');
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (selectedDate < today) {
            e.preventDefault();
            dateInput.style.borderColor = 'var(--color-danger)';
            dateInput.style.boxShadow = '0 0 0 4px rgba(239, 68, 68, 0.1)';
            alert('La date de visite doit être aujourd\'hui ou dans le futur.');
            dateInput.focus();
            return false;
        }
        return true;
    });

    // Réinitialiser le style du champ date quand l'utilisateur corrige
    document.getElementById('dateVisite').addEventListener('change', function() {
        this.style.borderColor = '';
        this.style.boxShadow = '';
    });

    function confirmDelete(id, nom) {
        const text = document.getElementById('warningText');
        const link = document.getElementById('confirmDeleteLink');
        text.innerHTML = 'Voulez-vous vraiment supprimer la visite de <strong>' + nom + '</strong> ? Cette action est irréversible.';
        link.href = 'VisiteServlet?action=delete&id=' + id;
        document.getElementById('warningModalOverlay').classList.add('open');
    }

    function closeWarning() {
        document.getElementById('warningModalOverlay').classList.remove('open');
    }

    (function() {
        const messages = {
            added:   { type: 'success', icon: 'fa-circle-check', text: 'Visite ajoutée avec succès !' },
            updated: { type: 'success', icon: 'fa-circle-check', text: 'Visite modifiée avec succès !' },
            deleted: { type: 'success', icon: 'fa-circle-check', text: 'Visite supprimée avec succès !' }
        };
        const params = new URLSearchParams(window.location.search);
        const msg = params.get('msg');
        if (msg && messages[msg]) {
            showSuccessAlert(messages[msg]);
            params.delete('msg');
            window.history.replaceState({}, '', window.location.pathname + (params.toString() ? '?' + params.toString() : ''));
        }
        function showSuccessAlert(m) {
            const overlay = document.getElementById('successAlertOverlay');
            const box = document.getElementById('successAlertBox');
            const icon = document.getElementById('successAlertIcon');
            const text = document.getElementById('successAlertText');
            box.className = 'success-alert-box ' + m.type;
            icon.innerHTML = '<i class="fas ' + m.icon + '"></i>';
            text.textContent = m.text;
            overlay.classList.add('show');
            requestAnimationFrame(() => box.classList.add('animate-in'));
            setTimeout(() => {
                box.classList.remove('animate-in');
                box.classList.add('animate-out');
                setTimeout(() => {
                    overlay.classList.remove('show');
                    box.classList.remove('animate-out');
                }, 350);
            }, 1800);
        }
    })();
</script>

</body>
</html>