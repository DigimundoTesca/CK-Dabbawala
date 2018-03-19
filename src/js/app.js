const PATH = window.location.pathname;
/**
 * Resalta el nombre de los enlaces del navbar de acuerdo a la ubicación en donde se encuentre
 *
 */
export function loadPathname() {
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