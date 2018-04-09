const exec = require('child_process').exec;
const gulp = require('gulp');
const pump = require('pump');

const cleanCSS = require('gulp-clean-css');
const less = require('gulp-less');

const styleSources = `${__dirname}/src/styles`;
const rbStyles = `${styleSources}/experimental/*.rb`;
const lessFiles = `${styleSources}/*.less`;
const cssDest = `${__dirname}/static/styles`;

const shrink = () => pump(
	[ gulp.src(lessFiles), less(), cleanCSS(), gulp.dest(cssDest) ]
);

gulp.task('shrink', shrink);

const transpose = (chObj) => {
	exec(`ruby ${chObj.path}`);
};

const rbStyleWatcher = gulp.watch(rbStyles)
rbStyleWatcher.on('change', transpose);

gulp.task('default', [ 'shrink' ], () => {
	gulp.watch(lessFiles, [ 'shrink' ]);
});