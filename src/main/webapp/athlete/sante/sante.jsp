<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Santé & Performance - Athlète | SPORT CONNECT</title>
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
                    <a href="sante.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-heartbeat w-6"></i>Santé & Performance</a>
                    <a href="../medias/medias.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-video w-6"></i>Médias & E-sport</a>
                    <a href="../notifications/notifications.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium"><i class="fas fa-bell w-6"></i>Notifications<span class="ml-auto bg-red-500 text-white text-xs px-2 py-0.5 rounded-full">3</span></a>
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
                        <h1 class="text-2xl font-bold text-secondary-800">Santé & Performance</h1>
                        <p class="text-secondary-500 text-sm">Suivi médical et biométrique confidentiel</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium"><i class="fas fa-shield-alt mr-1"></i>Accès restreint</span>
                        <button onclick="openNewEntryModal()" class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition"><i class="fas fa-plus mr-2"></i>Nouvelle saisie</button>
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- Alert Banner -->
                <div class="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-8 flex items-start">
                    <i class="fas fa-exclamation-triangle text-blue-500 mt-1 mr-3"></i>
                    <div>
                        <h4 class="font-semibold text-blue-800">Attention: Dossier médical confidentiel</h4>
                        <p class="text-sm text-blue-700">Ces informations sont accessibles uniquement par vous, votre médecin du sport et votre entraîneur (avec votre autorisation).</p>
                    </div>
                </div>

                <!-- Health Stats -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-weight text-blue-600 text-xl"></i>
                            </div>
                            <span class="text-blue-500 text-sm font-medium">Stable</span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Poids</h3>
                        <p class="text-2xl font-bold text-secondary-800">72.5 <span class="text-lg font-normal text-secondary-500">kg</span></p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-ruler-vertical text-blue-600 text-xl"></i>
                            </div>
                        </div>
                        <h3 class="text-secondary-500 text-sm">Taille</h3>
                        <p class="text-2xl font-bold text-secondary-800">183 <span class="text-lg font-normal text-secondary-500">cm</span></p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-calculator text-blue-600 text-xl"></i>
                            </div>
                            <span class="text-blue-500 text-sm font-medium">Normal</span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">IMC</h3>
                        <p class="text-2xl font-bold text-secondary-800">21.7</p>
                    </div>
                    <div class="bg-white rounded-2xl p-6 shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <div class="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-lungs text-red-600 text-xl"></i>
                            </div>
                            <span class="text-blue-500 text-sm font-medium">+2%</span>
                        </div>
                        <h3 class="text-secondary-500 text-sm">VO2 Max</h3>
                        <p class="text-2xl font-bold text-secondary-800">58.5 <span class="text-lg font-normal text-secondary-500">ml/kg/min</span></p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Biometric Charts -->
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h3 class="text-lg font-bold text-secondary-800 mb-4"><i class="fas fa-chart-line text-primary-500 mr-2"></i>Évolution du Poids</h3>
                        <canvas id="weightChart" height="250"></canvas>
                    </div>
                    <div class="bg-white rounded-2xl shadow-sm p-6">
                        <h3 class="text-lg font-bold text-secondary-800 mb-4"><i class="fas fa-heartbeat text-red-500 mr-2"></i>Fréquence Cardiaque au Repos</h3>
                        <canvas id="heartRateChart" height="250"></canvas>
                    </div>
                </div>

                <!-- Injury Log -->
                <div class="bg-white rounded-2xl shadow-sm mt-8">
                    <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                        <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-notes-medical text-red-500 mr-2"></i>Journal de Blessures</h2>
                        <button onclick="openInjuryModal()" class="px-4 py-2 bg-red-100 text-red-700 rounded-lg font-medium hover:bg-red-200 transition"><i class="fas fa-plus mr-2"></i>Déclarer une blessure</button>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4">
                            <div class="flex items-start p-4 bg-green-50 rounded-xl border-l-4 border-green-500">
                                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mr-4">
                                    <i class="fas fa-check-circle text-blue-600 text-xl"></i>
                                </div>
                                <div class="flex-1">
                                    <div class="flex items-center justify-between">
                                        <h4 class="font-semibold text-secondary-800">Entorse cheville gauche</h4>
                                        <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-medium">Guérie</span>
                                    </div>
                                    <p class="text-sm text-secondary-500 mt-1">15 Jan - 28 Fév 2025 (6 semaines)</p>
                                    <p class="text-sm text-secondary-600 mt-2">Traitement: Physiothérapie + renforcement proprioceptif</p>
                                </div>
                            </div>
                            <div class="flex items-start p-4 bg-blue-50 rounded-xl border-l-4 border-amber-500">
                                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mr-4">
                                    <i class="fas fa-band-aid text-blue-600 text-xl"></i>
                                </div>
                                <div class="flex-1">
                                    <div class="flex items-center justify-between">
                                        <h4 class="font-semibold text-secondary-800">Tension musculaire ischio-jambiers</h4>
                                        <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-medium">En traitement</span>
                                    </div>
                                    <p class="text-sm text-secondary-500 mt-1">Depuis le 5 Mai 2025</p>
                                    <p class="text-sm text-secondary-600 mt-2">Traitement: Repos, étirements, cryothérapie</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Medical Team -->
                <div class="bg-white rounded-2xl shadow-sm mt-8">
                    <div class="p-6 border-b border-secondary-100">
                        <h2 class="text-lg font-bold text-secondary-800"><i class="fas fa-user-md text-primary-500 mr-2"></i>Équipe Médicale</h2>
                    </div>
                    <div class="p-6">
                        <div class="flex items-center p-4 bg-secondary-50 rounded-xl">
                            <div class="w-16 h-16 bg-primary-100 rounded-xl flex items-center justify-center mr-4">
                                <i class="fas fa-user-md text-primary-600 text-2xl"></i>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-semibold text-secondary-800">Dr. Rasoamanana Luc</h4>
                                <p class="text-sm text-secondary-500">Médecin du Sport - CHU Antananarivo</p>
                                <div class="flex items-center mt-2 space-x-3">
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-medium">Disponible</span>
                                </div>
                            </div>
                            <button class="px-4 py-2 bg-primary-600 text-white rounded-lg font-medium hover:bg-primary-700 transition"><i class="fas fa-comment-medical mr-2"></i>Message</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- New Entry Modal -->
    <div id="newEntryModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-2xl w-full max-w-lg mx-4">
            <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                <h3 class="text-xl font-bold text-secondary-800">Nouvelle saisie biométrique</h3>
                <button onclick="closeNewEntryModal()" class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-times text-xl"></i></button>
            </div>
            <div class="p-6">
                <div class="grid grid-cols-2 gap-4 mb-4">
                    <div>
                        <label class="block text-sm font-medium text-secondary-700 mb-2">Poids (kg)</label>
                        <input type="number" step="0.1" class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none" placeholder="72.5">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-secondary-700 mb-2">FC Repos (bpm)</label>
                        <input type="number" class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none" placeholder="52">
                    </div>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-secondary-700 mb-2">Notes</label>
                    <textarea rows="3" class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none" placeholder="Commentaires sur votre état physique..."></textarea>
                </div>
                <div class="flex gap-4">
                    <button onclick="closeNewEntryModal()" class="flex-1 py-3 border border-secondary-300 text-secondary-700 rounded-xl font-medium hover:bg-secondary-50 transition">Annuler</button>
                    <button class="flex-1 py-3 bg-primary-600 text-white rounded-xl font-medium hover:bg-primary-700 transition">Enregistrer</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openNewEntryModal() {
            document.getElementById('newEntryModal').classList.remove('hidden');
            document.getElementById('newEntryModal').classList.add('flex');
        }
        function closeNewEntryModal() {
            document.getElementById('newEntryModal').classList.add('hidden');
            document.getElementById('newEntryModal').classList.remove('flex');
        }
        function openInjuryModal() {
            alert('Modal déclaration blessure à implémenter');
        }

        // Charts
        new Chart(document.getElementById('weightChart'), {
            type: 'line',
            data: {
                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai'],
                datasets: [{
                    label: 'Poids (kg)',
                    data: [73.2, 72.8, 72.5, 72.3, 72.5],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { min: 70, max: 75 } } }
        });

        new Chart(document.getElementById('heartRateChart'), {
            type: 'line',
            data: {
                labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai'],
                datasets: [{
                    label: 'FC (bpm)',
                    data: [54, 53, 52, 52, 51],
                    borderColor: '#ef4444',
                    backgroundColor: 'rgba(239, 68, 68, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { min: 45, max: 60 } } }
        });
    </script>
</body>
</html>
