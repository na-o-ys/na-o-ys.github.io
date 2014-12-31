module Commentary

  class ContestIndexPage < Jekyll::Page
    def initialize(site, contest, competitions)
      @site = site
      @base = site.source
      @dir = "/#{contest.to_path}/"
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(@base, '_layouts'), 'contest_index.html')
      self.data['contest'] = contest
      self.data['contest_url'] = "/#{contest.to_path}/"
      self.data['competitions'] = competitions
      self.data['title'] = contest
    end
  end

  class CompetitionIndexPage < Jekyll::Page
    def initialize(site, contest, competition, problems)
      @site = site
      @base = site.source
      @dir = "/#{contest.to_path}/#{competition.to_path}/"
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(@base, '_layouts'), 'competition_index.html')
      self.data['contest'] = contest
      self.data['contest_url'] = "/#{contest.to_path}/"
      self.data['competition'] = competition
      self.data['competition_url'] = "/#{contest.to_path}/#{competition.to_path}/"
      self.data['problems'] = problems
      self.data['title'] = "#{contest} #{competition}"
    end
  end

  class IndexPageGenerator < Jekyll::Generator
    safe true
    priority :normal

    def generate(site)
      contests = {}
      site.posts.select {|page| page.data['type'] == 'commentary'}.each do |page|
        contest     = page.data['contest']
        competition = page.data['competition']
        page_attrs = {
          'type'      => page.data['problem_type'],
          'name'      => page.data['problem_name'],
          'permalink' => page.data['permalink']
        }
        contests[contest] ||= {}
        contests[contest][competition] ||= []
        contests[contest][competition] << page_attrs
      end

      commentary_index = site.pages.detect {|page| page.name == 'commentary_index.html'}
      commentary_index.data['contests'] = contests
      site.data['solution_index'] = commentary_index

      contests.each do |contest, competitions|
        site.pages << ContestIndexPage.new(site, contest, competitions)
        competitions.each do |competition, problems|
          site.pages << CompetitionIndexPage.new(site, contest, competition, problems)
        end
      end
    end
  end

end
