<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planification Entraînements - Entraîneur | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
                    <a href="entrainements.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-calendar-alt w-6"></i>Planification</a>
                    <a href="../analyse/analyse.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-line w-6"></i>Analyse Performance</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting Terrain</a>
                    <a href="../communication/communication.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-comments w-6"></i>Communication</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Planification des Entraînements</h1>
                        <p class="text-slate-500 text-sm">Organisation des séances d'entraînement</p>
                    </div>
                    <button class="px-4 py-2 bg-emerald-600 text-white rounded-lg font-medium hover:bg-emerald-700"><i class="fas fa-plus mr-2"></i>Nouvelle séance</button>
                </div>
            </header>

            <main class="p-8">
                <!-- Calendar View -->
                <div class="bg-white rounded-2xl shadow-sm p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-bold text-slate-800">Semaine du 5 au 11 Mai 2025</h2>
                        <div class="flex gap-2">
                            <button class="px-3 py-1 border border-slate-300 rounded-lg text-slate-600 hover:bg-slate-50"><i class="fas fa-chevron-left"></i></button>
                            <button class="px-3 py-1 border border-slate-300 rounded-lg text-slate-600 hover:bg-slate-50"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-7 gap-2">
                        <div class="text-center"><div class="text-sm text-slate-500">Lun</div><div class="font-semibold">5</div></div>
                        <div class="text-center"><div class="text-sm text-slate-500">Mar</div><div class="font-semibold">6</div></div>
                        <div class="text-center"><div class="text-sm text-slate-500">Mer</div><div class="font-semibold text-blue-600">7</div></div>
                        <div class="text-center"><div class="text-sm text-slate-500">Jeu</div><div class="font-semibold">8</div></div>
                        <div class="text-center"><div class="text-sm text-slate-500">Ven</div><div class="font-semibold text-blue-600">9</div></div>
                        <div class="text-center"><div class="text-sm text-slate-500">Sam</div><div class="font-semibold">10</div></div>
                        <div class="text-center"><div class="text-sm text-slate-500">Dim</div><div class="font-semibold">11</div></div>
                    </div>

                    <div class="mt-6 space-y-3">
                        <div class="flex items-center p-4 bg-blue-50 rounded-xl border-l-4 border-emerald-500">
                            <div class="w-16 text-center mr-4">
                                <div class="text-sm font-bold text-blue-700">06:00</div>
                                <div class="text-xs text-blue-600">08:00</div>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-semibold text-slate-800">Entraînement 100m/200m</h4>
                                <p class="text-sm text-slate-500">Stade Mahamasina • 8 athlètes</p>
                            </div>
                            <div class="flex gap-2">
                                <button class="px-3 py-1 bg-white text-slate-600 rounded-lg text-sm hover:bg-slate-50"><i class="fas fa-edit"></i></button>
                                <button class="px-3 py-1 bg-white text-red-600 rounded-lg text-sm hover:bg-red-50"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                        <div class="flex items-center p-4 bg-blue-50 rounded-xl border-l-4 border-blue-500">
                            <div class="w-16 text-center mr-4">
                                <div class="text-sm font-bold text-blue-700">16:00</div>
                                <div class="text-xs text-blue-600">18:00</div>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-semibold text-slate-800">Renforcement musculaire</h4>
                                <p class="text-sm text-slate-500">Salle CAA • 12 athlètes</p>
                            </div>
                            <div class="flex gap-2">
                                <button class="px-3 py-1 bg-white text-slate-600 rounded-lg text-sm hover:bg-slate-50"><i class="fas fa-edit"></i></button>
                                <button class="px-3 py-1 bg-white text-red-600 rounded-lg text-sm hover:bg-red-50"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
