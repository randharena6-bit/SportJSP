<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Intelligence Artificielle - Admin | SPORT CONNECT</title>
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
                    <a href="../securite/securite.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-lock w-6"></i>Sécurité</a>
                    <a href="ia.jsp" class="sidebar-link active flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-robot w-6"></i>Intelligence Artificielle</a>
                    <a href="../infrastructure/infrastructure.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-server w-6"></i>Infrastructure</a>
                    <a href="../rapports/rapports.jsp" class="sidebar-link flex items-center px-4 py-3 text-slate-700 font-medium"><i class="fas fa-file-alt w-6"></i>Rapports</a>
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
                        <h1 class="text-2xl font-bold text-slate-800">Intelligence Artificielle</h1>
                        <p class="text-slate-500 text-sm">Supervision des algorithmes et modèles ML</p>
                    </div>
                    <div class="flex items-center px-3 py-1 bg-blue-100 text-purple-700 rounded-full text-sm">
                        <span class="w-2 h-2 bg-purple-500 rounded-full mr-2 animate-pulse"></span>
                        Modèles actifs
                    </div>
                </div>
            </header>

            <main class="p-8">
                <!-- AI Alerts -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                    <div class="bg-gradient-to-r from-purple-600 to-indigo-600 rounded-2xl p-6 text-white">
                        <h3 class="font-semibold mb-2"><i class="fas fa-star mr-2"></i>Talent Scoring System</h3>
                        <p class="text-purple-100 text-sm mb-4">Dernière mise à jour: 05/05/2025</p>
                        <div class="flex items-center justify-between">
                            <span class="text-2xl font-bold">92.4%</span>
                            <span class="text-purple-100">Précision modèle</span>
                        </div>
                    </div>
                    <div class="bg-gradient-to-r from-blue-600 to-blue-700 rounded-2xl p-6 text-white">
                        <h3 class="font-semibold mb-2"><i class="fas fa-exclamation-triangle mr-2"></i>Performance Anomaly Detector</h3>
                        <p class="text-rose-100 text-sm mb-4">Alertes doping/anomalies</p>
                        <div class="flex items-center justify-between">
                            <span class="text-2xl font-bold">3</span>
                            <span class="text-rose-100">Alertes actives</span>
                        </div>
                    </div>
                </div>

                <!-- AI Parameters -->
                <div class="bg-white rounded-2xl shadow-sm p-6 mb-8">
                    <h2 class="text-lg font-bold text-slate-800 mb-4"><i class="fas fa-sliders-h text-purple-500 mr-2"></i>Paramètres Talent Scoring</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Performance brute (%)</label>
                            <input type="range" value="40" class="w-full h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer">
                            <div class="flex justify-between text-sm text-slate-500 mt-1"><span>0%</span><span>40%</span><span>100%</span></div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Progression annuelle (%)</label>
                            <input type="range" value="25" class="w-full h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer">
                            <div class="flex justify-between text-sm text-slate-500 mt-1"><span>0%</span><span>25%</span><span>100%</span></div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Âge / Potentiel (%)</label>
                            <input type="range" value="20" class="w-full h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer">
                            <div class="flex justify-between text-sm text-slate-500 mt-1"><span>0%</span><span>20%</span><span>100%</span></div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-2">Cohérence mentale (%)</label>
                            <input type="range" value="15" class="w-full h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer">
                            <div class="flex justify-between text-sm text-slate-500 mt-1"><span>0%</span><span>15%</span><span>100%</span></div>
                        </div>
                    </div>
                    <div class="mt-6 flex gap-4">
                        <button class="px-4 py-2 bg-slate-200 text-slate-700 rounded-lg font-medium hover:bg-slate-300">Réinitialiser</button>
                        <button class="px-4 py-2 bg-purple-600 text-white rounded-lg font-medium hover:bg-purple-700"><i class="fas fa-save mr-2"></i>Sauvegarder paramètres</button>
                    </div>
                </div>

                <!-- Active Alerts -->
                <div class="bg-white rounded-2xl shadow-sm">
                    <div class="p-6 border-b border-slate-100 flex items-center justify-between">
                        <h2 class="text-lg font-bold text-slate-800"><i class="fas fa-bell text-blue-500 mr-2"></i>Alertes IA en attente de validation</h2>
                        <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-medium">3 alertes</span>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4">
                            <div class="flex items-start p-4 bg-blue-50 rounded-xl border-l-4 border-rose-500">
                                <i class="fas fa-exclamation-triangle text-blue-500 mt-1 mr-3"></i>
                                <div class="flex-1">
                                    <h4 class="font-semibold text-rose-800">Anomalie de performance détectée</h4>
                                    <p class="text-sm text-blue-600 mt-1">Athlète #12345 - Amélioration de 15% sur 100m en 2 semaines</p>
                                    <div class="flex gap-2 mt-3">
                                        <button class="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm font-medium">Valider alerte</button>
                                        <button class="px-3 py-1 bg-slate-100 text-slate-700 rounded-lg text-sm font-medium">Faux positif</button>
                                    </div>
                                </div>
                                <span class="text-xs text-slate-500">Il y a 2h</span>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
