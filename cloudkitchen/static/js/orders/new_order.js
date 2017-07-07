$(document).ready(function() {

  window.onload = document.getElementById("container-loader").style.display="none";
  window.onload = document.getElementById("infor").style.display="initial";

  let Ticket = {
    packages: {},
    cartridges: {}
  }
  /**
   * Shows a Sweet alert meanwhile the loads the page
   */
  function showAlert() {
    swal({
      title: "Menú cargado!",
      text: "Disfruta tus alimentos!",
      type: "success",
      timer: 2000,
      showConfirmButton: false
    }).then(
      function(){},
      function(dismiss){}
    );
    setTimeout(2100);
  }

  function initScrolls(){
    let scrolls = document.getElementsByClassName('container-scroll');
    let i = 0;
    for (; i < scrolls.length; i++) {
      let container = scrolls[i];
      Ps.initialize(container, {
        wheelPropagation: true,
        minScrollbarLength: 80,
        maxScrollbarLength: 180,
        useBothWheelAxes: true,
      });
    }
  }

  function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
      let cookies = document.cookie.split(';');
      let i = 0;
      for (; i < cookies.length; i++) {
        let cookie = jQuery.trim(cookies[i]);
        /** Does this cookie string begin with the name we want? */
        if (cookie.substring(0, name.length + 1) === (name + '=')) {
          cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
          break;
        }
      }
    }
    return cookieValue;
  }

  /**
   * Returns the total ticket in cartridges
   * @return {number} total cartridges ticket
   */
  function getTotalCartridges() {
    let totalCartridges = 0;

    for (var item in Ticket.cartridges) {
      totalCartridges += Ticket.cartridges[item].total;
    }

    return totalCartridges;
  }

  /**
   * Returns the total ticket in cartridges
   * @return {number} total packages ticket
   */
  function getTotalPackages() {
    let totalPackages = 0;

    for (var item in Ticket.packages) {
      totalPackages += Ticket.packages[item].total;
    }

    return totalPackages;
  }

  /**
   * Changes the total ticket label
   * @param {number} total new total ticket
   */
  function setTotalTicket(total) {
    // Checks if new total has decimals
    if (total % 1 === 0) {
      $('#int-total-price').text(total);
      $('#dec-total-price').text('00');
    } else {
      total = total.toFixed(2).split('.');
      $('#int-total-price').text(total[0]);
      $('#dec-total-price').text(total[1]);
    }
  }
  /**
   * Updates the total ticket at JSON and DOM
   */
  function updateTotal() {
    let total = getTotalCartridges() + getTotalPackages();
    setTotalTicket(total);
  }
  /**
   * Sets the data from Ticket Object in the cart
   * @return {[type]} [description]
   */
  function updateTicketList() {
    let i,
      newItem,
      packagesListContainer;

    packagesListContainer = $('ul#list-container-prods');

    newItem = $("<li class='prod-list-head  list-item'>" +
      "<span class='prod-name'>Producto</span>" +
      "<span class='prod-unit'>P. Unit</span>" +
      "<span class='prod-quantity'>Cant</span>" +
      "<span class='prod-total'>Total</span>" +
      "</li>");

    packagesListContainer.empty();
    packagesListContainer.append(newItem);

    for (key in Ticket.cartridges)  {
      newItem = $("<li class='list-item'>" +
        "<span class='prod-name'>" + Ticket.cartridges[key].name + "</span>" +
        "<span class='prod-unit'>$ " + Ticket.cartridges[key].cost.toFixed(2) + "</span>" +
        "<span class='prod-quantity'>" + Ticket.cartridges[key].quantity + "</span>" +
        "<span class='prod-total'> $ " + Ticket.cartridges[key].total.toFixed(2) + "</span>" +
        "</li>");
        packagesListContainer.append(newItem);
    }

  }
  /**
   * Adds the elements to the ticket json
   * @param {Number} id   Cartridge ticket id
   * @param {String} name Cartridge ticket name
   * @param {Number} cost Catridge ticket cost
   */
  function addProductToTicketObj(id, name, cost){
     // Cheks if there's a same product in the ticket json
    if (Ticket.cartridges[id]) {
      Ticket.cartridges[id].total += cost;
      Ticket.cartridges[id].quantity++;
    } else {
      let newProduct = {
        id: parseInt(id),
        name: name,
        cost: cost,
        quantity: 1,
        total: cost
      }
      Ticket.cartridges[id] = newProduct;
    }
    updateTicketList();
    updateTotal();
  };

  $(this).on('click', '.product', function(event) {
    let productId = +$(this).attr('id').split('-')[1];
    let productName = $(this).find('.product-name').text();
    let productCost = +$(this).find('.product-cost').text();

    addProductToTicketObj(productId, productName, productCost);
  });

  $(this).on('click', '#btn-orders-reset', function(event) {
    Ticket = {
      cartridges: {},
      packages: {}
    }
    updateTicketList();
  });

  $('#make-dabba').on('click', function(event) {
    if ($('#modal-package').hasClass('modal-hidde')) {
      $('#modal-package').removeClass('modal-hidde');
    }
  });

  $('#close-modal').on('click', function(event) {
    if( $('#close').text() === 'close' ) {
      $('#close').addClass('transformer')
      $('#done').removeClass('transformer')
      $('#close').text('');
      $('#done').text('done');
    } else {
      $('#done').addClass('transformer')
      $('#close').removeClass('transformer')
      $('#close').text('close');
      $('#done').text('');
    }
  });

  initScrolls();
  showAlert();
});

function visible() {
  $('#frontdisplay').removeClass('panels-backface-invisible');
  $('#backdisplay').addClass('panels-backface-invisible');
  $('#rightdisplay').addClass('panels-backface-invisible');
  $('#leftdisplay').addClass('panels-backface-invisible');
  $('#topdisplay').addClass('panels-backface-invisible');
  $('#bottomdisplay').addClass('panels-backface-invisible');
}

function visible1() {
  $('#frontdisplay').addClass('panels-backface-invisible');
  $('#backdisplay').removeClass('panels-backface-invisible');
  $('#rightdisplay').addClass('panels-backface-invisible');
  $('#leftdisplay').addClass('panels-backface-invisible');
  $('#topdisplay').addClass('panels-backface-invisible');
  $('#bottomdisplay').addClass('panels-backface-invisible');
}
function visible2() {
  $('#frontdisplay').addClass('panels-backface-invisible');
  $('#backdisplay').addClass('panels-backface-invisible');
  $('#rightdisplay').removeClass('panels-backface-invisible');
  $('#leftdisplay').addClass('panels-backface-invisible');
  $('#topdisplay').addClass('panels-backface-invisible');
  $('#bottomdisplay').addClass('panels-backface-invisible');
}
function visible3() {
  $('#frontdisplay').addClass('panels-backface-invisible');
  $('#backdisplay').addClass('panels-backface-invisible');
  $('#rightdisplay').addClass('panels-backface-invisible');
  $('#leftdisplay').removeClass('panels-backface-invisible');
  $('#topdisplay').addClass('panels-backface-invisible');
  $('#bottomdisplay').addClass('panels-backface-invisible');
}
