gulp = require('gulp')
coffee = require('gulp-coffee')

# Coffee
gulp.task 'coffee', (done) ->
	gulp.src './src/**/*.coffee', base: 'src'
		.pipe coffee {}
		.pipe gulp.dest './dist'

# Watcher
gulp.task 'watch', (done) ->
	gulp.watch './src/**/*.coffee', ['coffee']
