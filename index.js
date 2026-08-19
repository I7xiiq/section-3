const express = require('express');

//init app
const app = express();
const PORT = 4000 // add port 

app.get('/', (req, res) => res.send('<h1> Hello Docker!</h1>'));

app.listen(PORT, () => console.log(`app is up and running in port : ${PORT}`) ); 