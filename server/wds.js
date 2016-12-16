/*WebPack Dev Server*/

console.log('creating WebpackDevServer');
var webpack = require('webpack');
var config = require('../config/webpack.dev.config');
var WebpackDevServer = require('webpack-dev-server');

var wds = new WebpackDevServer(webpack(config));

// run webpack dev server
wds.listen(8080, 'localhost', function() {
	console.log('WebpackDevServer bundling, please wait...');
});