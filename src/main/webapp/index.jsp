<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPORT CONNECT - Numérique de Madagascar 2035</title>
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
        .gradient-bg { background: linear-gradient(135deg, #1e40af 0%, #3b82f6 50%, #60a5fa 100%); }
        .glass-effect { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); }
        .hero-pattern { background-image: radial-gradient(circle at 2px 2px, rgba(255,255,255,0.15) 1px, transparent 0); background-size: 40px 40px; }
        .card-hover { transition: all 0.3s ease; }
        .card-hover:hover { transform: translateY(-8px); box-shadow: 0 20px 40px rgba(30, 64, 175, 0.15); }
        .animate-fade-in { animation: fadeIn 0.8s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .role-card { background: white; border: 2px solid #e2e8f0; transition: all 0.3s ease; }
        .role-card:hover { border-color: #3b82f6; box-shadow: 0 10px 30px rgba(59, 130, 246, 0.2); }
        .stat-counter { font-variant-numeric: tabular-nums; }
        
        /* Mobile Menu Animation */
        #mobile-menu {
            transition: all 0.3s ease;
            transform-origin: top;
        }
        #mobile-menu.hidden {
            display: none;
            opacity: 0;
            transform: scaleY(0);
        }
        #mobile-menu:not(.hidden) {
            display: block;
            opacity: 1;
            transform: scaleY(1);
            animation: slideDown 0.3s ease;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Animated Background */
        .animated-bg {
            background: linear-gradient(-45deg, #1e40af, #3b82f6, #60a5fa, #2563eb, #1e3a8a);
            background-size: 400% 400%;
            animation: gradientMove 15s ease infinite;
        }
    </style>
</head>
<body class="bg-slate-50 font-sans antialiased">
    <!-- Navigation -->
    <nav class="fixed w-full z-50 glass-effect border-b border-secondary-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-20">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                        <i class="fas fa-running text-white text-xl"></i>
                    </div>
                    <div>
                        <span class="text-2xl font-bold text-primary-800">SPORT</span>
                        <span class="text-2xl font-bold text-primary-500">CONNECT</span>
                    </div>
                </div>
                <div class="hidden md:flex items-center space-x-8">
                    <a href="#features" class="text-secondary-600 hover:text-primary-600 font-medium transition">Fonctionnalités</a>
                    <a href="#roles" class="text-secondary-600 hover:text-primary-600 font-medium transition">Rôles</a>
                    <a href="#about" class="text-secondary-600 hover:text-primary-600 font-medium transition">À propos</a>
                    <a href="login.jsp" class="px-6 py-2.5 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition shadow-lg shadow-primary-500/30">
                        <i class="fas fa-sign-in-alt mr-2"></i>Connexion
                    </a>
                </div>
                <button id="mobile-menu-btn" class="md:hidden text-secondary-600 text-2xl p-2 hover:bg-secondary-100 rounded-lg transition">
                    <i class="fas fa-bars" id="menu-icon"></i>
                </button>
            </div>
            
            <!-- Mobile Menu -->
            <div id="mobile-menu" class="md:hidden hidden absolute top-full left-0 right-0 bg-white border-t border-secondary-200 shadow-lg">
                <div class="px-4 py-6 space-y-4">
                    <a href="#features" class="block text-secondary-600 hover:text-primary-600 font-medium transition py-2">Fonctionnalités</a>
                    <a href="#roles" class="block text-secondary-600 hover:text-primary-600 font-medium transition py-2">Rôles</a>
                    <a href="#about" class="block text-secondary-600 hover:text-primary-600 font-medium transition py-2">À propos</a>
                    <a href="login.jsp" class="block w-full text-center px-6 py-3 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition">
                        <i class="fas fa-sign-in-alt mr-2"></i>Connexion
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative min-h-screen animated-bg hero-pattern flex items-center pt-20 overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-b from-transparent via-primary-900/20 to-primary-900/40"></div>
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
            <div class="grid lg:grid-cols-2 gap-12 items-center">
                <div class="text-white animate-fade-in">
                    <div class="inline-flex items-center px-4 py-2 bg-white/10 backdrop-blur rounded-full mb-6 border border-white/20">
                        <span class="w-2 h-2 bg-green-400 rounded-full mr-2 animate-pulse"></span>
                        <span class="text-sm font-medium">Numérique de Madagascar 2035</span>
                    </div>
                    <h1 class="text-5xl lg:text-6xl font-bold leading-tight mb-6">
                        La Révolution Digitale du
                        <span class="text-primary-200">Sport Malgache</span>
                    </h1>
                    <p class="text-xl text-primary-100 mb-8 leading-relaxed max-w-xl">
                        Plateforme nationale intégrée pour la gestion des athlètes, fédérations, entraîneurs et compétitions. Un écosystème connecté pour l'excellence sportive.
                    </p>
                    <div class="flex flex-wrap gap-4">
                        <a href="login.jsp" class="px-8 py-4 bg-white text-primary-700 rounded-xl font-semibold hover:bg-primary-50 transition shadow-xl flex items-center">
                            <i class="fas fa-rocket mr-2"></i>Commencer maintenant
                        </a>
                        <a href="#features" class="px-8 py-4 bg-white/10 backdrop-blur text-white rounded-xl font-semibold border border-white/30 hover:bg-white/20 transition flex items-center">
                            <i class="fas fa-play-circle mr-2"></i>Découvrir
                        </a>
                    </div>
                    <div class="mt-12 flex items-center space-x-8">
                        <div>
                            <div class="text-3xl font-bold stat-counter">45+</div>
                            <div class="text-primary-200 text-sm">Fédérations</div>
                        </div>
                        <div class="h-12 w-px bg-white/20"></div>
                        <div>
                            <div class="text-3xl font-bold stat-counter">50K+</div>
                            <div class="text-primary-200 text-sm">Athlètes</div>
                        </div>
                        <div class="h-12 w-px bg-white/20"></div>
                        <div>
                            <div class="text-3xl font-bold stat-counter">100%</div>
                            <div class="text-primary-200 text-sm">Digital</div>
                        </div>
                    </div>
                </div>
                <div class="hidden lg:block">
                    <div class="relative">
                        <div class="absolute -inset-4 bg-white/10 rounded-3xl blur-2xl"></div>
                        <div class="relative bg-white/10 backdrop-blur-lg rounded-2xl shadow-2xl p-8 animate-fade-in border border-white/20" style="animation-delay: 0.2s;">
                            <div class="text-center text-white">
                                <div class="w-24 h-24 mx-auto mb-6 rounded-full bg-white/20 flex items-center justify-center">
                                    <i class="fas fa-trophy text-white text-4xl"></i>
                                </div>
                                <h3 class="text-2xl font-bold mb-2">Excellence Sportive</h3>
                                <p class="text-primary-100 mb-6">Rejoignez la première plateforme digitale dédiée au sport malgache</p>
                                <div class="grid grid-cols-2 gap-4">
                                    <div class="bg-white/10 rounded-xl p-4 text-center border border-white/10">
                                        <div class="text-3xl font-bold text-white">6</div>
                                        <div class="text-sm text-primary-200">Fédérations</div>
                                    </div>
                                    <div class="bg-white/10 rounded-xl p-4 text-center border border-white/10">
                                        <div class="text-3xl font-bold text-white">9</div>
                                        <div class="text-sm text-primary-200">Clubs</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Floating Particles -->
        <div class="particles">
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
        </div>
        
        <!-- Animated Wave -->
        <div class="wave"></div>
        
        <div class="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-slate-50 to-transparent"></div>
    </section>

    <!-- Roles Section -->
    <section id="roles" class="py-24 bg-slate-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <span class="text-primary-600 font-semibold text-sm uppercase tracking-wider">Espaces Dédiés</span>
                <h2 class="text-4xl font-bold text-secondary-800 mt-2 mb-4">Choisissez votre espace</h2>
                <p class="text-xl text-secondary-500 max-w-2xl mx-auto">Chaque rôle dispose d'un environnement sur mesure, adapté à vos besoins spécifiques</p>
            </div>
            <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
                <!-- Athlete Card -->
                <a href="login.jsp?role=athlete" class="role-card rounded-2xl p-8 text-center card-hover group">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center group-hover:scale-110 transition">
                        <i class="fas fa-running text-white text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-2">Athlète</h3>
                    <p class="text-secondary-500 text-sm mb-4">Gérez votre carrière sportive, licences et compétitions</p>
                    <div class="flex items-center justify-center text-primary-600 font-medium text-sm">
                        <span>7 pages dédiées</span>
                        <i class="fas fa-arrow-right ml-2 group-hover:translate-x-1 transition"></i>
                    </div>
                    <div class="mt-4 pt-4 border-t border-secondary-100">
                        <span class="text-xs text-secondary-400"><i class="fas fa-mobile-alt mr-1"></i>Web & Mobile</span>
                    </div>
                </a>
                <!-- Coach Card -->
                <a href="login.jsp?role=coach" class="role-card rounded-2xl p-8 text-center card-hover group">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-emerald-400 to-emerald-600 flex items-center justify-center group-hover:scale-110 transition">
                        <i class="fas fa-dumbbell text-white text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-2">Entraîneur</h3>
                    <p class="text-secondary-500 text-sm mb-4">Suivez et optimisez les performances de vos athlètes</p>
                    <div class="flex items-center justify-center text-primary-600 font-medium text-sm">
                        <span>7 pages dédiées</span>
                        <i class="fas fa-arrow-right ml-2 group-hover:translate-x-1 transition"></i>
                    </div>
                    <div class="mt-4 pt-4 border-t border-secondary-100">
                        <span class="text-xs text-secondary-400"><i class="fas fa-laptop mr-1"></i>Web & Mobile</span>
                    </div>
                </a>
                <!-- Federation Card -->
                <a href="login.jsp?role=federation" class="role-card rounded-2xl p-8 text-center card-hover group">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-amber-400 to-amber-600 flex items-center justify-center group-hover:scale-110 transition">
                        <i class="fas fa-landmark text-white text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-2">Fédération</h3>
                    <p class="text-secondary-500 text-sm mb-4">Administrez clubs, licences et compétitions</p>
                    <div class="flex items-center justify-center text-primary-600 font-medium text-sm">
                        <span>7 pages dédiées</span>
                        <i class="fas fa-arrow-right ml-2 group-hover:translate-x-1 transition"></i>
                    </div>
                    <div class="mt-4 pt-4 border-t border-secondary-100">
                        <span class="text-xs text-secondary-400"><i class="fas fa-desktop mr-1"></i>Dashboard Web</span>
                    </div>
                </a>
                <!-- Admin Card -->
                <a href="login.jsp?role=admin" class="role-card rounded-2xl p-8 text-center card-hover group">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-2xl bg-gradient-to-br from-rose-400 to-rose-600 flex items-center justify-center group-hover:scale-110 transition">
                        <i class="fas fa-shield-alt text-white text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-2">Administrateur</h3>
                    <p class="text-secondary-500 text-sm mb-4">Supervisez la plateforme nationale</p>
                    <div class="flex items-center justify-center text-primary-600 font-medium text-sm">
                        <span>8 pages dédiées</span>
                        <i class="fas fa-arrow-right ml-2 group-hover:translate-x-1 transition"></i>
                    </div>
                    <div class="mt-4 pt-4 border-t border-secondary-100">
                        <span class="text-xs text-secondary-400"><i class="fas fa-lock mr-1"></i>2FA Requis</span>
                    </div>
                </a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-24 bg-slate-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <span class="text-primary-600 font-semibold text-sm uppercase tracking-wider">Fonctionnalités</span>
                <h2 class="text-4xl font-bold text-secondary-800 mt-2 mb-4">Tout ce dont vous avez besoin</h2>
            </div>
            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <div class="bg-white rounded-2xl p-8 shadow-sm hover:shadow-xl transition">
                    <div class="w-14 h-14 rounded-xl bg-blue-100 flex items-center justify-center mb-6">
                        <i class="fas fa-id-card text-blue-600 text-xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-3">Licences Digitales</h3>
                    <p class="text-secondary-500">Gestion complète des licences avec QR code et paiement Mobile Money</p>
                </div>
                <div class="bg-white rounded-2xl p-8 shadow-sm hover:shadow-xl transition">
                    <div class="w-14 h-14 rounded-xl bg-green-100 flex items-center justify-center mb-6">
                        <i class="fas fa-trophy text-green-600 text-xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-3">Compétitions</h3>
                    <p class="text-secondary-500">Calendrier national, inscriptions et résultats en temps réel</p>
                </div>
                <div class="bg-white rounded-2xl p-8 shadow-sm hover:shadow-xl transition">
                    <div class="w-14 h-14 rounded-xl bg-purple-100 flex items-center justify-center mb-6">
                        <i class="fas fa-chart-line text-purple-600 text-xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-3">Analytics IA</h3>
                    <p class="text-secondary-500">Talent Scoring System et détection des performances exceptionnelles</p>
                </div>
                <div class="bg-white rounded-2xl p-8 shadow-sm hover:shadow-xl transition">
                    <div class="w-14 h-14 rounded-xl bg-red-100 flex items-center justify-center mb-6">
                        <i class="fas fa-heartbeat text-red-600 text-xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-3">Santé & Performance</h3>
                    <p class="text-secondary-500">Suivi médical biométrique avec dossier numérique sécurisé</p>
                </div>
                <div class="bg-white rounded-2xl p-8 shadow-sm hover:shadow-xl transition">
                    <div class="w-14 h-14 rounded-xl bg-amber-100 flex items-center justify-center mb-6">
                        <i class="fas fa-video text-amber-600 text-xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-3">Streaming & E-sport</h3>
                    <p class="text-secondary-500">Diffusion live des compétitions et tournois e-sport</p>
                </div>
                <div class="bg-white rounded-2xl p-8 shadow-sm hover:shadow-xl transition">
                    <div class="w-14 h-14 rounded-xl bg-teal-100 flex items-center justify-center mb-6">
                        <i class="fas fa-search text-teal-600 text-xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-secondary-800 mb-3">Scouting</h3>
                    <p class="text-secondary-500">Détection et suivi des jeunes talents avec évaluations standardisées</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-24 animated-bg hero-pattern relative overflow-hidden">
        <!-- Floating Particles for CTA -->
        <div class="particles">
            <div class="particle" style="left: 15%; animation-delay: 1s;"></div>
            <div class="particle" style="left: 35%; animation-delay: 5s;"></div>
            <div class="particle" style="left: 55%; animation-delay: 9s;"></div>
            <div class="particle" style="left: 75%; animation-delay: 13s;"></div>
            <div class="particle" style="left: 85%; animation-delay: 17s;"></div>
        </div>
        
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10">
            <h2 class="text-4xl font-bold text-white mb-6 animate-fade-in">Prêt à rejoindre la révolution ?</h2>
            <p class="text-xl text-primary-100 mb-10">Rejoignez les 45 fédérations et 50,000+ athlètes déjà connectés</p>
            <div class="flex flex-wrap justify-center gap-4">
                <a href="login.jsp" class="px-10 py-4 bg-white text-primary-700 rounded-xl font-semibold hover:bg-primary-50 transition shadow-xl hover:scale-105 transform">
                    <i class="fas fa-user-plus mr-2"></i>Créer un compte
                </a>
                <a href="#" class="px-10 py-4 bg-white/10 backdrop-blur text-white rounded-xl font-semibold border border-white/30 hover:bg-white/20 transition hover:scale-105 transform">
                    <i class="fas fa-info-circle mr-2"></i>En savoir plus
                </a>
            </div>
        </div>
        
        <!-- Wave Separator -->
        <div class="absolute top-0 left-0 right-0 h-20 bg-slate-50" style="clip-path: polygon(0 0, 100% 0, 100% 0, 0 100%);"></div>
    </section>

    <!-- Footer -->
    <footer class="bg-slate-900 text-white py-16 relative overflow-hidden">
        <!-- Animated Background Gradient -->
        <div class="absolute inset-0 bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 opacity-50"></div>
        
        <!-- Subtle Animated Particles in Footer -->
        <div class="particles">
            <div class="particle" style="width: 6px; height: 6px; left: 10%; animation-duration: 25s; animation-delay: 2s;"></div>
            <div class="particle" style="width: 4px; height: 4px; left: 25%; animation-duration: 30s; animation-delay: 7s;"></div>
            <div class="particle" style="width: 8px; height: 8px; left: 40%; animation-duration: 22s; animation-delay: 12s;"></div>
            <div class="particle" style="width: 5px; height: 5px; left: 60%; animation-duration: 28s; animation-delay: 5s;"></div>
            <div class="particle" style="width: 7px; height: 7px; left: 80%; animation-duration: 26s; animation-delay: 9s;"></div>
            <div class="particle" style="width: 4px; height: 4px; left: 95%; animation-duration: 24s; animation-delay: 15s;"></div>
        </div>
        
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
            <div class="grid md:grid-cols-4 gap-12 mb-12">
                <div>
                    <div class="flex items-center space-x-3 mb-6">
                        <div class="w-10 h-10 gradient-bg rounded-lg flex items-center justify-center">
                            <i class="fas fa-running text-white"></i>
                        </div>
                        <span class="text-xl font-bold">SPORT CONNECT</span>
                    </div>
                    <p class="text-secondary-400 text-sm leading-relaxed">Plateforme nationale de digitalisation du sport malgache. Numérique de Madagascar 2035.</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">Rôles</h4>
                    <ul class="space-y-2 text-secondary-400 text-sm">
                        <li><a href="login.jsp?role=athlete" class="hover:text-white transition">Espace Athlète</a></li>
                        <li><a href="login.jsp?role=coach" class="hover:text-white transition">Espace Entraîneur</a></li>
                        <li><a href="login.jsp?role=federation" class="hover:text-white transition">Espace Fédération</a></li>
                        <li><a href="login.jsp?role=admin" class="hover:text-white transition">Administration</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">Ressources</h4>
                    <ul class="space-y-2 text-secondary-400 text-sm">
                        <li><a href="#" class="hover:text-white transition">Documentation</a></li>
                        <li><a href="#" class="hover:text-white transition">API Référence</a></li>
                        <li><a href="#" class="hover:text-white transition">Support</a></li>
                        <li><a href="#" class="hover:text-white transition">FAQ</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold mb-4">Contact</h4>
                    <ul class="space-y-2 text-secondary-400 text-sm">
                        <li><i class="fas fa-envelope mr-2"></i>contact@sportconnect.mg</li>
                        <li><i class="fas fa-phone mr-2"></i>+261 20 XX XXX XX</li>
                        <li><i class="fas fa-map-marker-alt mr-2"></i>Antananarivo, Madagascar</li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-secondary-800 pt-8 flex flex-col md:flex-row justify-between items-center">
                <p class="text-secondary-400 text-sm">&copy; 2025 SPORT CONNECT - Numérique de Madagascar 2035. Tous droits réservés.</p>
                <div class="flex space-x-6 mt-4 md:mt-0">
                    <a href="#" class="text-secondary-400 hover:text-white transition"><i class="fab fa-facebook"></i></a>
                    <a href="#" class="text-secondary-400 hover:text-white transition"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-secondary-400 hover:text-white transition"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-secondary-400 hover:text-white transition"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Mobile Menu JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const mobileMenuBtn = document.getElementById('mobile-menu-btn');
            const mobileMenu = document.getElementById('mobile-menu');
            const menuIcon = document.getElementById('menu-icon');
            
            if (mobileMenuBtn && mobileMenu) {
                mobileMenuBtn.addEventListener('click', function() {
                    mobileMenu.classList.toggle('hidden');
                    
                    // Toggle icon between bars and times
                    if (menuIcon) {
                        if (mobileMenu.classList.contains('hidden')) {
                            menuIcon.classList.remove('fa-times');
                            menuIcon.classList.add('fa-bars');
                        } else {
                            menuIcon.classList.remove('fa-bars');
                            menuIcon.classList.add('fa-times');
                        }
                    }
                });
                
                // Close menu when clicking on a link
                const mobileLinks = mobileMenu.querySelectorAll('a');
                mobileLinks.forEach(function(link) {
                    link.addEventListener('click', function() {
                        mobileMenu.classList.add('hidden');
                        if (menuIcon) {
                            menuIcon.classList.remove('fa-times');
                            menuIcon.classList.add('fa-bars');
                        }
                    });
                });
                
                // Close menu when clicking outside
                document.addEventListener('click', function(event) {
                    if (!mobileMenu.contains(event.target) && !mobileMenuBtn.contains(event.target)) {
                        mobileMenu.classList.add('hidden');
                        if (menuIcon) {
                            menuIcon.classList.remove('fa-times');
                            menuIcon.classList.add('fa-bars');
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
