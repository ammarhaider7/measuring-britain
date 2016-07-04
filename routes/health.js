var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.render('health', { 
  	layout: 'ui',
  	title: 'Measuring Britain | Health',
  	page_header: 'Health'
  });
});

// Avoidable deaths
router.get('/avoidable-deaths-environmental', function(req, res, next) {
	res.render('react-container', { 
		layout: 'ui2',
		title: 'Measuring Britain | Health | Avoidable deaths (environmental)',
		page_header: 'Avoidable deaths (environmental) - 2014'
	});
});

module.exports = router;