<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rapports Ministériels - Admin | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    <a href="../configuration/configuration.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-cogs w-6"></i>Configuration</a>
                    <a href="../securite/securite.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-lock w-6"></i>Sécurité</a>
                    <a href="../ia/ia.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-robot w-6"></i>IA</a>
                    <a href="../infrastructure/infrastructure.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-server w-6"></i>Infrastructure</a>
                    <a href="rapports.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-file-alt w-6"></i>Rapports Ministériels</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Rapports Ministériels</h1>
                        <p class="text-slate-500 text-sm">Reporting officiel pour le Ministère du Numérique</p>
                    </div>
                    <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-file-export mr-2"></i>Générer rapport PDF</button>
                </div>
            </header>

            <main class="p-8">
                <!-- KPIs Nationaux -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm border-l-4 border-blue-500">
                        <h3 class="text-slate-500 text-sm">Athlètes digitalisés</h3>
                        <p class="text-3xl font-bold text-slate-800">45,678</p>
                        <p class="text-xs text-blue-500"><i class="fas fa-arrow-up"></i> +18% vs 2024</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm border-l-4 border-blue-500">
                        <h3 class="text-slate-500 text-sm">Fédérations actives</h3>
                        <p class="text-3xl font-bold text-slate-800">42/45</p>
                        <p class="text-xs text-blue-500">93% couverture</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm border-l-4 border-purple-500">
                        <h3 class="text-slate-500 text-sm">Volume transactions</h3>
                        <p class="text-3xl font-bold text-slate-800">847.2M Ar</p>
                        <p class="text-xs text-blue-500">Année 2025</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm border-l-4 border-amber-500">
                        <h3 class="text-slate-500 text-sm">Emplois créés</h3>
                        <p class="text-3xl font-bold text-slate-800">234</p>
                        <p class="text-xs text-blue-500">Directs et indirects</p>
                    </div>
                </div>

                <!-- COCOMO Progress -->
                <div class="bg-white rounded-2xl shadow-sm p-6 mb-8">
                    <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-tasks text-blue-500 mr-2"></i>Jalons COCOMO - Numérique 2035</h2>
                    <div class="space-y-4">
                        <div>
                            <div class="flex justify-between text-sm mb-2">
                                <span class="text-slate-700 font-medium">Phase 1: Fondation (2024)</span>
                                <span class="text-blue-600 font-semibold">100% Complété</span>
                            </div>
                            <div class="w-full h-3 bg-slate-200 rounded-full"><div class="h-3 bg-blue-500 rounded-full" style="width: 100%"></div></div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-2">
                                <span class="text-slate-700 font-medium">Phase 2: Déploiement fédérations (2025)</span>
                                <span class="text-blue-600 font-semibold">93% En cours</span>
                            </div>
                            <div class="w-full h-3 bg-slate-200 rounded-full"><div class="h-3 bg-blue-500 rounded-full" style="width: 93%"></div></div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-2">
                                <span class="text-slate-700 font-medium">Phase 3: IA & Analytics (2026)</span>
                                <span class="text-slate-500 font-semibold">À venir</span>
                            </div>
                            <div class="w-full h-3 bg-slate-200 rounded-full"><div class="h-3 bg-slate-400 rounded-full" style="width: 15%"></div></div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-2">
                                <span class="text-slate-700 font-medium">Phase 4: E-sport & Innovation (2027)</span>
                                <span class="text-slate-500 font-semibold">Planifié</span>
                            </div>
                            <div class="w-full h-3 bg-slate-200 rounded-full"><div class="h-3 bg-slate-300 rounded-full" style="width: 0%"></div></div>
                        </div>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-chart-line text-blue-500 mr-2"></i>Croissance mensuelle</h2>
                        <canvas id="growthChart" height="200"></canvas>
                    </div>
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-coins text-blue-500 mr-2"></i>Impact économique</h2>
                        <div class="space-y-4">
                            <div class="flex items-center justify-between p-4 bg-slate-50 rounded-xl">
                                <div>
                                    <p class="font-semibold text-slate-800">Recettes e-sport</p>
                                    <p class="text-sm text-slate-500">Tournois et sponsors</p>
                                </div>
                                <span class="text-xl font-bold text-blue-600">124.5M Ar</span>
                            </div>
                            <div class="flex items-center justify-between p-4 bg-slate-50 rounded-xl">
                                <div>
                                    <p class="font-semibold text-slate-800">Recettes licences</p>
                                    <p class="text-sm text-slate-500">Toutes fédérations</p>
                                </div>
                                <span class="text-xl font-bold text-blue-600">722.7M Ar</span>
                            </div>
                            <div class="flex items-center justify-between p-4 bg-slate-50 rounded-xl">
                                <div>
                                    <p class="font-semibold text-slate-800">Investissement DSI</p>
                                    <p class="text-sm text-slate-500">Infrastructure & dev</p>
                                </div>
                                <span class="text-xl font-bold text-blue-600">2.4Mds Ar</span>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        new Chart(document.getElementById('growthChart'), {
            type: 'line',
            data: {
                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai'],
                datasets: [{
                    label: 'Nouveaux athlètes',
                    data: [1200, 1850, 2100, 1950, 2200],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } } }
        });
    </script>
</body>
</html>
