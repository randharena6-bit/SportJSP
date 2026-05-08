<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Utilisateurs - Admin | SPORT CONNECT</title>
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
                    <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-blue-700 rounded-lg flex items-center justify-center"><i class="fas fa-shield-alt text-white"></i></div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="users.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users-cog w-6"></i>Gestion Utilisateurs</a>
                    <a href="../federations/federations.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-landmark w-6"></i>Gestion Fédérations</a>
                    <a href="../configuration/configuration.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-cogs w-6"></i>Configuration</a>
                    <a href="../securite/securite.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-lock w-6"></i>Sécurité</a>
                    <a href="../ia/ia.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-robot w-6"></i>IA</a>
                    <a href="../infrastructure/infrastructure.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-server w-6"></i>Infrastructure</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-file-alt w-6"></i>Rapports</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Gestion des Utilisateurs</h1>
                        <p class="text-slate-500 text-sm">Administration des comptes et permissions</p>
                    </div>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-plus mr-2"></i>Nouvel utilisateur</button>
                </div>
            </header>

            <main class="p-8">
                <div class="bg-white rounded-2xl shadow-sm p-4 mb-6">
                    <div class="flex flex-wrap gap-4">
                        <div class="flex-1 min-w-[300px]">
                            <div class="relative">
                                <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"></i>
                                <input type="text" placeholder="Rechercher un utilisateur..." class="w-full pl-12 pr-4 py-3 border border-slate-200 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none">
                            </div>
                        </div>
                        <select class="px-4 py-3 border border-slate-200 rounded-xl"><option>Tous les rôles</option><option>Admin</option><option>Fédération</option><option>Entraîneur</option><option>Athlète</option></select>
                        <select class="px-4 py-3 border border-slate-200 rounded-xl"><option>Statut</option><option>Actif</option><option>Suspendu</option><option>En attente</option></select>
                    </div>
                </div>

                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Utilisateur</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Rôle</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Fédération/Club</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Statut</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Dernière connexion</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <img src="https://ui-avatars.com/api/?name=Admin+Rabe&background=2563eb&color=fff" class="w-10 h-10 rounded-full mr-3">
                                            <div>
                                                <p class="font-medium text-slate-800">Rabe Andry</p>
                                                <p class="text-xs text-slate-500">admin.rabe@gov.mg</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Admin Système</span></td>
                                    <td class="py-4 px-6 text-slate-600">Ministère du Numérique</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Actif</span></td>
                                    <td class="py-4 px-6 text-slate-600">Il y a 5 minutes</td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-ban"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <img src="https://ui-avatars.com/api/?name=M+Rabe&background=2563eb&color=fff" class="w-10 h-10 rounded-full mr-3">
                                            <div>
                                                <p class="font-medium text-slate-800">Rabe José</p>
                                                <p class="text-xs text-slate-500">fma.admin@sport.mg</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Fédération</span></td>
                                    <td class="py-4 px-6 text-slate-600">FMA - Athlétisme</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Actif</span></td>
                                    <td class="py-4 px-6 text-slate-600">Il y a 2 heures</td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-ban"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <img src="https://ui-avatars.com/api/?name=Coach+Rakoto&background=2563eb&color=fff" class="w-10 h-10 rounded-full mr-3">
                                            <div>
                                                <p class="font-medium text-slate-800">Rakoto Luc</p>
                                                <p class="text-xs text-slate-500">luc.r@caa.mg</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Entraîneur</span></td>
                                    <td class="py-4 px-6 text-slate-600">CAA - Antananarivo</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Actif</span></td>
                                    <td class="py-4 px-6 text-slate-600">Hier</td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-ban"></i></button>
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
