const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const webpackFactory = require('./webpack.factory.config');
const raw_entries = require('./webpack.entries');
var CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');

// Append dev server items to entries array items
let entries, key, value, wdsLocal;

wdsLocal = 'webpack-dev-server/client?http://localhost:8080';
entries = {};

for (key in raw_entries) {
    value = raw_entries[key];
    entries[key] = [value, wdsLocal];
}

module.exports = webpackFactory({

    env: 'development',
    entries: entries,
    output: {
        path: path.resolve('client/dist'),
        filename: '[name].js',
        publicPath: '/dist/'
    },
    devtool: 'eval-source-map',
    extraProps: {
        devServer: {
            contentBase: path.resolve('./client/src'),
            hot: true,
            open: true
        }
    },
    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new ExtractTextPlugin('[name].css'),
        new webpack.LoaderOptionsPlugin({
            debug: true
        }),
        new CopyWebpackPlugin([{
            from: path.resolve('node_modules/reload/lib/reload-client.js'),
            to: path.resolve('client/dist')
        }]),
    ]

});