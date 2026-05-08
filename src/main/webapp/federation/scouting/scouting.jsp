<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scouting & Talents - Fédération | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar-link { transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background: #eff6ff; color: #2563eb; border-right: 3px solid #2563eb; }
        .talent-card { transition: all 0.3s ease; }
        .talent-card:hover { transform: translateY(-4px); box-shadow: 0 12px 24px rgba(0,0,0,0.1); }
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
                    <a href="scouting.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting & Talents</a>
                    <a href="../finances/finances.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-money-bill-wave w-6"></i>Finances & Licences</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-pie w-6"></i>Rapports & Stats</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-slate-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-slate-500 hover:text-red-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-slate-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Scouting & Détection des Talents</h1>
                        <p class="text-slate-500 text-sm">Identification des jeunes talents avec IA</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <span class="px-3 py-1 bg-blue-100 text-purple-700 rounded-full text-sm font-medium"><i class="fas fa-robot mr-1"></i>IA Activée</span>
                        <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition"><i class="fas fa-plus mr-2"></i>Nouvelle évaluation</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- AI Alert Banner -->
                <div class="bg-gradient-to-r from-purple-600 to-indigo-600 rounded-2xl p-6 mb-8 text-white">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <div class="w-14 h-14 bg-white/20 rounded-xl flex items-center justify-center">
                                <i class="fas fa-star text-white text-2xl"></i>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold">Talent Exceptionnel Détecté !</h3>
                                <p class="text-purple-100">L'IA a identifié un athlète avec un potentiel "Elite" - Score: 92.4</p>
                            </div>
                        </div>
                        <button class="px-6 py-3 bg-white text-blue-600 rounded-xl font-semibold hover:bg-purple-50 transition">Voir le profil</button>
                    </div>
                </div>

                <!-- Talent Stats -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-star text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Talents Elite</h3>
                        <p class="text-2xl font-bold text-slate-800">24</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-arrow-up text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Prometteurs</h3>
                        <p class="text-2xl font-bold text-slate-800">156</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-eye text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">À suivre</h3>
                        <p class="text-2xl font-bold text-slate-800">342</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-chart-line text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Évaluations ce mois</h3>
                        <p class="text-2xl font-bold text-slate-800">89</p>
                    </div>
                </div>

                <!-- Top Talents -->
                <div class="bg-white rounded-2xl shadow-sm mb-8">
                    <div class="p-6 border-b border-slate-100 flex items-center justify-between">
                        <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-crown text-blue-500 mr-2"></i>Top Talents Identifiés</h2>
                        <div class="flex gap-2">
                            <select class="px-3 py-2 border border-slate-200 rounded-lg text-sm"><option>Tous les âges</option><option>14-16 ans</option><option>17-19 ans</option></select>
                            <select class="px-3 py-2 border border-slate-200 rounded-lg text-sm"><option>Toutes disciplines</option><option>100m</option><option>200m</option></select>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <div class="talent-card border border-slate-200 rounded-xl p-4">
                                <div class="flex items-center mb-4">
                                    <img src="https://ui-avatars.com/api/?name=Koto+Andria&background=8b5cf6&color=fff" class="w-14 h-14 rounded-xl mr-3">
                                    <div>
                                        <h4 class="font-bold text-slate-800">Andria Koto</h4>
                                        <p class="text-sm text-slate-500">16 ans • CAA</p>
                                    </div>
                                    <span class="ml-auto px-3 py-1 bg-blue-100 text-purple-700 rounded-full text-sm font-bold">92.4</span>
                                </div>
                                <div class="space-y-2 mb-4">
                                    <div class="flex justify-between text-sm"><span class="text-slate-500">100m</span><span class="font-semibold text-slate-800">10.85s</span></div>
                                    <div class="flex justify-between text-sm"><span class="text-slate-500">200m</span><span class="font-semibold text-slate-800">22.15s</span></div>
                                </div>
                                <span class="px-3 py-1 bg-blue-100 text-purple-700 rounded-lg text-sm font-medium">Catégorie: Elite</span>
                            </div>
                            <div class="talent-card border border-slate-200 rounded-xl p-4">
                                <div class="flex items-center mb-4">
                                    <img src="https://ui-avatars.com/api/?name=Raso+Jean&background=3b82f6&color=fff" class="w-14 h-14 rounded-xl mr-3">
                                    <div>
                                        <h4 class="font-bold text-slate-800">Raso Jean</h4>
                                        <p class="text-sm text-slate-500">17 ans • Club Olympique</p>
                                    </div>
                                    <span class="ml-auto px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-bold">88.7</span>
                                </div>
                                <div class="space-y-2 mb-4">
                                    <div class="flex justify-between text-sm"><span class="text-slate-500">Longueur</span><span class="font-semibold text-slate-800">6.85m</span></div>
                                    <div class="flex justify-between text-sm"><span class="text-slate-500">Triple saut</span><span class="font-semibold text-slate-800">14.20m</span></div>
                                </div>
                                <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Catégorie: Prometteur</span>
                            </div>
                            <div class="talent-card border border-slate-200 rounded-xl p-4">
                                <div class="flex items-center mb-4">
                                    <img src="https://ui-avatars.com/api/?name=Ravao+Marie&background=10b981&color=fff" class="w-14 h-14 rounded-xl mr-3">
                                    <div>
                                        <h4 class="font-bold text-slate-800">Ravao Marie</h4>
                                        <p class="text-sm text-slate-500">15 ans • ASSA</p>
                                    </div>
                                    <span class="ml-auto px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-bold">85.2</span>
                                </div>
                                <div class="space-y-2 mb-4">
                                    <div class="flex justify-between text-sm"><span class="text-slate-500">800m</span><span class="font-semibold text-slate-800">2:15.45</span></div>
                                    <div class="flex justify-between text-sm"><span class="text-slate-500">1500m</span><span class="font-semibold text-slate-800">4:45.20</span></div>
                                </div>
                                <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Catégorie: Prometteur</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- AI Evaluation Chart -->
                <div class="bg-white rounded-2xl shadow-sm p-6">
                    <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-robot text-purple-500 mr-2"></i>Talent Scoring System - Paramètres IA</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <canvas id="talentChart" height="200"></canvas>
                        <div class="space-y-4">
                            <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                <span class="text-slate-700">Performance brute</span>
                                <span class="font-semibold text-slate-800">40%</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                <span class="text-slate-700">Progression annuelle</span>
                                <span class="font-semibold text-slate-800">25%</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                <span class="text-slate-700">Âge / Potentiel</span>
                                <span class="font-semibold text-slate-800">20%</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                <span class="text-slate-700">Cohérence mentale</span>
                                <span class="font-semibold text-slate-800">15%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        new Chart(document.getElementById('talentChart'), {
            type: 'doughnut',
            data: {
                labels: ['Performance brute', 'Progression', 'Âge/Potentiel', 'Mental'],
                datasets: [{
                    data: [40, 25, 20, 15],
                    backgroundColor: ['#3b82f6', '#10b981', '#f59e0b', '#8b5cf6'],
                    borderWidth: 0
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });
    </script>
</body>
</html>
