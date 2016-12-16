console.log('running app-dev.js');

require('babel-register')({
  presets: ['react', 'es2015']
});

const express = require('express');
var url = require('url');
var proxy = require('proxy-middleware');
// var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var routes = require('./routes/index');

var app = express();

// set local app var to denote this is a dev app
app.locals.am_env = 'dev';

// view engine setup
var options = {
  transformViews: false
}
app.engine('jsx', require('express-react-views').createEngine(options));
app.set('views', __dirname + '/views');
app.set('view engine', 'jsx');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use('/dist', proxy(url.parse('http://localhost:8080/')));

app.use('/', routes);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;