require 'thor'
require 'michel/scanner'

module Michel
  class CLI < Thor
    desc 'scan [<directories>...]',
         'scan the lockfiles in the directories'
    def scan(*directories)
      Scanner.scan(directories.map { |d| File.expand_path(d) })
    end
  end
end
