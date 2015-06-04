gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
coffee = require 'gulp-coffee'

gulp.task 'default', ['coffee']

gulp.task 'coffee', ->
  browserify(entries: ['./index.coffee'])
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe(source('./index.js'))
    .pipe(gulp.dest('./'))