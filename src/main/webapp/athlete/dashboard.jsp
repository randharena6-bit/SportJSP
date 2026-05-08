<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Athlète | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .card-hover { transition: all 0.3s ease; }
        .card-hover:hover { transform: translateY(-4px); box-shadow: 0 12px 24px rgba(0,0,0,0.1); }
        .notification-badge { animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
    </style>
</head>
<body class="bg-secondary-50 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <aside class="w-64 bg-white border-r border-secondary-200 flex-shrink-0 overflow-y-auto">
            <div class="p-6">
                <div class="flex items-center space-x-3 mb-8">
                    <div class="w-10 h-10 gradient-bg rounded-lg flex items-center justify-center">
                        <i class="fas fa-running text-white"></i>
                    </div>
                    <span class="text-xl font-bold text-secondary-800">SPORT<span class="text-primary-600">CONNECT</span></span>
                </div>
                
                <div class="mb-6 p-4 bg-primary-50 rounded-xl">
                    <div class="flex items-center space-x-3">
                        <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff" class="w-12 h-12 rounded-full">
                        <div>
                            <p class="font-semibold text-secondary-800 text-sm">Jean Rakoto</p>
                            <p class="text-xs text-secondary-500">Athlète - Athlétisme</p>
                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 mt-1">
                                <span class="w-1.5 h-1.5 bg-blue-500 rounded-full mr-1"></span>Licence Active
                            </span>
                        </div>
                    </div>
                </div>

                <nav class="space-y-1">
                    <p class="px-4 text-xs font-semibold text-secondary-400 uppercase tracking-wider mb-2">Menu Principal</p>
                    <a href="dashboard.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-home w-6"></i>Tableau de Bord
                    </a>
                    <a href="profil/profil.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-user w-6"></i>Mon Profil
                    </a>
                    <a href="licences/licences.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-id-card w-6"></i>Mes Licences
                    </a>
                    <a href="competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-trophy w-6"></i>Compétitions
                    </a>
                    <a href="sante/sante.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-heartbeat w-6"></i>Santé & Performance
                    </a>
                    <a href="medias/medias.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-video w-6"></i>Médias & E-sport
                    </a>
                    <a href="notifications/notifications.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-bell w-6"></i>Notifications
                        <span class="ml-auto bg-blue-500 text-white text-xs px-2 py-0.5 rounded-full">3</span>
                    </a>
                </nav>

                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-blue-600 font-medium transition">
                        <i class="fas fa-sign-out-alt w-6"></i>Déconnexion
                    </a>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="flex-1 overflow-y-auto">
            <!-- Header -->
            <header class="bg-white border-b border-secondary-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-secondary-800">Tableau de Bord</h1>
                        <p class="text-secondary-500 text-sm">Bienvenue, Jean ! Voici votre résumé sportif.</p>
                    </div>
                    <div class="flex items-center space-x-4">
                        <button class="relative p-2 text-secondary-400 hover:text-secondary-600 transition">
                            <i class="fas fa-bell text-xl"></i>
                            <span class="absolute top-0 right-0 w-5 h-5 bg-blue-500 text-white text-xs rounded-full flex items-center justify-center notification-badge">3</span>
                        </button>
                        <button class="relative p-2 text-secondary-400 hover:text-secondary-600 transition">
                            <i class="fas fa-envelope text-xl"></i>
                            <span class="absolute top-0 right-0 w-5 h-5 bg-primary-500 text-white text-xs rounded-full flex items-center justify-center">2</span>
                        </button>
                        <div class="h-8 w-px bg-secondary-200"></div>
                        <div class="flex items-center space-x-3">
                            <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff" class="w-10 h-10 rounded-full border-2 border-primary-200">
                            <span class="font-medium text-secondary-700">Jean Rakoto</span>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Dashboard Content -->
            <main class="p-8">
                <!-- Stats Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-id-card text-blue-600 text-xl"></i>
                            </div>
                            <span class="text-blue-500 text-sm font-medium"><i class="fas fa-check mr-1"></i>Active</span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Statut Licence</h3>
                        <p class="text-2xl font-bold text-secondary-800">2024-2025</p>
                        <p class="text-xs text-secondary-400 mt-1">Expire le 31/12/2025</p>
                    </div>

                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-trophy text-blue-600 text-xl"></i>
                            </div>
                            <span class="text-blue-500 text-sm font-medium">+2 ce mois</span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Compétitions</h3>
                        <p class="text-2xl font-bold text-secondary-800">24</p>
                        <p class="text-xs text-secondary-400 mt-1">Cette saison</p>
                    </div>

                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-medal text-blue-600 text-xl"></i>
                            </div>
                            <span class="text-blue-500 text-sm font-medium">Top 10%</span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Score de Talent</h3>
                        <p class="text-2xl font-bold text-secondary-800">Elite</p>
                        <p class="text-xs text-secondary-400 mt-1">Score IA: 87.5/100</p>
                    </div>

                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-heartbeat text-blue-600 text-xl"></i>
                            </div>
                            <span class="text-blue-500 text-sm font-medium">Optimal</span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Forme Physique</h3>
                        <p class="text-2xl font-bold text-secondary-800">92%</p>
                        <p class="text-xs text-secondary-400 mt-1">Dernière mise à jour: hier</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Left Column -->
                    <div class="lg:col-span-2 space-y-8">
                        <!-- Upcoming Competitions -->
                        <div class="bg-white rounded-2xl shadow-sm">
                            <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                                <h2 class="text-lg font-bold text-secondary-800">
                                    <i class="fas fa-calendar-alt text-primary-500 mr-2"></i>Prochaines Compétitions
                                </h2>
                                <a href="competitions/competitions.jsp" class="text-primary-600 text-sm font-medium hover:underline">Voir tout</a>
                            </div>
                            <div class="p-6">
                                <div class="space-y-4">
                                    <div class="flex items-center p-4 bg-secondary-50 rounded-xl">
                                        <div class="w-16 h-16 bg-primary-100 rounded-xl flex flex-col items-center justify-center mr-4">
                                            <span class="text-xs text-primary-600 font-bold">MAI</span>
                                            <span class="text-xl font-bold text-primary-700">15</span>
                                        </div>
                                        <div class="flex-1">
                                            <h4 class="font-semibold text-secondary-800">Championnat National d'Athlétisme</h4>
                                            <p class="text-sm text-secondary-500"><i class="fas fa-map-marker-alt mr-1"></i>Stade Mahamasina, Antananarivo</p>
                                        </div>
                                        <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Inscrit</span>
                                    </div>
                                    <div class="flex items-center p-4 bg-secondary-50 rounded-xl">
                                        <div class="w-16 h-16 bg-secondary-100 rounded-xl flex flex-col items-center justify-center mr-4">
                                            <span class="text-xs text-secondary-600 font-bold">JUIN</span>
                                            <span class="text-xl font-bold text-secondary-700">08</span>
                                        </div>
                                        <div class="flex-1">
                                            <h4 class="font-semibold text-secondary-800">Meeting International de Tamatave</h4>
                                            <p class="text-sm text-secondary-500"><i class="fas fa-map-marker-alt mr-1"></i>Stade Municipal, Toamasina</p>
                                        </div>
                                        <a href="competitions/competitions.jsp" class="px-3 py-1 bg-primary-100 text-primary-700 rounded-lg text-sm font-medium hover:bg-primary-200 transition">S'inscrire</a>
                                    </div>
                                    <div class="flex items-center p-4 bg-secondary-50 rounded-xl">
                                        <div class="w-16 h-16 bg-secondary-100 rounded-xl flex flex-col items-center justify-center mr-4">
                                            <span class="text-xs text-secondary-600 font-bold">JUIL</span>
                                            <span class="text-xl font-bold text-secondary-700">20</span>
                                        </div>
                                        <div class="flex-1">
                                            <h4 class="font-semibold text-secondary-800">Coupe des Clubs</h4>
                                            <p class="text-sm text-secondary-500"><i class="fas fa-map-marker-alt mr-1"></i>Centre Sportif, Antsirabe</p>
                                        </div>
                                        <span class="px-3 py-1 bg-secondary-200 text-secondary-600 rounded-lg text-sm font-medium">Bientôt</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Performance Chart -->
                        <div class="bg-white rounded-2xl shadow-sm p-6">
                            <h2 class="text-lg font-bold text-secondary-800 mb-6">
                                <i class="fas fa-chart-line text-primary-500 mr-2"></i>Évolution des Performances
                            </h2>
                            <canvas id="performanceChart" height="250"></canvas>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="space-y-8">
                        <!-- Talent Score -->
                        <div class="bg-gradient-to-br from-primary-600 to-primary-800 rounded-2xl p-6 text-white">
                            <h3 class="font-semibold mb-4"><i class="fas fa-star mr-2"></i>Score de Talent</h3>
                            <div class="flex items-center justify-center mb-4">
                                <div class="relative w-32 h-32">
                                    <svg class="w-32 h-32 transform -rotate-90">
                                        <circle cx="64" cy="64" r="56" stroke="rgba(255,255,255,0.2)" stroke-width="8" fill="none"/>
                                        <circle cx="64" cy="64" r="56" stroke="white" stroke-width="8" fill="none" stroke-dasharray="351.86" stroke-dashoffset="44" stroke-linecap="round"/>
                                    </svg>
                                    <div class="absolute inset-0 flex items-center justify-center">
                                        <span class="text-3xl font-bold">87.5</span>
                                    </div>
                                </div>
                            </div>
                            <p class="text-center text-primary-100 text-sm">Catégorie: <span class="font-semibold text-white">Elite</span></p>
                            <div class="mt-4 pt-4 border-t border-white/20">
                                <div class="flex justify-between text-sm">
                                    <span class="text-primary-100">Rang national:</span>
                                    <span class="font-semibold">#12</span>
                                </div>
                                <div class="flex justify-between text-sm mt-2">
                                    <span class="text-primary-100">Progression:</span>
                                    <span class="font-semibold text-blue-300">+5.2%</span>
                                </div>
                            </div>
                        </div>

                        <!-- Notifications -->
                        <div class="bg-white rounded-2xl shadow-sm">
                            <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                                <h2 class="text-lg font-bold text-secondary-800">
                                    <i class="fas fa-bell text-primary-500 mr-2"></i>Alertes
                                </h2>
                                <span class="bg-blue-100 text-blue-600 text-xs px-2 py-1 rounded-full font-medium">3 nouvelles</span>
                            </div>
                            <div class="p-4">
                                <div class="space-y-3">
                                    <div class="flex items-start space-x-3 p-3 bg-blue-50 rounded-xl border-l-4 border-blue-500">
                                        <i class="fas fa-exclamation-circle text-blue-500 mt-1"></i>
                                        <div>
                                            <p class="text-sm font-medium text-secondary-800">Renouvellement licence</p>
                                            <p class="text-xs text-secondary-500">Votre licence expire dans 45 jours</p>
                                        </div>
                                    </div>
                                    <div class="flex items-start space-x-3 p-3 bg-blue-50 rounded-xl border-l-4 border-blue-500">
                                        <i class="fas fa-info-circle text-blue-500 mt-1"></i>
                                        <div>
                                            <p class="text-sm font-medium text-secondary-800">Nouvelle compétition</p>
                                            <p class="text-xs text-secondary-500">Championnat national ouvert</p>
                                        </div>
                                    </div>
                                    <div class="flex items-start space-x-3 p-3 bg-blue-50 rounded-xl border-l-4 border-blue-500">
                                        <i class="fas fa-check-circle text-blue-500 mt-1"></i>
                                        <div>
                                            <p class="text-sm font-medium text-secondary-800">Paiement confirmé</p>
                                            <p class="text-xs text-secondary-500">Licence 2024-2025 payée</p>
                                        </div>
                                    </div>
                                </div>
                                <a href="notifications/notifications.jsp" class="block text-center text-primary-600 text-sm font-medium mt-4 hover:underline">Voir toutes les notifications</a>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="bg-white rounded-2xl shadow-sm p-6">
                            <h2 class="text-lg font-bold text-secondary-800 mb-4">Actions Rapides</h2>
                            <div class="space-y-3">
                                <a href="licences/licences.jsp" class="flex items-center p-3 bg-secondary-50 rounded-xl hover:bg-primary-50 transition group">
                                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3 group-hover:bg-blue-200 transition">
                                        <i class="fas fa-id-card text-blue-600"></i>
                                    </div>
                                    <span class="font-medium text-secondary-700">Renouveler ma licence</span>
                                </a>
                                <a href="competitions/competitions.jsp" class="flex items-center p-3 bg-secondary-50 rounded-xl hover:bg-primary-50 transition group">
                                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3 group-hover:bg-blue-200 transition">
                                        <i class="fas fa-trophy text-blue-600"></i>
                                    </div>
                                    <span class="font-medium text-secondary-700">Trouver une compétition</span>
                                </a>
                                <a href="sante/sante.jsp" class="flex items-center p-3 bg-secondary-50 rounded-xl hover:bg-primary-50 transition group">
                                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3 group-hover:bg-blue-200 transition">
                                        <i class="fas fa-heartbeat text-blue-600"></i>
                                    </div>
                                    <span class="font-medium text-secondary-700">Mettre à jour mes données</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        // Performance Chart
        const ctx = document.getElementById('performanceChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai'],
                datasets: [{
                    label: 'Performance (%)',
                    data: [72, 75, 78, 82, 87.5],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#3b82f6',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        min: 60,
                        max: 100,
                        grid: { color: '#e2e8f0' }
                    },
                    x: {
                        grid: { display: false }
                    }
                }
            }
        });
    </script>
</body>
</html>
