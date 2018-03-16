import swal from 'sweetalert2';
import 'bootstrap';
import 'chart.js';
import 'jsPDF';
require('../scss/app.scss');
const PATH = $(location).attr('pathname');

$(function() {
  /**
   * Resalta el nombre de los enlaces del navbar de acuerdo a la ubicación en donde se encuentre
   *
   */
  if (PATH === '/ventas/') {
    $('#link-sales').addClass('active');
  }
  else if (PATH === '/sales/new/breakfast/') {
    $('#link-new-breakfast').addClass('active');
  }
  else if (PATH === '/sales/new/food/') {
    $('#link-new-food').addClass('active');
  }
  else if (PATH === '/supplies/' || PATH === '/supplies/new/') {
    $('#link-warehouse').addClass('active');
  }
  else if (PATH === '/cartridges/' || PATH === '/cartridges/new/') {
    $('#link-warehouse').addClass('active');
  }
  else if (PATH === '/customers/register/list/') {
    $('#link-customers').addClass('active');
  }
  else if (PATH === '/kitchen/' || PATH === '/kitchen/assembly/' ) {
    $('#link-kitchen').addClass('active');
  }
  else if (PATH === '/diners/' || PATH === '/diners/logs/') {
    $('#link-diners').addClass('active');
  }

  /**
   * Obtención de Cookies
   */
  function getCookie(name) {
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

  let csrftoken = getCookie('csrftoken');
  let ctx_week = document.getElementById("canvas-week-sales"),
    ctx_day = document.getElementById("canvas-day-sales"),
    earningsDayChart,
    earningsHourChart,
    today_date,
    sales_week,
    dates_range;

  /**
   * Función que se encarga de disparar las peticiones ajax para
   * la carga de las fechas y datos de las ventas
   */
  (function init() {
    /**
     * Método AJAX que carga los campos de rangos de fechas
     */
    $.ajax({
      method: 'post',
      url: PATH,
      dataType : 'json',
      traditional: true,
      async: true,
      data: {
        csrfmiddlewaretoken: csrftoken,
        type: 'dates_range'
      },
      success: function(result) {
        dates_range = result.data;
        fillDatesRangeFilter();
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
        console.log(XMLHttpRequest, textStatus);
      }
    });

    /**
     * Método AJAX que solicita los datos de las ventas de la semana actual
     */
    $.ajax({
      method: 'post',
      url: PATH,
      type: 'json',
      traditional: true,
      async: true,
      data: {
        csrfmiddlewaretoken: csrftoken,
        type: 'sales_actual_week'
      },
      success: function(result) {
        sales_week = result.data;
        drawCharts();
        setSalesDayChart(today_date);
        setTotalEarnings();
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
        console.log("error");
      }
    });
  })
  ([]);

  function convertDateToString(date) {
    let months = {
      1: 'Ene', 2: 'Feb', 3: 'Mar', 4: 'Abr', 5: 'May', 6: 'Jun',
      7: 'Jul', 8: 'Ago', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dic',
    };
    date = date.split('-');
    return date[0] + " " + months[parseInt(date[1])] + " " + date[2];
  }

  /**
   * Rellena el filtro de fechas
   */
  function fillDatesRangeFilter() {
    let selected_year;

    $.each(dates_range, function(index, item) {
      $('#dates-range-form').find('#dt-year').append(
        "<option value=" + item.year + ">" + item.year + "</option>"
      );
    });

    selected_year = parseInt($('#dates-range-form').find('#dt-year').val());

    $.each(dates_range, function(index, item) {
      if (dates_range[index].year ===  selected_year) {
        $.each(dates_range[index].weeks_list, function(index, item) {
          $('#dates-range-form').find('#dt-week').append(
            "<option value=" + item.start_date + "," + item.end_date + ">" +
            "S-" + item.week_number + ": " +
            convertDateToString(item.start_date) +
            " - " + convertDateToString(item.end_date) +
            "</option>"
          );
        });
        return false;
      }
    });
    today_date = $('#dt-week').val().split(',')[1];
  }

  /**
   * Dibuja las gráficas de ChartJS
   */
  function drawCharts() {
    /**
     * Draws the chart of sales of the week
     */
    earningsDayChart = new Chart(ctx_week, {
      type: 'bar',
      data: {
        labels: ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sábado", "Domingo"],
        datasets: [{
          label: 'Ventas del día',
          data: getEarningsWeekList(),
          backgroundColor: [
            'rgba(0,123,255,0.7)',
            'rgba(0,123,255,0.7)',
            'rgba(0,123,255,0.7)',
            'rgba(0,123,255,0.7)',
            'rgba(0,123,255,0.7)',
            'rgba(0,123,255,0.7)',
            'rgba(0,123,255,0.7)'
          ],
          borderColor: [
            'rgba(0,123,255,0.9)',
            'rgba(0,123,255,0.9)',
            'rgba(0,123,255,0.9)',
            'rgba(0,123,255,0.9)',
            'rgba(0,123,255,0.9)',
            'rgba(0,123,255,0.9)',
            'rgba(0,123,255,0.9)'
          ],
        }]
      },
      options: {
        responsive: true,
        onClick: function(event, legendItem) {
          try {
            let selected_day = legendItem[0]._index;
            for (let i = 0; i < sales_week.length; i++) {
              if (sales_week[i].number_day === selected_day) {
                setSalesDayChart(sales_week[i].date);
              }
            }
          } catch (error) {
            console.log(error.message);
          }
        },
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true,
            },
          }]
        }
      }
    });

    /**
     * Draws the chart of sales of the day
     */
    earningsHourChart = new Chart(ctx_day, {
      type: 'horizontalBar',
      data: {
        labels: [
          "Out", "15:00 - 16:00", "14:00 - 15:00", "13:00 - 14:00",
          "12:00 - 13:00", "11:00 - 12:00", "10:00 - 11:00", "09:00 - 10:00",
          "08:00 - 09:00", "07:00 - 08:00", "06:00 - 07:00"
        ],
        datasets: [{
          label: 'Ventas en este horario',
          data: [],
          backgroundColor: [
            'rgba(247,202,24,0.7)',
            'rgba(247,202,24,0.7)',
            'rgba(247,202,24,0.7)',
            'rgba(247,202,24,0.7)',
            'rgba(247,202,24,0.7)',
            'rgba(46,204,113,0.7)',
            'rgba(46,204,113,0.7)',
            'rgba(46,204,113,0.7)',
            'rgba(46,204,113,0.7)',
            'rgba(46,204,113,0.7)',
            'rgba(46,204,113,0.7)',
          ],
          borderWidth: 0
        }]
      },
      options: {
        responsive: true,
        onClick: function(event, legendItem) {
          try {
            console.log(legendItem[0]._index);
          }
          catch(error) {
            console.log(error.message);
          }
        },
        scales: {
          xAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    });

  }

  /**
   * Calcula el total de ventas de la semana actual y lo imprime en el template
   */
  function setTotalEarnings() {
    let total_earnings = 0;
    let earnings_list = getEarningsWeekList();
    for (let i = 0; i < earnings_list.length; i++) {
      total_earnings += earnings_list[i];
    }
    total_earnings = setDecimalFormat(total_earnings, 2);
    $('#total-earnings-text').append(total_earnings);
  }

  /**
   * Regresa una lista con la ganancia de cada dia de la semana utilizando la variable sales_week
   */
  function getEarningsWeekList() {
    let earnings_list = [],
      count = 0;
    while (count < sales_week.length) {
      earnings_list.push(parseFloat(sales_week[count]['earnings']));
      count++;
    }
    return earnings_list;
  }

  /**
   * Recibe un valor número y lo retorna un número con decimales (String)
   */
  function setDecimalFormat(amount, decimals) {
    let amount_parts,
      regexp = /(\d+)(\d{3})/;
    amount += '';
    amount = parseFloat(amount.replace(/[^0-9.]/g, ''));
    decimals = decimals || 0;
    if (isNaN(amount) || amount === 0)
      return parseFloat(0).toFixed(decimals);
    amount = '' + amount.toFixed(decimals);
    amount_parts = amount.split('.');
    while (regexp.test(amount_parts[0]))
      amount_parts[0] = amount_parts[0].replace(regexp, '$1' + ' ' + '$2');
    return amount_parts.join('.');
  }

  /**
   * Retorna una lista con las ganancias respectivas a cada día de la semana
   * utilizando la lista de objetos sales_list como argumento
   */
  function getEarningsWeekRange(sales_list) {
    let week_list = [0, 0, 0, 0, 0, 0, 0,];
    for (let i = 0; i < 7; i++) {
      for (let j = 0; j < sales_list.length; j++) {
        if (sales_list[j].number_day === i) {
          week_list[i] = sales_list[j]['earnings']
        }
      }
    }
    return week_list;
  }

  /**
   * Recibe una hora en formato de 24 hrs y la regresa en formateada en minutos
   * El String debe tener el siguiente formato: hh:mm
   */
  function convertHoursToMinutes(original_time) {
    let hours,
      minutes;
    hours = parseInt(original_time.split(':')[0])*60;
    minutes = parseInt(original_time.split(':')[1]);
    return parseInt(hours + minutes);
  }

  /**
   * Recibe una hora en enteros (minutos) y la regresa en formato de 24 hrs
   * El String debe tener el siguiente formato: hh:mm
   */
  function convertMinutesToHours(original_time) {
    let hours = parseInt(original_time / 60),
      minutes = parseInt(original_time % 60);
    if (hours.toString().length < 2) {
      hours = "0"+hours;
    }
    if (minutes.toString().length < 2) {
      minutes = "0"+minutes;
    }
    return hours + ':' + minutes;
  }

  /**
   * Recibe una hora y verifica si ésta, se encuentra dentro del rango de horas brindada
   * La hora recibida debe tener el siguiente formato: hh:mm
   * Si la condición se cumple retorna true, sino, retorna falso
   */
  function isHourInRange(hour, start_hour, end_hour) {
    let hour_in_minutes = convertHoursToMinutes(hour),
      start_hour_in_minutes = convertHoursToMinutes(start_hour),
      end_hour_in_minutes = convertHoursToMinutes(end_hour);
    return hour_in_minutes >= start_hour_in_minutes && hour_in_minutes < end_hour_in_minutes;
  }

  /**
   * Recibe un datetime con formato brindado por Python
   * Regresa el datetime convertido en formato de 24 hrs: hh:mm con Timezone +06:00
   */
  function convertPythonDatetimeFormatToHour(original_datetime){
    return original_datetime.split('T')[1].split('.')[0].substr(0, 5);
  }

  /**
   * Regresa una lista con las ganancias por cada rango de fechas
   */
  function getSalesDayList(initial_hour, final_hour, separation_time, sales_list) {
    let initial_hour_minutes,
      final_hour_minutes;
    let list_formatted = [],
      elements_ok = [],
      earnings = 0;
    initial_hour_minutes = convertHoursToMinutes(initial_hour);
    final_hour_minutes = convertHoursToMinutes(final_hour);
    while(initial_hour_minutes < final_hour_minutes) {
      let start_hour_f = convertMinutesToHours(initial_hour_minutes),
        end_hour_f = convertMinutesToHours(initial_hour_minutes + separation_time);
      for (let i = 0; i < sales_list.length; i++) {
        let hour_sale = convertPythonDatetimeFormatToHour(sales_list[i].datetime);
        if(isHourInRange(hour_sale, start_hour_f, end_hour_f)) {
          earnings += parseFloat(sales_list[i].earnings);
          elements_ok.push(sales_list[i]);
        }
      }
      list_formatted.push(earnings);
      initial_hour_minutes += separation_time;
      earnings = 0;
    }
    // Searches the times outside the time range
    for(let i = 0; i < sales_list.length; i++) {
      if(elements_ok.indexOf(sales_list[i]) === -1) {
        earnings += parseFloat(sales_list[i].earnings);
      }
    }
    list_formatted.push(earnings);
    return list_formatted.reverse();
  }

  /**
   * Obtiene las ganancias del día específico de la gráfica de ganancias diarias
   * después, muestra los resultados en la gráfica de ganancias por hora
   */
  function setSalesDayChart(date) {
    $.ajax({
      url: PATH,
      type: 'POST',
      data: {
        csrfmiddlewaretoken: csrftoken,
        'date': date,
        'type': 'sales_day',
      },
      traditional: true,
      dataType : 'json',
      beforeSend: function(){
        swal({
          title: "Generando gráficas",
          text: "Espere mientras se calculan los datos",
        });
        swal.enableLoading();
      },
      success: function(result) {
        let sales_day_earnings_list;
        let initial_hour = '06:00',
          final_hour = '16:00',
          separation_time = 60; // In minutes
        let sales_day_object_list = result['sales_day_list'];

        sales_day_earnings_list = getSalesDayList(initial_hour, final_hour, separation_time, sales_day_object_list);

        earningsHourChart.data.datasets[0].data = sales_day_earnings_list;
        earningsHourChart.update();
        swal.close();
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.error(textStatus, errorThrown);
        console.error(jqXHR);
      },
    });
  }

  /**
   * Refresca los datos de las gráficas y tabla con la semana y el año elegido
   */
  $('#dt-week').change(function(event) {
    let dt_year = $('#dt-year').val(),
      dt_week = $('#dt-week').val();
    $.ajax({
      url: PATH,
      method: 'POST',
      data: {
        csrfmiddlewaretoken: csrftoken,
        'dt_year': dt_year,
        'dt_week': dt_week,
        'type': 'sales_week',
      },
      traditional: true,
      dataType : 'json',
      beforeSend: function(){
        swal({
          title: "Obteniendo registros",
          text: "Espere mientras obtenemos toda la información",
        });
        swal.enableLoading();
      },
      success: function(result, status, XHR) {
        let tickets_objects = result['tickets'],
          sales_week = result['sales'],
          week_number = result['week_number'],
          sales_details_table = $('#sales-details-table').find('tbody'),
          week_earnings = 0;
        sales_details_table.empty();
        swal({
          title: "Éxito",
          text: "Datos obtenidos",
          type: "info",
          timer: 750,
          showConfirmButton: false
        }).then(
          function(){},
          function(dismiss){});
        /**
         * Filling the sales table
         */
        for (let i = 0; i < tickets_objects.length; i++) {
          week_earnings += parseFloat(tickets_objects[i].total);
          let cartridges_list = "";
          let packages_list = "";
          for (let j = 0; j < tickets_objects[i]['cartridges'].length; j++) {
            cartridges_list += "" +
              "<span class='badge badge-success'>" +
              "<span class='badge badge-info'>" +
              tickets_objects[i]['cartridges'][j].quantity +
              "</span>" +
              "<span class='badge badge-success'>" +
              tickets_objects[i]['cartridges'][j].name +
              "</span>" +
              "</span>" +
              "";
          }
          for (let j = 0; j < tickets_objects[i]['packages'].length; j++) {
            packages_list += "" +
              "<span class='badge badge-primary'>" +
              "<span class='badge badge-info'>" +
              tickets_objects[i]['packages'][j].quantity +
              "</span>" +
              "<span class='badge badge-primary'>" +
              tickets_objects[i]['packages'][j].name +
              "</span>" +
              "</span>" +
              "";
          }
          sales_details_table.append("" +
            "<tr>" +
            "<th class='header-id'>" + tickets_objects[i].id + "</th>" +
            "<th class='header-order'>" + tickets_objects[i].order_number + "</th>" +
            "<td class='header-date'>" + tickets_objects[i].created_at + "</td>" +
            "<td class='header-products'>" + cartridges_list + "</td>" +
            "<td class='header-packages'>" + packages_list + "</td>" +
            "<td class='header-seller'>" + tickets_objects[i].cashier + "</td>" +
            "<td class='td-total'>" + tickets_objects[i].total + "</td>" +
            "<td class='header-actions'>" +
            "<span class='sales-actions delete-ticket'><i class='material-icons text-muted'>delete</i></span>" +
            "<span class='sales-actions print-ticket'><i class='material-icons text-primary'>local_printshop</i></span>" +
            "</td>" +
            "</tr>" +
            "");
        }
        earningsDayChart.data.datasets[0].data = getEarningsWeekRange(sales_week);
        earningsDayChart.update();
        $('#total-earnings-text').text(week_earnings.toFixed(2));
        $('#week-number').text(week_number);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(jqXHR);
      },
      complete: function(result){}
    });
  });

  /**
   * Obtiene la información del ticket específico y la muestra para impresión
   * TODO: Make an iframe to print the ticket
   */
  $(this).on('click', '.print-ticket', function(event) {
    let id_element = $(this).parent().siblings('.header-id').text();
    let btn_printer = $('.btn-printer');
    let sales_list_modal = $('#sales-list-modal');
    let total = $(this).parent().siblings('.td-total').text();

    function iterate_cartridges(element, index, array) {
      let name = element.name;
      let cost_base = parseFloat(element.total) / element.quantity;
      let total = parseFloat(element.total);
      let quantity = element.quantity;
      let new_li;

      // Formats the cost_base and total
      if (cost_base % 2 !== 0) {
        cost_base = cost_base.toFixed(2);
      } else
        cost_base += '.00';
      if (total % 2 !== 0) {
        total = total.toFixed(2);
      } else
        total += '.00';

      // Adds the list to tickets
      new_li = $("" +
        "<li class='list-group-item'>" +
        "<span class='name-li-modal text-uppercase'>" + name + "</span> " +
        "<span class='cost-li-modal'>" + '$ ' + cost_base + "</span>" +
        "<span class='quantity-li-modal'>" + quantity + "</span>" +
        "<span class='total-li-modal'>" + '$ ' + total + "</span> " +
        "</li>");

      sales_list_modal.append(new_li);
    }

    function iterate_packages(element, index, array) {
      let cartridges_list = array[index].cartridges;
      let name = '';
      let cost_base = parseFloat(element.total) / element.quantity;
      let total = parseFloat(element.total);
      let quantity = element.quantity;
      let new_li;

      // Formats the names
      $.each(cartridges_list, function(index, item) {
        name += item.substring(0, 3) + ' ';
      });

      // Formats the cost_base and total
      if (cost_base % 2 !== 0) {
        cost_base = cost_base.toFixed(2);
      } else
        cost_base += '.00';
      if (total % 2 !== 0) {
        total = total.toFixed(2);
      } else
        total += '.00';

      // Adds the list to tickets
      new_li = $("" +
        "<li class='list-group-item'>" +
        "<span class='name-li-modal text-uppercase'>" + name + "</span> " +
        "<span class='cost-li-modal'>" + '$ ' + cost_base + "</span>" +
        "<span class='quantity-li-modal'>" + quantity + "</span>" +
        "<span class='total-li-modal'>" + '$ ' + total + "</span> " +
        "</li>");

      sales_list_modal.append(new_li);
    }

    function show_modal(ticket_details) {
      let new_li;
      // First reset the ticket
      sales_list_modal.empty();
      new_li = ("" +
        "<li>" +
        "<span class='name-li-title-modal'>Nombre</span> " +
        "<span class='cost-li-title-modal'>Cost</span>" +
        "<span class='quantity-li-title-modal'>Cant</span>" +
        "<span class='total-li-title-modal'>Total</span> " +
        "</li>");
      sales_list_modal.append(new_li);

      ticket_details.cartridges.forEach(iterate_cartridges);
      ticket_details.packages.forEach(iterate_packages);
      $("#ticket-id").text(id_element);
      let nuevo_li = $("" +
        "<li class='total-ticket-container mt-1'>" +
        " <span id='total-ticket'>$ <span class='total-ticket-cant'> " +
        " " + total +"</span></span> " +
        "</li>" +
        "");
      sales_list_modal.append(nuevo_li);
      $('#modal-ticket').modal('show');
    }

    /**
     * Dibuja el ticket en el modal y activa el onClic() listener del botón .btn-printer
     */
    $.ajax({
      url: PATH,
      method: 'POST',
      traditional: true,
      dataType: 'json',
      async: true,
      data: {
        csrfmiddlewaretoken: csrftoken,
        'ticket_id': id_element,
        'type': 'ticket_details',
      },
      beforeSend: function(xhr){
        swal({
          title: "Obteniendo datos del ticket",
          text: "Espere mientras obtenemos toda la información",
        });
        swal.enableLoading();
      }
    })
      .done(function(data) {
        swal.close();
        console.log(data);
        let ticket_details = data.ticket_details;
        $('.ticket-order-container').find('#ticket-order').text(ticket_details.ticket_order);
        setTimeout(function() {
          show_modal(ticket_details)
        }, 500);
        btn_printer.on('click', function(){
          let options = {
            mode: 'iframe',
            popClose: true,
          };
          $("#printer").printArea(options);
        });
      });
  });

  /**
   * Obtiene el id del ticket específico y realiza la petición para eliminarlo
   * TODO: Make a view for delete the ticket from backend
   */
  $(this).on('click', '.delete-ticket', function(event) {
    let id_element = $(this).parent().siblings('.header-id').text();
    function delete_ticket() {
      $.ajax({
        url: PATH,
        method: 'POST',
        data: {
          csrfmiddlewaretoken: csrftoken,
          'ticket_id': id_element,
        },
        traditional: true,
        dataType : 'json',
        beforeSend: function(){
          swal({
            title: "Eliminando ticket",
            text: "Espere mientras se realiza la petición",
          });
          swal.enableLoading();
        },
        success: function(result) {
          swal({
            title: "Éxito",
            text: "Ticket Eliminando",
            type: "warning",
            timer: 1000,
            showConfirmButton: false
          }).then(
            function(){},
            function(dismiss){
              location.reload();
            }
          );
        }
      });
    }
    swal({
      title: '¿Estás seguro?',
      text: "No podras recuperar el ticket!",
      type: 'warning',
      showCancelButton: true,
      cancelButtonColor: '#3085d6',
      confirmButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar ticket!'
    }).then(function () {
        delete_ticket();
      },
      function(dismiss){});
  });

});
