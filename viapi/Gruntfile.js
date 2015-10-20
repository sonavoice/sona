module.exports = function(grunt) {

  grunt.initConfig({

    jshint: {
      files: [
      'src/**/*.js'
      ],
    },

    mochaTest: {
      test: {
        options: {
          reporter: 'spec'
        },
        src: ['test/**/*.js']
      }
    },

    watch: {
      scripts: {
        files: [
          'src/**/*.js',
          'test/**/*.js'
        ],
        tasks: [
          'jshint',
          'mochaTest'
        ]
      }
    }

  });

  grunt.loadNpmTasks('grunt-notify');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');


  grunt.registerTask('default', [
    'watch'
  ]);
};