var express = require('express');
var router = express.Router();
var data = require('../views/data/ui/demographics.js');

router.get('/', function(req, res, next) {
  res.render('demographics', { 
  	layout: 'ui',
  	data: data,
  	title: 'MB App | Demographics',
  	page_header: 'Demographics'
  });
});

module.exports = router;