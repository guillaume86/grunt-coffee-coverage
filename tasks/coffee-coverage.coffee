cc = require('coffee-coverage')
fs = require('fs')

module.exports = (grunt) ->

  grunt.registerMultiTask 'coffeecover', ->
    options = @options()

    try
      grunt.log.writeln 'Instrumenting files using coffee-coverage'
      coverageInstrumentor = new cc.CoverageInstrumentor()

      if options.verbose
          coverageInstrumentor.on "instrumentingFile", (sourceFile, outFile) ->
              grunt.log.writeln "    #{sourceFile} to #{outFile}"
          coverageInstrumentor.on "instrumentingDirectory", (sourceDir, outDir) ->
              grunt.log.writeln "Instrumenting directory: #{sourceDir} to #{outDir}"
          coverageInstrumentor.on "skip", (file) ->
              grunt.log.writeln "    Skipping: #{file}"

      # Change initFile into a output stream
      if options.initfile
          options.initFileStream = fs.createWriteStream options.initfile

      result = 
        lines: 0

      this.files.forEach (f) ->
        result = coverageInstrumentor.instrument f.src, f.dest, options

      options.initFileStream?.end()
      grunt.log.writeln "Annotated #{result.lines} lines."

    catch err
      grunt.log.error err
      return false