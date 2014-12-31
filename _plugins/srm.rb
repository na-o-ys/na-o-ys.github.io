require 'active_support'
require 'active_support/core_ext'

class String
  def to_path
    self.underscore.tr(' ', '_')
  end
end

module SRM
  class SRMGenerator < Jekyll::Generator
    priority :high

    def generate(site)
      site.posts.select {|page| page.data['type'] == 'commentary'}.each do |page|
        contest     = page.data['contest']
        competition = page.data['competition']
        type        = page.data['problem_type']
        name        = page.data['problem_name']
        page.data['contest_url'] = "/#{contest.to_path}/"
        page.data['competition_url'] = "/#{contest.to_path}/#{competition.to_path}/"
        page.data['title'] =
          "#{contest} #{competition} #{type}, #{name}"
        page.data['permalink'] =
          "/#{contest.to_path}/#{competition.to_path}/#{name.to_path}.html"
      end
    end
  end
end
