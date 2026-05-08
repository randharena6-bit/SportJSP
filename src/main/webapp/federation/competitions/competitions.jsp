<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Compétitions - Fédération | SPORT CONNECT</title>
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
                    <a href="../clubs/clubs.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-building w-6"></i>Gestion Clubs</a>
                    <a href="competitions.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Gestion des Compétitions</h1>
                        <p class="text-slate-500 text-sm">Planification et suivi des événements</p>
                    </div>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition"><i class="fas fa-plus mr-2"></i>Nouvelle compétition</button>
                </div>
            </header>

            <main class="p-8">
                <!-- Calendar View Toggle -->
                <div class="flex gap-2 mb-6">
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium">Liste</button>
                    <button class="px-4 py-2 bg-white text-slate-600 rounded-lg font-medium hover:bg-slate-100 transition">Calendrier</button>
                    <button class="px-4 py-2 bg-white text-slate-600 rounded-lg font-medium hover:bg-slate-100 transition">Résultats</button>
                </div>

                <!-- Competitions Table -->
                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Compétition</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Date</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Lieu</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Inscrits</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Statut</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <p class="font-semibold text-slate-800">Championnat National d'Athlétisme</p>
                                        <p class="text-xs text-slate-500">Catégorie: Senior, Junior</p>
                                    </td>
                                    <td class="py-4 px-6 text-slate-700">15-17 Mai 2025</td>
                                    <td class="py-4 px-6 text-slate-700">Stade Mahamasina, Tana</td>
                                    <td class="py-4 px-6"><span class="font-semibold text-slate-800">156</span> <span class="text-slate-500">/ 200</span></td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Inscriptions ouvertes</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-eye"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-slate-400 hover:text-slate-600"><i class="fas fa-chart-bar"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <p class="font-semibold text-slate-800">Meeting International Tamatave</p>
                                        <p class="text-xs text-slate-500">Catégorie: Toutes</p>
                                    </td>
                                    <td class="py-4 px-6 text-slate-700">8-10 Juin 2025</td>
                                    <td class="py-4 px-6 text-slate-700">Stade Municipal, Toamasina</td>
                                    <td class="py-4 px-6"><span class="font-semibold text-slate-800">89</span> <span class="text-slate-500">/ 150</span></td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">En préparation</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-eye"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-slate-400 hover:text-slate-600"><i class="fas fa-chart-bar"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <p class="font-semibold text-slate-800">Coupe des Clubs</p>
                                        <p class="text-xs text-slate-500">Catégorie: Club</p>
                                    </td>
                                    <td class="py-4 px-6 text-slate-700">20-22 Juillet 2025</td>
                                    <td class="py-4 px-6 text-slate-700">Centre Sportif, Antsirabe</td>
                                    <td class="py-4 px-6"><span class="font-semibold text-slate-800">--</span></td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-slate-200 text-slate-700 rounded-lg text-sm">Planification</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-eye"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
