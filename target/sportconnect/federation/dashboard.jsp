<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Fédération | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: { 50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a' },
                        secondary: { 50: '#f8fafc', 100: '#f1f5f9', 200: '#e2e8f0', 300: '#cbd5e1', 400: '#94a3b8', 500: '#64748b', 600: '#475569', 700: '#334155', 800: '#1e293b', 900: '#0f172a' },
                        amber: { 400: '#fbbf24', 500: '#f59e0b', 600: '#d97706' }
                    }
                }
            }
        }
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .gradient-bg { background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%); }
        .sidebar-link { transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background: #eff6ff; color: #2563eb; border-right: 3px solid #2563eb; }
        .card-hover { transition: all 0.3s ease; }
        .card-hover:hover { transform: translateY(-4px); box-shadow: 0 12px 24px rgba(0,0,0,0.1); }
    </style>
</head>
<body class="bg-secondary-50 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-secondary-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 bg-gradient-to-br from-amber-400 to-amber-600 rounded-lg flex items-center justify-center">
                        <i class="fas fa-landmark text-white"></i>
                    </div>
                    <span class="text-xl font-bold text-secondary-800">SPORT<span class="text-primary-600">CONNECT</span></span>
                </div>
                <div class="mb-6 p-4 bg-amber-50 rounded-xl">
                    <p class="text-xs text-amber-600 font-semibold uppercase tracking-wider mb-1">Fédération</p>
                    <p class="font-semibold text-secondary-800">Fédération Malgache d'Athlétisme</p>
                    <p class="text-xs text-secondary-500 mt-1">Administrateur: M. Rabe</p>
                </div>
                <nav class="space-y-1">
                    <a href="dashboard.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="athletes/athletes.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="clubs/clubs.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-building w-6"></i>Gestion Clubs</a>
                    <a href="competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-search w-6"></i>Scouting & Talents</a>
                    <a href="finances/finances.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-money-bill-wave w-6"></i>Finances & Licences</a>
                    <a href="rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-chart-pie w-6"></i>Rapports & Stats</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-red-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-secondary-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-secondary-800">Tableau de Bord Fédération</h1>
                        <p class="text-secondary-500 text-sm">Vue d'ensemble opérationnelle - FMA</p>
                    </div>
                    <div class="flex items-center space-x-4">
                        <button class="relative p-2 text-secondary-400 hover:text-secondary-600 transition"><i class="fas fa-bell text-xl"></i><span class="absolute top-0 right-0 w-5 h-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center">5</span></button>
                        <div class="h-8 w-px bg-secondary-200"></div>
                        <div class="flex items-center space-x-3">
                            <img src="https://ui-avatars.com/api/?name=Admin+FMA&background=f59e0b&color=fff" class="w-10 h-10 rounded-full border-2 border-amber-200">
                            <span class="font-medium text-secondary-700">M. Rabe</span>
                        </div>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- KPI Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center"><i class="fas fa-users text-blue-600 text-xl"></i></div>
                            <span class="text-green-500 text-sm font-medium">+12% <i class="fas fa-arrow-up"></i></span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Athlètes licenciés</h3>
                        <p class="text-2xl font-bold text-secondary-800">1,247</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-amber-100 rounded-xl flex items-center justify-center"><i class="fas fa-building text-amber-600 text-xl"></i></div>
                            <span class="text-green-500 text-sm font-medium">+3 <i class="fas fa-arrow-up"></i></span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Clubs affiliés</h3>
                        <p class="text-2xl font-bold text-secondary-800">42</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center"><i class="fas fa-id-card text-green-600 text-xl"></i></div>
                            <span class="text-green-500 text-sm font-medium">95% <i class="fas fa-check"></i></span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Licences actives</h3>
                        <p class="text-2xl font-bold text-secondary-800">1,185</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center"><i class="fas fa-money-bill-wave text-purple-600 text-xl"></i></div>
                            <span class="text-green-500 text-sm font-medium">+8% <i class="fas fa-arrow-up"></i></span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Recettes licences</h3>
                        <p class="text-2xl font-bold text-secondary-800">32.4M Ar</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Left Column -->
                    <div class="lg:col-span-2 space-y-8">
                        <!-- Chart Section -->
                        <div class="bg-white rounded-2xl shadow-sm p-6">
                            <h2 class="text-lg font-bold text-secondary-800 mb-4"><i class="fas fa-chart-line text-primary-500 mr-2"></i>Évolution des licenciés</h2>
                            <canvas id="licenseChart" height="250"></canvas>
                        </div>

                        <!-- Pending Approvals -->
                        <div class="bg-white rounded-2xl shadow-sm">
                            <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                                <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-clock text-amber-500 mr-2"></i>Demandes en attente</h2>
                                <span class="px-3 py-1 bg-amber-100 text-amber-700 rounded-full text-sm font-medium">12 en attente</span>
                            </div>
                            <div class="overflow-x-auto">
                                <table class="w-full">
                                    <thead class="bg-secondary-50">
                                        <tr>
                                            <th class="text-left py-4 px-6 font-semibold text-secondary-700">Athlète</th>
                                            <th class="text-left py-4 px-6 font-semibold text-secondary-700">Type</th>
                                            <th class="text-left py-4 px-6 font-semibold text-secondary-700">Date</th>
                                            <th class="text-left py-4 px-6 font-semibold text-secondary-700">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="border-b border-secondary-100">
                                            <td class="py-4 px-6">
                                                <div class="flex items-center">
                                                    <img src="https://ui-avatars.com/api/?name=Rakoto+Jean&background=3b82f6&color=fff" class="w-10 h-10 rounded-full mr-3">
                                                    <span class="font-medium text-secondary-800">Rakoto Jean</span>
                                                </div>
                                            </td>
                                            <td class="py-4 px-6 text-secondary-700">Nouvelle licence Senior</td>
                                            <td class="py-4 px-6 text-secondary-500">Aujourd'hui</td>
                                            <td class="py-4 px-6">
                                                <button class="px-3 py-1 bg-green-100 text-green-700 rounded-lg text-sm font-medium mr-2 hover:bg-green-200"><i class="fas fa-check mr-1"></i>Valider</button>
                                                <button class="px-3 py-1 bg-red-100 text-red-700 rounded-lg text-sm font-medium hover:bg-red-200"><i class="fas fa-times mr-1"></i>Rejeter</button>
                                            </td>
                                        </tr>
                                        <tr class="border-b border-secondary-100">
                                            <td class="py-4 px-6">
                                                <div class="flex items-center">
                                                    <img src="https://ui-avatars.com/api/?name=Andria+Marie&background=10b981&color=fff" class="w-10 h-10 rounded-full mr-3">
                                                    <span class="font-medium text-secondary-800">Andria Marie</span>
                                                </div>
                                            </td>
                                            <td class="py-4 px-6 text-secondary-700">Renouvellement Junior</td>
                                            <td class="py-4 px-6 text-secondary-500">Hier</td>
                                            <td class="py-4 px-6">
                                                <button class="px-3 py-1 bg-green-100 text-green-700 rounded-lg text-sm font-medium mr-2 hover:bg-green-200"><i class="fas fa-check mr-1"></i>Valider</button>
                                                <button class="px-3 py-1 bg-red-100 text-red-700 rounded-lg text-sm font-medium hover:bg-red-200"><i class="fas fa-times mr-1"></i>Rejeter</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="space-y-8">
                        <!-- Competitions -->
                        <div class="bg-white rounded-2xl shadow-sm">
                            <div class="p-6 border-b border-secondary-100">
                                <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-calendar-alt text-primary-500 mr-2"></i>Compétitions à venir</h2>
                            </div>
                            <div class="p-4">
                                <div class="space-y-3">
                                    <div class="p-3 bg-secondary-50 rounded-xl">
                                        <div class="flex items-center justify-between mb-2">
                                            <span class="px-2 py-1 bg-green-100 text-green-700 rounded text-xs font-medium">En préparation</span>
                                            <span class="text-xs text-secondary-500">Dans 10 jours</span>
                                        </div>
                                        <h4 class="font-semibold text-secondary-800">Championnat National</h4>
                                        <p class="text-xs text-secondary-500 mt-1">Stade Mahamasina • 150 inscrits</p>
                                    </div>
                                    <div class="p-3 bg-secondary-50 rounded-xl">
                                        <div class="flex items-center justify-between mb-2">
                                            <span class="px-2 py-1 bg-amber-100 text-amber-700 rounded text-xs font-medium">Planification</span>
                                            <span class="text-xs text-secondary-500">Juin 2025</span>
                                        </div>
                                        <h4 class="font-semibold text-secondary-800">Meeting International</h4>
                                        <p class="text-xs text-secondary-500 mt-1">Tamatave • À planifier</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Digital Stats -->
                        <div class="bg-gradient-to-br from-primary-600 to-primary-800 rounded-2xl p-6 text-white">
                            <h3 class="font-semibold mb-4"><i class="fas fa-chart-pie mr-2"></i>Taux de Digitalisation</h3>
                            <div class="flex items-center justify-center mb-4">
                                <div class="relative w-28 h-28">
                                    <svg class="w-28 h-28 transform -rotate-90">
                                        <circle cx="56" cy="56" r="48" stroke="rgba(255,255,255,0.2)" stroke-width="8" fill="none"/>
                                        <circle cx="56" cy="56" r="48" stroke="white" stroke-width="8" fill="none" stroke-dasharray="301.59" stroke-dashoffset="45" stroke-linecap="round"/>
                                    </svg>
                                    <div class="absolute inset-0 flex items-center justify-center"><span class="text-2xl font-bold">85%</span></div>
                                </div>
                            </div>
                            <p class="text-center text-primary-100 text-sm">Objectif 2025: 95%</p>
                        </div>

                        <!-- Alerts -->
                        <div class="bg-white rounded-2xl shadow-sm">
                            <div class="p-6 border-b border-secondary-100">
                                <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-exclamation-triangle text-red-500 mr-2"></i>Alertes</h2>
                            </div>
                            <div class="p-4">
                                <div class="space-y-3">
                                    <div class="flex items-start p-3 bg-red-50 rounded-xl">
                                        <i class="fas fa-user-times text-red-500 mt-1 mr-3"></i>
                                        <div>
                                            <p class="text-sm font-medium text-secondary-800">5 dossiers incomplets</p>
                                            <p class="text-xs text-secondary-500">Athlètes sans certificat médical</p>
                                        </div>
                                    </div>
                                    <div class="flex items-start p-3 bg-amber-50 rounded-xl">
                                        <i class="fas fa-exclamation-circle text-amber-500 mt-1 mr-3"></i>
                                        <div>
                                            <p class="text-sm font-medium text-secondary-800">Anomalie détectée</p>
                                            <p class="text-xs text-secondary-500">Performance suspecte - IA Alert</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        new Chart(document.getElementById('licenseChart'), {
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
    </script>
</body>
</html>
