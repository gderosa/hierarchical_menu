# Thanks to: http://nadeausoftware.com/articles/2007/12/latency_friendly_hierarchical_menus_using_unicode_bullets_and_bit_javascript

require 'tree'
require 'hmenu/extensions/tree'

module HMenu
  class Node < Tree::TreeNode

    def to_html_ul
      s = ""

      if content 
        if content[:href]
          s << 
            "<a class=\"hmenu-content\" " << 
              "title=\"#{content[:desc]}\" " << 
              "href=\"#{content[:href]}\">#{content[:name]}" <<
            "</a>"
        elsif content[:name]
          s << 
              '<span class="hmenu-content" title="' << (content[:desc] || '') << '">' << 
                (content[:name] || '') << 
              '</span>'
        end
      else
        s << '<span class="hmenu-content"' << name.capitalize << '</span>'
      end

      if hasChildren?

        if isRoot? 
          s += '<ul class="hmenu">'
        else
          s += "<ul>"
        end

        children.sort.each do |child|

          css_li_class = 
              child.hasChildren? ? 
                  'hmenu-submenu' : 
                  'hmenu-item'
          css_bullet_class = 
              child.hasChildren? ? 
                  'hmenu-bullet' : 
                  'hmenu-bullet-nochildren'

          s += "<li class=\"#{css_li_class}\">" << "<span class=\"#{css_bullet_class}\" onclick=\"toggle_submenu(this);\"></span>" << child.to_html_ul << "</li>"

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

  end
end
