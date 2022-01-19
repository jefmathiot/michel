require 'csv'

module Michel
  module CsvReporter
    class << self
      def report(results)
        results.keys.each do |project_key|
          puts project_key
          CSV.open("#{project_key}_outdated.csv", "wb") do |csv|
            results[project_key].outdated.each do |v|
              csv << [
                v.current.name,
                v.active.version.to_s,
                v.current.version.to_s,
                v.groups.to_s,
              ]
            end
          end
          CSV.open("#{project_key}_unpatched.csv", "wb") do |csv|
            results[project_key].unpatched.each do |v|
              csv << [
                v.gem.name,
                v.gem.version.to_s,
                v.advisory.id,
                v.advisory.title,
                v.advisory.url,
                v.advisory.cvss_v3 || v.advisory.cvss_v2,
                v.advisory.patched_versions.map(&:to_s).join(', '),
              ]
            end
          end
        end
      end
    end
  end
end
