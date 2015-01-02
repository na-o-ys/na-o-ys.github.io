module Competition
  class CompetitionIndexPageGenerator < Jekyll::Generator
    safe true
    priority :normal

    def generate(site)
      contests = {}
      solutions = site.posts.select { |page| page.data['layout'] == 'competition' }
      solutions.sort_by { |page| page.date  }.reverse.each do |page|
        contest     = page.data['contest']
        competition = page.data['competition']
        contests[contest] ||= {}
        contests[contest][competition] ||= []
        contests[contest][competition] << page
      end

      solution_index = site.pages.detect {|page| page.path == 'competitions/index.html'}
      solution_index.data['contests'] = contests
    end
  end
end
