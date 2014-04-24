var gulp = require("gulp"),
		gutil = require("gulp-util"),
		coffee = require("gulp-coffee"),
		coffeelint = require("gulp-coffeelint"),
		mocha = require("gulp-mocha");

gulp.task("coffee", function () {
	gulp.src("./src/**/*.coffee")
		.pipe(coffee({bare: true}).on("error", gutil.log))
    .pipe(gulp.dest("./lib/"))		
});

gulp.task("coffee-test", function () {
	gulp.src("./test/**/*.coffee")
		.pipe(coffee({bare: true}).on("error", gutil.log))
    .pipe(gulp.dest("./test"))		
});

gulp.task("lint", function () {
	gulp.src(["./src/*.coffee", "./test/*.coffee"])
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
});

gulp.task("test", function () {
  gulp.src("test/*.js")
    .pipe(mocha({reporter: "spec"}));
});

gulp.task("default", function () {
	gulp.run("lint");
  	gulp.run("coffee");
	gulp.run("coffee-test");

	gulp.watch(["./src/**/*.coffee","./test/**/*.coffee"], function() {
		gulp.run("lint");
    gulp.run("coffee");
    gulp.run("coffee-test");
    gulp.run("test");
  });
});