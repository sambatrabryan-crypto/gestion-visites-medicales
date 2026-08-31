<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediGest · Gestion des visites</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet" />
<style>
    :root {
        --color-primary: #2563eb;
        --color-primary-dark: #1d4ed8;
        --color-primary-light: #dbeafe;
        --color-secondary: #7c3aed;
        --color-success: #22c55e;
        --color-warning: #eab308;
        --color-danger: #ef4444;
        --color-gray-50: #f8fafc;
        --color-gray-100: #f1f5f9;
        --color-gray-200: #e2e8f0;
        --color-gray-300: #cbd5e1;
        --color-gray-500: #64748b;
        --color-gray-600: #475569;
        --color-gray-700: #334155;
        --color-gray-800: #1e293b;
        --color-gray-900: #0b1e33;
        --font-primary: 'Inter', -apple-system, sans-serif;
        --radius-md: 16px;
        --radius-lg: 24px;
        --radius-xl: 32px;
        --radius-full: 9999px;
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
        align-items:center;
        min-height:100vh;
        padding:24px;
    }

    .app-container {
        max-width: 900px;
        width:100%;
        background:white;
        border-radius: var(--radius-xl);
        box-shadow: var(--shadow-xl);
        overflow:hidden;
    }

    .app-header {
        padding: 32px;
        text-align:center;
        background: linear-gradient(145deg, var(--color-primary), var(--color-secondary));
        color:white;
    }

    .app-header .logo-icon {
        width:56px; height:56px;
        background:rgba(255,255,255,0.15);
        border-radius: var(--radius-md);
        display:flex; align-items:center; justify-content:center;
        margin:0 auto 14px;
        font-size:26px;
    }

    .app-header h1 {
        font-size:22px;
        font-weight:700;
        letter-spacing:-0.3px;
    }

    .app-header p {
        margin-top:6px;
        font-size:14px;
        opacity:0.85;
    }

    .content-area {
        padding: 32px;
        display:grid;
        grid-template-columns: 1fr 1fr;
        gap:18px;
    }

    .nav-card {
        display:flex;
        align-items:center;
        gap:16px;
        padding:22px;
        border-radius: var(--radius-lg);
        border:1px solid var(--color-gray-200);
        text-decoration:none;
        color: var(--color-gray-900);
        transition: all 0.2s;
        box-shadow: 0 1px 3px rgba(0,0,0,0.04);
    }

    .nav-card:hover {
        border-color: var(--color-primary);
        box-shadow: var(--shadow-md);
        transform: translateY(-2px);
    }

    .nav-card .icon {
        width:48px; height:48px;
        border-radius: var(--radius-md);
        display:flex; align-items:center; justify-content:center;
        font-size:20px;
        color:white;
        flex-shrink:0;
    }

    .nav-card .icon.blue { background: linear-gradient(145deg,#2563eb,#1d4ed8); }
    .nav-card .icon.purple { background: linear-gradient(145deg,#7c3aed,#6d28d9); }
    .nav-card .icon.green { background: linear-gradient(145deg,#22c55e,#16a34a); }

    .nav-card h3 {
        font-size:16px;
        font-weight:700;
    }

    .nav-card p {
        font-size:13px;
        color: var(--color-gray-500);
        margin-top:2px;
    }

    .app-footer {
        text-align:center;
        padding:16px;
        font-size:13px;
        color: var(--color-gray-500);
        border-top:1px solid var(--color-gray-200);
    }

    @media (max-width:640px) {
        .content-area { grid-template-columns: 1fr; }
    }
</style>
</head>
<body>

<div class="app-container">

    <header class="app-header">
        <div class="logo-icon"><i class="fas fa-heartbeat"></i></div>
        <h1>Gestion des visites de medicaments — Centre Médical</h1>
        <p>Médecins · Patients · Visites</p>
    </header>

    <main class="content-area">

        <a href="MedecinServlet" class="nav-card">
            <div class="icon blue"><i class="fas fa-user-md"></i></div>
            <div>
                <h3>Médecins</h3>
                <p>Ajouter, modifier, consulter</p>
            </div>
        </a>

        <a href="PatientServlet" class="nav-card">
            <div class="icon purple"><i class="fas fa-user-injured"></i></div>
            <div>
                <h3>Patients</h3>
                <p>Ajouter, modifier, rechercher</p>
            </div>
        </a>

        <a href="VisiteServlet" class="nav-card">
            <div class="icon green"><i class="fas fa-calendar-check"></i></div>
            <div>
                <h3>Visites</h3>
                <p>Planifiera et dada  et gérer les visites</p>
            </div>
        </a>

    </main>

    <footer class="app-footer">
        © 2026 Gestion des Visites · Centre Médical
    </footer>

</div>

</body>
</html>