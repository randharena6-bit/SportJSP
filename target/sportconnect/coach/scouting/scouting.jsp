<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scouting Terrain - Entraîneur | SPORT CONNECT</title>
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
                    <div class="w-10 h-10 bg-gradient-to-br from-emerald-400 to-emerald-600 rounded-lg flex items-center justify-center"><i class="fas fa-dumbbell text-white"></i></div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="../athletes/athletes.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="../entrainements/entrainements.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-calendar-alt w-6"></i>Planification</a>
                    <a href="../analyse/analyse.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-line w-6"></i>Analyse Performance</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="scouting.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting Terrain</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Scouting (Terrain)</h1>
                        <p class="text-slate-500 text-sm">Évaluation des jeunes talents - Mode offline disponible</p>
                    </div>
                    <div class="flex gap-3">
                        <span class="px-3 py-1 bg-green-100 text-green-700 rounded-full text-sm"><i class="fas fa-wifi mr-1"></i>Connecté</span>
                        <button class="px-4 py-2 bg-emerald-600 text-white rounded-lg font-medium hover:bg-emerald-700"><i class="fas fa-plus mr-2"></i>Nouvelle évaluation</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Evaluation Form -->
                <div class="bg-white rounded-2xl shadow-sm p-6 mb-8">
                    <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-clipboard-check text-emerald-500 mr-2"></i>Formulaire d'évaluation standardisé</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Nom du jeune athlète</label>
                            <input type="text" class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none" placeholder="Nom et prénom">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Âge</label>
                            <input type="number" class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none" placeholder="Ex: 16">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Club / École</label>
                            <input type="text" class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none" placeholder="Nom du club">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Discipline observée</label>
                            <select class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none">
                                <option>100m</option>
                                <option>200m</option>
                                <option>400m</option>
                                <option>Longueur</option>
                                <option>Triple saut</option>
                            </select>
                        </div>
                    </div>

                    <div class="mt-6">
                        <h3 class="font-semibold text-slate-800 mb-4">Grille d'évaluation (sur 20)</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                            <div>
                                <label class="block text-sm text-slate-600 mb-1">Technique</label>
                                <input type="number" max="20" class="w-full px-3 py-2 border border-slate-200 rounded-lg" placeholder="/20">
                            </div>
                            <div>
                                <label class="block text-sm text-slate-600 mb-1">Vitesse</label>
                                <input type="number" max="20" class="w-full px-3 py-2 border border-slate-200 rounded-lg" placeholder="/20">
                            </div>
                            <div>
                                <label class="block text-sm text-slate-600 mb-1">Endurance</label>
                                <input type="number" max="20" class="w-full px-3 py-2 border border-slate-200 rounded-lg" placeholder="/20">
                            </div>
                            <div>
                                <label class="block text-sm text-slate-600 mb-1">Mental</label>
                                <input type="number" max="20" class="w-full px-3 py-2 border border-slate-200 rounded-lg" placeholder="/20">
                            </div>
                        </div>
                    </div>

                    <div class="mt-6">
                        <label class="block text-sm font-medium text-slate-700 mb-2">Observations / Commentaires</label>
                        <textarea rows="3" class="w-full px-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none" placeholder="Vos observations sur le jeune athlète..."></textarea>
                    </div>

                    <div class="mt-6 flex gap-4">
                        <button class="px-6 py-3 bg-slate-200 text-slate-700 rounded-xl font-medium hover:bg-slate-300"><i class="fas fa-save mr-2"></i>Sauvegarder local</button>
                        <button class="px-6 py-3 bg-emerald-600 text-white rounded-xl font-medium hover:bg-emerald-700"><i class="fas fa-paper-plane mr-2"></i>Transmettre à la fédération</button>
                    </div>
                </div>

                <!-- Pending Sync -->
                <div class="bg-amber-50 border border-amber-200 rounded-xl p-4">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <i class="fas fa-sync-alt text-amber-500 mr-3"></i>
                            <div>
                                <h4 class="font-semibold text-amber-800">3 évaluations en attente de synchronisation</h4>
                                <p class="text-sm text-amber-600">Enregistrées en mode offline - Connexion requise pour transmission</p>
                            </div>
                        </div>
                        <button class="px-4 py-2 bg-emerald-600 text-white rounded-lg font-medium hover:bg-emerald-700">Synchroniser maintenant</button>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
