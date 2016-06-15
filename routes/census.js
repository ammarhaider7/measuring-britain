var express = require('express');
var router = express.Router();

// GET census home
router.get('/', function(req, res, next) {
  res.render('census', { 
  	layout: 'home',
  	title: 'MB App | Census',
  	page_header: 'Census'
  });
});

// Population pyramid
router.get('/population-pyramid', function(req, res, next) {
  res.render('react-container', { 
  	layout: 'ui2',
  	title: 'MB App | Census | Population Pyramid',
  	page_header: 'Population Pyramid - Census'
  });
});

// Ethnic diversity
router.get('/ethnic-diversity', function(req, res, next) {
  res.render('react-container', { 
  	layout: 'ui2',
  	title: 'MB App | Census | Ethnic Diversity',
  	page_header: 'Ethnic Diversity - Census'
  });
});

// Religious Diversity
router.get('/religious-diversity', function(req, res, next) {
  res.render('react-container', { 
  	layout: 'ui2',
  	title: 'MB App | Census | Religious Diversity',
  	page_header: 'Religious Diversity - Census'
  });
});

// Ethnic diversities in general health
router.get('/ethnic-disparities-general-health', function(req, res, next) {
  res.render('react-container', { 
    layout: 'ui2',
    title: 'MB App | Census | Ethnic Disparities in General Health',
    page_header: 'Ethnic Disparities in General Health - Census'
  });
});

// Long term illness/disability by ethnicity
router.get('/longterm-illness-disability-by-ethnicity', function(req, res, next) {
  res.render('react-container', { 
    layout: 'ui2',
    title: 'MB App | Census | Long-term illness or disability by ethnicity',
    page_header: 'Long-term illness or disability by ethnicity'
  });
});

module.exports = router;