


// const express = require('express');
// require('dotenv').config();
// const db = require('./db'); // MongoDB connection
// const passport=require('./auth');
// const app = express();
// const cors = require('cors');
// const bodyParser = require('body-parser');
// const LocalStrategy=require('passport-local').Strategy;
//  const User=require('./models/user');

// const PORT = process.env.PORT || 3000;
// app.use(cors())
// app.use(express.json());

// //app.use(bodyParser.json());
// //middle ware to remove problem
// app.use((err, req, res, next) => {
//   if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
//     console.error('Bad JSON:', err.message);
//     return res.status(400).json({ error: 'Invalid JSON format' });
//   }
//   next();
// });


// const logRequest = (req, res, next) => {
//   console.log(`${new Date().toLocaleString()} - Request made to: ${req.originalUrl}`);
//   next();
// };

// //Apply the middleware globally
// app.use(logRequest);
// app.use(passport.initialize());
// // Route
// const localAuthmiddleware = passport.authenticate('local',{session:false});

// app.get('/', (req, res) => {
//   res.send('Welcome to Smart Task Management!');
// });

// const userRoutes = require('./routes/userRoutes');
// app.use('/',userRoutes); // Now correct ✅
// //,localAuthmiddleware 

// const taskRoutes = require('./routes/taskRoutes');
// app.use('/',taskRoutes);
// const aiRoutes = require('./routes/ai');
// app.use('/api', aiRoutes);

// app.listen(PORT, () => {
//   console.log(`🚀 Server is listening on port ${PORT}`);
// });


const express = require('express');
require('dotenv').config();
const db = require('./db'); // MongoDB connection
const passport = require('./auth');
const cors = require('cors');
const bodyParser = require('body-parser');
const LocalStrategy = require('passport-local').Strategy;
const User = require('./models/user');

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json()); // Parses incoming JSON requests

// Optional: If you plan to support form-data, include this
app.use(bodyParser.urlencoded({ extended: false }));

// Syntax error handling for JSON
app.use((err, req, res, next) => {
  if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
    console.error('Bad JSON:', err.message);
    return res.status(400).json({ error: 'Invalid JSON format' });
  }
  next();
});

// Log every request
const logRequest = (req, res, next) => {
  console.log(`${new Date().toLocaleString()} - Request to: ${req.method} ${req.originalUrl}`);
  next();
};
app.use(logRequest);

// Initialize Passport
app.use(passport.initialize());

// Default route
app.get('/', (req, res) => {
  res.send('🚀 Welcome to Smart Task Management!');
});

// Routes
app.use('/', require('./routes/userRoutes')); // Auth/User routes
app.use('/', require('./routes/taskRoutes')); // Task CRUD
//app.use('/api', require('./routes/ai'));      // AI Routes for recommendations/scheduling

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Server is running on http://localhost:${PORT}`);
});

