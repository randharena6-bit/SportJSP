<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Athlètes - Entraîneur | SPORT CONNECT</title>
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
                    <a href="athletes.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="../entrainements/entrainements.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-calendar-alt w-6"></i>Planification</a>
                    <a href="../analyse/analyse.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-line w-6"></i>Analyse Performance</a>
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
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Gestion des Athlètes</h1>
                        <p class="text-slate-500 text-sm">Suivi individualisé de chaque athlète</p>
                    </div>
                    <div class="flex gap-3">
                        <button class="px-4 py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-blue-200"><i class="fas fa-file-export mr-2"></i>Export rapports</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Athletes Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Athlete Card 1 -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <div class="flex items-center mb-4">
                            <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff" class="w-16 h-16 rounded-xl mr-4">
                            <div>
                                <h3 class="font-bold text-slate-800">Rakoto Jean</h3>
                                <p class="text-sm text-slate-500">Senior • 100m/200m</p>
                                <span class="inline-flex items-center px-2 py-0.5 bg-blue-100 text-blue-700 rounded text-xs mt-1">Actif</span>
                            </div>
                        </div>
                        <div class="grid grid-cols-3 gap-2 text-center mb-4">
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">10.45s</div><div class="text-xs text-slate-500">100m PB</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">21.32s</div><div class="text-xs text-slate-500">200m PB</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">87.5</div><div class="text-xs text-slate-500">Score IA</div></div>
                        </div>
                        <div class="flex gap-2">
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium hover:bg-blue-200"><i class="fas fa-chart-line mr-1"></i>Stats</button>
                            <button class="flex-1 py-2 bg-slate-100 text-slate-700 rounded-lg text-sm font-medium hover:bg-slate-200"><i class="fas fa-edit mr-1"></i>Saisie</button>
                        </div>
                    </div>

                    <!-- Athlete Card 2 -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <div class="flex items-center mb-4">
                            <img src="https://ui-avatars.com/api/?name=Marie+Andria&background=2563eb&color=fff" class="w-16 h-16 rounded-xl mr-4">
                            <div>
                                <h3 class="font-bold text-slate-800">Andria Marie</h3>
                                <p class="text-sm text-slate-500">Junior • 400m/800m</p>
                                <span class="inline-flex items-center px-2 py-0.5 bg-blue-100 text-blue-700 rounded text-xs mt-1">Blessée</span>
                            </div>
                        </div>
                        <div class="grid grid-cols-3 gap-2 text-center mb-4">
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">58.45s</div><div class="text-xs text-slate-500">400m PB</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">2:15.20</div><div class="text-xs text-slate-500">800m PB</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">78.2</div><div class="text-xs text-slate-500">Score IA</div></div>
                        </div>
                        <div class="flex gap-2">
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium hover:bg-blue-200"><i class="fas fa-chart-line mr-1"></i>Stats</button>
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium hover:bg-blue-200"><i class="fas fa-heartbeat mr-1"></i>Santé</button>
                        </div>
                    </div>

                    <!-- Athlete Card 3 -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <div class="flex items-center mb-4">
                            <img src="https://ui-avatars.com/api/?name=Paul+Rasoa&background=2563eb&color=fff" class="w-16 h-16 rounded-xl mr-4">
                            <div>
                                <h3 class="font-bold text-slate-800">Rasoa Paul</h3>
                                <p class="text-sm text-slate-500">Junior • Saut/Longueur</p>
                                <span class="inline-flex items-center px-2 py-0.5 bg-blue-100 text-blue-700 rounded text-xs mt-1">Actif</span>
                            </div>
                        </div>
                        <div class="grid grid-cols-3 gap-2 text-center mb-4">
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">6.85m</div><div class="text-xs text-slate-500">Longueur</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">14.20m</div><div class="text-xs text-slate-500">Triple</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-lg font-bold text-blue-600">72.4</div><div class="text-xs text-slate-500">Score IA</div></div>
                        </div>
                        <div class="flex gap-2">
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium hover:bg-blue-200"><i class="fas fa-chart-line mr-1"></i>Stats</button>
                            <button class="flex-1 py-2 bg-slate-100 text-slate-700 rounded-lg text-sm font-medium hover:bg-slate-200"><i class="fas fa-edit mr-1"></i>Saisie</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
