<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analyse de Performance - Entraîneur | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar-link { transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background: #eff6ff; color: #2563eb; border-right: 3px solid #2563eb; }
    </style>
</head>
<body class="bg-slate-50 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <aside class="w-64 bg-white border-r border-slate-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-blue-700 rounded-lg flex items-center justify-center"><i class="fas fa-dumbbell text-white"></i></div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="../athletes/athletes.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="../entrainements/entrainements.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-calendar-alt w-6"></i>Planification</a>
                    <a href="analyse.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-line w-6"></i>Analyse Performance</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting Terrain</a>
                    <a href="../communication/communication.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-comments w-6"></i>Communication</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-slate-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-slate-500 hover:text-blue-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-slate-200 sticky top-0 z-30">
                <div class="px-8 py-4">
                    <h1 class="text-2xl font-bold text-slate-800">Analyse de Performance</h1>
                    <p class="text-slate-500 text-sm">Exploitation des données de performance</p>
                </div>
            </header>

            <main class="p-8">
                <!-- Athlete Selector -->
                <div class="bg-white rounded-2xl shadow-sm p-4 mb-6">
                    <div class="flex items-center gap-4">
                        <label class="text-sm font-medium text-slate-700">Sélectionner un athlète:</label>
                        <select class="px-4 py-2 border border-slate-200 rounded-xl flex-1 max-w-md">
                            <option>Rakoto Jean - 100m/200m</option>
                            <option>Andria Marie - 400m/800m</option>
                            <option>Rasoa Paul - Saut/Longueur</option>
                        </select>
                        <button class="px-4 py-2 bg-blue-600 text-white rounded-xl font-medium"><i class="fas fa-sync-alt mr-2"></i>Analyser</button>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                    <!-- Performance Chart -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4">Évolution 100m - Rakoto Jean</h2>
                        <canvas id="perfChart" height="250"></canvas>
                    </div>
                    <!-- Stats Comparison -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4">Comparaison vs Objectifs</h2>
                        <div class="space-y-4">
                            <div>
                                <div class="flex justify-between text-sm mb-1"><span class="text-slate-600">100m Actuel: 10.45s</span><span class="font-semibold text-slate-800">Objectif: 10.30s</span></div>
                                <div class="w-full h-3 bg-slate-200 rounded-full"><div class="h-3 bg-blue-500 rounded-full" style="width: 85%"></div></div>
                            </div>
                            <div>
                                <div class="flex justify-between text-sm mb-1"><span class="text-slate-600">200m Actuel: 21.32s</span><span class="font-semibold text-slate-800">Objectif: 21.00s</span></div>
                                <div class="w-full h-3 bg-slate-200 rounded-full"><div class="h-3 bg-blue-500 rounded-full" style="width: 75%"></div></div>
                            </div>
                            <div>
                                <div class="flex justify-between text-sm mb-1"><span class="text-slate-600">Score IA: 87.5</span><span class="font-semibold text-slate-800">Target: 90.0</span></div>
                                <div class="w-full h-3 bg-slate-200 rounded-full"><div class="h-3 bg-purple-500 rounded-full" style="width: 90%"></div></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- AI Insights -->
                <div class="bg-gradient-to-r from-purple-600 to-indigo-600 rounded-2xl p-6 text-white">
                    <h3 class="font-semibold mb-2"><i class="fas fa-robot mr-2"></i>Insights IA - Talent Scoring System</h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
                        <div class="bg-white/10 rounded-xl p-4">
                            <p class="text-purple-100 text-sm">Potentiel</p>
                            <p class="text-2xl font-bold">Elite (92%)</p>
                        </div>
                        <div class="bg-white/10 rounded-xl p-4">
                            <p class="text-purple-100 text-sm">Progression</p>
                            <p class="text-2xl font-bold">+5.2% /mois</p>
                        </div>
                        <div class="bg-white/10 rounded-xl p-4">
                            <p class="text-purple-100 text-sm">Risque blessure</p>
                            <p class="text-2xl font-bold text-blue-300">Faible</p>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        new Chart(document.getElementById('perfChart'), {
            type: 'line',
            data: {
                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai'],
                datasets: [{
                    label: '100m (s)',
                    data: [10.85, 10.72, 10.65, 10.52, 10.45],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { reverse: true, min: 10.2, max: 11.0 } } }
        });
    </script>
</body>
</html>
