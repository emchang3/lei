const gulp = require('gulp');
const pump = require('pump');

const cleanCSS = require('gulp-clean-css');
const less = require('gulp-less');
const uglify = require('gulp-uglify');

const jsFiles = `${__dirname}/src/scripts/*.js`;
const jsDest = `${__dirname}/static/scripts`;

const lessFiles = `${__dirname}/src/styles/*.less`;
const cssDest = `${__dirname}/static/styles`;

const minify = () => pump(
	[ gulp.src(jsFiles), uglify(), gulp.dest(jsDest) ]
);

gulp.task('minify', minify);

const shrink = () => pump(
	[ gulp.src(lessFiles), less(), cleanCSS(), gulp.dest(cssDest) ]
);

gulp.task('shrink', shrink);

gulp.task('default', [ 'minify', 'shrink' ], () => {
	gulp.watch(jsFiles, [ 'minify' ]);
	gulp.watch(lessFiles, [ 'shrink' ]);
});