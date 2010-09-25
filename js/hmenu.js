// stongly based on http://nadeausoftware.com/articles/2007/12/latency_friendly_hierarchical_menus_using_unicode_bullets_and_bit_javascript

//ITEM  = '\u00A0';
ITEM  = '\u25E6';
OPEN  = '\u25BC';
CLOSE = '\u25BA';

function toggle_submenu(e) {
  if (e.innerHTML==OPEN || e.innerHTML==CLOSE) {
    e.innerHTML=(e.innerHTML==OPEN) ? CLOSE : OPEN;
    for (var c, p=e.parentNode, i=0; c=p.childNodes[i]; i++)
      if (c.tagName=='UL') c.style.display=(c.style.display=='none') ? 'block' : 'none';
  }
}

function reset_menus() {
  var li_tags=document.getElementsByTagName('LI');
  for (var li, i=0; li=li_tags[i]; i++) {
    if (li.className.match('hmenu-item')) {
      for (var c, j=0; c=li.childNodes[j]; j++) {
        if (c.tagName=='SPAN' && c.className.match('hmenu-bullet')) { 
          c.innerHTML=ITEM; 
        }
      }
    }
    if (li.className.match('hmenu-submenu')) {
      for (var c, j=0; c=li.childNodes[j]; j++) {
        if (any_descendant_className_match(c, 'hmenu-selected')) {
          expand(c);
        } else { 
          collapse(c);  
        }
      }
    }
  }
}

function collapse(e) {
  if (e.tagName=='SPAN' && e.className.match('hmenu-bullet')) { 
    e.innerHTML=CLOSE; 
  }
  else if (e.tagName=='UL') {
    e.style.display = 'none';
  }
}

function expand(e) {
  if (e.tagName=='SPAN' && e.className.match('hmenu-bullet')) { 
    e.innerHTML=OPEN; 
  }
  else if (e.tagName=='UL') {
    e.style.display = 'block';
  }
}

function any_descendant_className_match(element, klassName) {

  //debug('\n');
  //debug('called: ' + element.tagName);
  //if (element.className) {
  //  debug('.' + element.className);
  //}
  //if (element.tagName && element.tagName.match('SPAN')) {
  //  debug(': ' + element.innerHTML);
  //}

  if (element.className && element.className.match(klassName)) {
    return true;
  } 
  else if (element.hasChildNodes) {
    //debug(' (has child nodes)');
    for (var c, i=0; c=element.childNodes[i]; i++) {
      //debug('\n*');
      //debug('-->[child]: ' + c.tagName + '.' + c.className);
      if (any_descendant_className_match(c, klassName)) {
        return true;
      }
    }
  }
  return false;
}

function debug(s) {
  jsdbg = document.getElementById('jsdebug');
  jsdbg.innerHTML = jsdbg.innerHTML + s;
}

