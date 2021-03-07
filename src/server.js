"use strict";
exports.__esModule = true;
var express_1 = require("express");
var dotenv = require("dotenv");
dotenv.config();
var app = express_1["default"]();
var port = process.env.PORT || 3000;
app.get('/', function (req, res) {
    res.send({ msg: 'Hello World' });
});
app.listen(port, function () {
    console.log("Server running on port " + port + "...");
});
