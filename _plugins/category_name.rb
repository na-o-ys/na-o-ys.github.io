module Jekyll
  class RenderCategoryNameTag < Liquid::Tag

    def initialize(tag_name, category, tokens)
      super
      @category = category
    end

    def render(context)
      puts context.registers[:site].config['category_map']['others']
      puts context.registers[:site].config['category_map'][@category.chomp]
      puts @category.length
      puts 'others'.length
      context.registers[:site].config['category_map'][@category] || @category
    end
  end
end

Liquid::Template.register_tag('category_name', Jekyll::RenderCategoryNameTag)
