const exec = require('child_process').exec;
const gulp = require('gulp');
const pump = require('pump');

const cleanCSS = require('gulp-clean-css');
const less = require('gulp-less');

const lessFiles = `${__dirname}/src/styles/*.less`;
const cssDest = `${__dirname}/static/styles`;

const shrink = () => pump(
	[ gulp.src(lessFiles), less(), cleanCSS(), gulp.dest(cssDest) ]
);

gulp.task('shrink', shrink);

gulp.task('default', [ 'shrink' ], () => {
	gulp.watch(lessFiles, [ 'shrink' ]);
});