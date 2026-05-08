<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Finances & Licences - Fédération | SPORT CONNECT</title>
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
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-slate-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 bg-gradient-to-br from-amber-400 to-amber-600 rounded-lg flex items-center justify-center">
                        <i class="fas fa-landmark text-white"></i>
                    </div>
                    <span class="text-xl font-bold text-slate-800">SPORT<span class="text-blue-600">CONNECT</span></span>
                </div>
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="../athletes/athletes.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-users w-6"></i>Gestion Athlètes</a>
                    <a href="../clubs/clubs.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-building w-6"></i>Gestion Clubs</a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../scouting/scouting.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-search w-6"></i>Scouting & Talents</a>
                    <a href="finances.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-money-bill-wave w-6"></i>Finances & Licences</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-chart-pie w-6"></i>Rapports & Stats</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Finances & Licences</h1>
                        <p class="text-slate-500 text-sm">Suivi des paiements et audit des transactions</p>
                    </div>
                    <div class="flex gap-3">
                        <button class="px-4 py-2 bg-green-100 text-green-700 rounded-lg font-medium hover:bg-green-200"><i class="fas fa-file-export mr-2"></i>Export financier</button>
                        <button class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700"><i class="fas fa-cog mr-2"></i>Paramètres tarifs</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Financial Stats -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-wallet text-green-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Recettes totales (2025)</h3>
                        <p class="text-2xl font-bold text-slate-800">32.4M Ar</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-mobile-alt text-blue-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Transactions Mvola</h3>
                        <p class="text-2xl font-bold text-slate-800">1,156</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-orange-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-mobile-alt text-orange-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Transactions Orange</h3>
                        <p class="text-2xl font-bold text-slate-800">623</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center mb-4"><i class="fas fa-mobile-alt text-red-600 text-xl"></i></div>
                        <h3 class="text-slate-500 text-sm">Transactions Airtel</h3>
                        <p class="text-2xl font-bold text-slate-800">312</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                    <!-- Revenue Chart -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-chart-bar text-blue-500 mr-2"></i>Recettes par mois</h2>
                        <canvas id="revenueChart" height="200"></canvas>
                    </div>
                    <!-- Payment Methods -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-chart-pie text-green-500 mr-2"></i>Répartition Mobile Money</h2>
                        <canvas id="paymentChart" height="200"></canvas>
                    </div>
                </div>

                <!-- Recent Transactions -->
                <div class="bg-white rounded-2xl shadow-sm">
                    <div class="p-6 border-b border-slate-100 flex items-center justify-between">
                        <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-list text-blue-500 mr-2"></i>Transactions récentes</h2>
                        <div class="flex gap-2">
                            <input type="date" class="px-3 py-2 border border-slate-200 rounded-lg text-sm">
                            <select class="px-3 py-2 border border-slate-200 rounded-lg text-sm"><option>Tous opérateurs</option><option>Mvola</option><option>Orange</option><option>Airtel</option></select>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-slate-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Date</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Athlète</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Type</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Opérateur</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Montant</th>
                                    <th class="text-left py-4 px-6 font-semibold text-slate-700">Statut</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-slate-100">
                                    <td class="py-4 px-6 text-slate-600">06/05/2025 14:32</td>
                                    <td class="py-4 px-6 font-medium text-slate-800">Rakoto Jean</td>
                                    <td class="py-4 px-6 text-slate-700">Licence Senior 2025</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-green-100 text-green-700 rounded text-sm">Mvola</span></td>
                                    <td class="py-4 px-6 font-semibold text-slate-800">27,000 Ar</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-green-100 text-green-700 rounded text-sm">Confirmé</span></td>
                                </tr>
                                <tr class="border-b border-slate-100">
                                    <td class="py-4 px-6 text-slate-600">06/05/2025 13:15</td>
                                    <td class="py-4 px-6 font-medium text-slate-800">Andria Marie</td>
                                    <td class="py-4 px-6 text-slate-700">Licence Junior 2025</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-orange-100 text-orange-700 rounded text-sm">Orange</span></td>
                                    <td class="py-4 px-6 font-semibold text-slate-800">20,000 Ar</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-green-100 text-green-700 rounded text-sm">Confirmé</span></td>
                                </tr>
                                <tr class="border-b border-slate-100">
                                    <td class="py-4 px-6 text-slate-600">06/05/2025 11:45</td>
                                    <td class="py-4 px-6 font-medium text-slate-800">Raso Paul</td>
                                    <td class="py-4 px-6 text-slate-700">Inscription Championnat</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-red-100 text-red-700 rounded text-sm">Airtel</span></td>
                                    <td class="py-4 px-6 font-semibold text-slate-800">10,000 Ar</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-green-100 text-green-700 rounded text-sm">Confirmé</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        new Chart(document.getElementById('revenueChart'), {
            type: 'bar',
            data: {
                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai'],
                datasets: [{
                    label: 'Recettes (M Ar)',
                    data: [5.2, 6.8, 7.1, 6.5, 6.8],
                    backgroundColor: '#3b82f6',
                    borderRadius: 6
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } } }
        });

        new Chart(document.getElementById('paymentChart'), {
            type: 'doughnut',
            data: {
                labels: ['Mvola', 'Orange Money', 'Airtel Money'],
                datasets: [{
                    data: [55, 30, 15],
                    backgroundColor: ['#10b981', '#f97316', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });
    </script>
</body>
</html>
