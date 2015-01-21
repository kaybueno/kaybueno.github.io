module Jekyll

  module TagFilter
    def unbreak_spaces(str)
      return str.gsub(' ', '&nbsp;')
    end

    def make_tag_links(tags)
      return tags.map{ |tag|
        "<a class='tag' href='/tags/#{tag}'>#{unbreak_spaces(tag)}</a>"
      }.join(" ")
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag
      
      tag_title_prefix = site.config['tag_title_prefix'] || 'Tag: '
      self.data['title'] = tag_title_prefix + tag

      self.data['posts'] = site.posts.select{|p| p.tags.include?(tag)}
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag_index'
        dir = site.config['tags_dir'] || 'tags'
        site.tags.keys.each do |tag|
          site.pages << TagPage.new(site, site.source, File.join(dir, tag), tag)
        end
      end
    end
  end

end

Liquid::Template.register_filter(Jekyll::TagFilter)
