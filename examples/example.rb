$LOAD_PATH.unshift File.dirname(__FILE__) + '../lib'

require 'hmenu'

root = HMenu::Node.new('ROOT')

root.add_path('/aaa/bbb/ccc/ddd', {
  :name => 'test1',
  :href => '/xxx/yyy/zzz.html',
  :extra_info => Object.new
})

root.add_path('/aaa/bbb/ccc/eee', {
  :name => 'test2',
  :href => '/xxx/yyy/2.html',
})

root.add_path('/aaa/fff/ccc/eee', {
  :name => 'test2',
  :href => '/xxx/yyy/2.html',
})

html_ul = root.to_html_ul do |node, output| # code block is optional!
  if
      node.content.respond_to? :[] and
      node.content[:extra_info].class == Object

    output[:name] += ' (extra_info is just an Object)'
    output[:extra_class] = 'hmenu-selected'
    output[:href] = nil
  end
end

puts <<END # you may use a template system like ERB if you wish...
<head>
  <script type="text/javascript">
    #{HMenu::JS.out}
  </script>
  <style type="text/css">
    #{HMenu::CSS.out} 
    #{File.read File.join HMenu::ROOTDIR, 'examples/hmenu.more.example.css'}
  </style>
</head>
<body onload="reset_menus();">
  #{html_ul}
</body>
END

