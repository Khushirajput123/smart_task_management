


const express = require('express');
require('dotenv').config();
const db = require('./db'); // MongoDB connection
const passport=require('./auth');
const app = express();
const bodyParser = require('body-parser');
const LocalStrategy=require('passport-local').Strategy;
 const User=require('./models/user');

const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());
//middle ware to remove problem
app.use((err, req, res, next) => {
  if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
    console.error('Bad JSON:', err.message);
    return res.status(400).json({ error: 'Invalid JSON format' });
  }
  next();
});


const logRequest = (req, res, next) => {
  console.log(`${new Date().toLocaleString()} - Request made to: ${req.originalUrl}`);
  next();
};

//Apply the middleware globally
app.use(logRequest);
app.use(passport.initialize());
// Route
const localAuthmiddleware = passport.authenticate('local',{session:false});

app.get('/', (req, res) => {
  res.send('Welcome to Smart Task Management!');
});

const userRoutes = require('./routes/userRoutes');
app.use('/', localAuthmiddleware,userRoutes); // Now correct ✅
//,localAuthmiddleware 

const taskRoutes = require('./routes/taskRoutes');
app.use('/',taskRoutes);
const aiRoutes = require('./routes/ai');
app.use('/api', aiRoutes);

app.listen(PORT, () => {
  console.log(`🚀 Server is listening on port ${PORT}`);
});



