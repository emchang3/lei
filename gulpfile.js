const gulp = require('gulp');
const uglify = require('gulp-uglify');
const pump = require('pump');
const cleanCSS = require('gulp-clean-css');

const jsSrc = `${__dirname}/src/scripts`;
const jsDest = `${__dirname}/static/scripts`;
const jsFiles = `${jsSrc}/*.js`;

const cssSrc = `${__dirname}/src/styles`;
const cssDest = `${__dirname}/static/styles`;
const cssFiles = `${cssSrc}/*.css`;

const minify = () => pump(
  [ gulp.src(jsFiles), uglify(), gulp.dest(jsDest) ]
);

gulp.task('minify', minify);

const shrink = () => pump(
	[ gulp.src(cssFiles), cleanCSS(), gulp.dest(cssDest) ]
);

gulp.task('shrink', shrink);

gulp.task('default', [ 'minify', 'shrink' ], () => {
	gulp.watch(jsFiles, [ 'minify' ]);
	gulp.watch(cssFiles, [ 'shrink' ]);
});