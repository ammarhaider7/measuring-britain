require('newrelic');
var express = require('express');
var compress = require('compression');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var routes = require('./routes/index');
var landing = require('./routes/landing');
var demographics = require('./routes/demographics');
var health = require('./routes/health');
var census = require('./routes/census');
var about = require('./routes/about');

var app = express();

var exphbs = require('express-handlebars');

// Create `ExpressHandlebars` instance with a default layout.
var hbs = exphbs.create({
    // defaultLayout: 'main',
    partialsDir: [
      'views/partials/'
    ]
});

// view engine setup
app.engine('handlebars', hbs.engine);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'handlebars');

// uncomment after placing your favicon in /public
app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(compress());
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/landing', landing);
app.use('/demographics', demographics);
app.use('/health', health);
app.use('/census', census);
app.use('/about', about);

// catch 404 and forward to error handler
// Ammar's note: Acts as a catch-all for 'unrouted' pages because the above routes will execute first
app.use(function (req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers
// console.log('NODE_ENV = ' + app.get('env'));

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function (err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
