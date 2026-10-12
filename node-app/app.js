const express = require('express');
const _ = require('lodash');

const app = express();

app.get('/', (req, res) => {
  res.send('Hello from my DevSecOps lab!');
});

// Planted flaw for Phase 8: user input goes straight into the page (XSS).
app.get('/hello', (req, res) => {
  res.send('Hello ' + req.query.name);
});

app.listen(3000, () => {
  console.log('App running on port 3000');
});