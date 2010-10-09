require 'pathname'

module HMenu

  def self.rootdir_pathname
    Pathname.new(__FILE__).dirname.realpath + '../..'
  end
  

  VERSION = '0.1.3'
  # TODO: manage symlinks...
  ROOTDIR = self.rootdir_pathname.to_s

end
