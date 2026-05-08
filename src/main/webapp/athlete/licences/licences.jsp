<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Licences - Athlète | SPORT CONNECT</title>
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
        .payment-card { transition: all 0.3s ease; cursor: pointer; }
        .payment-card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .payment-card.selected { border-color: #3b82f6; background: #eff6ff; }
        .license-card { background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%); }
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
                    <a href="../profil/profil.jsp" class="sidebar-link flex items-center px-4 py-3 text-secondary-700 font-medium">
                        <i class="fas fa-user w-6"></i>Mon Profil
                    </a>
                    <a href="licences.jsp" class="sidebar-link active flex items-center px-4 py-3 text-secondary-700 font-medium">
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
                        <span class="ml-auto bg-blue-500 text-white text-xs px-2 py-0.5 rounded-full">3</span>
                    </a>
                </nav>
                <div class="mt-8 pt-6 border-t border-secondary-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-secondary-500 hover:text-blue-600 font-medium transition">
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
                        <h1 class="text-2xl font-bold text-secondary-800">Mes Licences</h1>
                        <p class="text-secondary-500 text-sm">Gérez vos licences sportives et paiements</p>
                    </div>
                    <button onclick="openNewLicenseModal()" class="px-6 py-2.5 bg-primary-600 text-white rounded-xl font-medium hover:bg-primary-700 transition">
                        <i class="fas fa-plus mr-2"></i>Nouvelle licence
                    </button>
                </div>
            </header>

            <main class="p-8">
                <!-- Current License Card -->
                <div class="bg-white rounded-2xl shadow-sm p-8 mb-8">
                    <div class="flex flex-col md:flex-row items-center justify-between">
                        <div class="flex-1">
                            <div class="flex items-center mb-4">
                                <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium mr-3">Active</span>
                                <span class="text-secondary-500 text-sm">Saison 2024-2025</span>
                            </div>
                            <h2 class="text-2xl font-bold text-secondary-800 mb-2">Licence Athlétisme - Senior</h2>
                            <p class="text-secondary-500 mb-4">Fédération Malgache d'Athlétisme (FMA)</p>
                            <div class="flex flex-wrap gap-4 text-sm">
                                <div class="flex items-center text-secondary-600">
                                    <i class="fas fa-calendar mr-2 text-primary-500"></i>
                                    <span>Valide du 01/01/2024 au 31/12/2025</span>
                                </div>
                                <div class="flex items-center text-secondary-600">
                                    <i class="fas fa-hashtag mr-2 text-primary-500"></i>
                                    <span>N° LIC-2024-001234</span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-6 md:mt-0 flex flex-col items-center">
                            <div class="w-32 h-32 bg-secondary-100 rounded-xl flex items-center justify-center mb-3">
                                <img src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=LIC-2024-001234" alt="QR Code" class="w-28 h-28">
                            </div>
                            <p class="text-xs text-secondary-500">Scannez pour vérifier</p>
                        </div>
                    </div>
                    <div class="mt-6 pt-6 border-t border-secondary-100 flex flex-wrap gap-3">
                        <button class="px-4 py-2 bg-primary-100 text-primary-700 rounded-lg font-medium hover:bg-primary-200 transition">
                            <i class="fas fa-download mr-2"></i>Télécharger PDF
                        </button>
                        <button class="px-4 py-2 bg-secondary-100 text-secondary-700 rounded-lg font-medium hover:bg-secondary-200 transition">
                            <i class="fas fa-share-alt mr-2"></i>Partager
                        </button>
                        <button class="px-4 py-2 bg-secondary-100 text-secondary-700 rounded-lg font-medium hover:bg-secondary-200 transition">
                            <i class="fas fa-print mr-2"></i>Imprimer
                        </button>
                    </div>
                </div>

                <!-- License History -->
                <div class="bg-white rounded-2xl shadow-sm">
                    <div class="p-6 border-b border-secondary-100">
                        <h2 class="text-lg font-bold text-secondary-800">Historique des Licences</h2>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-secondary-50">
                                <tr>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Saison</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Discipline</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Catégorie</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Période</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Statut</th>
                                    <th class="text-left py-4 px-6 font-semibold text-secondary-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="border-b border-secondary-100">
                                    <td class="py-4 px-6 font-medium text-secondary-800">2024-2025</td>
                                    <td class="py-4 px-6 text-secondary-700">Athlétisme</td>
                                    <td class="py-4 px-6 text-secondary-700">Senior</td>
                                    <td class="py-4 px-6 text-secondary-600">01/01/24 - 31/12/25</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Active</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-primary-600 hover:text-primary-700 mr-3"><i class="fas fa-download"></i></button>
                                        <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-eye"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-secondary-100">
                                    <td class="py-4 px-6 font-medium text-secondary-800">2023-2024</td>
                                    <td class="py-4 px-6 text-secondary-700">Athlétisme</td>
                                    <td class="py-4 px-6 text-secondary-700">Senior</td>
                                    <td class="py-4 px-6 text-secondary-600">01/01/23 - 31/12/24</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-secondary-200 text-secondary-700 rounded-lg text-sm font-medium">Expirée</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-primary-600 hover:text-primary-700 mr-3"><i class="fas fa-download"></i></button>
                                        <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-eye"></i></button>
                                    </td>
                                </tr>
                                <tr class="border-b border-secondary-100">
                                    <td class="py-4 px-6 font-medium text-secondary-800">2022-2023</td>
                                    <td class="py-4 px-6 text-secondary-700">Athlétisme</td>
                                    <td class="py-4 px-6 text-secondary-700">Junior</td>
                                    <td class="py-4 px-6 text-secondary-600">01/01/22 - 31/12/23</td>
                                    <td class="py-4 px-6"><span class="px-2 py-1 bg-secondary-200 text-secondary-700 rounded-lg text-sm font-medium">Expirée</span></td>
                                    <td class="py-4 px-6">
                                        <button class="text-primary-600 hover:text-primary-700 mr-3"><i class="fas fa-download"></i></button>
                                        <button class="text-secondary-400 hover:text-secondary-600"><i class="fas fa-eye"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- New License Modal -->
    <div id="newLicenseModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto">
            <div class="p-6 border-b border-secondary-100 flex items-center justify-between">
                <h3 class="text-xl font-bold text-secondary-800">Demande de nouvelle licence</h3>
                <button onclick="closeNewLicenseModal()" class="text-secondary-400 hover:text-secondary-600">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>
            <div class="p-6">
                <div class="mb-6">
                    <label class="block text-sm font-medium text-secondary-700 mb-2">Discipline</label>
                    <select class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                        <option>Athlétisme</option>
                        <option>Football</option>
                        <option>Basketball</option>
                        <option>Natation</option>
                        <option>Judo</option>
                    </select>
                </div>
                <div class="mb-6">
                    <label class="block text-sm font-medium text-secondary-700 mb-2">Catégorie</label>
                    <select class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none">
                        <option>Senior (23+ ans)</option>
                        <option>U23 (20-23 ans)</option>
                        <option>U20 (18-20 ans)</option>
                        <option>Junior (16-18 ans)</option>
                    </select>
                </div>
                <div class="mb-6">
                    <label class="block text-sm font-medium text-secondary-700 mb-2">Saison</label>
                    <input type="text" value="2025-2026" readonly class="w-full px-4 py-3 bg-secondary-50 border border-secondary-200 rounded-xl text-secondary-700">
                </div>
                <div class="mb-6">
                    <label class="block text-sm font-medium text-secondary-700 mb-3">Méthode de paiement Mobile Money</label>
                    <div class="grid grid-cols-3 gap-4">
                        <div class="payment-card border-2 border-secondary-200 rounded-xl p-4 text-center" onclick="selectPayment(this, 'mvola')">
                            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mx-auto mb-2">
                                <i class="fas fa-mobile-alt text-blue-600 text-xl"></i>
                            </div>
                            <p class="font-medium text-secondary-700">Mvola</p>
                        </div>
                        <div class="payment-card border-2 border-secondary-200 rounded-xl p-4 text-center" onclick="selectPayment(this, 'orange')">
                            <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mx-auto mb-2">
                                <i class="fas fa-mobile-alt text-orange-600 text-xl"></i>
                            </div>
                            <p class="font-medium text-secondary-700">Orange Money</p>
                        </div>
                        <div class="payment-card border-2 border-secondary-200 rounded-xl p-4 text-center" onclick="selectPayment(this, 'airtel')">
                            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mx-auto mb-2">
                                <i class="fas fa-mobile-alt text-blue-600 text-xl"></i>
                            </div>
                            <p class="font-medium text-secondary-700">Airtel Money</p>
                        </div>
                    </div>
                </div>
                <div class="bg-secondary-50 rounded-xl p-4 mb-6">
                    <div class="flex justify-between items-center">
                        <span class="text-secondary-700">Frais de licence</span>
                        <span class="font-semibold text-secondary-800">25 000 Ar</span>
                    </div>
                    <div class="flex justify-between items-center mt-2">
                        <span class="text-secondary-700">Frais administratifs</span>
                        <span class="font-semibold text-secondary-800">2 000 Ar</span>
                    </div>
                    <div class="border-t border-secondary-200 my-2"></div>
                    <div class="flex justify-between items-center">
                        <span class="font-semibold text-secondary-800">Total</span>
                        <span class="text-xl font-bold text-primary-600">27 000 Ar</span>
                    </div>
                </div>
                <div class="flex gap-4">
                    <button onclick="closeNewLicenseModal()" class="flex-1 py-3 border border-secondary-300 text-secondary-700 rounded-xl font-medium hover:bg-secondary-50 transition">Annuler</button>
                    <button class="flex-1 py-3 bg-primary-600 text-white rounded-xl font-medium hover:bg-primary-700 transition">Procéder au paiement</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openNewLicenseModal() {
            document.getElementById('newLicenseModal').classList.remove('hidden');
            document.getElementById('newLicenseModal').classList.add('flex');
        }
        function closeNewLicenseModal() {
            document.getElementById('newLicenseModal').classList.add('hidden');
            document.getElementById('newLicenseModal').classList.remove('flex');
        }
        function selectPayment(element, method) {
            document.querySelectorAll('.payment-card').forEach(card => card.classList.remove('selected'));
            element.classList.add('selected');
        }
    </script>
</body>
</html>
