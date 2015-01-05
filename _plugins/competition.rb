require 'active_support'
require 'active_support/core_ext'

class String
  def to_path
    self.underscore.tr(' ', '_')
  end
end

module Competition
  class CompetitionPageGenerator < Jekyll::Generator
    priority :high

    def generate(site)
      site.posts.select {|page| page.data['layout'] == 'competition'}.each do |page|
        contest     = page.data['contest']
        competition = page.data['competition']
        type        = page.data['problem_type']
        name        = page.data['problem_name']
        page.data['contest_url'] = "/#{contest.to_path}/"
        page.data['title_sub'] =
          [contest, competition].compact.join(" ")
        if type.present?
          page.data['title_main'] = "#{type}: #{name}"
        else
          page.data['title_main'] = name
        end
        page.data['title'] =
          "#{contest} #{competition} #{type}: #{name}"
      end
    end
  end
end
