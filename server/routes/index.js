var express = require('express');
var router = express.Router();
const assets = require('../../client/dist/webpack.assets.json');
const commonJs = assets.common.js;
const commonCss = assets.common.css;

/* GET home page. */
router.get('/', (req, res) => {
	res.render('index', { 
		title: 'Webpack-app',
		name: 'I am a server-side react component',
		env: req.app.locals.am_env,
		jsFile: assets.bundle.js,
		cssFile: assets.bundle.css,
		commonJs,
		commonCss
	});
});

router.get('/x', (req, res) => {
  res.render('x', { 
	title: 'x Express',
	name: 'Ammar X',
	jsFile: assets.xBundle.js,
	cssFile: assets.xBundle.css,
	commonJs,
	commonCss
  });
});

module.exports = router;