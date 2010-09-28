# Thanks to: http://nadeausoftware.com/articles/2007/12/latency_friendly_hierarchical_menus_using_unicode_bullets_and_bit_javascript

require 'tree'
require 'hmenu/extensions/tree'

module HMenu
  class Node < Tree::TreeNode

    # See #Tree::TreeNode#add_recursive .
    #
    # +content_hash+ has the following pre-defined keys:
    # 
    # +:n+:: Integer, for sorting (default +0+)
    # 
    # +:name+:: String, displayed name  (if different from node name takem from the path)
    #
    # +:description+:: String, will be rendered as a +title+ HTML attribute
    #
    # +:extra_class+:: String, add extra HTML/CSS class; you may also provide a space-separeted list of classes; NOTE: class +hmenu-selected+ is special: the JavaScript code from HMenu::JS.out (function +reset_menus()+) will expand items with such class instead of collasing them.
    #
    # You can add any custom keys and use them later for any customization.
    #
    def add_path(path, content_hash) # just for docs
      super(path, content_hash)
    end

    # Retuns the HTML code for the menu as an unnumbered list.
    #
    # A block may optionally be provided to modify the output:
    #
    #   html_ul = root.to_html_ul do |node, output| 
    #     if
    #         node.content.respond_to? :[] and
    #         node.content[:extra_info].class == Object
    # 
    #       output[:name] += ' (extra_info is just an Object)'
    #           # modify the dsplayed name
    #       output[:extra_class] = 'hmenu-selected' 
    #           # expanded/hghlightd by JS/CSS
    #       output[:href] = nil
    #           # turn off hyperlink
    #     end
    #   end
    #
    def to_html_ul(&block)
      ctag = 'div' # HTML tag for content
      btag = 'div' # HTML tag for bullets

      o = content ? content.clone : nil
      if block.respond_to? :call
        block.call(self, o)
      end

      s = ""

      hmenu_content_class = "hmenu-content"

      hmenu_content_class << " hmenu-root" if isRoot?

      if o
        hmenu_content_class << ' ' << o[:extra_class] if o[:extra_class]
        s << "<#{ctag} class=\"#{hmenu_content_class}\" title=\"#{(o[:desc] || '')}\">"
        if o[:href]
          s <<
            "<a href=\"#{o[:href]}\">#{o[:name]}</a>" 
        elsif o[:name]
          s << (o[:name] || '')  
        end
        s << "</#{ctag}>"
      else
        s << "<#{ctag} class=\"#{hmenu_content_class}\">" << name.capitalize << "</#{ctag}>"
      end

      if hasChildren?

        if isRoot? 
          s += '<ul class="hmenu">'
        else
          s += "<ul>"
        end

        children.sort.each do |child|

          o = child.content ? child.content.clone : nil
          if block.respond_to? :call
            block.call(child, o)
          end

          css_li_class =  
              child.hasChildren? ? 
                  'hmenu-submenu' : 
                  'hmenu-item'
          css_li_class << ' ' << o[:extra_class] if o and o[:extra_class]
          css_bullet_class = 
              child.hasChildren? ? 
                  'hmenu-bullet' : 
                  'hmenu-bullet-nochildren'

          s += "<li class=\"#{css_li_class}\">" << "<#{btag} class=\"#{css_bullet_class}\" onclick=\"toggle_submenu(this);\"></#{btag}>" << child.to_html_ul(&block) << "</li>"

        end

        s += "</ul>"

      end

      return s
    end

    protected

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
