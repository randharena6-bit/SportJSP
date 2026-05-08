<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Configuration Système - Admin | SPORT CONNECT</title>
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
                    <a href="../federations/federations.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-landmark w-6"></i>Gestion Fédérations</a>
                    <a href="configuration.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-cogs w-6"></i>Configuration</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Configuration du Système</h1>
                        <p class="text-slate-500 text-sm">Paramètres globaux de la plateforme</p>
                    </div>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-save mr-2"></i>Sauvegarder</button>
                </div>
            </header>

            <main class="p-8">
                <!-- Mobile Money Settings -->
                <div class="bg-white rounded-2xl shadow-sm p-6 mb-6">
                    <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-mobile-alt text-blue-500 mr-2"></i>Intégrations Mobile Money</h2>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div class="border border-slate-200 rounded-xl p-4">
                            <div class="flex items-center mb-3">
                                <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3"><i class="fas fa-mobile-alt text-blue-600"></i></div>
                                <span class="font-semibold text-slate-800">Mvola</span>
                                <span class="ml-auto px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs">Actif</span>
                            </div>
                            <label class="block text-sm text-slate-600 mb-1">Clé API</label>
                            <input type="password" value="mvola_api_key_xxx" class="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm">
                        </div>
                        <div class="border border-slate-200 rounded-xl p-4">
                            <div class="flex items-center mb-3">
                                <div class="w-10 h-10 bg-orange-100 rounded-lg flex items-center justify-center mr-3"><i class="fas fa-mobile-alt text-orange-600"></i></div>
                                <span class="font-semibold text-slate-800">Orange Money</span>
                                <span class="ml-auto px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs">Actif</span>
                            </div>
                            <label class="block text-sm text-slate-600 mb-1">Clé API</label>
                            <input type="password" value="orange_api_key_xxx" class="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm">
                        </div>
                        <div class="border border-slate-200 rounded-xl p-4">
                            <div class="flex items-center mb-3">
                                <div class="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center mr-3"><i class="fas fa-mobile-alt text-red-600"></i></div>
                                <span class="font-semibold text-slate-800">Airtel Money</span>
                                <span class="ml-auto px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs">Actif</span>
                            </div>
                            <label class="block text-sm text-slate-600 mb-1">Clé API</label>
                            <input type="password" value="airtel_api_key_xxx" class="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm">
                        </div>
                    </div>
                </div>

                <!-- Sports Configuration -->
                <div class="bg-white rounded-2xl shadow-sm p-6 mb-6">
                    <div class="flex items-center justify-between mb-4">
                        <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-running text-blue-500 mr-2"></i>Types de Sport et Disciplines</h2>
                        <button class="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium"><i class="fas fa-plus mr-1"></i>Ajouter</button>
                    </div>
                    <div class="space-y-3">
                        <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                            <div class="flex items-center">
                                <i class="fas fa-running text-blue-500 mr-3"></i>
                                <span class="font-medium text-slate-700">Athlétisme</span>
                            </div>
                            <div class="flex items-center gap-4">
                                <span class="text-sm text-slate-500">12 disciplines</span>
                                <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-edit"></i></button>
                            </div>
                        </div>
                        <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                            <div class="flex items-center">
                                <i class="fas fa-futbol text-blue-500 mr-3"></i>
                                <span class="font-medium text-slate-700">Football</span>
                            </div>
                            <div class="flex items-center gap-4">
                                <span class="text-sm text-slate-500">5 disciplines</span>
                                <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-edit"></i></button>
                            </div>
                        </div>
                        <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                            <div class="flex items-center">
                                <i class="fas fa-basketball-ball text-purple-500 mr-3"></i>
                                <span class="font-medium text-slate-700">Basketball</span>
                            </div>
                            <div class="flex items-center gap-4">
                                <span class="text-sm text-slate-500">3 disciplines</span>
                                <button class="text-blue-600 hover:text-blue-700"><i class="fas fa-edit"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- License Pricing -->
                <div class="bg-white rounded-2xl shadow-sm p-6">
                    <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-tag text-blue-500 mr-2"></i>Tarifs des Licences</h2>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th class="text-left py-3 px-4 font-semibold text-slate-700">Catégorie</th>
                                    <th class="text-left py-3 px-4 font-semibold text-slate-700">Tarif</th>
                                    <th class="text-left py-3 px-4 font-semibold text-slate-700">Validité</th>
                                    <th class="text-left py-3 px-4 font-semibold text-slate-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-slate-100">
                                    <td class="py-3 px-4">Senior</td>
                                    <td class="py-3 px-4 font-semibold">25,000 Ar</td>
                                    <td class="py-3 px-4">1 an</td>
                                    <td class="py-3 px-4"><button class="text-blue-600 hover:text-blue-700"><i class="fas fa-edit"></i></button></td>
                                </tr>
                                <tr class="border-b border-slate-100">
                                    <td class="py-3 px-4">Junior</td>
                                    <td class="py-3 px-4 font-semibold">20,000 Ar</td>
                                    <td class="py-3 px-4">1 an</td>
                                    <td class="py-3 px-4"><button class="text-blue-600 hover:text-blue-700"><i class="fas fa-edit"></i></button></td>
                                </tr>
                                <tr class="border-b border-slate-100">
                                    <td class="py-3 px-4">Cadet</td>
                                    <td class="py-3 px-4 font-semibold">15,000 Ar</td>
                                    <td class="py-3 px-4">1 an</td>
                                    <td class="py-3 px-4"><button class="text-blue-600 hover:text-blue-700"><i class="fas fa-edit"></i></button></td>
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
