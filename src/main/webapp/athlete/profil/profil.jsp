<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil - Athlète | SPORT CONNECT</title>
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
        .tab-active { border-bottom: 2px solid #3b82f6; color: #2563eb; }
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
                    <a href="../dashboard.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-home w-6"></i>Tableau de Bord
                    </a>
                    <a href="profil.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-user w-6"></i>Mon Profil
                    </a>
                    <a href="../licences/licences.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-id-card w-6"></i>Mes Licences
                    </a>
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-trophy w-6"></i>Compétitions
                    </a>
                    <a href="../sante/sante.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-heartbeat w-6"></i>Santé & Performance
                    </a>
                    <a href="../medias/medias.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-video w-6"></i>Médias & E-sport
                    </a>
                    <a href="../notifications/notifications.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-bell w-6"></i>Notifications
                        <span class="ml-auto bg-red-500 text-white text-xs px-2 py-0.5 rounded-full">3</span>
                    </a>
                </nav>
                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-red-600 font-medium transition">
                        <i class="fas fa-sign-out-alt w-6"></i>Déconnexion
                    </a>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-secondary-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-secondary-800">Mon Profil Sportif</h1>
                        <p class="text-secondary-500 text-sm">Gérez vos informations personnelles et votre palmarès</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff" class="w-10 h-10 rounded-full border-2 border-primary-200">
                        <span class="font-medium text-secondary-700">Jean Rakoto</span>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Profile Header Card -->
                <div class="bg-white rounded-2xl shadow-sm mb-8">
                    <div class="h-32 gradient-bg rounded-t-2xl"></div>
                    <div class="px-8 pb-8">
                        <div class="flex flex-col md:flex-row items-start md:items-end -mt-16 mb-6">
                            <div class="relative">
                                <img src="https://ui-avatars.com/api/?name=Jean+Rakoto&background=3b82f6&color=fff&size=128" class="w-32 h-32 rounded-2xl border-4 border-white shadow-lg">
                                <button class="absolute bottom-2 right-2 w-8 h-8 bg-white rounded-full shadow-md flex items-center justify-center text-secondary-600 hover:text-primary-600">
                                    <i class="fas fa-camera"></i>
                                </button>
                            </div>
                            <div class="mt-4 md:mt-0 md:ml-6 flex-1">
                                <h2 class="text-2xl font-bold text-secondary-800">Jean Rakoto</h2>
                                <p class="text-secondary-500">Athlète - Athlétisme | 100m, 200m, Relais</p>
                                <div class="flex items-center mt-2 space-x-4">
                                    <span class="inline-flex items-center px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium">
                                        <i class="fas fa-check-circle mr-1"></i>Licence Active
                                    </span>
                                    <span class="inline-flex items-center px-3 py-1 bg-primary-100 text-primary-700 rounded-full text-sm font-medium">
                                        <i class="fas fa-star mr-1"></i>Elite
                                    </span>
                                </div>
                            </div>
                            <div class="mt-4 md:mt-0">
                                <button class="px-6 py-2.5 bg-primary-600 text-white rounded-xl font-medium hover:bg-primary-700 transition">
                                    <i class="fas fa-edit mr-2"></i>Modifier le profil
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabs -->
                <div class="bg-white rounded-2xl shadow-sm mb-8">
                    <div class="border-b border-secondary-200">
                        <nav class="flex px-6">
                            <button class="px-6 py-4 text-sm font-medium tab-active" onclick="switchTab('personal')">Informations Personnelles</button>
                            <button class="px-6 py-4 text-sm font-medium text-secondary-500 hover:text-secondary-700" onclick="switchTab('sports')">Disciplines & Palmarès</button>
                            <button class="px-6 py-4 text-sm font-medium text-secondary-500 hover:text-secondary-700" onclick="switchTab('documents')">Documents</button>
                            <button class="px-6 py-4 text-sm font-medium text-secondary-500 hover:text-secondary-700" onclick="switchTab('stats')">Statistiques</button>
                        </nav>
                    </div>

                    <!-- Personal Info Tab -->
                    <div id="personalTab" class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Prénom</label>
                                <input type="text" value="Jean" readonly class="w-full px-4 py-3 bg-secondary-50 border border-secondary-200 rounded-xl text-secondary-700">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Nom</label>
                                <input type="text" value="Rakoto" readonly class="w-full px-4 py-3 bg-secondary-50 border border-secondary-200 rounded-xl text-secondary-700">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">NIN (Numéro d'Identification National)</label>
                                <input type="text" value="1023456789012" readonly class="w-full px-4 py-3 bg-secondary-50 border border-secondary-200 rounded-xl text-secondary-700">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Date de naissance</label>
                                <input type="text" value="15 Mars 1998" readonly class="w-full px-4 py-3 bg-secondary-50 border border-secondary-200 rounded-xl text-secondary-700">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Email</label>
                                <input type="email" value="jean.rakoto@email.mg" class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Téléphone</label>
                                <input type="tel" value="+261 34 12 345 67" class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Adresse</label>
                                <input type="text" value="Lot II K 45 bis, Ankorondrano" class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Ville</label>
                                <input type="text" value="Antananarivo 101" class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                            </div>
                        </div>
                        <div class="mt-6 pt-6 border-t border-secondary-100">
                            <h4 class="font-semibold text-secondary-800 mb-4">Club Actuel</h4>
                            <div class="flex items-center p-4 bg-secondary-50 rounded-xl">
                                <div class="w-16 h-16 bg-primary-100 rounded-xl flex items-center justify-center mr-4">
                                    <i class="fas fa-running text-primary-600 text-2xl"></i>
                                </div>
                                <div>
                                    <h5 class="font-semibold text-secondary-800">Club Athlétisme Antananarivo</h5>
                                    <p class="text-sm text-secondary-500">Membre depuis 2019</p>
                                </div>
                                <span class="ml-auto px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Actif</span>
                            </div>
                        </div>
                    </div>

                    <!-- Sports & Palmares Tab (Hidden by default) -->
                    <div id="sportsTab" class="p-6 hidden">
                        <h4 class="font-semibold text-secondary-800 mb-4">Disciplines pratiquées</h4>
                        <div class="flex flex-wrap gap-3 mb-8">
                            <span class="px-4 py-2 bg-primary-100 text-primary-700 rounded-lg font-medium">100m</span>
                            <span class="px-4 py-2 bg-primary-100 text-primary-700 rounded-lg font-medium">200m</span>
                            <span class="px-4 py-2 bg-primary-100 text-primary-700 rounded-lg font-medium">400m</span>
                            <span class="px-4 py-2 bg-primary-100 text-primary-700 rounded-lg font-medium">4x100m Relais</span>
                        </div>

                        <h4 class="font-semibold text-secondary-800 mb-4">Palmarès</h4>
                        <div class="space-y-4">
                            <div class="flex items-center p-4 bg-blue-50 rounded-xl border-l-4 border-amber-400">
                                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mr-4">
                                    <i class="fas fa-medal text-blue-600 text-xl"></i>
                                </div>
                                <div class="flex-1">
                                    <h5 class="font-semibold text-secondary-800">Championnat National 2024</h5>
                                    <p class="text-sm text-secondary-500">100m - Médaille d'Or</p>
                                </div>
                                <span class="text-sm text-secondary-400">Mai 2024</span>
                            </div>
                            <div class="flex items-center p-4 bg-slate-50 rounded-xl border-l-4 border-slate-400">
                                <div class="w-12 h-12 bg-slate-100 rounded-lg flex items-center justify-center mr-4">
                                    <i class="fas fa-medal text-slate-600 text-xl"></i>
                                </div>
                                <div class="flex-1">
                                    <h5 class="font-semibold text-secondary-800">Meeting International Tamatave</h5>
                                    <p class="text-sm text-secondary-500">200m - Médaille d'Argent</p>
                                </div>
                                <span class="text-sm text-secondary-400">Juin 2024</span>
                            </div>
                            <div class="flex items-center p-4 bg-orange-50 rounded-xl border-l-4 border-orange-400">
                                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mr-4">
                                    <i class="fas fa-medal text-orange-600 text-xl"></i>
                                </div>
                                <div class="flex-1">
                                    <h5 class="font-semibold text-secondary-800">Coupe des Clubs</h5>
                                    <p class="text-sm text-secondary-500">4x100m Relais - Médaille de Bronze</p>
                                </div>
                                <span class="text-sm text-secondary-400">Juillet 2023</span>
                            </div>
                        </div>
                    </div>

                    <!-- Documents Tab -->
                    <div id="documentsTab" class="p-6 hidden">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="border-2 border-dashed border-secondary-300 rounded-xl p-6 text-center hover:border-primary-500 transition cursor-pointer">
                                <i class="fas fa-id-card text-4xl text-secondary-400 mb-3"></i>
                                <h5 class="font-medium text-secondary-700">Carte d'identité</h5>
                                <p class="text-sm text-secondary-500">PDF, JPG (max 5MB)</p>
                                <span class="inline-flex items-center px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-medium mt-2">
                                    <i class="fas fa-check mr-1"></i>Document vérifié
                                </span>
                            </div>
                            <div class="border-2 border-dashed border-secondary-300 rounded-xl p-6 text-center hover:border-primary-500 transition cursor-pointer">
                                <i class="fas fa-file-medical text-4xl text-secondary-400 mb-3"></i>
                                <h5 class="font-medium text-secondary-700">Certificat médical</h5>
                                <p class="text-sm text-secondary-500">PDF (max 5MB)</p>
                                <span class="inline-flex items-center px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-medium mt-2">
                                    <i class="fas fa-check mr-1"></i>Document vérifié
                                </span>
                            </div>
                            <div class="border-2 border-dashed border-secondary-300 rounded-xl p-6 text-center hover:border-primary-500 transition cursor-pointer">
                                <i class="fas fa-camera text-4xl text-secondary-400 mb-3"></i>
                                <h5 class="font-medium text-secondary-700">Photo d'identité</h5>
                                <p class="text-sm text-secondary-500">JPG, PNG (max 2MB)</p>
                                <span class="inline-flex items-center px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-medium mt-2">
                                    <i class="fas fa-check mr-1"></i>Document vérifié
                                </span>
                            </div>
                            <div class="border-2 border-dashed border-secondary-300 rounded-xl p-6 text-center hover:border-primary-500 transition cursor-pointer">
                                <i class="fas fa-file-alt text-4xl text-secondary-400 mb-3"></i>
                                <h5 class="font-medium text-secondary-700">Justificatif de domicile</h5>
                                <p class="text-sm text-secondary-500">PDF, JPG (max 5MB)</p>
                                <button class="mt-2 px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 transition">
                                    <i class="fas fa-upload mr-1"></i>Télécharger
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Stats Tab -->
                    <div id="statsTab" class="p-6 hidden">
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                            <div class="bg-secondary-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-primary-600">24</div>
                                <div class="text-sm text-secondary-500">Compétitions</div>
                            </div>
                            <div class="bg-secondary-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-blue-600">12</div>
                                <div class="text-sm text-secondary-500">Médailles</div>
                            </div>
                            <div class="bg-secondary-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-blue-600">5</div>
                                <div class="text-sm text-secondary-500">Records perso</div>
                            </div>
                            <div class="bg-secondary-50 rounded-xl p-4 text-center">
                                <div class="text-3xl font-bold text-blue-600">87.5</div>
                                <div class="text-sm text-secondary-500">Score Talent</div>
                            </div>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead>
                                    <tr class="border-b border-secondary-200">
                                        <th class="text-left py-3 px-4 font-semibold text-secondary-700">Saison</th>
                                        <th class="text-left py-3 px-4 font-semibold text-secondary-700">Discipline</th>
                                        <th class="text-left py-3 px-4 font-semibold text-secondary-700">Meilleur temps</th>
                                        <th class="text-left py-3 px-4 font-semibold text-secondary-700">Classement</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="border-b border-secondary-100">
                                        <td class="py-3 px-4 text-secondary-700">2024-2025</td>
                                        <td class="py-3 px-4 text-secondary-700">100m</td>
                                        <td class="py-3 px-4 font-semibold text-primary-600">10.45s</td>
                                        <td class="py-3 px-4"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm">#1 National</span></td>
                                    </tr>
                                    <tr class="border-b border-secondary-100">
                                        <td class="py-3 px-4 text-secondary-700">2024-2025</td>
                                        <td class="py-3 px-4 text-secondary-700">200m</td>
                                        <td class="py-3 px-4 font-semibold text-primary-600">21.32s</td>
                                        <td class="py-3 px-4"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm">#2 National</span></td>
                                    </tr>
                                    <tr class="border-b border-secondary-100">
                                        <td class="py-3 px-4 text-secondary-700">2023-2024</td>
                                        <td class="py-3 px-4 text-secondary-700">100m</td>
                                        <td class="py-3 px-4 font-semibold text-primary-600">10.62s</td>
                                        <td class="py-3 px-4"><span class="px-2 py-1 bg-slate-100 text-slate-700 rounded text-sm">#3 National</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        function switchTab(tabName) {
            // Hide all tabs
            document.getElementById('personalTab').classList.add('hidden');
            document.getElementById('sportsTab').classList.add('hidden');
            document.getElementById('documentsTab').classList.add('hidden');
            document.getElementById('statsTab').classList.add('hidden');
            
            // Show selected tab
            document.getElementById(tabName + 'Tab').classList.remove('hidden');
            
            // Update tab styles
            const buttons = document.querySelectorAll('nav button');
            buttons.forEach(btn => {
                btn.classList.remove('tab-active');
                btn.classList.add('text-secondary-500');
            });
            event.target.classList.add('tab-active');
            event.target.classList.remove('text-secondary-500');
        }
    </script>
</body>
</html>
