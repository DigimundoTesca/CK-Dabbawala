$(function() {
  /**
   * It records the records of "Ticket Details" and eliminates the id's of repeated tickets.
   * Color the "Ticket Details" records associated with the same ticket.
   */
  function format_tables() {
    const objects = $('tr');
    let list_id = [];
    let list_aux = [];
    let list_color = [];
    let color = [];
    let the_color=['#96E8BC','#B6F9C9','#C9FFE2'];
    let a = 0;
    let b = 0;
    let c = 1;
    let col = 0;
    let count = -1;

    /**
     * Format lists so that they only contain integers and ignores the head.
     */
    objects.each(function(index, element) {
      let id_element = parseInt($(element).find('th.id_kitchen_table').text().trim());
      if (!isNaN(id_element)) {
        list_id.push(id_element);
        list_aux.push(id_element);
        list_color.push(id_element);
      }
    });

    /**
     * Change the text for each item in the list.
     */
    for (let j=0; j<list_id.length; j++){
      let a = j;
      let b = j+1;

      if (list_aux[a] ===  list_id[b]){
        list_id[b] = " ";
      }
    }

    /**
     * Associates a color with each item in the list.
     */
    for (let i=0; i<=list_aux.length; i++){
      let r = i;
      let t = i+1;
      if (list_aux[r] == list_color[t]){
        c++;
      }else{
        for(q=0;q<c;q++)
        {
          color.push(the_color[col]);
        }
          col++;
          c=1;
      }
        if(col==3)
        {
          col=0;
        }
    }

    /**
     * Applies changed text to items in the list.
     * Applies the new color to items in the list.
     */
    objects.each(function(index, element) {
      let id_element = parseInt($(element).find('th.id_kitchen_table').text(list_id[count]));
      id_element = parseInt($(element).css('background',color[count]));
      count++;
    });
  }
  /**
   * Gets a cookie from cache
   */
  function get_cookie(name) {
    let cookie_value = null;
    if (document.cookie && document.cookie !== '') {
      let cookies = document.cookie.split(';');
      for (let i = 0; i < cookies.length; i++) {
        let cookie = jQuery.trim(cookies[i]);
        if (cookie.substring(0, name.length + 1) === (name + '=')) {
          cookie_value = decodeURIComponent(cookie.substring(name.length + 1));
          break;
        }
      }
    }
    return cookie_value;
  }

  /**
   * Reload the table
   */
  function reloadTableData(){
    // Refresh the tbody from the table-kitchen
    let table_tbody = $('#table-kitchen').find('tbody');

    // Load the new elements for the table-kitchen
    $.ajax({
      url: '',
      method: 'POST',
      data: {
        type: 'get_hot_kitchen_data',
        csrfmiddlewaretoken: get_cookie('csrftoken')
      },
      async: true,
      type: 'json',
      success: function (response) {
        table_tbody.empty();
        $.each(response.data, function(index_data, ticketOrder) {
          // If the object has cartridges
          /** @namespace ticketOrder.cartridges */
          if (ticketOrder.cartridges.length > 0) {
            let cartridges = ticketOrder.cartridges;

            $.each(cartridges, function (index_cartridge, cartridges_value){
              /** @namespace cartridges_value.cartridge */
              let oCartridge = cartridges_value.cartridge[0].fields;

              /** @namespace oCartridge.kitchen_assembly */
              if (oCartridge.kitchen_assembly.toString() === 'CO') {
                  /** @namespace ticketOrder.ticket_order */
                  table_tbody.append('' +
                      '<tr class="tr_id">' +
                        '<th scope="row" class="id_kitchen_table">' + ticketOrder.ticket_order + '</th>' +
                        '<td>' + oCartridge.name + '</td>' +
                        '<td>' + cartridges_value.quantity + '</td>' +
                      '</tr>');
                  }
            });

          }

          // If the object has packages cartridges
          /** @namespace ticketOrder.packages */
          if (ticketOrder.packages.length > 0) {
            let packages = ticketOrder.packages;

            $.each(packages, function (index_package, packages_value){
              /** @namespace packages_value.package_recipe */
              let oPackageRecipe = packages_value.package_recipe;

              $.each(oPackageRecipe, function(indexPackageRecipe, oCartridge) {
                oCartridge = oCartridge[0];

                /** @namespace oPackageRecipe.kitchen_assembly */
                if (oCartridge.fields.kitchen_assembly.toString() === 'CO') {
                  /** @namespace packages_value.quantity */
                    table_tbody.append('' +
                        '<tr class="tr_id">' +
                          '<th scope="row" class="id_kitchen_table">' + ticketOrder.ticket_order + '</th>' +
                          '<td>' + oCartridge.fields.name + '</td>' +
                          '<td>' + packages_value.quantity + '</td>' +
                        '</tr>');
                    }
              });
            });
          }
        });
        format_tables();
      }, error: function (jqXHR, textStatus ) {
        console.log(jqXHR);
        console.log(textStatus);
      }
    });


  }

  format_tables();
  setInterval(reloadTableData, 3000);
});
