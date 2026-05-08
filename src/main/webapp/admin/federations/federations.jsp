<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Fédérations - Admin | SPORT CONNECT</title>
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
                    <a href="../users/users.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users-cog w-6"></i>Gestion Utilisateurs</a>
                    <a href="federations.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-landmark w-6"></i>Gestion Fédérations</a>
                    <a href="../configuration/configuration.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-cogs w-6"></i>Configuration</a>
                    <a href="../securite/securite.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-lock w-6"></i>Sécurité</a>
                    <a href="../ia/ia.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-robot w-6"></i>IA</a>
                    <a href="../infrastructure/infrastructure.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-server w-6"></i>Infrastructure</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-file-alt w-6"></i>Rapports</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Gestion des Fédérations</h1>
                        <p class="text-slate-500 text-sm">45 fédérations cibles • 42 actives</p>
                    </div>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-plus mr-2"></i>Nouvelle fédération</button>
                </div>
            </header>

            <main class="p-8">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-check-circle text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Fédérations actives</h3>
                        <p class="text-2xl font-bold text-slate-800">42</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-cog text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">En configuration</h3>
                        <p class="text-2xl font-bold text-slate-800">2</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-slate-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-pause-circle text-slate-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">En attente</h3>
                        <p class="text-2xl font-bold text-slate-800">1</p>
                    </div>
                </div>

                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Fédération</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Admin</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Athlètes</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Digitalisation</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Statut</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3"><i class="fas fa-running text-blue-600"></i></div>
                                            <div>
                                                <p class="font-medium text-slate-800">Athlétisme</p>
                                                <p class="text-xs text-slate-500">FMA</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6 text-slate-700">Rabe José</td>
                                    <td class="py-4 px-6 font-semibold text-slate-800">1,247</td>
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <div class="w-24 h-2 bg-slate-200 rounded-full mr-2">
                                                <div class="h-2 bg-blue-500 rounded-full" style="width: 85%"></div>
                                            </div>
                                            <span class="text-sm text-slate-600">85%</span>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Active</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-chart-bar"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3"><i class="fas fa-futbol text-blue-600"></i></div>
                                            <div>
                                                <p class="font-medium text-slate-800">Football</p>
                                                <p class="text-xs text-slate-500">FMF</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6 text-slate-700">Rakoto Jean</td>
                                    <td class="py-4 px-6 font-semibold text-slate-800">8,456</td>
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <div class="w-24 h-2 bg-slate-200 rounded-full mr-2">
                                                <div class="h-2 bg-blue-500 rounded-full" style="width: 92%"></div>
                                            </div>
                                            <span class="text-sm text-slate-600">92%</span>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Active</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-chart-bar"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-slate-100 hover:bg-slate-50">
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3"><i class="fas fa-basketball-ball text-blue-600"></i></div>
                                            <div>
                                                <p class="font-medium text-slate-800">Basketball</p>
                                                <p class="text-xs text-slate-500">FMBB</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6 text-slate-700">Andria Paul</td>
                                    <td class="py-4 px-6 font-semibold text-slate-800">1,890</td>
                                    <td class="py-4 px-6">
                                        <div class="flex items-center">
                                            <div class="w-24 h-2 bg-slate-200 rounded-full mr-2">
                                                <div class="h-2 bg-blue-500 rounded-full" style="width: 65%"></div>
                                            </div>
                                            <span class="text-sm text-slate-600">65%</span>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">Config</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-blue-600 hover:text-blue-700 mr-3"><i class="fas fa-edit"></i></button>
                                        <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-chart-bar"></i></button>
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
