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
		jsFile: assets.bundle.js,
		cssFile: assets.bundle.css,
		commonJs,
		commonCss
	});
});

router.get('/about', (req, res) => {
  res.render('about', { 
	title: 'Measuring Britain | About',
	jsFile: assets.xBundle.js,
	cssFile: assets.xBundle.css,
	commonJs,
	commonCss
  });
});

module.exports = router;