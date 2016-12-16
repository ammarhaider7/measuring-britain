const webpack = require('webpack');
const path = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const webpackFactory = require('./webpack.factory.config');
const entries = require('./webpack.entries');
// Build folder
const publicPath = path.resolve('client/dist');

module.exports = webpackFactory({

    env: 'production',
    entries: entries,
    output: {
        path: publicPath,
        filename: '[name].[chunkhash].js',
        // This is used for require.ensure
        chunkFilename: '[chunkhash].js',
        publicPath: '/'
    },
    extraProps: {},
    // devtool: 'source-map',
    plugins: [
        new ExtractTextPlugin('[name].[chunkhash].css'),
        new webpack.optimize.UglifyJsPlugin({
            compress: {
            warnings: false,
                // Drop `console` statements
                drop_console: true
            }
        }),
        new CleanWebpackPlugin([publicPath], {
            // Without `root` CleanWebpackPlugin won't point to our
            // project and will fail to work.
            root: process.cwd()
        })
    ]

});