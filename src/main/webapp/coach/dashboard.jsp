<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Entraîneur | SPORT CONNECT</title>
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
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-blue-700 rounded-lg flex items-center justify-center"><i class="fas fa-dumbbell text-white"></i></div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <div class="mb-6 p-4 bg-blue-50 rounded-xl">
                    <p class="text-xs text-blue-600 font-semibold uppercase">Entraîneur</p>
                    <p class="font-semibold text-slate-800">Rakoto Luc</p>
                    <p class="text-xs text-slate-500">CAA - Athlétisme</p>
                </div>
                <nav class="space-y-1">
                    <a href="dashboard.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="athletes/athletes.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="entrainements/entrainements.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-calendar-alt w-6"></i>Planification</a>
                    <a href="analyse/analyse.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-line w-6"></i>Analyse Performance</a>
                    <a href="competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting Terrain</a>
                    <a href="communication/communication.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-comments w-6"></i>Communication</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-slate-200">
                    <a href="../index.jsp" class="flex items-center px-4 py-3 text-slate-500 hover:text-red-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-slate-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Tableau de Bord Entraîneur</h1>
                        <p class="text-slate-500 text-sm">Vue d'ensemble de l'équipe</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <img src="https://ui-avatars.com/api/?name=Coach+Rakoto&background=10b981&color=fff" class="w-10 h-10 rounded-full border-2 border-blue-200">
                        <span class="font-medium text-slate-700">Rakoto Luc</span>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Team Stats -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-users text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Athlètes encadrés</h3>
                        <p class="text-2xl font-bold text-slate-800">24</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-check-circle text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Actifs</h3>
                        <p class="text-2xl font-bold text-slate-800">21</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-band-aid text-red-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Blessés</h3>
                        <p class="text-2xl font-bold text-slate-800">2</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-star text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Score talent moyen</h3>
                        <p class="text-2xl font-bold text-slate-800">78.4</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Next Sessions -->
                    <div class="bg-white rounded-2xl shadow-sm">
                        <div class="p-6 border-b border-slate-100">
                            <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-calendar-alt text-blue-500 mr-2"></i>Prochains entraînements</h2>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <div class="flex items-center p-4 bg-blue-50 rounded-xl">
                                    <div class="w-16 h-16 bg-blue-100 rounded-xl flex flex-col items-center justify-center mr-4">
                                        <span class="text-xs text-blue-600 font-bold">MAI</span>
                                        <span class="text-xl font-bold text-blue-700">07</span>
                                    </div>
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Entraînement 100m/200m</h4>
                                        <p class="text-sm text-slate-500">06:00 - 08:00 • Stade Mahamasina</p>
                                        <p class="text-sm text-slate-600 mt-1">Groupe: 8 athlètes</p>
                                    </div>
                                </div>
                                <div class="flex items-center p-4 bg-slate-50 rounded-xl">
                                    <div class="w-16 h-16 bg-slate-100 rounded-xl flex flex-col items-center justify-center mr-4">
                                        <span class="text-xs text-slate-600 font-bold">MAI</span>
                                        <span class="text-xl font-bold text-slate-700">09</span>
                                    </div>
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Renforcement musculaire</h4>
                                        <p class="text-sm text-slate-500">16:00 - 18:00 • Salle de sport CAA</p>
                                        <p class="text-sm text-slate-600 mt-1">Groupe: 12 athlètes</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Performance Alerts -->
                    <div class="bg-white rounded-2xl shadow-sm">
                        <div class="p-6 border-b border-slate-100">
                            <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-exclamation-triangle text-blue-500 mr-2"></i>Alertes athlètes</h2>
                        </div>
                        <div class="p-6">
                            <div class="space-y-4">
                                <div class="flex items-start p-4 bg-red-50 rounded-xl border-l-4 border-red-500">
                                    <i class="fas fa-band-aid text-red-500 mt-1 mr-3"></i>
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Andria Marie - Blessure</h4>
                                        <p class="text-sm text-slate-600 mt-1">Tension ischio-jambier signalée hier</p>
                                    </div>
                                </div>
                                <div class="flex items-start p-4 bg-blue-50 rounded-xl border-l-4 border-amber-500">
                                    <i class="fas fa-chart-line text-blue-500 mt-1 mr-3"></i>
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Raso Paul - Régression</h4>
                                        <p class="text-sm text-slate-600 mt-1">Chrono 100m dégradé de 0.3s</p>
                                    </div>
                                </div>
                                <div class="flex items-start p-4 bg-green-50 rounded-xl border-l-4 border-green-500">
                                    <i class="fas fa-arrow-up text-blue-500 mt-1 mr-3"></i>
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Rakoto Jean - Progression</h4>
                                        <p class="text-sm text-slate-600 mt-1">Nouveau PB sur 100m: 10.45s</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
