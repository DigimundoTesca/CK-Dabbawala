const PATH = window.location.pathname;
/**
 * Resalta el nombre de los enlaces del navbar de acuerdo a la ubicación en donde se encuentre
 *
 */
export function loadPathname() {
  if (PATH === '/ventas/') {
    let linkElement = document.getElementById('link-sales');
    $('#link-sales').addClass('active');
  } else if (PATH === '/sales/new/breakfast/') {
    $('#link-new-breakfast').addClass('active');
  } else if (PATH === '/sales/new/food/') {
    $('#link-new-food').addClass('active');
  } else if (PATH === '/supplies/' || PATH === '/supplies/new/') {
    $('#link-warehouse').addClass('active');
  } else if (PATH === '/cartridges/' || PATH === '/cartridges/new/') {
    $('#link-warehouse').addClass('active');
  } else if (PATH === '/customers/register/list/') {
    $('#link-customers').addClass('active');
  } else if (PATH === '/kitchen/' || PATH === '/kitchen/assembly/') {
    $('#link-kitchen').addClass('active');
  } else if (PATH === '/diners/' || PATH === '/diners/logs/') {
    $('#link-diners').addClass('active');
  }
}

/**
 * Obtención de Cookies
 * 
 */
export function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== '') {
    let cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
      let cookie = jQuery.trim(cookies[i]);
      // Does this cookie string begin with the name we want?
      if (cookie.substring(0, name.length + 1) === (name + '=')) {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}
