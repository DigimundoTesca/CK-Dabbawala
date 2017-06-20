$(document).ready(function() {

  Ticket = {
    packages: [],
    cartridges: []
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

  $('.product').click(function(){
    let productId = $(this).attr('id').split('-')[1];
    let productName = $(this).find('.product-name').text();
    let productCost = $(this).find('.product-cost').text();
    
  });
  
});

  function visible() {
    document.getElementById("frontdisplay").style.visibility = "visible";
    document.getElementById("backdisplay").style.visibility = "hidden";
    document.getElementById("rightdisplay").style.visibility = "hidden";
    document.getElementById("leftdisplay").style.visibility = "hidden";
    document.getElementById("topdisplay").style.visibility = "hidden";
  }
  function visible1() {
    document.getElementById("frontdisplay").style.visibility = "hidden";
    document.getElementById("backdisplay").style.visibility = "visible";
    document.getElementById("rightdisplay").style.visibility = "hidden";
    document.getElementById("leftdisplay").style.visibility = "hidden";
    document.getElementById("topdisplay").style.visibility = "hidden";
  }
  function visible2() {
    document.getElementById("frontdisplay").style.visibility = "hidden";
    document.getElementById("backdisplay").style.visibility = "hidden";
    document.getElementById("rightdisplay").style.visibility = "visible";
    document.getElementById("leftdisplay").style.visibility = "hidden";
    document.getElementById("topdisplay").style.visibility = "hidden";
  }
  function visible3() {
    document.getElementById("frontdisplay").style.visibility = "hidden";
    document.getElementById("backdisplay").style.visibility = "hidden";
    document.getElementById("rightdisplay").style.visibility = "hidden";
    document.getElementById("leftdisplay").style.visibility = "visible";
    document.getElementById("topdisplay").style.visibility = "hidden";
  }
  function visible4() {
    document.getElementById("frontdisplay").style.visibility = "hidden";
    document.getElementById("backdisplay").style.visibility = "hidden";
    document.getElementById("rightdisplay").style.visibility = "hidden";
    document.getElementById("leftdisplay").style.visibility = "hidden";
    document.getElementById("topdisplay").style.visibility = "visible";
  }
