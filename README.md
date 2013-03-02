GRUNT COFFEE-COVERAGE
=====================

exemple for .coffee files in src/ directory and output instrumented js files in lib-cov/

    grunt.initConfig

      coffeecover:
        options:
          verbose: true
        lib:
          src: 'src/'
          dest: 'lib-cov/'

    grunt.registerTask 'cover', ['coffeecover:lib']