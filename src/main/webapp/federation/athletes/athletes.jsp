<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Athlètes - Fédération | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: { 50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a' },
                        secondary: { 50: '#f8fafc', 100: '#f1f5f9', 200: '#e2e8f0', 300: '#cbd5e1', 400: '#94a3b8', 500: '#64748b', 600: '#475569', 700: '#334155', 800: '#1e293b', 900: '#0f172a' }
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
    </style>
</head>
<body class="bg-secondary-50 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-secondary-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-blue-700 rounded-lg flex items-center justify-center">
                        <i class="fas fa-landmark text-white"></i>
                    </div>
                    <span class="text-xl font-bold text-secondary-800">SPORT<span class="text-primary-600">CONNECT</span></span>
                </div>
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="athletes.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="../clubs/clubs.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-building w-6"></i>Gestion Clubs</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-search w-6"></i>Scouting & Talents</a>
                    <a href="../finances/finances.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-money-bill-wave w-6"></i>Finances & Licences</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-chart-pie w-6"></i>Rapports & Stats</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-red-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-secondary-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-secondary-800">Gestion des Athlètes</h1>
                        <p class="text-secondary-500 text-sm">Base de données nationale des licenciés</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <button class="px-4 py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-green-200 transition"><i class="fas fa-file-export mr-2"></i>Export Excel</button>
                        <button class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition"><i class="fas fa-plus mr-2"></i>Ajouter</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Search & Filters -->
                <div class="bg-white rounded-2xl shadow-sm p-4 mb-6">
                    <div class="flex flex-wrap gap-4">
                        <div class="flex-1 min-w-[300px]">
                            <div class="relative">
                                <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                <input type="text" placeholder="Rechercher un athlète (nom, NIN, club...)" class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            </div>
                        </div>
                        <select class="px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            <option>Toutes catégories</option>
                            <option>Senior</option>
                            <option>Junior</option>
                            <option>Cadet</option>
                        </select>
                        <select class="px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            <option>Tous les clubs</option>
                            <option>CAA</option>
                            <option>Club Olympique</option>
                        </select>
                        <select class="px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            <option>Statut licence</option>
                            <option>Active</option>
                            <option>En attente</option>
                            <option>Expirée</option>
                        </select>
                    </div>
                </div>

                <!-- Athletes Table -->
                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-secondary-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700"><input type="checkbox" class="w-4 h-4 rounded border-secondary-300 text-primary-600 focus:ring-primary-500"></th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Athlète</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Catégorie</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Club</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Licence</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Score IA</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-secondary-100 hover:bg-secondary-50">
                                    <td class="py-4 px-6"><input type="checkbox" class="w-4 h-4 rounded border-secondary-300 text-primary-600 focus:ring-primary-500"></td>
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff" class="w-10 h-10 rounded-full mr-3">
                                            <div>
                                                <p class="font-medium text-secondary-800">Rakoto Jean</p>
                                                <p class="text-xs text-secondary-500">NIN: 1023456789012</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Senior</span></td>
                                    <td class="py-4 px-6 text-secondary-700">CAA</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Active</span></td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-purple-700 rounded-lg text-sm font-semibold">87.5 Elite</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-primary-600 hover:text-primary-700 mr-3"><i class="fas fa-eye"></i></button>
                                        <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-secondary-100 hover:bg-secondary-50">
                                    <td class="py-4 px-6"><input type="checkbox" class="w-4 h-4 rounded border-secondary-300 text-primary-600 focus:ring-primary-500"></td>
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <img src="https://ui-avatars.com/api/?name=Marie+Andria&background=2563eb&color=fff" class="w-10 h-10 rounded-full mr-3">
                                            <div>
                                                <p class="font-medium text-secondary-800">Andria Marie</p>
                                                <p class="text-xs text-secondary-500">NIN: 1023456789013</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Junior</span></td>
                                    <td class="py-4 px-6 text-secondary-700">Club Olympique</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Active</span></td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-semibold">78.2 Prometteur</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-primary-600 hover:text-primary-700 mr-3"><i class="fas fa-eye"></i></button>
                                        <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-secondary-100 hover:bg-secondary-50">
                                    <td class="py-4 px-6"><input type="checkbox" class="w-4 h-4 rounded border-secondary-300 text-primary-600 focus:ring-primary-500"></td>
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <img src="https://ui-avatars.com/api/?name=Paul+Rasoa&background=2563eb&color=fff" class="w-10 h-10 rounded-full mr-3">
                                            <div>
                                                <p class="font-medium text-secondary-800">Rasoa Paul</p>
                                                <p class="text-xs text-secondary-500">NIN: 1023456789014</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Cadet</span></td>
                                    <td class="py-4 px-6 text-secondary-700">CAA</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">En attente</span></td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-secondary-100 text-secondary-700 rounded-lg text-sm font-semibold">-- Éval.</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3" title="Valider"><i class="fas fa-check"></i></button>
                                        <button class="text-red-600 hover:text-red-700 mr-3" title="Rejeter"><i class="fas fa-times"></i></button>
                                        <button class="text-primary-600 hover:text-primary-700"><i class="fas fa-eye"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="p-4 border-t border-secondary-100 flex items-center justify-between">
                        <p class="text-sm text-secondary-500">Affichage 1-3 sur 1,247 athlètes</p>
                        <div class="flex gap-2">
                            <button class="px-3 py-1 border border-secondary-300 rounded-lg text-secondary-600 hover:bg-secondary-50"><i class="fas fa-chevron-left"></i></button>
                            <button class="px-3 py-1 bg-primary-600 text-white rounded-lg">1</button>
                            <button class="px-3 py-1 border border-secondary-300 rounded-lg text-secondary-600 hover:bg-secondary-50">2</button>
                            <button class="px-3 py-1 border border-secondary-300 rounded-lg text-secondary-600 hover:bg-secondary-50">3</button>
                            <button class="px-3 py-1 border border-secondary-300 rounded-lg text-secondary-600 hover:bg-secondary-50"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
