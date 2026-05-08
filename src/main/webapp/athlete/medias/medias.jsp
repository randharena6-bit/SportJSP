<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Médias & E-sport - Athlète | SPORT CONNECT</title>
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
        .live-badge { animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.7; } }
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
                    <a href="../competitions/competitions.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-trophy w-6"></i>Compétitions</a>
                    <a href="../sante/sante.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-heartbeat w-6"></i>Santé & Performance</a>
                    <a href="medias.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-video w-6"></i>Médias & E-sport</a>
                    <a href="../notifications/notifications.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-bell w-6"></i>Notifications<span class="ml-auto bg-red-500 text-white text-xs px-2 py-0.5 rounded-full">3</span></a>
                </nav>
                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-red-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-secondary-200 sticky top-0 z-30">
                <div class="px-8 py-4">
                    <h1 class="text-2xl font-bold text-secondary-800">Médias & E-sport</h1>
                    <p class="text-secondary-500 text-sm">Streaming, replays et tournois e-sport</p>
                </div>
            </header>

            <main class="p-8">
                <!-- Live Streaming Banner -->
                <div class="bg-gradient-to-r from-red-600 to-rose-600 rounded-2xl p-6 mb-8 text-white">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <div class="w-14 h-14 bg-white/20 rounded-xl flex items-center justify-center live-badge">
                                <i class="fas fa-broadcast-tower text-white text-2xl"></i>
                            </div>
                            <div>
                                <div class="flex items-center space-x-2 mb-1">
                                    <span class="w-2 h-2 bg-red-400 rounded-full animate-pulse"></span>
                                    <span class="text-sm font-medium text-red-100">EN DIRECT</span>
                                </div>
                                <h3 class="text-xl font-bold">Championnat National d'Athlétisme 2025</h3>
                                <p class="text-red-100 text-sm">Stade Mahamasina - 1500 spectateurs en ligne</p>
                            </div>
                        </div>
                        <button class="px-6 py-3 bg-white text-red-600 rounded-xl font-semibold hover:bg-red-50 transition"><i class="fas fa-play mr-2"></i>Regarder le live</button>
                    </div>
                </div>

                <!-- Tabs -->
                <div class="flex gap-6 mb-6 border-b border-secondary-200">
                    <button class="px-4 py-3 text-primary-600 font-semibold border-b-2 border-primary-600">Streaming</button>
                    <button class="px-4 py-3 text-secondary-500 font-medium hover:text-secondary-700">Replays</button>
                    <button class="px-4 py-3 text-secondary-500 font-medium hover:text-secondary-700">E-sport</button>
                    <button class="px-4 py-3 text-secondary-500 font-medium hover:text-secondary-700">Ma Galerie</button>
                </div>

                <!-- Stream Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                    <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                        <div class="relative h-48 bg-gradient-to-br from-primary-600 to-primary-800">
                            <div class="absolute top-4 left-4 px-3 py-1 bg-red-500 text-white rounded-lg text-sm font-medium flex items-center"><span class="w-2 h-2 bg-white rounded-full mr-2 animate-pulse"></span>LIVE</div>
                            <div class="absolute inset-0 flex items-center justify-center"><i class="fas fa-play-circle text-white/50 text-6xl"></i></div>
                            <div class="absolute bottom-4 right-4 px-3 py-1 bg-black/50 text-white rounded-lg text-sm"><i class="fas fa-eye mr-1"></i>1,234</div>
                        </div>
                        <div class="p-4">
                            <span class="text-xs text-primary-600 font-semibold">ATHLÉTISME</span>
                            <h4 class="font-bold text-secondary-800 mt-1">Championnat National - Jour 2</h4>
                            <p class="text-sm text-secondary-500 mt-1"><i class="fas fa-map-marker-alt mr-1"></i>Stade Mahamasina</p>
                        </div>
                    </div>
                    <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                        <div class="relative h-48 bg-gradient-to-br from-emerald-600 to-teal-700">
                            <div class="absolute top-4 left-4 px-3 py-1 bg-secondary-700 text-white rounded-lg text-sm font-medium">REPLAY</div>
                            <div class="absolute inset-0 flex items-center justify-center"><i class="fas fa-play-circle text-white/50 text-6xl"></i></div>
                            <div class="absolute bottom-4 right-4 px-3 py-1 bg-black/50 text-white rounded-lg text-sm">2:45:12</div>
                        </div>
                        <div class="p-4">
                            <span class="text-xs text-blue-600 font-semibold">FOOTBALL</span>
                            <h4 class="font-bold text-secondary-800 mt-1">Coupe de Madagascar - Finale</h4>
                            <p class="text-sm text-secondary-500 mt-1"><i class="fas fa-calendar mr-1"></i>Diffusé hier</p>
                        </div>
                    </div>
                    <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                        <div class="relative h-48 bg-gradient-to-br from-purple-600 to-indigo-700">
                            <div class="absolute top-4 left-4 px-3 py-1 bg-secondary-700 text-white rounded-lg text-sm font-medium">REPLAY</div>
                            <div class="absolute inset-0 flex items-center justify-center"><i class="fas fa-play-circle text-white/50 text-6xl"></i></div>
                            <div class="absolute bottom-4 right-4 px-3 py-1 bg-black/50 text-white rounded-lg text-sm">1:30:45</div>
                        </div>
                        <div class="p-4">
                            <span class="text-xs text-blue-600 font-semibold">BASKETBALL</span>
                            <h4 class="font-bold text-secondary-800 mt-1">Playoffs - Demi-finale</h4>
                            <p class="text-sm text-secondary-500 mt-1"><i class="fas fa-calendar mr-1"></i>Il y a 3 jours</p>
                        </div>
                    </div>
                </div>

                <!-- E-sport Section -->
                <div class="bg-white rounded-2xl shadow-sm mb-8">
                    <div class="p-6 border-b border-secondary-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-gamepad text-purple-500 mr-2"></i>Tournois E-sport</h2>
                            <a href="#" class="text-primary-600 font-medium text-sm hover:underline">Voir tous les tournois</a>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div class="border border-secondary-200 rounded-xl p-4 hover:border-purple-500 transition">
                                <div class="flex items-center justify-between mb-3">
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-medium">Inscriptions ouvertes</span>
                                    <i class="fas fa-futbol text-purple-500 text-xl"></i>
                                </div>
                                <h4 class="font-bold text-secondary-800">FIFA 24 Championship</h4>
                                <p class="text-sm text-secondary-500 mt-1">Tournoi national - 64 joueurs</p>
                                <div class="flex items-center justify-between mt-4">
                                    <span class="text-sm text-secondary-600"><i class="fas fa-calendar mr-1"></i>15 Juin</span>
                                    <span class="text-sm font-semibold text-blue-600">50 000 Ar</span>
                                </div>
                                <button class="w-full mt-4 py-2 bg-purple-600 text-white rounded-lg font-medium hover:bg-purple-700 transition">S'inscrire</button>
                            </div>
                            <div class="border border-secondary-200 rounded-xl p-4 hover:border-purple-500 transition">
                                <div class="flex items-center justify-between mb-3">
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-medium">En cours</span>
                                    <i class="fas fa-car text-purple-500 text-xl"></i>
                                </div>
                                <h4 class="font-bold text-secondary-800">eRacing Madagascar Cup</h4>
                                <p class="text-sm text-secondary-500 mt-1">Formule 1 - 32 pilotes</p>
                                <div class="flex items-center justify-between mt-4">
                                    <span class="text-sm text-secondary-600"><i class="fas fa-calendar mr-1"></i>Phase finale</span>
                                    <span class="text-sm font-semibold text-blue-600">#8/32</span>
                                </div>
                                <button class="w-full mt-4 py-2 border border-purple-600 text-blue-600 rounded-lg font-medium hover:bg-purple-50 transition">Voir classement</button>
                            </div>
                            <div class="border border-secondary-200 rounded-xl p-4 hover:border-purple-500 transition">
                                <div class="flex items-center justify-between mb-3">
                                    <span class="px-2 py-1 bg-secondary-100 text-secondary-700 rounded text-xs font-medium">Bientôt</span>
                                    <i class="fas fa-basketball-ball text-purple-500 text-xl"></i>
                                </div>
                                <h4 class="font-bold text-secondary-800">NBA 2K24 League</h4>
                                <p class="text-sm text-secondary-500 mt-1">Saison régulière - 128 joueurs</p>
                                <div class="flex items-center justify-between mt-4">
                                    <span class="text-sm text-secondary-600"><i class="fas fa-calendar mr-1"></i>1 Juillet</span>
                                    <span class="text-sm font-semibold text-blue-600">25 000 Ar</span>
                                </div>
                                <button class="w-full mt-4 py-2 bg-secondary-200 text-secondary-600 rounded-lg font-medium cursor-not-allowed" disabled>Bientôt</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Personal Gallery -->
                <div class="bg-white rounded-2xl shadow-sm">
                    <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                        <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-images text-primary-500 mr-2"></i>Ma Galerie Personnelle</h2>
                        <button class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition"><i class="fas fa-upload mr-2"></i>Ajouter</button>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                            <div class="aspect-square bg-secondary-100 rounded-xl flex items-center justify-center cursor-pointer hover:bg-secondary-200 transition">
                                <i class="fas fa-image text-secondary-400 text-3xl"></i>
                            </div>
                            <div class="aspect-square bg-secondary-100 rounded-xl flex items-center justify-center cursor-pointer hover:bg-secondary-200 transition">
                                <i class="fas fa-image text-secondary-400 text-3xl"></i>
                            </div>
                            <div class="aspect-square bg-secondary-100 rounded-xl flex items-center justify-center cursor-pointer hover:bg-secondary-200 transition">
                                <i class="fas fa-image text-secondary-400 text-3xl"></i>
                            </div>
                            <div class="aspect-square bg-secondary-100 rounded-xl flex items-center justify-center cursor-pointer hover:bg-secondary-200 transition border-2 border-dashed border-secondary-300">
                                <i class="fas fa-plus text-secondary-400 text-3xl"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
