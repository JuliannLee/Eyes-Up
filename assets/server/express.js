const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const fs = require('fs');
const port = 8000;
const ip = "192.168.0.102"; //SESUAIKAN IP DENGAN IPCONFIG DI CMD
const dataFile = 'data.json'; // The file to store data

app.use(express.json());

// Middleware to parse JSON data in requests
app.use(bodyParser.json());

// In-memory data storage (initialize with data from file)
let data = loadStoredData();

// To get the IP Address, go to CMD and type in IPCONFIG and copy the IPv4 IP Address and copy it to each GET, POST, PUT, DELETE protocols in each community page(VOLUNTEER AND DISABLED!!!
app.listen(port, ip,() => { 
  console.log(`Server is running on :${port}`);
});

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

// Handle PUT request to update data by ID
app.put('/data.json/:id', (req, res) => {
  const postId = req.params.id;
  const updatedData = req.body;

  // Find and update the data with the specified ID
  const postIndex = data.findIndex(post => post[0].id === postId); // Use post[0].id to access the ID
  if (postIndex !== -1) {
    data[postIndex][0] = updatedData; // Update the first element of the subarray
    saveDataToFile(data); // Save data to the file
    res.status(200).json({ message: 'Data updated successfully' });
  } else {
    res.status(404).json({ message: 'Post not found' });
  }
});

app.delete('/data.json/:id', (req, res) => {
  const postId = req.params.id;
  // Find and remove the post with the specified ID
  const postIndex = data.findIndex(post => post[0].id === postId);
  if (postIndex !== -1) {
    data.splice(postIndex, 1);
    saveDataToFile(data); // Save data to the file
    res.status(200).json({ message: 'Data deleted successfully' });
  } else {
    res.status(404).json({ message: 'Post not found' });
  }
});

// Load data from the file when the server starts
function loadStoredData() {
  if (fs.existsSync(dataFile)) {
    dataJson = fs.readFileSync(dataFile, 'utf8');
    return JSON.parse(dataJson);
  }
  return [];
}

// Save data to the file
function saveDataToFile(data) {
  dataJson = JSON.stringify(data, null, 2);
  fs.writeFileSync(dataFile, dataJson, 'utf8');
}
