require 'hmenu/constants'

module HMenu
  module CSS
    def self.out
      File.read "#{::HMenu::ROOTDIR}/css/hmenu.css"
    end
  end
end

