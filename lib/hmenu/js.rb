require 'hmenu/constants'

module HMenu
  module JS
    def self.out
      File.read "#{::HMenu::ROOTDIR}/js/hmenu.js"
    end
  end
end

