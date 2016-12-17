const express = require('express');
const router = express.Router();
const assets = require('../../client/dist/webpack.assets.json');
const commonJs = assets.common.js;
const commonCss = assets.common.css;

/* GET home page. */
router.get('/', (req, res) => {
	res.render('index', { 
		title: 'Measuring Britain | Home',
		env: req.app.locals.am_env,
		jsFile: assets.indexBundle.js,
		cssFile: assets.indexBundle.css,
		commonJs,
		commonCss
	});
});

router.get('/about', (req, res) => {
  res.render('about', { 
	title: 'Measuring Britain | About',
	jsFile: assets.aboutBundle.js,
	cssFile: assets.aboutBundle.css,
	commonJs,
	commonCss
  });
});

module.exports = router;