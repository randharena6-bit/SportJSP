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
        .gradient-bg { 
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 50%, #60a5fa 100%);
            position: relative;
            overflow: hidden;
        }
        .gradient-bg::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shimmer 3s infinite;
        }
        
        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }
        
        .role-card { 
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); 
            cursor: pointer; 
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }
        .role-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.1), transparent);
            transition: left 0.5s ease;
        }
        .role-card:hover::before {
            left: 100%;
        }
        .role-card:hover { 
            transform: translateY(-8px) scale(1.02); 
            box-shadow: 0 20px 40px rgba(30, 64, 175, 0.3);
            border-color: #3b82f6;
        }
        .role-card.selected { 
            border-color: #3b82f6 !important; 
            background: rgba(59, 130, 246, 0.1) !important;
            transform: translateY(-4px) scale(1.01);
            box-shadow: 0 15px 35px rgba(30, 64, 175, 0.25);
        }
        
        .role-card.selected .role-check {
            display: flex !important;
        }
        
        .tab-active { 
            border-bottom: 3px solid #3b82f6; 
            color: #3b82f6;
            position: relative;
        }
        .tab-active::after {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #3b82f6, #60a5fa);
            animation: tabGlow 2s ease-in-out infinite;
        }
        
        @keyframes tabGlow {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .tab-inactive { 
            color: #64748b;
            transition: all 0.3s ease;
        }
        .tab-inactive:hover { 
            color: #3b82f6;
            transform: translateY(-2px);
        }
        
        /* Form animations */
        .form-container {
            animation: slideInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }
        
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Form transition styles */
        #registerForm {
            opacity: 0;
            transform: translateX(20px);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }
        
        #registerForm:not(.hidden) {
            opacity: 1;
            transform: translateX(0);
        }
        
        .form-input {
            transition: all 0.3s ease;
            position: relative;
        }
        
        .form-input:focus {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.15);
        }
        
        .submit-btn {
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .submit-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .submit-btn:hover::before {
            width: 300px;
            height: 300px;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(59, 130, 246, 0.3);
        }
        
        /* Loading animation */
        .loading-spinner {
            display: none;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        .loading .loading-spinner {
            display: inline-block;
        }
        
        .loading .btn-text {
            display: none;
        }
        
        /* Role Option Cards in Register Form */
        .role-option input:checked + .role-option-card {
            border-color: #3b82f6 !important;
            background: rgba(59, 130, 246, 0.1) !important;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            transform: scale(1.05);
        }
        .role-option input:checked + .role-option-card [class*="bg-"] {
            transform: scale(1.2) rotate(5deg);
            transition: transform 0.3s ease;
        }
        
        /* Ensure role check icons are visible when selected */
        .role-check {
            display: none;
            align-items: center;
            justify-content: center;
        }
        
        .role-card.selected .role-check,
        .role-option input:checked + .role-option-card .role-check {
            display: flex !important;
        }
        
        /* Success/Error animations */
        .shake {
            animation: shake 0.5s;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
        
        .success-pulse {
            animation: successPulse 0.6s ease;
        }
        
        @keyframes successPulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        /* Floating animation for role cards */
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        
        .float-animation {
            animation: float 3s ease-in-out infinite;
        }
        
        /* Staggered animation for role cards */
        .role-card:nth-child(1) { animation-delay: 0.1s; }
        .role-card:nth-child(2) { animation-delay: 0.2s; }
        .role-card:nth-child(3) { animation-delay: 0.3s; }
        .role-card:nth-child(4) { animation-delay: 0.4s; }
        
        /* 2FA section animation */
        #twoFASection {
            transition: opacity 0.3s ease;
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
                        <form id="loginForm" class="space-y-6 form-container" onsubmit="handleLogin(event)" action="javascript:void(0)">
                            <input type="hidden" name="role" id="selectedRole" value="athlete">
                            
                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Email ou NIN</label>
                                <div class="relative">
                                    <i class="fas fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="text" name="username" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
                                           placeholder="votre@email.com">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Mot de passe</label>
                                <div class="relative">
                                    <i class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="password" name="password" required id="loginPassword"
                                           class="w-full pl-12 pr-12 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
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

                            <button type="submit" class="w-full py-4 gradient-bg text-white rounded-xl font-semibold hover:opacity-90 transition shadow-lg shadow-primary-500/30 submit-btn">
                                <i class="fas fa-sign-in-alt mr-2 btn-text"></i>
                                <span class="btn-text">Se connecter</span>
                                <i class="fas fa-spinner loading-spinner"></i>
                            </button>
                        </form>

                        <!-- Register Form -->
                        <form id="registerForm" class="space-y-6 hidden form-container" onsubmit="handleRegister(event)" action="javascript:void(0)">
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
                                           class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
                                           placeholder="Jean">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-secondary-700 mb-2">Nom</label>
                                    <input type="text" name="lastname" required 
                                           class="w-full px-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
                                           placeholder="Rakoto">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Email</label>
                                <div class="relative">
                                    <i class="fas fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="email" name="email" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
                                           placeholder="votre@email.com">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">NIN (Numéro d'Identification National)</label>
                                <div class="relative">
                                    <i class="fas fa-id-card absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="text" name="nin" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
                                           placeholder="1234567890123">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Téléphone</label>
                                <div class="relative">
                                    <i class="fas fa-phone absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="tel" name="phone" required 
                                           class="w-full pl-12 pr-4 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
                                           placeholder="+261 34 XX XXX XX">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-secondary-700 mb-2">Mot de passe</label>
                                <div class="relative">
                                    <i class="fas fa-lock absolute left-4 top-1/2 -translate-y-1/2 text-secondary-400"></i>
                                    <input type="password" name="password" required id="regPassword"
                                           class="w-full pl-12 pr-12 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
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
                                           class="w-full pl-12 pr-12 py-3 border border-secondary-200 rounded-xl focus:ring-2 focus:ring-primary-500 focus:border-primary-500 outline-none transition form-input"
                                           placeholder="••••••••">
                                </div>
                            </div>

                            <div class="flex items-start">
                                <input type="checkbox" required class="w-4 h-4 mt-1 text-primary-600 border-secondary-300 rounded focus:ring-primary-500">
                                <span class="ml-2 text-sm text-secondary-600">
                                    J'accepte les <a href="#" class="text-primary-600 hover:underline">conditions d'utilisation</a> et la <a href="#" class="text-primary-600 hover:underline">politique de confidentialité</a>
                                </span>
                            </div>

                            <button type="submit" class="w-full py-4 gradient-bg text-white rounded-xl font-semibold hover:opacity-90 transition shadow-lg shadow-primary-500/30 submit-btn">
                                <i class="fas fa-user-plus mr-2 btn-text"></i>
                                <span class="btn-text">Créer mon compte</span>
                                <i class="fas fa-spinner loading-spinner"></i>
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
        // Force refresh - v20250108_1448
        console.log('Loading login script with API URL: http://localhost:3003/api/auth');
        const API_BASE_URL = 'http://localhost:3003/api/auth';
        let currentRole = 'athlete';

        async function handleLogin(event) {
            event.preventDefault();
            const form = event.target;
            const submitBtn = form.querySelector('.submit-btn');
            const formData = new FormData(form);
            const data = {
                username: formData.get('username'),
                password: formData.get('password'),
                role: formData.get('role')
            };

            // Add loading state
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;

            try {
                const response = await fetch(`${API_BASE_URL}/login`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                });

                const contentType = response.headers.get('content-type');
                if (!contentType || !contentType.includes('application/json')) {
                    throw new Error('Le serveur a retourné une réponse non-JSON. Vérifiez que l\'API est disponible.');
                }

                const result = await response.json();

                if (result.success) {
                    localStorage.setItem('token', result.token);
                    localStorage.setItem('user', JSON.stringify(result.user));
                    form.classList.add('success-pulse');
                    showNotification('Connexion réussie !', 'success');
                    setTimeout(() => {
                        window.location.href = 'dashboard.jsp';
                    }, 1000);
                } else {
                    form.classList.add('shake');
                    showNotification(result.message || 'Erreur lors de la connexion', 'error');
                    setTimeout(() => {
                        form.classList.remove('shake');
                    }, 500);
                }
            } catch (error) {
                console.error('Login error:', error);
                form.classList.add('shake');
                showNotification('Erreur de connexion au serveur', 'error');
                setTimeout(() => {
                    form.classList.remove('shake');
                }, 500);
            } finally {
                // Remove loading state
                submitBtn.classList.remove('loading');
                submitBtn.disabled = false;
            }
        }

        async function handleRegister(event) {
            event.preventDefault();
            const form = event.target;
            const submitBtn = form.querySelector('.submit-btn');
            const formData = new FormData(form);
            const data = {
                firstname: formData.get('firstname'),
                lastname: formData.get('lastname'),
                email: formData.get('email'),
                nin: formData.get('nin'),
                phone: formData.get('phone'),
                password: formData.get('password'),
                confirmPassword: formData.get('confirmPassword'),
                role: formData.get('role')
            };

            // Add loading state
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;

            try {
                const response = await fetch(`${API_BASE_URL}/register`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                });

                const contentType = response.headers.get('content-type');
                if (!contentType || !contentType.includes('application/json')) {
                    throw new Error('Le serveur a retourné une réponse non-JSON. Vérifiez que l\'API est disponible.');
                }

                const result = await response.json();

                if (result.success) {
                    localStorage.setItem('token', result.token);
                    localStorage.setItem('user', JSON.stringify(result.user));
                    form.classList.add('success-pulse');
                    showNotification('Compte créé avec succès !', 'success');
                    setTimeout(() => {
                        window.location.href = 'dashboard.jsp';
                    }, 1000);
                } else {
                    form.classList.add('shake');
                    showNotification(result.message || 'Erreur lors de l\'inscription', 'error');
                    setTimeout(() => {
                        form.classList.remove('shake');
                    }, 500);
                }
            } catch (error) {
                console.error('Register error:', error);
                form.classList.add('shake');
                showNotification('Erreur de connexion au serveur', 'error');
                setTimeout(() => {
                    form.classList.remove('shake');
                }, 500);
            } finally {
                // Remove loading state
                submitBtn.classList.remove('loading');
                submitBtn.disabled = false;
            }
        }

        function showNotification(message, type) {
            // Remove existing notifications
            const existingNotification = document.querySelector('.notification');
            if (existingNotification) {
                existingNotification.remove();
            }

            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification fixed top-4 right-4 px-6 py-4 rounded-xl shadow-lg z-50 flex items-center space-x-3 transform translate-x-full transition-transform duration-300`;
            
            if (type === 'success') {
                notification.classList.add('bg-green-500', 'text-white');
                notification.innerHTML = `
                    <i class="fas fa-check-circle"></i>
                    <span>${message}</span>
                `;
            } else {
                notification.classList.add('bg-red-500', 'text-white');
                notification.innerHTML = `
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${message}</span>
                `;
            }

            document.body.appendChild(notification);

            // Animate in
            setTimeout(() => {
                notification.classList.remove('translate-x-full');
                notification.classList.add('translate-x-0');
            }, 100);

            // Remove after 3 seconds
            setTimeout(() => {
                notification.classList.add('translate-x-full');
                setTimeout(() => {
                    notification.remove();
                }, 300);
            }, 3000);
        }

        function selectRole(role) {
            currentRole = role;
            document.getElementById('selectedRole').value = role;
            document.getElementById('registerRole').value = role;
            
            // Update UI - Left panel role cards with animation
            document.querySelectorAll('.role-card').forEach(card => {
                if (card.dataset.role === role) {
                    card.classList.add('selected');
                    const checkIcon = card.querySelector('.role-check');
                    if (checkIcon) {
                        checkIcon.style.display = 'flex';
                        checkIcon.style.animation = 'successPulse 0.4s ease';
                    }
                } else {
                    card.classList.remove('selected');
                    const checkIcon = card.querySelector('.role-check');
                    if (checkIcon) {
                        checkIcon.style.display = 'none';
                    }
                }
            });
            
            // Sync register form radio buttons with animation
            document.querySelectorAll('input[name="roleSelect"]').forEach(radio => {
                const card = radio.nextElementSibling;
                if (radio.value === role) {
                    radio.checked = true;
                    if (card) {
                        card.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                            card.style.transform = 'scale(1)';
                        }, 200);
                    }
                } else {
                    radio.checked = false;
                }
            });

            // Show 2FA for admin with animation
            const twoFASection = document.getElementById('twoFASection');
            if (role === 'admin') {
                twoFASection.classList.remove('hidden');
                twoFASection.style.opacity = '0';
                setTimeout(() => {
                    twoFASection.style.opacity = '1';
                }, 50);
            } else {
                twoFASection.style.opacity = '0';
                setTimeout(() => {
                    twoFASection.classList.add('hidden');
                }, 200);
            }
        }

        function switchTab(tab) {
            const loginForm = document.getElementById('loginForm');
            const registerForm = document.getElementById('registerForm');
            const loginTab = document.getElementById('loginTab');
            const registerTab = document.getElementById('registerTab');

            if (tab === 'login') {
                // Fade out register form
                registerForm.style.opacity = '0';
                registerForm.style.transform = 'translateX(20px)';
                
                setTimeout(() => {
                    registerForm.classList.add('hidden');
                    loginForm.classList.remove('hidden');
                    
                    // Fade in login form
                    setTimeout(() => {
                        loginForm.style.opacity = '1';
                        loginForm.style.transform = 'translateX(0)';
                    }, 50);
                }, 200);
                
                loginTab.classList.add('tab-active');
                loginTab.classList.remove('tab-inactive');
                registerTab.classList.remove('tab-active');
                registerTab.classList.add('tab-inactive');
            } else {
                // Fade out login form
                loginForm.style.opacity = '0';
                loginForm.style.transform = 'translateX(-20px)';
                
                setTimeout(() => {
                    loginForm.classList.add('hidden');
                    registerForm.classList.remove('hidden');
                    
                    // Fade in register form
                    setTimeout(() => {
                        registerForm.style.opacity = '1';
                        registerForm.style.transform = 'translateX(0)';
                    }, 50);
                }, 200);
                
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
