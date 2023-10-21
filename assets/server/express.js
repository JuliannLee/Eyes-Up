const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const fs = require('fs');
const port = 8000;
const dataFile = 'data.json'; // The file to store data

// Middleware to parse JSON data in requests
app.use(bodyParser.json());

// In-memory data storage (initialize with data from file)
let data = loadStoredData();

// GET route to retrieve data
app.get('/data.json', (req, res) => {
  res.status(200).json(data);
});

// POST route to store data
app.post('/data.json', (req, res) => {
  const newData = req.body;
  data.push(newData);
  saveDataToFile(data); // Save data to the file
  res.status(200).json({ message: 'Data saved successfully' });
});

app.put('/data.json/:id', (req, res) => {
  const updatedData = req.body; // The request should contain the updated data
  const postId = req.params.id; // Get the post ID from the URL parameter

  // Find the index of the post to update by comparing IDs
  const index = data.findIndex((item) => item.id === postId);

  if (index === -1) {
    res.status(404).json({ message: 'Post not found' });
  } else {
    // Update the post in the data array
    data[index] = { ...data[index], ...updatedData };
    saveDataToFile(data); // Save updated data to the file
    res.status(200).json({ message: 'Data updated successfully' });
  }
});
app.listen(port, () => {
  console.log(`Server is running on :${port}`);
});

// Load data from the file when the server starts
function loadStoredData() {
  if (fs.existsSync(dataFile)) {
    const dataJson = fs.readFileSync(dataFile, 'utf8');
    return JSON.parse(dataJson);
  }
  return [];
}

// Save data to the file
function saveDataToFile(data) {
  const dataJson = JSON.stringify(data, null, 2);
  fs.writeFileSync(dataFile, dataJson, 'utf8');
}
