ITEM  = '\u00A0';
OPEN  = '\u25BC';
CLOSE = '\u25BA';

function toggle_submenu(e) {
  e.innerHTML=(e.innerHTML==OPEN) ? CLOSE : OPEN;
  for (var c, p=e.parentNode, i=0; c=p.childNodes[i]; i++)
    if (c.tagName=='UL') c.style.display=(c.style.display=='none') ? 'block' : 'none';
}

function reset_menus() {
  var li_tags=document.getElementsByTagName('LI');
  for (var li, i=0; li=li_tags[i]; i++) {
    if (li.className.match('hmenu-item'))
      for (var c, j=0; c=li.childNodes[j]; j++)
        if (c.tagName=='SPAN' && c.className.match('hmenu-bullet')) { c.innerHTML=ITEM; }
    if (li.className.match('hmenu-submenu'))
      for (var c, j=0; c=li.childNodes[j]; j++)
        if (c.tagName=='SPAN' && c.className.match('hmenu-bullet')) { c.innerHTML=CLOSE; }
        else if (c.tagName=='UL') { c.style.display = 'none'; }
  }
}

