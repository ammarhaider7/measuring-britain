var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('about', { 
  	layout: 'home',
  	title: 'Measuring Britain | About' 
  });
});

module.exports = router;
