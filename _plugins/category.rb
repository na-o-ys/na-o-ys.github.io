module Category
  class CategoryPage < Jekyll::Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category_index.html')
      self.data['category'] = category

      category_title_prefix = site.config['category_title_prefix'] || 'Category: '
      self.data['title'] = "#{category_title_prefix}#{category}"
      self.data['posts'] = site.posts.select { |page| page.categories.include? category }
    end
  end

  class CategoryPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      if site.layouts.key? 'category_index'
        site.data['category_pages'] ||= {}
        dir = 'categories'
        site.categories.each_key do |category|
          category_page = CategoryPage.new(site, site.source, File.join(dir, category), category)
          site.pages << category_page
          site.data['category_pages'][category] = category_page
        end
      end
    end
  end
end
