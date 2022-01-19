require 'michel/outdated'
require 'bundler/audit/scanner'
require 'michel/csv_reporter'
require 'byebug'

module Michel
  module Scanner
    class << self
      Project = Struct.new(:outdated, :unpatched)
      Unpatched = Struct.new(:current, :active, :groups)

      def scan(directories)
        results = {}.tap do |projects|
          directories.each do |dir|
            @current_project = Project.new([], [])
            projects[File.basename(dir)] = @current_project
            scan_outdated(dir)
            scan_unpatched(dir)
          end
        end
        CsvReporter.report(results)
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

      def outdated(current, active, groups)
        @current_project.outdated << Unpatched.new(current, active, groups)
      end
    end
  end
end
