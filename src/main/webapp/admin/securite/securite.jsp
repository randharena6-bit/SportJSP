<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sécurité & Conformité - Admin | SPORT CONNECT</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
                    <a href="securite.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-lock w-6"></i>Sécurité</a>
                    <a href="../ia/ia.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-robot w-6"></i>IA</a>
                    <a href="../infrastructure/infrastructure.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-server w-6"></i>Infrastructure</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-file-alt w-6"></i>Rapports</a>
                </nav>
                <div class="mt-8 pt-6 border-t border-slate-200">
                    <a href="../../index.jsp" class="flex items-center px-4 py-3 text-slate-500 hover:text-blue-600 font-medium transition"><i class="fas fa-sign-out-alt w-6"></i>Déconnexion</a>
                </div>
            </div>
        </aside>

        <div class="flex-1 overflow-y-auto">
            <header class="bg-white border-b border-slate-200 sticky top-0 z-30">
                <div class="px-8 py-4">
                    <h1 class="text-2xl font-bold text-slate-800">Sécurité & Conformité</h1>
                    <p class="text-slate-500 text-sm">Audit log, conformité RGPD/Loi 2021-016</p>
                </div>
            </header>

            <main class="p-8">
                <!-- Security Alerts -->
                <div class="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6 flex items-start">
                    <i class="fas fa-exclamation-triangle text-blue-500 mt-1 mr-3"></i>
                    <div class="flex-1">
                        <h4 class="font-semibold text-rose-800">3 alertes de sécurité actives</h4>
                        <p class="text-sm text-blue-700">Tentatives d'accès suspects détectées - Examen requis</p>
                    </div>
                    <button class="px-4 py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-blue-200">Examiner</button>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Audit Log -->
                    <div class="bg-white rounded-2xl shadow-sm">
                        <div class="p-6 border-b border-slate-100 flex items-center justify-between">
                            <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-clipboard-list text-blue-500 mr-2"></i>Audit Log</h2>
                            <button class="text-blue-600 font-medium text-sm"><i class="fas fa-download mr-1"></i>Export</button>
                        </div>
                        <div class="p-4 max-h-96 overflow-y-auto">
                            <div class="space-y-3">
                                <div class="flex items-start p-3 bg-slate-50 rounded-lg">
                                    <i class="fas fa-user-shield text-blue-500 mt-1 mr-3"></i>
                                    <div class="flex-1">
                                        <p class="text-sm font-medium text-slate-800">Connexion admin - Rabe Andry</p>
                                        <p class="text-xs text-slate-500">06/05/2025 14:32:15 • IP: 197.149.XXX.XXX</p>
                                    </div>
                                </div>
                                <div class="flex items-start p-3 bg-blue-50 rounded-lg">
                                    <i class="fas fa-exclamation-circle text-blue-500 mt-1 mr-3"></i>
                                    <div class="flex-1">
                                        <p class="text-sm font-medium text-blue-800">Tentative échouée - Fédération Football</p>
                                        <p class="text-xs text-blue-600">06/05/2025 14:28:42 • IP: 197.149.XXX.XXX</p>
                                    </div>
                                </div>
                                <div class="flex items-start p-3 bg-slate-50 rounded-lg">
                                    <i class="fas fa-edit text-blue-500 mt-1 mr-3"></i>
                                    <div class="flex-1">
                                        <p class="text-sm font-medium text-slate-800">Modification licence - Athlète #12345</p>
                                        <p class="text-xs text-slate-500">06/05/2025 14:15:30 • Par: Admin Rabe</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Compliance -->
                    <div class="space-y-6">
                        <div class="bg-white rounded-2xl shadow-sm p-6">
                            <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-shield-alt text-blue-500 mr-2"></i>Conformité</h2>
                            <div class="space-y-4">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center">
                                        <i class="fas fa-certificate text-blue-500 mr-3"></i>
                                        <span class="text-slate-700">TLS/SSL Certificate</span>
                                    </div>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm">Valide</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center">
                                        <i class="fas fa-lock text-blue-500 mr-3"></i>
                                        <span class="text-slate-700">Chiffrement AES-256</span>
                                    </div>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm">Actif</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center">
                                        <i class="fas fa-user-shield text-blue-500 mr-3"></i>
                                        <span class="text-slate-700">2FA Admin</span>
                                    </div>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm">Obligatoire</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center">
                                        <i class="fas fa-file-contract text-blue-500 mr-3"></i>
                                        <span class="text-slate-700">RGPD / Loi 2021-016</span>
                                    </div>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-sm">Conforme</span>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white rounded-2xl shadow-sm p-6">
                            <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-bug text-blue-500 mr-2"></i>Sécurité</h2>
                            <div class="space-y-3">
                                <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                    <span class="text-slate-700">Dernier penetration test</span>
                                    <span class="text-sm text-slate-600">15 Mars 2025</span>
                                </div>
                                <div class="flex items-center justify-between p-3 bg-slate-50 rounded-lg">
                                    <span class="text-slate-700">Prochain test planifié</span>
                                    <span class="text-sm text-slate-600">15 Septembre 2025</span>
                                </div>
                                <button class="w-full py-2 bg-blue-100 text-blue-700 rounded-lg font-medium hover:bg-blue-200"><i class="fas fa-shield-alt mr-2"></i>Lancer audit sécurité</button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
