var express = require('express');
var router = express.Router();
var data = require('../views/data/ui/demographics.js');

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.render('demographics', { 
  	layout: 'ui',
  	data: data,
  	title: 'MB App | Demographics'
  });
});

module.exports = router;
