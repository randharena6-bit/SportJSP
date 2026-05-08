<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Communication - Entraîneur | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar-link { transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background: #eff6ff; color: #2563eb; border-right: 3px solid #2563eb; }
        .message-bubble { max-width: 70%; }
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
                    <a href="../analyse/analyse.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-line w-6"></i>Analyse Performance</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting Terrain</a>
                    <a href="communication.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-comments w-6"></i>Communication</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-slate-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-slate-500 hover:text-blue-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-slate-200 sticky top-0 z-30">
                <div class="px-8 py-4">
                    <h1 class="text-2xl font-bold text-slate-800">Communication</h1>
                    <p class="text-slate-500 text-sm">Échanges avec athlètes, médecin et fédération</p>
                </div>
            </header>

            <main class="p-8">
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Contacts List -->
                    <div class="bg-white rounded-2xl shadow-sm">
                        <div class="p-4 border-b border-slate-100">
                            <div class="relative">
                                <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-400"></i>
                                <input type="text" placeholder="Rechercher un contact..." class="w-full pl-10 pr-4 py-2 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none">
                            </div>
                        </div>
                        <div class="p-2">
                            <div class="space-y-1">
                                <div class="flex items-center p-3 bg-blue-50 rounded-xl cursor-pointer">
                                    <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff" class="w-12 h-12 rounded-full mr-3">
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Rakoto Jean</h4>
                                        <p class="text-sm text-slate-500">Athlète - 100m</p>
                                    </div>
                                    <span class="w-3 h-3 bg-blue-500 rounded-full"></span>
                                </div>
                                <div class="flex items-center p-3 hover:bg-slate-50 rounded-xl cursor-pointer">
                                    <img src="https://ui-avatars.com/api/?name=Marie+Andria&background=2563eb&color=fff" class="w-12 h-12 rounded-full mr-3">
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Andria Marie</h4>
                                        <p class="text-sm text-slate-500">Athlète - 400m</p>
                                    </div>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs">2</span>
                                </div>
                                <div class="flex items-center p-3 hover:bg-slate-50 rounded-xl cursor-pointer">
                                    <img src="https://ui-avatars.com/api/?name=Dr+Raso&background=2563eb&color=fff" class="w-12 h-12 rounded-full mr-3">
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Dr. Rasoamanana</h4>
                                        <p class="text-sm text-slate-500">Médecin du sport</p>
                                    </div>
                                </div>
                                <div class="flex items-center p-3 hover:bg-slate-50 rounded-xl cursor-pointer">
                                    <img src="https://ui-avatars.com/api/?name=FMA+Admin&background=2563eb&color=fff" class="w-12 h-12 rounded-full mr-3">
                                    <div class="flex-1">
                                        <h4 class="font-semibold text-slate-800">Fédération FMA</h4>
                                        <p class="text-sm text-slate-500">Direction technique</p>
                                    </div>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs">1</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Chat Area -->
                    <div class="lg:col-span-2 bg-white rounded-2xl shadow-sm flex flex-col h-[600px]">
                        <div class="p-4 border-b border-slate-100 flex items-center">
                            <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff" class="w-10 h-10 rounded-full mr-3">
                            <div>
                                <h4 class="font-semibold text-slate-800">Rakoto Jean</h4>
                                <p class="text-xs text-blue-600">En ligne</p>
                            </div>
                        </div>
                        <div class="flex-1 p-4 overflow-y-auto">
                            <div class="space-y-4">
                                <div class="flex justify-start">
                                    <div class="message-bubble bg-slate-100 rounded-2xl rounded-tl-none p-3">
                                        <p class="text-slate-700">Bonjour coach, je voulais savoir si je dois modifier mon programme cette semaine après le 10.45s d'hier?</p>
                                        <span class="text-xs text-slate-500 mt-1">10:32</span>
                                    </div>
                                </div>
                                <div class="flex justify-end">
                                    <div class="message-bubble bg-blue-500 text-white rounded-2xl rounded-tr-none p-3">
                                        <p>Excellent travail Jean ! On maintient le programme actuel, tu es sur la bonne voie pour les championnats.</p>
                                        <span class="text-xs text-emerald-100 mt-1">10:35</span>
                                    </div>
                                </div>
                                <div class="flex justify-start">
                                    <div class="message-bubble bg-slate-100 rounded-2xl rounded-tl-none p-3">
                                        <p class="text-slate-700">Parfait, merci coach! Je vais donner le maximum demain à l'entraînement.</p>
                                        <span class="text-xs text-slate-500 mt-1">10:36</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="p-4 border-t border-slate-100">
                            <div class="flex gap-2">
                                <input type="text" placeholder="Écrire un message..." class="flex-1 px-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none">
                                <button class="px-4 py-3 bg-emerald-600 text-white rounded-xl hover:bg-emerald-700"><i class="fas fa-paper-plane"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
