require 'bundler/cli/outdated'

module Michel
  class Outdated < Bundler::CLI::Outdated
    def initialize(dir, scanner)
      ENV['BUNDLE_GEMFILE'] = File.join(dir, 'Gemfile')
      Bundler.reset!
      @scanner = scanner
      super({}, [])
    end

    def exit(_); end

    def print_gem(newest_spec, active_spec, dependency, _, _)
      @scanner.send :outdated, newest_spec, active_spec, dependency
    end
  end
end
