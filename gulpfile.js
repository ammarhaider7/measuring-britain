var gulp = require('gulp'),
    sass = require('gulp-sass'),
    minifycss = require('gulp-minify-css'),
    rename = require('gulp-rename');

gulp.task('express', function() {
  var express = require('express');
  var app = express();
  app.use(express.static(__dirname));
  app.use(express.static('./css'));
  app.listen(4000);
});

gulp.task('sass', function () {
  gulp.src('./sass/**/*.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./css'));
});

gulp.task('sass:watch', function () {
  gulp.watch('./sass/**/*.scss', ['sass']);
});

gulp.task('default', ['express', 'sass', 'sass:watch'], function() {

});