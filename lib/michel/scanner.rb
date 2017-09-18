require 'michel/outdated'
require 'bundler/audit/scanner'
require 'michel/reporter'

module Michel
  module Scanner
    class << self
      Project = Struct.new(:outdated, :unpatched)
      Unpatched = Struct.new(:newest, :current, :dependency)

      def scan(directories)
        results = {}.tap do |projects|
          directories.each do |dir|
            @current_project = Project.new([], [])
            projects[File.basename(dir)] = @current_project
            scan_outdated(dir)
            scan_unpatched(dir)
          end
        end
        Reporter.report(results)
      end

      private

      def scan_outdated(dir)
        Outdated.new(dir, self).run
      end

      def scan_unpatched(dir)
        Bundler::Audit::Database.update!(quiet: true)
        Bundler::Audit::Scanner.new(dir).scan_specs do |unpatched|
          @current_project.unpatched << unpatched
        end
      end

      def outdated(newest, current, dependency)
        @current_project.outdated << Unpatched.new(newest, current, dependency)
      end
    end
  end
end
