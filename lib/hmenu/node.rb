# Thanks to: http://nadeausoftware.com/articles/2007/12/latency_friendly_hierarchical_menus_using_unicode_bullets_and_bit_javascript

require 'tree'
require 'hmenu/extensions/tree'

module HMenu
  class Node < Tree::TreeNode

    def to_html_ul(&block)
      o = content.clone
      if block.respond_to? :call
        block.call(self, o)
      end

      s = ""

      hmenu_content_class = "hmenu-content"

      hmenu_content_class << " hmenu-root" if isRoot?

      if o
        hmenu_content_class << ' ' << o[:extra_class] if o[:extra_class]
        if o[:href]
          s << 
            "<a class=\"#{hmenu_content_class}\" " << 
              "title=\"#{o[:desc]}\" " << 
              "href=\"#{o[:href]}\">#{o[:name]}" <<
            "</a>"
        elsif o[:name]
          s << 
              "<span class=\"#{hmenu_content_class}\" title=\"" << (o[:desc] || '') << '">' << 
                (o[:name] || '') << 
              '</span>'
        end
      else
        s << "<span class=\"#{hmenu_content_class}\"" << name.capitalize << '</span>'
      end

      if hasChildren?

        if isRoot? 
          s += '<ul class="hmenu">'
        else
          s += "<ul>"
        end

        children.sort.each do |child|

          o = child.content.clone
          if block.respond_to? :call
            block.call(child, o)
          end

          css_li_class =  
              child.hasChildren? ? 
                  'hmenu-submenu' : 
                  'hmenu-item'
          css_bullet_class = 
              child.hasChildren? ? 
                  'hmenu-bullet' : 
                  'hmenu-bullet-nochildren'

          s += "<li class=\"#{css_li_class}\">" << "<span class=\"#{css_bullet_class}\" onclick=\"toggle_submenu(this);\"></span>" << child.to_html_ul(&block) << "</li>"

        end

        s += "</ul>"

      end

      return s
    end

    def <=>(other) # for sorting
      n <=> other.n 
    end

    def n
      begin
        content[:n] ? content[:n] : 0
      rescue
        0
      end
    end

    def mangle_output(o, &block)
      unless o
        if block.respond_to? :call
          o = {}
          block.call(self, o)
        else
          o = content.dup
        end
      end
    end

  end
end
