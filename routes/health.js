var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.render('health', { 
  	layout: 'ui',
  	title: 'Measuring Britain | Health',
  	page_header: 'Health'
  });
});

module.exports = router;
