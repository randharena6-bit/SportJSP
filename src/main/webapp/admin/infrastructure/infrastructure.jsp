<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Infrastructure & DevOps - Admin | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar-link { transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background: #eff6ff; color: #2563eb; border-right: 3px solid #2563eb; }
        .pulse-dot { animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
    </style>
</head>
<body class="bg-slate-50 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <aside class="w-64 bg-white border-r border-slate-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 bg-gradient-to-br from-rose-500 to-rose-600 rounded-lg flex items-center justify-center"><i class="fas fa-shield-alt text-white"></i></div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="../users/users.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users-cog w-6"></i>Gestion Utilisateurs</a>
                    <a href="../federations/federations.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-landmark w-6"></i>Gestion Fédérations</a>
                    <a href="../configuration/configuration.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-cogs w-6"></i>Configuration</a>
                    <a href="../securite/securite.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-lock w-6"></i>Sécurité</a>
                    <a href="../ia/ia.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-robot w-6"></i>IA</a>
                    <a href="infrastructure.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-server w-6"></i>Infrastructure</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Infrastructure & DevOps</h1>
                        <p class="text-slate-500 text-sm">Monitoring serveurs, sauvegardes, CDN</p>
                    </div>
                    <div class="flex items-center px-3 py-1 bg-green-100 text-green-700 rounded-full text-sm">
                        <span class="w-2 h-2 bg-green-500 rounded-full mr-2 pulse-dot"></span>
                        Opérationnel
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Server Stats -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-server text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Serveurs actifs</h3>
                        <p class="text-2xl font-bold text-slate-800">8/8</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-database text-green-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Dernière backup</h3>
                        <p class="text-2xl font-bold text-slate-800">14:00</p>
                        <p class="text-xs text-green-500">RPO: 1h atteint</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-network-wired text-purple-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Bande passante</h3>
                        <p class="text-2xl font-bold text-slate-800">45%</p>
                        <p class="text-xs text-slate-500">234 Mbps / 500 Mbps</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-amber-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-users text-amber-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Utilisateurs actifs</h3>
                        <p class="text-2xl font-bold text-slate-800">1,234</p>
                        <p class="text-xs text-green-500">+12% vs hier</p>
                    </div>
                </div>

                <!-- Server Health -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-microchip text-blue-500 mr-2"></i>Ressources Serveurs</h2>
                        <div class="space-y-4">
                            <div>
                                <div class="flex justify-between text-sm mb-1"><span class="text-slate-600">CPU Usage (App Server 1)</span><span class="font-semibold text-slate-800">45%</span></div>
                                <div class="w-full h-2 bg-slate-200 rounded-full"><div class="h-2 bg-blue-500 rounded-full" style="width: 45%"></div></div>
                            </div>
                            <div>
                                <div class="flex justify-between text-sm mb-1"><span class="text-slate-600">Mémoire (App Server 1)</span><span class="font-semibold text-slate-800">62%</span></div>
                                <div class="w-full h-2 bg-slate-200 rounded-full"><div class="h-2 bg-purple-500 rounded-full" style="width: 62%"></div></div>
                            </div>
                            <div>
                                <div class="flex justify-between text-sm mb-1"><span class="text-slate-600">Stockage</span><span class="font-semibold text-slate-800">78%</span></div>
                                <div class="w-full h-2 bg-slate-200 rounded-full"><div class="h-2 bg-amber-500 rounded-full" style="width: 78%"></div></div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-cloud text-green-500 mr-2"></i>Sauvegardes & CDN</h2>
                        <div class="space-y-4">
                            <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                <div class="flex items-center"><i class="fas fa-database text-blue-500 mr-3"></i><span class="text-slate-700">Backup Database</span></div>
                                <span class="px-2 py-1 bg-green-100 text-green-700 rounded text-sm">OK - 14:00</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                <div class="flex items-center"><i class="fas fa-file-archive text-blue-500 mr-3"></i><span class="text-slate-700">Backup Fichiers</span></div>
                                <span class="px-2 py-1 bg-green-100 text-green-700 rounded text-sm">OK - 13:30</span>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                <div class="flex items-center"><i class="fas fa-globe text-purple-500 mr-3"></i><span class="text-slate-700">CDN Cloudflare</span></div>
                                <span class="px-2 py-1 bg-green-100 text-green-700 rounded text-sm">Actif</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Deployment -->
                <div class="bg-white rounded-2xl shadow-sm p-6">
                    <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-rocket text-blue-500 mr-2"></i>Gestion des Versions</h2>
                    <div class="flex items-center justify-between p-4 bg-slate-50 rounded-xl">
                        <div>
                            <p class="font-semibold text-slate-800">Version actuelle: v2.4.1</p>
                            <p class="text-sm text-slate-500">Déployée le 01/05/2025 - 14:32</p>
                        </div>
                        <div class="flex gap-3">
                            <button class="px-4 py-2 border border-slate-300 text-slate-700 rounded-lg font-medium hover:bg-slate-50"><i class="fas fa-history mr-2"></i>Rollback</button>
                            <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-upload mr-2"></i>Déployer mise à jour</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
