const express = require('express');
const router = express.Router();
const axios = require('axios');

router.post('/ai-predict', async (req, res) => {
  try {
    const { description, deadline, priority } = req.body;

    if (!description) {
      return res.status(400).json({ error: "Missing 'description' in request" });
    }

    const response = await axios.post('http://localhost:5000/predict', {
      description,
      deadline,
      priority
    }, {
      headers: {
        'Content-Type': 'application/json'
      }
    });

    res.json(response.data);
  } catch (err) {
    console.error('Error connecting to Flask AI service:', err.message);
    res.status(500).json({ error: 'Failed to connect to AI microservice' });
  }
});

module.exports = router;
