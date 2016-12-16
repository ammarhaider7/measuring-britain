const ExtractTextPlugin = require('extract-text-webpack-plugin');
const path = require('path');
const boostrapDir = path.resolve('node_modules/bootstrap-sass/assets');
const pureCssDir = path.resolve('node_modules/purecss');
const srcDir = path.resolve('client/src');
const includeDirs = [srcDir, pureCssDir, boostrapDir];

module.exports = [{
	// SASS
	test: /\.scss$/,
	include: includeDirs,
	loader: ExtractTextPlugin.extract({
		fallbackLoader: 'style-loader', 
		loader: ['css-loader', 'sass-loader']
	})

}, {
	// CSS
	test: /\.css$/,
	include: includeDirs,
	loader: ExtractTextPlugin.extract({ fallbackLoader: 'style-loader', loader: [ { loader: 'css-loader'} ] })

}, {
	// JSX (react) & JS
	test: /\.jsx?$/,
	include: includeDirs,
	loader: 'babel-loader',
	options: {
		presets: ['es2015', 'react', 'stage-0']
	}
}, {
	// CoffeeScript
	test: /\.coffee$/,
	include: includeDirs,
	loader: 'coffee-loader'
}, {
	// CJSX
	test: /\.cjsx$/,
	include: includeDirs,
	loader: 'coffee-jsx-loader'

}, {
	// JPG and PNG (images)
	test: /\.(jpg|png)$/,
	loader: [
		// file-loader will then take require statements to image paths and create image files
		'file-loader?name=[path][name].[hash].[ext]',
		// image-webpack will compress the images first
		'image-webpack-loader?bypassOnDebug&optimizationLevel=7&interlaced=false'
	],
	include: includeDirs

}, {
	test: /\.svg$/,
	loader: 'file-loader',
	include: includeDirs
}, {
	// WOFF (fonts)
	test: /\.woff2?$/,
	// Inline small woff files and output them below font/.
	// Set mimetype just in case.
	loader: 'url-loader',
	options: {
		name: 'font/[hash].[ext]',
		limit: 5000,
		mimetype: 'application/font-woff'
	},
	include: includeDirs

}, {
	// TTF and EOT (fonts)
	test: /\.ttf$|\.eot$/,
	loader: 'file-loader',
	options: {
		name: 'font/[hash].[ext]'
	},
	include: includeDirs

}];