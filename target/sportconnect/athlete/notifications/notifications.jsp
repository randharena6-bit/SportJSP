<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - Athlète | SPORT CONNECT</title>
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
        .notification-unread { border-left: 3px solid #3b82f6; background: #eff6ff; }
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
                    <a href="../medias/medias.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-video w-6"></i>Médias & E-sport</a>
                    <a href="notifications.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-bell w-6"></i>Notifications<span class="ml-auto bg-red-500 text-white text-xs px-2 py-0.5 rounded-full">3</span></a>
                </nav>
                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-red-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-secondary-200 sticky top-0 z-30">
                <div class="px-8 py-4 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-secondary-800">Notifications</h1>
                        <p class="text-secondary-500 text-sm">Vos alertes et messages importants</p>
                    </div>
                    <div class="flex gap-3">
                        <button class="px-4 py-2 text-secondary-600 hover:text-primary-600 font-medium transition"><i class="fas fa-check-double mr-2"></i>Tout marquer comme lu</button>
                        <button class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition"><i class="fas fa-cog mr-2"></i>Paramètres</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Filter Tabs -->
                <div class="flex gap-2 mb-6">
                    <button class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium">Toutes</button>
                    <button class="px-4 py-2 bg-white text-secondary-600 rounded-lg font-medium hover:bg-secondary-100 transition">Non lues (3)</button>
                    <button class="px-4 py-2 bg-white text-secondary-600 rounded-lg font-medium hover:bg-secondary-100 transition">Compétitions</button>
                    <button class="px-4 py-2 bg-white text-secondary-600 rounded-lg font-medium hover:bg-secondary-100 transition">Licences</button>
                    <button class="px-4 py-2 bg-white text-secondary-600 rounded-lg font-medium hover:bg-secondary-100 transition">Santé</button>
                </div>

                <!-- Notifications List -->
                <div class="space-y-4">
                    <!-- Notification 1 - Unread -->
                    <div class="bg-white rounded-xl shadow-sm p-6 notification-unread">
                        <div class="flex items-start">
                            <div class="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-exclamation-circle text-red-600 text-xl"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-semibold text-secondary-800">Renouvellement de licence requis</h4>
                                    <span class="text-sm text-secondary-400">Il y a 2 heures</span>
                                </div>
                                <p class="text-secondary-600 mt-1">Votre licence expire dans 45 jours. Pensez à la renouveler pour continuer à participer aux compétitions.</p>
                                <div class="flex items-center gap-3 mt-3">
                                    <a href="../licences/licences.jsp" class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 transition">Renouveler maintenant</a>
                                    <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-times"></i></button>
                                </div>
                            </div>
                            <span class="w-2 h-2 bg-primary-500 rounded-full ml-4 flex-shrink-0"></span>
                        </div>
                    </div>

                    <!-- Notification 2 - Unread -->
                    <div class="bg-white rounded-xl shadow-sm p-6 notification-unread">
                        <div class="flex items-start">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-trophy text-blue-600 text-xl"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-semibold text-secondary-800">Nouvelle compétition disponible</h4>
                                    <span class="text-sm text-secondary-400">Aujourd'hui, 09:30</span>
                                </div>
                                <p class="text-secondary-600 mt-1">Le Championnat National d'Athlétisme est ouvert aux inscriptions. Ne manquez pas cette occasion !</p>
                                <div class="flex items-center gap-3 mt-3">
                                    <a href="../competitions/competitions.jsp" class="px-4 py-2 bg-primary-600 text-white rounded-lg text-sm font-medium hover:bg-primary-700 transition">S'inscrire</a>
                                    <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-times"></i></button>
                                </div>
                            </div>
                            <span class="w-2 h-2 bg-primary-500 rounded-full ml-4 flex-shrink-0"></span>
                        </div>
                    </div>

                    <!-- Notification 3 - Unread -->
                    <div class="bg-white rounded-xl shadow-sm p-6 notification-unread">
                        <div class="flex items-start">
                            <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-check-circle text-green-600 text-xl"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-semibold text-secondary-800">Paiement confirmé</h4>
                                    <span class="text-sm text-secondary-400">Hier, 14:20</span>
                                </div>
                                <p class="text-secondary-600 mt-1">Votre paiement de 27 000 Ar pour la licence 2024-2025 a été confirmé. Votre licence est maintenant active.</p>
                                <div class="flex items-center gap-3 mt-3">
                                    <a href="../licences/licences.jsp" class="px-4 py-2 bg-secondary-100 text-secondary-700 rounded-lg text-sm font-medium hover:bg-secondary-200 transition">Voir ma licence</a>
                                    <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-times"></i></button>
                                </div>
                            </div>
                            <span class="w-2 h-2 bg-primary-500 rounded-full ml-4 flex-shrink-0"></span>
                        </div>
                    </div>

                    <!-- Notification 4 - Read -->
                    <div class="bg-white rounded-xl shadow-sm p-6">
                        <div class="flex items-start">
                            <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-chart-line text-purple-600 text-xl"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-semibold text-secondary-800">Alerte de performance</h4>
                                    <span class="text-sm text-secondary-400">Il y a 3 jours</span>
                                </div>
                                <p class="text-secondary-600 mt-1">Félicitations ! Vous avez dépassé votre record personnel sur 100m. Nouveau temps: 10.45s</p>
                            </div>
                        </div>
                    </div>

                    <!-- Notification 5 - Read -->
                    <div class="bg-white rounded-xl shadow-sm p-6">
                        <div class="flex items-start">
                            <div class="w-12 h-12 bg-amber-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-envelope text-amber-600 text-xl"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-semibold text-secondary-800">Message de votre entraîneur</h4>
                                    <span class="text-sm text-secondary-400">Il y a 5 jours</span>
                                </div>
                                <p class="text-secondary-600 mt-1">Rakoto Jean: "Excellent travail cette semaine ! On continue sur cette lancée pour les championnats."</p>
                                <div class="flex items-center gap-3 mt-3">
                                    <button class="text-primary-600 font-medium text-sm hover:underline">Répondre</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Notification 6 - Read -->
                    <div class="bg-white rounded-xl shadow-sm p-6">
                        <div class="flex items-start">
                            <div class="w-12 h-12 bg-teal-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-heartbeat text-teal-600 text-xl"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-semibold text-secondary-800">Rappel bilan de santé</h4>
                                    <span class="text-sm text-secondary-400">Il y a 1 semaine</span>
                                </div>
                                <p class="text-secondary-600 mt-1">Votre bilan de santé annuel est dû. Prenez rendez-vous avec le médecin du sport.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Notification 7 - Read -->
                    <div class="bg-white rounded-xl shadow-sm p-6">
                        <div class="flex items-start">
                            <div class="w-12 h-12 bg-rose-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                <i class="fas fa-video text-rose-600 text-xl"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-semibold text-secondary-800">Replay disponible</h4>
                                    <span class="text-sm text-secondary-400">Il y a 2 semaines</span>
                                </div>
                                <p class="text-secondary-600 mt-1">Le replay de votre dernière compétition est maintenant disponible dans la section Médias.</p>
                                <div class="flex items-center gap-3 mt-3">
                                    <a href="../medias/medias.jsp" class="px-4 py-2 bg-secondary-100 text-secondary-700 rounded-lg text-sm font-medium hover:bg-secondary-200 transition">Voir le replay</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Load More -->
                <div class="text-center mt-8">
                    <button class="px-6 py-3 bg-white text-secondary-600 rounded-xl font-medium hover:bg-secondary-100 transition shadow-sm">
                        <i class="fas fa-chevron-down mr-2"></i>Charger plus de notifications
                    </button>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
