<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compétitions - Athlète | SPORT CONNECT</title>
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
        .competition-card { transition: all 0.3s ease; }
        .competition-card:hover { transform: translateY(-4px); box-shadow: 0 12px 24px rgba(0,0,0,0.1); }
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
                <nav class="space-y-1">
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-home w-6"></i>Tableau de Bord</a>
                    <a href="../profil/profil.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-user w-6"></i>Mon Profil</a>
                    <a href="../licences/licences.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-id-card w-6"></i>Mes Licences</a>
                    <a href="competitions.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../sante/sante.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-heartbeat w-6"></i>Santé & Performance</a>
                    <a href="../medias/medias.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-video w-6"></i>Médias & E-sport</a>
                    <a href="../notifications/notifications.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-bell w-6"></i>Notifications<span class="ml-auto bg-blue-500 text-white text-xs px-2 py-0.5 rounded-full">3</span></a>
                </nav>
                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-blue-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-secondary-200 sticky top-0 z-30">
                <div class="px-8 py-4">
                    <h1 class="text-2xl font-bold text-secondary-800">Compétitions</h1>
                    <p class="text-secondary-500 text-sm">Calendrier national et inscriptions aux compétitions</p>
                </div>
            </header>

            <main class="p-8">
                <!-- Filters -->
                <div class="bg-white rounded-2xl shadow-sm p-4 mb-8">
                    <div class="flex flex-wrap gap-4">
                        <select class="px-4 py-2 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none">
                            <option>Toutes les disciplines</option>
                            <option>Athlétisme</option>
                            <option>Football</option>
                            <option>Basketball</option>
                        </select>
                        <select class="px-4 py-2 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none">
                            <option>Toutes les catégories</option>
                            <option>Senior</option>
                            <option>Junior</option>
                            <option>Cadet</option>
                        </select>
                        <input type="month" class="px-4 py-2 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none">
                        <div class="flex-1"></div>
                        <div class="flex bg-secondary-100 rounded-lg p-1">
                            <button class="px-4 py-2 bg-white rounded-md shadow-sm text-primary-600 font-medium"><i class="fas fa-list mr-2"></i>Liste</button>
                            <button class="px-4 py-2 text-secondary-600 font-medium"><i class="fas fa-calendar-alt mr-2"></i>Calendrier</button>
                        </div>
                    </div>
                </div>

                <!-- Competition Tabs -->
                <div class="flex gap-6 mb-6 border-b border-secondary-200">
                    <button class="px-4 py-3 text-primary-600 font-semibold border-b-2 border-primary-600">À venir</button>
                    <button class="px-4 py-3 text-secondary-500 font-medium hover:text-secondary-700">Mes inscriptions</button>
                    <button class="px-4 py-3 text-secondary-500 font-medium hover:text-secondary-700">Historique</button>
                    <button class="px-4 py-3 text-secondary-500 font-medium hover:text-secondary-700">Résultats</button>
                </div>

                <!-- Competition Cards -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                    <!-- Competition 1 -->
                    <div class="competition-card bg-white rounded-2xl shadow-sm overflow-hidden">
                        <div class="h-32 gradient-bg relative">
                            <div class="absolute inset-0 flex items-center justify-center">
                                <i class="fas fa-trophy text-white/20 text-6xl"></i>
                            </div>
                            <div class="absolute top-4 right-4 px-3 py-1 bg-green-400 text-white rounded-full text-sm font-medium">Inscriptions ouvertes</div>
                        </div>
                        <div class="p-6">
                            <div class="flex items-center gap-2 mb-3">
                                <span class="px-2 py-1 bg-primary-100 text-primary-700 rounded text-xs font-medium">Athlétisme</span>
                                <span class="px-2 py-1 bg-secondary-100 text-secondary-700 rounded text-xs font-medium">Senior</span>
                            </div>
                            <h3 class="text-xl font-bold text-secondary-800 mb-2">Championnat National d'Athlétisme</h3>
                            <div class="space-y-2 text-sm text-secondary-600 mb-4">
                                <div class="flex items-center"><i class="fas fa-calendar-alt w-5 text-primary-500"></i>15-17 Mai 2025</div>
                                <div class="flex items-center"><i class="fas fa-map-marker-alt w-5 text-primary-500"></i>Stade Mahamasina, Antananarivo</div>
                                <div class="flex items-center"><i class="fas fa-clock w-5 text-primary-500"></i>Clôture des inscriptions: 10 Mai</div>
                            </div>
                            <div class="flex items-center justify-between pt-4 border-t border-secondary-100">
                                <div class="text-sm">
                                    <span class="text-secondary-500">Frais d'inscription:</span>
                                    <span class="font-semibold text-secondary-800">10 000 Ar</span>
                                </div>
                                <button onclick="openInscriptionModal('Championnat National d\'Athlétisme')" class="px-6 py-2 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition">S'inscrire</button>
                            </div>
                        </div>
                    </div>

                    <!-- Competition 2 -->
                    <div class="competition-card bg-white rounded-2xl shadow-sm overflow-hidden">
                        <div class="h-32 bg-gradient-to-br from-emerald-500 to-teal-600 relative">
                            <div class="absolute inset-0 flex items-center justify-center">
                                <i class="fas fa-medal text-white/20 text-6xl"></i>
                            </div>
                            <div class="absolute top-4 right-4 px-3 py-1 bg-green-400 text-white rounded-full text-sm font-medium">Inscriptions ouvertes</div>
                        </div>
                        <div class="p-6">
                            <div class="flex items-center gap-2 mb-3">
                                <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-medium">Athlétisme</span>
                                <span class="px-2 py-1 bg-secondary-100 text-secondary-700 rounded text-xs font-medium">Senior</span>
                            </div>
                            <h3 class="text-xl font-bold text-secondary-800 mb-2">Meeting International de Tamatave</h3>
                            <div class="space-y-2 text-sm text-secondary-600 mb-4">
                                <div class="flex items-center"><i class="fas fa-calendar-alt w-5 text-blue-500"></i>8-10 Juin 2025</div>
                                <div class="flex items-center"><i class="fas fa-map-marker-alt w-5 text-blue-500"></i>Stade Municipal, Toamasina</div>
                                <div class="flex items-center"><i class="fas fa-clock w-5 text-blue-500"></i>Clôture: 1 Juin</div>
                            </div>
                            <div class="flex items-center justify-between pt-4 border-t border-secondary-100">
                                <div class="text-sm">
                                    <span class="text-secondary-500">Frais d'inscription:</span>
                                    <span class="font-semibold text-secondary-800">15 000 Ar</span>
                                </div>
                                <button onclick="openInscriptionModal('Meeting International de Tamatave')" class="px-6 py-2 bg-emerald-600 text-white rounded-lg font-medium hover:bg-emerald-700 transition">S'inscrire</button>
                            </div>
                        </div>
                    </div>

                    <!-- Competition 3 -->
                    <div class="competition-card bg-white rounded-2xl shadow-sm overflow-hidden">
                        <div class="h-32 bg-gradient-to-br from-purple-500 to-indigo-600 relative">
                            <div class="absolute inset-0 flex items-center justify-center">
                                <i class="fas fa-running text-white/20 text-6xl"></i>
                            </div>
                            <div class="absolute top-4 right-4 px-3 py-1 bg-amber-400 text-white rounded-full text-sm font-medium">Bientôt</div>
                        </div>
                        <div class="p-6">
                            <div class="flex items-center gap-2 mb-3">
                                <span class="px-2 py-1 bg-blue-100 text-purple-700 rounded text-xs font-medium">Athlétisme</span>
                                <span class="px-2 py-1 bg-secondary-100 text-secondary-700 rounded text-xs font-medium">Toutes catégories</span>
                            </div>
                            <h3 class="text-xl font-bold text-secondary-800 mb-2">Coupe des Clubs</h3>
                            <div class="space-y-2 text-sm text-secondary-600 mb-4">
                                <div class="flex items-center"><i class="fas fa-calendar-alt w-5 text-purple-500"></i>20-22 Juillet 2025</div>
                                <div class="flex items-center"><i class="fas fa-map-marker-alt w-5 text-purple-500"></i>Centre Sportif, Antsirabe</div>
                                <div class="flex items-center"><i class="fas fa-clock w-5 text-purple-500"></i>Ouverture: 15 Juillet</div>
                            </div>
                            <div class="flex items-center justify-between pt-4 border-t border-secondary-100">
                                <div class="text-sm">
                                    <span class="text-secondary-500">Frais:</span>
                                    <span class="font-semibold text-secondary-800">À déterminer</span>
                                </div>
                                <button class="px-6 py-2 bg-secondary-200 text-secondary-600 rounded-lg font-medium cursor-not-allowed" disabled>
                                    <i class="fas fa-bell mr-2"></i>M'alerter
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Results Section -->
                <div class="bg-white rounded-2xl shadow-sm">
                    <div class="p-6 border-b border-secondary-100">
                        <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-chart-bar text-primary-500 mr-2"></i>Mes Résultats Récents</h2>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-secondary-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Compétition</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Date</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Épreuve</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Performance</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Classement</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-secondary-100">
                                    <td class="py-4 px-6 font-medium text-secondary-800">Championnat Régional</td>
                                    <td class="py-4 px-6 text-secondary-600">12 Mars 2025</td>
                                    <td class="py-4 px-6 text-secondary-700">100m</td>
                                    <td class="py-4 px-6 font-semibold text-primary-600">10.45s (PB)</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm font-medium">1er</span></td>
                                </tr>
                                <tr class="border-b border-secondary-100">
                                    <td class="py-4 px-6 font-medium text-secondary-800">Meeting de préparation</td>
                                    <td class="py-4 px-6 text-secondary-600">28 Fév 2025</td>
                                    <td class="py-4 px-6 text-secondary-700">200m</td>
                                    <td class="py-4 px-6 font-semibold text-secondary-700">21.32s</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-slate-100 text-slate-700 rounded text-sm font-medium">2ème</span></td>
                                </tr>
                                <tr class="border-b border-secondary-100">
                                    <td class="py-4 px-6 font-medium text-secondary-800">Championnat National 2024</td>
                                    <td class="py-4 px-6 text-secondary-600">15 Mai 2024</td>
                                    <td class="py-4 px-6 text-secondary-700">100m</td>
                                    <td class="py-4 px-6 font-semibold text-secondary-700">10.62s</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm font-medium">1er</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Inscription Modal -->
    <div id="inscriptionModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-2xl w-full max-w-lg mx-4">
            <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                <h3 class="text-xl font-bold text-secondary-800">Inscription à la compétition</h3>
                <button onclick="closeInscriptionModal()" class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-times text-xl"></i></button>
            </div>
            <div class="p-6">
                <h4 id="competitionName" class="font-semibold text-secondary-800 mb-4"></h4>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-secondary-700 mb-2">Épreuves (sélection multiple)</label>
                    <div class="space-y-2">
                        <label class="flex items-center p-3 border border-secondary-200 rounded-lg cursor-pointer hover:bg-secondary-50">
                            <input type="checkbox" class="w-4 h-4 text-primary-600 rounded focus:ring-primary-500">
                            <span class="ml-3">100m - 5 000 Ar</span>
                        </label>
                        <label class="flex items-center p-3 border border-secondary-200 rounded-lg cursor-pointer hover:bg-secondary-50">
                            <input type="checkbox" class="w-4 h-4 text-primary-600 rounded focus:ring-primary-500">
                            <span class="ml-3">200m - 5 000 Ar</span>
                        </label>
                        <label class="flex items-center p-3 border border-secondary-200 rounded-lg cursor-pointer hover:bg-secondary-50">
                            <input type="checkbox" class="w-4 h-4 text-primary-600 rounded focus:ring-primary-500">
                            <span class="ml-3">400m - 5 000 Ar</span>
                        </label>
                        <label class="flex items-center p-3 border border-secondary-200 rounded-lg cursor-pointer hover:bg-secondary-50">
                            <input type="checkbox" class="w-4 h-4 text-primary-600 rounded focus:ring-primary-500">
                            <span class="ml-3">4x100m Relais - 10 000 Ar</span>
                        </label>
                    </div>
                </div>
                <div class="bg-secondary-50 rounded-xl p-4 mb-4">
                    <div class="flex justify-between items-center">
                        <span class="text-secondary-700">Total</span>
                        <span class="text-xl font-bold text-primary-600">10 000 Ar</span>
                    </div>
                </div>
                <div class="flex gap-4">
                    <button onclick="closeInscriptionModal()" class="flex-1 py-3 border border-secondary-300 text-secondary-700 rounded-xl font-medium hover:bg-secondary-50 transition">Annuler</button>
                    <button class="flex-1 py-3 bg-primary-600 text-white rounded-xl font-medium hover:bg-primary-700 transition">Confirmer et payer</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openInscriptionModal(competitionName) {
            document.getElementById('competitionName').textContent = competitionName;
            document.getElementById('inscriptionModal').classList.remove('hidden');
            document.getElementById('inscriptionModal').classList.add('flex');
        }
        function closeInscriptionModal() {
            document.getElementById('inscriptionModal').classList.add('hidden');
            document.getElementById('inscriptionModal').classList.remove('flex');
        }
    </script>
</body>
</html>
