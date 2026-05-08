<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compétitions - Entraîneur | SPORT CONNECT</title>
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
                    <a href="competitions.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
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
                <div class="px-8 py-4">
                    <h1 class="text-2xl font-bold text-slate-800">Compétitions</h1>
                    <p class="text-slate-500 text-sm">Préparation et suivi compétitif</p>
                </div>
            </header>

            <main class="p-8">
                <!-- Upcoming Competitions -->
                <div class="bg-white rounded-2xl shadow-sm mb-8">
                    <div class="p-6 border-b border-slate-100">
                        <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-calendar-alt text-emerald-500 mr-2"></i>Prochaines compétitions de l'équipe</h2>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4">
                            <div class="flex items-center p-4 bg-emerald-50 rounded-xl">
                                <div class="w-16 h-16 bg-emerald-100 rounded-xl flex flex-col items-center justify-center mr-4">
                                    <span class="text-xs text-emerald-600 font-bold">MAI</span>
                                    <span class="text-xl font-bold text-emerald-700">15</span>
                                </div>
                                <div class="flex-1">
                                    <h4 class="font-semibold text-slate-800">Championnat National d'Athlétisme</h4>
                                    <p class="text-sm text-slate-500">Stade Mahamasina • 6 athlètes inscrits</p>
                                </div>
                                <button class="px-4 py-2 bg-emerald-600 text-white rounded-lg font-medium hover:bg-emerald-700">Feuille de match</button>
                            </div>
                            <div class="flex items-center p-4 bg-slate-50 rounded-xl">
                                <div class="w-16 h-16 bg-slate-100 rounded-xl flex flex-col items-center justify-center mr-4">
                                    <span class="text-xs text-slate-600 font-bold">JUIN</span>
                                    <span class="text-xl font-bold text-slate-700">08</span>
                                </div>
                                <div class="flex-1">
                                    <h4 class="font-semibold text-slate-800">Meeting International Tamatave</h4>
                                    <p class="text-sm text-slate-500">Stade Municipal • 4 athlètes inscrits</p>
                                </div>
                                <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700">Feuille de match</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Match Sheet -->
                <div class="bg-white rounded-2xl shadow-sm">
                    <div class="p-6 border-b border-slate-100 flex items-center justify-between">
                        <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-file-alt text-blue-500 mr-2"></i>Feuille de match digitale</h2>
                        <span class="px-3 py-1 bg-amber-100 text-amber-700 rounded-full text-sm">Championnat National - 100m Finale</span>
                    </div>
                    <div class="p-6">
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-slate-50">
                                    <tr>
                                        <th class="text-left py-3 px-4 font-semibold text-slate-700">Athlète</th>
                                        <th class="text-left py-3 px-4 font-semibold text-slate-700">N° dossard</th>
                                        <th class="text-left py-3 px-4 font-semibold text-slate-700">Chrono</th>
                                        <th class="text-left py-3 px-4 font-semibold text-slate-700">Place</th>
                                        <th class="text-left py-3 px-4 font-semibold text-slate-700">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="border-b border-slate-100">
                                        <td class="py-3 px-4 font-medium text-slate-800">Rakoto Jean</td>
                                        <td class="py-3 px-4"><input type="text" class="w-20 px-2 py-1 border border-slate-200 rounded text-center" value="245"></td>
                                        <td class="py-3 px-4"><input type="text" class="w-24 px-2 py-1 border border-slate-200 rounded text-center" placeholder="10.45"></td>
                                        <td class="py-3 px-4"><input type="text" class="w-16 px-2 py-1 border border-slate-200 rounded text-center" placeholder="1"></td>
                                        <td class="py-3 px-4"><button class="px-3 py-1 bg-green-100 text-green-700 rounded text-sm"><i class="fas fa-check mr-1"></i>Valider</button></td>
                                    </tr>
                                    <tr class="border-b border-slate-100">
                                        <td class="py-3 px-4 font-medium text-slate-800">Rasoa Paul</td>
                                        <td class="py-3 px-4"><input type="text" class="w-20 px-2 py-1 border border-slate-200 rounded text-center" value="247"></td>
                                        <td class="py-3 px-4"><input type="text" class="w-24 px-2 py-1 border border-slate-200 rounded text-center" placeholder="11.02"></td>
                                        <td class="py-3 px-4"><input type="text" class="w-16 px-2 py-1 border border-slate-200 rounded text-center" placeholder="5"></td>
                                        <td class="py-3 px-4"><button class="px-3 py-1 bg-green-100 text-green-700 rounded text-sm"><i class="fas fa-check mr-1"></i>Valider</button></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="mt-4 flex gap-3">
                            <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-save mr-2"></i>Sauvegarder</button>
                            <button class="px-4 py-2 bg-emerald-100 text-emerald-700 rounded-lg font-medium hover:bg-emerald-200"><i class="fas fa-paper-plane mr-2"></i>Transmettre à la fédération</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
