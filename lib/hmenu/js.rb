require 'hmenu/constants'

module HMenu
  module JS
    # Return JavaScript code to show/hide submenus by clicking
    # on list bullets.
    def self.out
      File.read "#{::HMenu::ROOTDIR}/js/hmenu.js"
    end
  end
end

