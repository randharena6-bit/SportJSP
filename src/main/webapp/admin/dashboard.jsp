<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Système - Admin | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar-link { transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background: #eff6ff; color: #2563eb; border-right: 3px solid #2563eb; }
        .stat-card { transition: all 0.3s ease; }
        .stat-card:hover { transform: translateY(-4px); }
        .pulse-dot { animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
    </style>
</head>
<body class="bg-slate-50 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-slate-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 bg-gradient-to-br from-rose-500 to-rose-600 rounded-lg flex items-center justify-center">
                        <i class="fas fa-shield-alt text-white"></i>
                    </div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <div class="mb-6 p-3 bg-rose-50 rounded-lg">
                    <p class="text-xs text-rose-600 font-semibold uppercase">Administration Système</p>
                    <p class="text-sm text-slate-700">Ministère du Numérique</p>
                </div>
                <nav class="space-y-1">
                    <a href="dashboard.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="users/users.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users-cog w-6"></i>Gestion Utilisateurs</a>
                    <a href="federations/federations.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-landmark w-6"></i>Gestion Fédérations</a>
                    <a href="configuration/configuration.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-cogs w-6"></i>Configuration</a>
                    <a href="securite/securite.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-lock w-6"></i>Sécurité</a>
                    <a href="ia/ia.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-robot w-6"></i>Intelligence Artificielle</a>
                    <a href="infrastructure/infrastructure.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-server w-6"></i>Infrastructure</a>
                    <a href="rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-file-alt w-6"></i>Rapports Ministériels</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-slate-200">
                    <a href="../index.jsp" class="flex items-center px-4 py-3 text-slate-500 hover:text-red-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-slate-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Tableau de Bord Système</h1>
                        <p class="text-slate-500 text-sm">Supervision de la plateforme nationale</p>
                    </div>
                    <div class="flex items-center space-x-4">
                        <div class="flex items-center px-3 py-1 bg-green-100 text-green-700 rounded-full text-sm">
                            <span class="w-2 h-2 bg-green-500 rounded-full mr-2 pulse-dot"></span>
                            Système opérationnel
                        </div>
                        <div class="flex items-center space-x-3">
                            <img src="https://ui-avatars.com/api/?name=Admin+Sys&background=e11d48&color=fff" class="w-10 h-10 rounded-full border-2 border-rose-200">
                            <span class="font-medium text-slate-700">Admin Système</span>
                        </div>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Alert Banner -->
                <div class="bg-amber-50 border border-amber-200 rounded-xl p-4 mb-8 flex items-start">
                    <i class="fas fa-exclamation-triangle text-amber-500 mt-1 mr-3"></i>
                    <div class="flex-1">
                        <h4 class="font-semibold text-amber-800">Alerte de sécurité: Tentative d'accès suspecte</h4>
                        <p class="text-sm text-amber-700">3 tentatives échouées détectées depuis l'IP 197.XX.XX.XX - Fédération Football</p>
                    </div>
                    <button class="px-4 py-2 bg-amber-100 text-amber-700 rounded-lg font-medium hover:bg-amber-200">Examiner</button>
                </div>

                <!-- System Stats -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <div class="stat-card bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-landmark text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Fédérations actives</h3>
                        <p class="text-2xl font-bold text-slate-800">42/45</p>
                        <p class="text-xs text-green-500 mt-1"><i class="fas fa-check"></i> 93% digitalisées</p>
                    </div>
                    <div class="stat-card bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-users text-green-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Athlètes enregistrés</h3>
                        <p class="text-2xl font-bold text-slate-800">45,678</p>
                        <p class="text-xs text-green-500 mt-1"><i class="fas fa-arrow-up"></i> +8.5% ce mois</p>
                    </div>
                    <div class="stat-card bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-exchange-alt text-purple-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Transactions (Mai)</h3>
                        <p class="text-2xl font-bold text-slate-800">12,456</p>
                        <p class="text-xs text-slate-500 mt-1">Vol: 342.8M Ar</p>
                    </div>
                    <div class="stat-card bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-rose-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-bug text-rose-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Incidents actifs</h3>
                        <p class="text-2xl font-bold text-rose-600">3</p>
                        <p class="text-xs text-rose-500 mt-1">Nécessitent attention</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- System Health -->
                    <div class="lg:col-span-2 space-y-8">
                        <div class="bg-white rounded-2xl shadow-sm p-6">
                            <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-heartbeat text-green-500 mr-2"></i>État du Système</h2>
                            <div class="grid grid-cols-3 gap-4">
                                <div class="bg-slate-50 rounded-xl p-4 text-center">
                                    <div class="w-16 h-16 mx-auto mb-2 relative">
                                        <svg class="w-16 h-16 transform -rotate-90">
                                            <circle cx="32" cy="32" r="28" stroke="#e2e8f0" stroke-width="4" fill="none"/>
                                            <circle cx="32" cy="32" r="28" stroke="#22c55e" stroke-width="4" fill="none" stroke-dasharray="175.9" stroke-dashoffset="8" stroke-linecap="round"/>
                                        </svg>
                                        <div class="absolute inset-0 flex items-center justify-center"><span class="text-lg font-bold">95%</span></div>
                                    </div>
                                    <p class="text-sm text-slate-600">Uptime API</p>
                                </div>
                                <div class="bg-slate-50 rounded-xl p-4 text-center">
                                    <div class="w-16 h-16 mx-auto mb-2 relative">
                                        <svg class="w-16 h-16 transform -rotate-90">
                                            <circle cx="32" cy="32" r="28" stroke="#e2e8f0" stroke-width="4" fill="none"/>
                                            <circle cx="32" cy="32" r="28" stroke="#3b82f6" stroke-width="4" fill="none" stroke-dasharray="175.9" stroke-dashoffset="26" stroke-linecap="round"/>
                                        </svg>
                                        <div class="absolute inset-0 flex items-center justify-center"><span class="text-lg font-bold">85%</span></div>
                                    </div>
                                    <p class="text-sm text-slate-600">CPU Usage</p>
                                </div>
                                <div class="bg-slate-50 rounded-xl p-4 text-center">
                                    <div class="w-16 h-16 mx-auto mb-2 relative">
                                        <svg class="w-16 h-16 transform -rotate-90">
                                            <circle cx="32" cy="32" r="28" stroke="#e2e8f0" stroke-width="4" fill="none"/>
                                            <circle cx="32" cy="32" r="28" stroke="#8b5cf6" stroke-width="4" fill="none" stroke-dasharray="175.9" stroke-dashoffset="44" stroke-linecap="round"/>
                                        </svg>
                                        <div class="absolute inset-0 flex items-center justify-center"><span class="text-lg font-bold">75%</span></div>
                                    </div>
                                    <p class="text-sm text-slate-600">Mémoire</p>
                                </div>
                            </div>
                        </div>

                        <!-- Activity Log -->
                        <div class="bg-white rounded-2xl shadow-sm">
                            <div class="p-6 border-b border-slate-100">
                                <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-list-alt text-blue-500 mr-2"></i>Activité en temps réel</h2>
                            </div>
                            <div class="p-4">
                                <div class="space-y-3">
                                    <div class="flex items-center p-3 bg-slate-50 rounded-lg">
                                        <div class="w-2 h-2 bg-green-500 rounded-full mr-3"></div>
                                        <span class="text-sm text-slate-600">14:32:15</span>
                                        <span class="mx-3 text-slate-300">|</span>
                                        <span class="text-sm text-slate-800">Nouvelle connexion - Fédération Athlétisme</span>
                                    </div>
                                    <div class="flex items-center p-3 bg-slate-50 rounded-lg">
                                        <div class="w-2 h-2 bg-blue-500 rounded-full mr-3"></div>
                                        <span class="text-sm text-slate-600">14:28:42</span>
                                        <span class="mx-3 text-slate-300">|</span>
                                        <span class="text-sm text-slate-800">Licence créée - Athlète #12345</span>
                                    </div>
                                    <div class="flex items-center p-3 bg-slate-50 rounded-lg">
                                        <div class="w-2 h-2 bg-purple-500 rounded-full mr-3"></div>
                                        <span class="text-sm text-slate-600">14:25:18</span>
                                        <span class="mx-3 text-slate-300">|</span>
                                        <span class="text-sm text-slate-800">Paiement Mobile Money confirmé - 27,000 Ar</span>
                                    </div>
                                    <div class="flex items-center p-3 bg-amber-50 rounded-lg">
                                        <div class="w-2 h-2 bg-amber-500 rounded-full mr-3"></div>
                                        <span class="text-sm text-slate-600">14:20:05</span>
                                        <span class="mx-3 text-slate-300">|</span>
                                        <span class="text-sm text-amber-800">Alerte IA - Performance anomalie détectée</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="space-y-8">
                        <!-- Digitalization Progress -->
                        <div class="bg-gradient-to-br from-blue-600 to-blue-800 rounded-2xl p-6 text-white">
                            <h3 class="font-semibold mb-4"><i class="fas fa-chart-line mr-2"></i>Digitalisation</h3>
                            <div class="flex items-center justify-center mb-4">
                                <div class="relative w-24 h-24">
                                    <svg class="w-24 h-24 transform -rotate-90">
                                        <circle cx="48" cy="48" r="40" stroke="rgba(255,255,255,0.2)" stroke-width="8" fill="none"/>
                                        <circle cx="48" cy="48" r="40" stroke="white" stroke-width="8" fill="none" stroke-dasharray="251.2" stroke-dashoffset="18" stroke-linecap="round"/>
                                    </svg>
                                    <div class="absolute inset-0 flex items-center justify-center"><span class="text-2xl font-bold">93%</span></div>
                                </div>
                            </div>
                            <p class="text-center text-blue-100 text-sm">Objectif 2025: 100%</p>
                        </div>

                        <!-- Federation Status -->
                        <div class="bg-white rounded-2xl shadow-sm">
                            <div class="p-6 border-b border-slate-100">
                                <h2 class="text-lg font-bold text-slate-800">État des Fédérations</h2>
                            </div>
                            <div class="p-4">
                                <div class="space-y-3">
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-slate-700">Athlétisme</span>
                                        <span class="px-2 py-1 bg-green-100 text-green-700 rounded text-xs">Active</span>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-slate-700">Football</span>
                                        <span class="px-2 py-1 bg-green-100 text-green-700 rounded text-xs">Active</span>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-slate-700">Basketball</span>
                                        <span class="px-2 py-1 bg-green-100 text-green-700 rounded text-xs">Active</span>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-slate-700">Natation</span>
                                        <span class="px-2 py-1 bg-amber-100 text-amber-700 rounded text-xs">Config</span>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <span class="text-sm text-slate-700">Judo</span>
                                        <span class="px-2 py-1 bg-slate-100 text-slate-700 rounded text-xs">Inactive</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
