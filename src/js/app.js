const PATH = window.location.pathname;
/**
 * Resalta el nombre de los enlaces del navbar de acuerdo a la ubicación en donde se encuentre
 *
 */
export function loadPathname(PATH) {
  let el;
  switch (PATH) {
    case '/ventas/':
    case '/ventas/nueva-venta/':
      el = document.getElementById('link-sales');
      break;
    case '/cocina/friad/':
    case '/cocina/caliente/':
    case '/cocina/ensamblado/':
      el = document.getElementById('link-kitchen');
      break;
    case '/warehouse/':
    case '/warehouse/analytics/':
    case '/warehouse/shoplist':
    case '/warehouse/new_shoplist':
    case '/supplies/':
    case '/cartridges/':
      el = document.getElementById('link-warehouse');
      break;
    case '/diners/':
    case '/diners/log/':
      el = document.getElementById('link-dinning-room');
      break;
    case '/diners/analytics/':
    case '/diners/suggestions/':
      el = document.getElementById('link-diners');
      break;
    case '/settings/':
      el = document.getElementById('link-panel');
      break;
  }

  addClass(el, 'active');

  function addClass(el, className) {
    if (el.classList)
      el.classList.add(className);
    else
      el.className += ' ' + className;
  }
}

/**
 * Obtención de Cookies
 *
 */
export function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== '') {
    let cookies = document
      .cookie
      .split(';');
    for (let i = 0; i < cookies.length; i++) {
      let cookie = cookies[i].trim();
      // Does this cookie string begin with the name we want?
      if (cookie.substring(0, name.length + 1) === (name + '=')) {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}

/**
 * Buscar un elemento padre en el DOM
 */
export function findParentBySelector(elm, selector) {
  var all = document.querySelectorAll(selector);
  var cur = elm.parentNode;
  
  function collectionHas(a, b) { //helper function (see below)
    for (var i = 0, len = a.length; i < len; i++) {
      if (a[i] == b) return true;
    }
    return false;
  }

  while (cur && !collectionHas(all, cur)) { //keep going up until you find a match
    cur = cur.parentNode; //go up
  }
  return cur; //will return null if not found
}

/**
 * Permite dar formato con decimales a un numero
 * @param amount
 * @param decimals
 * @returns {string}
 */
export function numberFormat(amount, decimals) {
    amount += ''; // por si pasan un numero en vez de un string
    amount = parseFloat(amount.replace(/[^0-9\.]/g, '')); // elimino cualquier cosa que no sea numero o punto

    decimals = decimals || 0; // por si la variable no fue fue pasada

    // si no es un numero o es igual a cero retorno el mismo cero
    if (isNaN(amount) || amount === 0)
        return parseFloat(0).toFixed(decimals);

    // si es mayor o menor que cero retorno el valor formateado como numero
    amount = '' + amount.toFixed(decimals);

    let amount_parts = amount.split('.'),
        regexp = /(\d+)(\d{3})/;

    while (regexp.test(amount_parts[0]))
        amount_parts[0] = amount_parts[0].replace(regexp, '$1' + ',' + '$2');

    return amount_parts.join('.');
}
