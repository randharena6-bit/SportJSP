<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Clubs - Fédération | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .gradient-bg { background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%); }
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
                    <a href="clubs.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-building w-6"></i>Gestion Clubs</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting & Talents</a>
                    <a href="../finances/finances.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-money-bill-wave w-6"></i>Finances & Licences</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-pie w-6"></i>Rapports & Stats</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Gestion des Clubs</h1>
                        <p class="text-slate-500 text-sm">Affiliation et gestion des clubs</p>
                    </div>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition"><i class="fas fa-plus mr-2"></i>Nouveau club</button>
                </div>
            </header>

            <main class="p-8">
                <!-- Clubs Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Club Card 1 -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-16 h-16 bg-blue-100 rounded-xl flex items-center justify-center"><i class="fas fa-running text-blue-600 text-2xl"></i></div>
                            <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium">Conforme</span>
                        </div>
                        <h3 class="text-lg font-bold text-slate-800">Club Athlétisme Antananarivo</h3>
                        <p class="text-slate-500 text-sm mb-4">CAA • Créé en 1985</p>
                        <div class="grid grid-cols-3 gap-4 mb-4 text-center">
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">145</div><div class="text-xs text-slate-500">Athlètes</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">8</div><div class="text-xs text-slate-500">Staff</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">12</div><div class="text-xs text-slate-500">Entraîneurs</div></div>
                        </div>
                        <div class="flex gap-2">
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-blue-200"><i class="fas fa-eye mr-1"></i>Détails</button>
                            <button class="flex-1 py-2 bg-slate-100 text-slate-700 rounded-lg font-medium hover:bg-slate-200"><i class="fas fa-edit mr-1"></i>Modifier</button>
                        </div>
                    </div>

                    <!-- Club Card 2 -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-16 h-16 bg-blue-100 rounded-xl flex items-center justify-center"><i class="fas fa-medal text-blue-600 text-2xl"></i></div>
                            <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium">Conforme</span>
                        </div>
                        <h3 class="text-lg font-bold text-slate-800">Club Olympique de Toamasina</h3>
                        <p class="text-slate-500 text-sm mb-4">COT • Créé en 1992</p>
                        <div class="grid grid-cols-3 gap-4 mb-4 text-center">
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">98</div><div class="text-xs text-slate-500">Athlètes</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">6</div><div class="text-xs text-slate-500">Staff</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">8</div><div class="text-xs text-slate-500">Entraîneurs</div></div>
                        </div>
                        <div class="flex gap-2">
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-blue-200"><i class="fas fa-eye mr-1"></i>Détails</button>
                            <button class="flex-1 py-2 bg-slate-100 text-slate-700 rounded-lg font-medium hover:bg-slate-200"><i class="fas fa-edit mr-1"></i>Modifier</button>
                        </div>
                    </div>

                    <!-- Club Card 3 -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-16 h-16 bg-blue-100 rounded-xl flex items-center justify-center"><i class="fas fa-star text-blue-600 text-2xl"></i></div>
                            <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium">Action requise</span>
                        </div>
                        <h3 class="text-lg font-bold text-slate-800">AS Sportive d'Antsirabe</h3>
                        <p class="text-slate-500 text-sm mb-4">ASSA • Créé en 2005</p>
                        <div class="grid grid-cols-3 gap-4 mb-4 text-center">
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">67</div><div class="text-xs text-slate-500">Athlètes</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">4</div><div class="text-xs text-slate-500">Staff</div></div>
                            <div class="bg-slate-50 rounded-lg p-2"><div class="text-xl font-bold text-blue-600">2</div><div class="text-xs text-slate-500">Entraîneurs</div></div>
                        </div>
                        <div class="flex gap-2">
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-blue-200"><i class="fas fa-eye mr-1"></i>Détails</button>
                            <button class="flex-1 py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-blue-200"><i class="fas fa-exclamation-triangle mr-1"></i>Vérifier</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
