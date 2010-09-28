require 'hmenu/constants'

module HMenu
  module CSS
    # Return a minimal CSS to make the menu work.
    def self.out
      File.read "#{::HMenu::ROOTDIR}/css/hmenu.css"
    end
  end
end

