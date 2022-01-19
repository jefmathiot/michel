require 'bundler/cli/outdated'

module Michel
  class Outdated < Bundler::CLI::Outdated
    def initialize(dir, scanner)
      ENV['BUNDLE_GEMFILE'] = File.join(dir, 'Gemfile')
      Bundler.reset!
      @scanner = scanner
      super({parseable: true, groups: true}, [])
    end

    def exit(_); end

    def print_gem(current_spec, active_spec, dependency, groups)
      @scanner.send :outdated, current_spec, active_spec, groups
    end
  end
end
