<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - SPORT CONNECT</title>
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
        .role-card { transition: all 0.3s ease; cursor: pointer; border: 2px solid transparent; }
        .role-card:hover { transform: translateY(-4px); box-shadow: 0 10px 30px rgba(30, 64, 175, 0.2); }
        .role-card.selected { border-color: #3b82f6; background: #eff6ff; }
        .tab-active { border-bottom: 2px solid #3b82f6; color: #3b82f6; }
        .tab-inactive { color: #64748b; }
        .tab-inactive:hover { color: #3b82f6; }
        
        /* Role Option Cards in Register Form */
        .role-option input:checked + .role-option-card {
            border-color: #3b82f6;
            background: #eff6ff;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        .role-option input:checked + .role-option-card [class*="bg-"] {
            transform: scale(1.1);
            transition: transform 0.2s ease;
        }
    </style>
</head>
<body class="bg-secondary-50 min-h-screen flex flex-col">
    <!-- Header -->
    <nav class="bg-white border-b border-secondary-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-20">
                <a href="index.jsp" class="flex items-center space-x-3">
                    <div class="w-12 h-12 gradient-bg rounded-xl flex items-center justify-center">
                        <i class="fas fa-running text-white text-xl"></i>
                    </div>
                    <div>
                        <span class="text-2xl font-bold text-primary-800">SPORT</span>
                        <span class="text-2xl font-bold text-primary-500">CONNECT</span>
                    </div>
                </a>
                <a href="index.jsp" class="text-secondary-600 hover:text-primary-600 font-medium">
                    <i class="fas fa-arrow-left mr-2"></i>Retour à l'accueil
                </a>
            </div>
        </div>
    </nav>

    <div class="flex-1 flex items-center justify-center p-4">
        <div class="w-full max-w-5xl">
            <div class="bg-white rounded-3xl shadow-2xl overflow-hidden">
                <div class="grid lg:grid-cols-2">
                    <!-- Left Panel - Role Selection -->
                    <div class="p-8 lg:p-12 bg-gradient-to-br from-primary-600 to-primary-800 text-white">
                        <h2 class="text-3xl font-bold mb-2">Bienvenue</h2>
                        <p class="text-primary-100 mb-8">Sélectionnez votre profil pour accéder à votre espace</p>
                        
                        <div class="space-y-4">
                            <!-- Athlete Role -->
                            <div class="role-card bg-white/10 backdrop-blur rounded-xl p-4 flex items-center space-x-4" data-role="athlete" onclick="selectRole('athlete')">
                                <div class="w-14 h-14 rounded-xl bg-blue-400 flex items-center justify-center">
                                    <i class="fas fa-running text-white text-2xl"></i>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-bold">Athlète</h3>
                                    <p class="text-sm text-primary-100">Gérez votre carrière sportive</p>
                                </div>
                                <div class="role-check hidden">
                                    <i class="fas fa-check-circle text-2xl"></i>
                                </div>
                            </div>

                            <!-- Coach Role -->
                            <div class="role-card bg-white/10 backdrop-blur rounded-xl p-4 flex items-center space-x-4" data-role="coach" onclick="selectRole('coach')">
                                <div class="w-14 h-14 rounded-xl bg-emerald-400 flex items-center justify-center">
                                    <i class="fas fa-dumbbell text-white text-2xl"></i>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-bold">Entraîneur</h3>
                                    <p class="text-sm text-primary-100">Suivez vos athlètes</p>
                                </div>
                                <div class="role-check hidden">
                                    <i class="fas fa-check-circle text-2xl"></i>
                                </div>
                            </div>

                            <!-- Federation Role -->
                            <div class="role-card bg-white/10 backdrop-blur rounded-xl p-4 flex items-center space-x-4" data-role="federation" onclick="selectRole('federation')">
                                <div class="w-14 h-14 rounded-xl bg-amber-400 flex items-center justify-center">
                                    <i class="fas fa-landmark text-white text-2xl"></i>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-bold">Fédération</h3>
                                    <p class="text-sm text-primary-100">Administrez votre fédération</p>
                                </div>
                                <div class="role-check hidden">
                                    <i class="fas fa-check-circle text-2xl"></i>
                                </div>
                            </div>

                            <!-- Admin Role -->
                            <div class="role-card bg-white/10 backdrop-blur rounded-xl p-4 flex items-center space-x-4" data-role="admin" onclick="selectRole('admin')">
                                <div class="w-14 h-14 rounded-xl bg-rose-400 flex items-center justify-center">
                                    <i class="fas fa-shield-alt text-white text-2xl"></i>
                                </div>
                                <div class="flex-1">
                                    <h3 class="font-bold">Administrateur</h3>
                                    <p class="text-sm text-primary-100">Supervisez la plateforme</p>
                                </div>
                                <div class="role-check hidden">
                                    <i class="fas fa-check-circle text-2xl"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Panel - Auth Forms -->
                    <div class="p-8 lg:p-12">
                        <!-- Tabs -->
                        <div class="flex mb-8 border-b border-secondary-200">
                            <button class="flex-1 pb-4 text-lg font-semibold tab-active" id="loginTab" onclick="switchTab('login')">
                                <i class="fas fa-sign-in-alt mr-2"></i>Connexion
                            </button>
                            <button class="flex-1 pb-4 text-lg font-semibold tab-inactive" id="registerTab" onclick="switchTab('register')">
                                <i class="fas fa-user-plus mr-2"></i>Inscription
                            </button>
                        </div>

                        <!-- Login Form -->
                        <form id="loginForm" class="space-y-6" action="dashboard.jsp" method="post">
                            <input type="hidden" name="role" id="selectedRole" value="athlete">
                            
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Email ou NIN</label>
                                <div class="relative">
                                    <i class="fas fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="text" name="username" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="votre@email.com">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Mot de passe</label>
                                <div class="relative">
                                    <i class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="password" name="password" required id="loginPassword"
                                           class="w-full pl-12 pr-12 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="••••••••">
                                    <button type="button" onclick="togglePassword('loginPassword', this)" class="absolute right-4 top-1/2 -translate-y-1/2 text-secondary-400 hover:text-secondary-600">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="flex items-center justify-between">
                                <label class="flex items-center">
                                    <input type="checkbox" class="w-4 h-4 text-primary-600 border-secondary-300 rounded focus:ring-primary-500">
                                    <span class="ml-2 text-sm text-secondary-600">Se souvenir de moi</span>
                                </label>
                                <a href="#" class="text-sm text-primary-600 hover:text-primary-700 font-medium">Mot de passe oublié ?</a>
                            </div>

                            <button type="submit" class="w-full py-4 gradient-bg text-white rounded-xl font-semibold hover:opacity-90 transition shadow-lg shadow-primary-500/30">
                                <i class="fas fa-sign-in-alt mr-2"></i>Se connecter
                            </button>
                        </form>

                        <!-- Register Form -->
                        <form id="registerForm" class="space-y-6 hidden" action="register.jsp" method="post">
                            <input type="hidden" name="role" id="registerRole" value="athlete">
                            
                            <!-- Role Selection Display -->
                            <div class="bg-primary-50 border border-primary-200 rounded-xl p-4">
                                <label class="block text-sm font-medium text-secondary-700 mb-3">S'inscrire en tant que</label>
                                <div class="grid grid-cols-2 gap-3">
                                    <label class="role-option cursor-pointer">
                                        <input type="radio" name="roleSelect" value="athlete" class="hidden" checked onchange="selectRole('athlete')">
                                        <div class="role-option-card flex items-center space-x-3 p-3 rounded-lg border-2 border-transparent bg-white hover:border-primary-400 transition" data-role-option="athlete">
                                            <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                                                <i class="fas fa-running text-blue-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-semibold text-sm">Athlète</div>
                                                <div class="text-xs text-secondary-500">Sportif</div>
                                            </div>
                                        </div>
                                    </label>
                                    <label class="role-option cursor-pointer">
                                        <input type="radio" name="roleSelect" value="coach" class="hidden" onchange="selectRole('coach')">
                                        <div class="role-option-card flex items-center space-x-3 p-3 rounded-lg border-2 border-transparent bg-white hover:border-primary-400 transition" data-role-option="coach">
                                            <div class="w-10 h-10 rounded-lg bg-emerald-100 flex items-center justify-center">
                                                <i class="fas fa-dumbbell text-emerald-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-semibold text-sm">Entraîneur</div>
                                                <div class="text-xs text-secondary-500">Coach</div>
                                            </div>
                                        </div>
                                    </label>
                                    <label class="role-option cursor-pointer">
                                        <input type="radio" name="roleSelect" value="federation" class="hidden" onchange="selectRole('federation')">
                                        <div class="role-option-card flex items-center space-x-3 p-3 rounded-lg border-2 border-transparent bg-white hover:border-primary-400 transition" data-role-option="federation">
                                            <div class="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
                                                <i class="fas fa-landmark text-amber-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-semibold text-sm">Fédération</div>
                                                <div class="text-xs text-secondary-500">Gestion</div>
                                            </div>
                                        </div>
                                    </label>
                                    <label class="role-option cursor-pointer">
                                        <input type="radio" name="roleSelect" value="admin" class="hidden" onchange="selectRole('admin')">
                                        <div class="role-option-card flex items-center space-x-3 p-3 rounded-lg border-2 border-transparent bg-white hover:border-primary-400 transition" data-role-option="admin">
                                            <div class="w-10 h-10 rounded-lg bg-rose-100 flex items-center justify-center">
                                                <i class="fas fa-shield-alt text-rose-600"></i>
                                            </div>
                                            <div>
                                                <div class="font-semibold text-sm">Admin</div>
                                                <div class="text-xs text-secondary-500">Système</div>
                                            </div>
                                        </div>
                                    </label>
                                </div>
                            </div>
                            
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-secondary-700 mb-2">Prénom</label>
                                    <input type="text" name="firstname" required 
                                           class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="Jean">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-secondary-700 mb-2">Nom</label>
                                    <input type="text" name="lastname" required 
                                           class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="Rakoto">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Email</label>
                                <div class="relative">
                                    <i class="fas fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="email" name="email" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="votre@email.com">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">NIN (Numéro d'Identification National)</label>
                                <div class="relative">
                                    <i class="fas fa-id-card absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="text" name="nin" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="1234567890123">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Téléphone</label>
                                <div class="relative">
                                    <i class="fas fa-phone absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="tel" name="phone" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="+261 34 XX XXX XX">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Mot de passe</label>
                                <div class="relative">
                                    <i class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="password" name="password" required id="regPassword"
                                           class="w-full pl-12 pr-12 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="••••••••">
                                    <button type="button" onclick="togglePassword('regPassword', this)" class="absolute right-4 top-1/2 -translate-y-1/2 text-secondary-400 hover:text-secondary-600">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <p class="text-xs text-secondary-500 mt-1">Minimum 8 caractères, 1 majuscule, 1 chiffre</p>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Confirmer le mot de passe</label>
                                <div class="relative">
                                    <i class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="password" name="confirmPassword" required id="regConfirmPassword"
                                           class="w-full pl-12 pr-12 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition"
                                           placeholder="••••••••">
                                </div>
                            </div>

                            <div class="flex items-start">
                                <input type="checkbox" required class="w-4 h-4 mt-1 text-primary-600 border-secondary-300 rounded focus:ring-primary-500">
                                <span class="ml-2 text-sm text-secondary-600">
                                    J'accepte les <a href="#" class="text-primary-600 hover:underline">conditions d'utilisation</a> et la <a href="#" class="text-primary-600 hover:underline">politique de confidentialité</a>
                                </span>
                            </div>

                            <button type="submit" class="w-full py-4 gradient-bg text-white rounded-xl font-semibold hover:opacity-90 transition shadow-lg shadow-primary-500/30">
                                <i class="fas fa-user-plus mr-2"></i>Créer mon compte
                            </button>
                        </form>

                        <!-- 2FA Section (Admin only) -->
                        <div id="twoFASection" class="hidden mt-6 pt-6 border-t border-secondary-200">
                            <div class="bg-amber-50 border border-amber-200 rounded-xl p-4 mb-4">
                                <div class="flex items-start">
                                    <i class="fas fa-exclamation-triangle text-amber-500 mt-1 mr-3"></i>
                                    <div>
                                        <h4 class="font-semibold text-amber-800">Authentification 2FA requise</h4>
                                        <p class="text-sm text-amber-700">Pour les administrateurs, une vérification supplémentaire est nécessaire.</p>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Code d'authentification</label>
                                <div class="flex space-x-2">
                                    <input type="text" maxlength="1" class="w-12 h-12 text-center border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none text-xl font-bold">
                                    <input type="text" maxlength="1" class="w-12 h-12 text-center border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none text-xl font-bold">
                                    <input type="text" maxlength="1" class="w-12 h-12 text-center border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none text-xl font-bold">
                                    <input type="text" maxlength="1" class="w-12 h-12 text-center border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none text-xl font-bold">
                                    <input type="text" maxlength="1" class="w-12 h-12 text-center border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none text-xl font-bold">
                                    <input type="text" maxlength="1" class="w-12 h-12 text-center border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none text-xl font-bold">
                                </div>
                                <p class="text-xs text-secondary-500 mt-2">Entrez le code envoyé sur votre application d'authentification</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let currentRole = 'athlete';

        function selectRole(role) {
            currentRole = role;
            document.getElementById('selectedRole').value = role;
            document.getElementById('registerRole').value = role;
            
            // Update UI - Left panel role cards
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('selected');
                card.querySelector('.role-check').classList.add('hidden');
            });
            
            const selectedCard = document.querySelector(`[data-role="${role}"]`);
            if (selectedCard) {
                selectedCard.classList.add('selected');
                selectedCard.querySelector('.role-check').classList.remove('hidden');
            }
            
            // Sync register form radio buttons
            document.querySelectorAll('input[name="roleSelect"]').forEach(radio => {
                radio.checked = (radio.value === role);
            });

            // Show 2FA for admin
            const twoFASection = document.getElementById('twoFASection');
            if (role === 'admin') {
                twoFASection.classList.remove('hidden');
            } else {
                twoFASection.classList.add('hidden');
            }
        }

        function switchTab(tab) {
            const loginForm = document.getElementById('loginForm');
            const registerForm = document.getElementById('registerForm');
            const loginTab = document.getElementById('loginTab');
            const registerTab = document.getElementById('registerTab');

            if (tab === 'login') {
                loginForm.classList.remove('hidden');
                registerForm.classList.add('hidden');
                loginTab.classList.add('tab-active');
                loginTab.classList.remove('tab-inactive');
                registerTab.classList.remove('tab-active');
                registerTab.classList.add('tab-inactive');
            } else {
                loginForm.classList.add('hidden');
                registerForm.classList.remove('hidden');
                registerTab.classList.add('tab-active');
                registerTab.classList.remove('tab-inactive');
                loginTab.classList.remove('tab-active');
                loginTab.classList.add('tab-inactive');
            }
        }

        function togglePassword(inputId, btn) {
            const input = document.getElementById(inputId);
            const icon = btn.querySelector('i');
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }

        // Auto-select role from URL
        const urlParams = new URLSearchParams(window.location.search);
        const roleFromUrl = urlParams.get('role');
        if (roleFromUrl && ['athlete', 'coach', 'federation', 'admin'].includes(roleFromUrl)) {
            selectRole(roleFromUrl);
        } else {
            selectRole('athlete');
        }
    </script>
</body>
</html>
