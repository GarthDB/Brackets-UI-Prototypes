module.exports = function(grunt) {
  
  // Project configuration.
  grunt.initConfig({
    coffeeFiles: ['js/*.coffee', '!node_modules/**'],
    jadeFiles: ['index.jade'],
    stylusFiles: ['css/*.styl', '!node_modules/**'],
    watch: {
      coffeeScripts: {
        files: '<config:coffeeFiles>',
        tasks: 'coffee'
      }, 
      jadeScripts: {
        files: '<config:jadeFiles>',
        tasks: 'jade'
      },
      stylusScripts: {
        files: '<config:stylusFiles>',
        tasks: 'stylus'
      }
    },
    server: {
      port: 8080,
      base: './'
    },
    coffee: {
      compile: {
        files: {
          'js/*.js': '<config:coffeeFiles>'
        }
      },
    },
    jade: {
      options: {
        pretty: true
      },
      compile: {
        files: {
          'index.html': '<config:jadeFiles>'
        }
      }
    },
    stylus: {
      compile: {
        files: {
          'css/*.css': '<config:stylusFiles>'
        }
      },
    }
  });
  
  grunt.loadNpmTasks('grunt-contrib');
  grunt.loadNpmTasks('grunt-reload');
  
  // Default task.
  grunt.registerTask('default', ['coffee', 'jade', 'stylus']);

};