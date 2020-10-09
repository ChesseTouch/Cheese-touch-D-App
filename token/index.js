// in node.js use: 
var Web3 = require('web3');

// var web3js = new Web3(web3.currentProvider);

var web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");


const http = require('http');
const express = require('express');
const path = require('path');
const app = express();
app.use(express.json());
app.use(express.static("express"));
// default URL for website
app.use('/', function(req,res){
    res.sendFile(path.join(__dirname+'/index.html'));
    //__dirname : It will resolve to your project folder.
  });
const server = http.createServer(app);
const port = 8545;
server.listen(port);
console.debug('Server listening on port ' + port);

