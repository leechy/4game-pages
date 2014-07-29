var gulp = require('gulp'),
    minifycss = require('gulp-minify-css'),
    csscomb = require('gulp-csscomb'),
    autoprefixer = require('gulp-autoprefixer'),
    concat = require('gulp-concat'),
    less = require('gulp-less'),
    path = require('path');

gulp.task('css', function() {
    return gulp.src(['css/b/**/*', 'css/b/*'])
        .pipe(concat('css/styles.less'))
        .pipe(less({ compress: true }))
        .pipe(csscomb())
        .pipe(autoprefixer("last 2 version"))
        .pipe(gulp.dest(''));
});

gulp.task('default', function() {
    gulp.run('css');

    gulp.watch('css/b/**/*', ['css']);
});