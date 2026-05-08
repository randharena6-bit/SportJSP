<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rapports & Statistiques - Fédération | SPORT CONNECT</title>
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
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-slate-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-blue-700 rounded-lg flex items-center justify-center">
                        <i class="fas fa-landmark text-white"></i>
                    </div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="../athletes/athletes.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="../clubs/clubs.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-building w-6"></i>Gestion Clubs</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting & Talents</a>
                    <a href="../finances/finances.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-money-bill-wave w-6"></i>Finances & Licences</a>
                    <a href="rapports.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-pie w-6"></i>Rapports & Stats</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-slate-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-slate-500 hover:text-blue-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-slate-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Rapports & Statistiques</h1>
                        <p class="text-slate-500 text-sm">Analyse et reporting fédéral</p>
                    </div>
                    <div class="flex gap-3">
                        <select class="px-4 py-2 border border-slate-200 rounded-lg text-sm">
                            <option>Saison 2024-2025</option>
                            <option>Saison 2023-2024</option>
                        </select>
                        <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-download mr-2"></i>Exporter rapport</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Report Cards -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-users text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Croissance licenciés</h3>
                        <p class="text-2xl font-bold text-slate-800">+12.4%</p>
                        <p class="text-xs text-blue-500 mt-1"><i class="fas fa-arrow-up"></i> vs saison précédente</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-trophy text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Compétitions organisées</h3>
                        <p class="text-2xl font-bold text-slate-800">18</p>
                        <p class="text-xs text-slate-500 mt-1">Saison en cours</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-star text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Talents identifiés</h3>
                        <p class="text-2xl font-bold text-slate-800">47</p>
                        <p class="text-xs text-blue-500 mt-1"><i class="fas fa-arrow-up"></i> +15 vs N-1</p>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4">Évolution des licenciés par saison</h2>
                        <canvas id="evolutionChart" height="250"></canvas>
                    </div>
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4">Répartition par catégorie</h2>
                        <canvas id="categoryChart" height="250"></canvas>
                    </div>
                </div>

                <div class="bg-white rounded-2xl shadow-sm p-6 mb-8">
                    <h2 class="text-lg font-bold text-slate-800 mb-4">Participation aux compétitions</h2>
                    <canvas id="participationChart" height="200"></canvas>
                </div>

                <!-- Pipeline Detection -->
                <div class="bg-white rounded-2xl shadow-sm">
                    <div class="p-6 border-b border-slate-100">
                        <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-project-diagram text-blue-500 mr-2"></i>Pipeline de détection des talents</h2>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                            <div class="bg-slate-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-slate-700 mb-1">523</div>
                                <div class="text-sm text-slate-500">Scoutés</div>
                            </div>
                            <div class="bg-blue-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-blue-700 mb-1">156</div>
                                <div class="text-sm text-slate-500">Évaluations IA</div>
                            </div>
                            <div class="bg-purple-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-purple-700 mb-1">47</div>
                                <div class="text-sm text-slate-500">Talents confirmés</div>
                            </div>
                            <div class="bg-blue-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-blue-700 mb-1">12</div>
                                <div class="text-sm text-slate-500">Intégrés centres</div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        new Chart(document.getElementById('evolutionChart'), {
            type: 'line',
            data: {
                labels: ['2020', '2021', '2022', '2023', '2024', '2025'],
                datasets: [{
                    label: 'Licenciés',
                    data: [850, 920, 980, 1050, 1150, 1247],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } } }
        });

        new Chart(document.getElementById('categoryChart'), {
            type: 'doughnut',
            data: {
                labels: ['Senior', 'U23', 'Junior', 'Cadet', 'Minime'],
                datasets: [{
                    data: [456, 312, 287, 134, 58],
                    backgroundColor: ['#3b82f6', '#10b981', '#f59e0b', '#8b5cf6', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'right' } } }
        });

        new Chart(document.getElementById('participationChart'), {
            type: 'bar',
            data: {
                labels: ['Championnat National', 'Meeting Régional', 'Coupe des Clubs', 'Tournoi Junior', 'Inter-clubs'],
                datasets: [{
                    label: 'Participants 2024',
                    data: [156, 234, 89, 178, 145],
                    backgroundColor: '#3b82f6',
                    borderRadius: 6
                }, {
                    label: 'Participants 2025',
                    data: [189, 256, 98, 198, 167],
                    backgroundColor: '#10b981',
                    borderRadius: 6
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });
    </script>
</body>
</html>
