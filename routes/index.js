var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { 
  	layout: 'index',
  	title: 'Measuring Britain | Home' 
  });
});

module.exports = router;
