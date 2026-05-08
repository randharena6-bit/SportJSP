const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const authRoutes = require('./src/routes/authRoutes');
const adminRoutes = require('./src/routes/adminRoutes');
const federationRoutes = require('./src/routes/federationRoutes');
const reportRoutes = require('./src/routes/reportRoutes');
const athleteRoutes = require('./src/routes/athleteRoutes');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors({
  origin: ['http://localhost:8080', 'http://localhost:8081', 'http://localhost:9090', 'http://127.0.0.1:8080', 'http://127.0.0.1:8081', 'http://127.0.0.1:9090'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/federations', federationRoutes);
app.use('/api/reports', reportRoutes);
app.use('/api/athlete', athleteRoutes);

// Health check route
app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: 'SPORT CONNECT Backend API is running',
    timestamp: new Date().toISOString()
  });
});

// Root route
app.get('/', (req, res) => {
  res.json({
    message: 'SPORT CONNECT Backend API',
    version: '1.0.0',
    endpoints: {
      auth: '/api/auth',
      admin: '/api/admin',
      federations: '/api/federations',
      reports: '/api/reports',
      athlete: '/api/athlete',
      health: '/health'
    },
    documentation: {
      admin: {
        users: '/api/admin/users',
        stats: '/api/admin/stats',
        auditLogs: '/api/admin/audit-logs',
        roles: '/api/admin/roles'
      },
      federations: {
        list: '/api/federations',
        clubs: '/api/federations/clubs',
        licenses: '/api/federations/licenses'
      },
      reports: {
        dashboard: '/api/reports/dashboard',
        users: '/api/reports/users',
        licenses: '/api/reports/licenses',
        financial: '/api/reports/financial',
        athletes: '/api/reports/athletes',
        export: '/api/reports/export'
      },
      athlete: {
        dashboard: '/api/athlete/dashboard',
        profile: '/api/athlete/profile',
        licenses: '/api/athlete/licenses',
        competitions: '/api/athlete/competitions',
        health: '/api/athlete/health',
        media: '/api/athlete/media',
        notifications: '/api/athlete/notifications'
      }
    }
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ 
    success: false, 
    message: 'Route non trouvée' 
  });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    success: false, 
    message: 'Erreur serveur interne' 
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📡 API available at http://localhost:${PORT}`);
  console.log(`🏥 Health check at http://localhost:${PORT}/health`);
});

module.exports = app;
