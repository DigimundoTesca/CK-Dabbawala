import swal from 'sweetalert2';
import 'bootstrap';
import { Chart } from 'chart.js';
import 'jsPDF';
import { downloadBlob } from 'download.js';
import { loadPathname, getCookie } from '../app.js';

require('../../scss/app.scss');

window.onload = function () {

  const PATH = loadPathname();

  // Declaración de botones
  const btnDownloadSalesReport = document.getElementById('btn-save-reports');

  let csrftoken = getCookie('csrftoken');
  let ctxWeek = document.getElementById("canvas-week-sales"),
    ctxDay = document.getElementById("canvas-day-sales"),
    earningsDayChart,
    earningsHourChart,
    todayDate,
    salesWeek,
    datesRange;

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
      dataType: 'json',
      traditional: true,
      async: true,
      data: {
        csrfmiddlewaretoken: csrftoken,
        type: 'dates_range'
      },
      success: function (result) {
        datesRange = result.data;
        fillDatesRangeFilter();
        setSalesData();
      },
      error: function (XMLHttpRequest, textStatus, errorThrown) {
        console.log(XMLHttpRequest, textStatus);
      }
    });

    /**
     * Método AJAX que solicita los datos de las ventas de la semana actual
     */
    function setSalesData() {
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
        success: function (result) {
          salesWeek = result.data;
          drawCharts();

          setSalesDayChart(todayDate);
          setTotalEarnings();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
          console.log(XMLHttpRequest, textStatus, errorThrown);
        }
      });

    }
  })([]);

  function convertDateToString(date) {
    let months = {
      1: 'Ene',
      2: 'Feb',
      3: 'Mar',
      4: 'Abr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Ago',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dic',
    };
    date = date.split('-');
    return date[0] + " " + months[parseInt(date[1])] + " " + date[2];
  }

  /**
   * Rellena el filtro de fechas
   */
  function fillDatesRangeFilter() {
    let selectedYear;

    $.each(datesRange, function (index, item) {
      $('#dates-range-form').find('#dt-year').append(
        "<option value=" + item.year + ">" + item.year + "</option>"
      );
    });

    selectedYear = parseInt($('#dates-range-form').find('#dt-year').val());

    $.each(datesRange, function (index, item) {
      if (datesRange[index].year === selectedYear) {
        $.each(datesRange[index].weeks_list, function (index, item) {
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
    todayDate = $('#dt-week').val().split(',')[1];
  }

  /**
   * Dibuja las gráficas de ChartJS
   */
  function drawCharts() {
    /**
     * Draws the chart of sales of the week
     */
    earningsDayChart = new Chart(ctxWeek, {
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
        onClick: function (event, legendItem) {
          try {
            // Actualiza la gráfica de ventas por hora dependiendo del día elegido
            let selectedDay = parseInt(legendItem[0]._index + 1);
            for (let i = 0; i < salesWeek.length; i++) {
              let numberDay = parseInt(salesWeek[i].number_day);
              if (numberDay === selectedDay) {
                setSalesDayChart(salesWeek[i].date);
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
    earningsHourChart = new Chart(ctxDay, {
      type: 'horizontalBar',
      data: {
        labels: [
          "Out", "15:00 - 16:00", "14:00 - 15:00", "13:00 - 14:00", "12:00 - 13:00", "11:00 - 12:00", "10:00 - 11:00", "09:00 - 10:00",
          "08:00 - 09:00", "07:00 - 08:00", "06:00 - 07:00"],
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
        onClick: function (event, legendItem) {
          try {
            console.log(legendItem[0]._index);
          } catch (error) {
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
    let totalEarnings = 0;
    let earningsList = getEarningsWeekList();
    for (let i = 0; i < earningsList.length; i++) {
      totalEarnings += earningsList[i];
    }
    totalEarnings = setDecimalFormat(totalEarnings, 2);
    $('#total-earnings-text').append(totalEarnings);
  }

  /**
   * Regresa una lista con la ganancia de cada dia de la semana utilizando la variable salesWeek
   */
  function getEarningsWeekList() {
    let earningsList = [],
      count = 0;
    while (count < salesWeek.length) {
      earningsList.push(parseFloat(salesWeek[count]['earnings']));
      count++;
    }
    return earningsList;
  }

  /**
   * Recibe un valor número y lo retorna un número con decimales (String)
   */
  function setDecimalFormat(amount, decimals) {
    let amountParts,
      regexp = /(\d+)(\d{3})/;
    amount += '';

    amount = parseFloat(amount.replace(/[^0-9.]/g, ''));
    decimals = decimals || 0;

    if (isNaN(amount) || amount === 0) {
      return parseFloat(0).toFixed(decimals);
    }

    amount = '' + amount.toFixed(decimals);
    amountParts = amount.split('.');

    while (regexp.test(amountParts[0])) {
      amountParts[0] = amountParts[0].replace(regexp, '$1' + ' ' + '$2');
    }

    return amountParts.join('.');
  }

  /**
   * Retorna una lista con las ganancias respectivas a cada día de la semana
   * utilizando la lista de objetos sales_list como argumento
   */
  function getEarningsWeekRange(salesList) {
    let weekList = [0, 0, 0, 0, 0, 0, 0,];
    for (let i = 0; i < 7; i++) {
      for (let j = 0; j < salesList.length; j++) {
        if (salesList[j].number_day === i) {
          weekList[i] = salesList[j]['earnings'];
        }
      }
    }
    return weekList;
  }

  /**
   * Recibe una hora en formato de 24 hrs y la regresa en formateada en minutos
   * El String debe tener el siguiente formato: hh:mm
   */
  function convertHoursToMinutes(originalTime) {
    let hours = parseInt(originalTime.split(':')[0]) * 60,
      minutes = parseInt(originalTime.split(':')[1]);
    return parseInt(hours + minutes);
  }

  /**
   * Recibe una hora en enteros (minutos) y la regresa en formato de 24 hrs
   * El String debe tener el siguiente formato: hh:mm
   */
  function convertMinutesToHours(originalTime) {
    let hours = parseInt(originalTime / 60),
      minutes = parseInt(originalTime % 60);
    if (hours.toString().length < 2) {
      hours = "0" + hours;
    }
    if (minutes.toString().length < 2) {
      minutes = "0" + minutes;
    }
    return hours + ':' + minutes;
  }

  /**
   * Recibe una hora y verifica si ésta, se encuentra dentro del rango de horas brindada
   * La hora recibida debe tener el siguiente formato: hh:mm
   * Si la condición se cumple retorna true, sino, retorna falso
   */
  function isHourInRange(hour, startHour, endHour) {
    let hourMinutes = convertHoursToMinutes(hour),
      startHourMinutes = convertHoursToMinutes(startHour),
      endHourMinutes = convertHoursToMinutes(endHour);
    return hourMinutes >= startHourMinutes && hourMinutes < endHourMinutes;
  }

  /**
   * Recibe un datetime con formato brindado por Python
   * Regresa el datetime convertido en formato de 24 hrs: hh:mm con Timezone +06:00
   */
  function convertPythonDatetimeFormatToHour(originalDatetime) {
    return originalDatetime.split('T')[1].split('.')[0].substr(0, 5);
  }

  /**
   * Regresa una lista con las ganancias por cada rango de fechas
   */
  function getSalesDayList(initialHour, finalHour, separationTime, salesList) {
    let initialHourMinutes,
      finalHourMinutes;
    let listFormatted = [],
      elementsOk = [],
      earnings = 0;
    initialHourMinutes = convertHoursToMinutes(initialHour);
    finalHourMinutes = convertHoursToMinutes(finalHour);
    while (initialHourMinutes < finalHourMinutes) {
      let startHourFormatted = convertMinutesToHours(initialHourMinutes),
        endHourHFormatted = convertMinutesToHours(initialHourMinutes + separationTime);
      for (let i = 0; i < salesList.length; i++) {
        let hourSale = convertPythonDatetimeFormatToHour(salesList[i].datetime);
        if (isHourInRange(hourSale, startHourFormatted, endHourHFormatted)) {
          earnings += parseFloat(salesList[i].earnings);
          elementsOk.push(salesList[i]);
        }
      }
      listFormatted.push(earnings);
      initialHourMinutes += separationTime;
      earnings = 0;
    }
    // Searches the times outside the time range
    for (let i = 0; i < salesList.length; i++) {
      if (elementsOk.indexOf(salesList[i]) === -1) {
        earnings += parseFloat(salesList[i].earnings);
      }
    }
    listFormatted.push(earnings);
    return listFormatted.reverse();
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
        'type': 'sales_day'
      },
      traditional: true,
      dataType: 'json',
      beforeSend: function () {
        swal({
          title: "Generando gráficas",
          text: "Espere mientras se calculan los datos",
        });
        swal.enableLoading();
      },
      success: function (result) {
        let salesDayEarningsList;
        let initialHour = '06:00',
          finalHour = '16:00',
          separationTime = 60; // In minutes
        let salesDayObjectList = result['sales_day_list'];

        salesDayEarningsList = getSalesDayList(initialHour, finalHour, separationTime, salesDayObjectList);

        earningsHourChart.data.datasets[0].data = salesDayEarningsList;
        earningsHourChart.update();
        swal.close();
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error(textStatus, errorThrown);
        console.error(jqXHR);
      },
    });
  }

  /**
   * Refresca los datos de las gráficas y tabla con la semana y el año elegido
   */
  $('#dt-week').change(function (event) {
    let dtYear = $('#dt-year').val(),
      dtWweek = $('#dt-week').val();
    $.ajax({
      url: PATH,
      method: 'POST',
      data: {
        csrfmiddlewaretoken: csrftoken,
        'dt_year': dtYear,
        'dt_week': dtWweek,
        'type': 'sales_week',
      },
      traditional: true,
      dataType: 'json',
      beforeSend: function () {
        swal({
          title: "Obteniendo registros",
          text: "Espere mientras obtenemos toda la información",
        });
        swal.enableLoading();
      },
      success: function (result, status, XHR) {
        let ticketsObjects = result['tickets'],
          salesWeek = result['sales'],
          weekNumber = result['week_number'],
          salesDetailsTable = $('#sales-details-table').find('tbody'),
          weekEarnings = 0;
        salesDetailsTable.empty();
        swal({
          title: "Éxito",
          text: "Datos obtenidos",
          type: "info",
          timer: 750,
          showConfirmButton: false
        }).then(
          function () { },
          function (dismiss) { });
        /**
         * Filling the sales table
         */
        for (let i = 0; i < ticketsObjects.length; i++) {
          weekEarnings += parseFloat(ticketsObjects[i].total);
          let cartridgesList = "";
          let packagesList = "";
          for (let j = 0; j < ticketsObjects[i]['cartridges'].length; j++) {
            cartridgesList += "" +
              "<span class='badge badge-success'>" +
              "<span class='badge badge-info'>" +
              ticketsObjects[i]['cartridges'][j].quantity +
              "</span>" +
              "<span class='badge badge-success'>" +
              ticketsObjects[i]['cartridges'][j].name +
              "</span>" +
              "</span>" +
              "";
          }
          for (let j = 0; j < ticketsObjects[i]['packages'].length; j++) {
            packagesList += "" +
              "<span class='badge badge-primary'>" +
              "<span class='badge badge-info'>" +
              ticketsObjects[i]['packages'][j].quantity +
              "</span>" +
              "<span class='badge badge-primary'>" +
              ticketsObjects[i]['packages'][j].name +
              "</span>" +
              "</span>" +
              "";
          }
          salesDetailsTable.append("" +
            "<tr>" +
            "<th class='header-id'>" + ticketsObjects[i].id + "</th>" +
            "<th class='header-order'>" + ticketsObjects[i].order_number + "</th>" +
            "<td class='header-date'>" + ticketsObjects[i].created_at + "</td>" +
            "<td class='header-products'>" + cartridgesList + "</td>" +
            "<td class='header-packages'>" + packagesList + "</td>" +
            "<td class='header-seller'>" + ticketsObjects[i].cashier + "</td>" +
            "<td class='td-total'>" + ticketsObjects[i].total + "</td>" +
            "<td class='header-actions'>" +
            "<span class='sales-actions delete-ticket'><i class='material-icons text-muted'>delete</i></span>" +
            "<span class='sales-actions print-ticket'><i class='material-icons text-primary'>local_printshop</i></span>" +
            "</td>" +
            "</tr>" +
            "");
        }
        earningsDayChart.data.datasets[0].data = getEarningsWeekRange(salesWeek);
        earningsDayChart.update();
        $('#total-earnings-text').text(weekEarnings.toFixed(2));
        $('#week-number').text(weekNumber);
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.log(jqXHR);
      },
      complete: function (result) { }
    });
  });

  /**
   * Obtiene la información del ticket específico y la muestra para impresión
   * TODO: Make an iframe to print the ticket
   */
  $(this).on('click', '.print-ticket', function (event) {
    let idElement = $(this).parent().siblings('.header-id').text();
    let btnPrinter = $('.btn-printer');
    let salesListModal = $('#sales-list-modal');
    let total = $(this).parent().siblings('.td-total').text();

    function iterateCartridges(element, index, array) {
      let name = element.name;
      let costBase = parseFloat(element.total) / element.quantity;
      let total = parseFloat(element.total);
      let quantity = element.quantity;
      let newListElement;

      // Formats the cost_base and total
      if (costBase % 2 !== 0) {
        costBase = costBase.toFixed(2);
      } else
        costBase += '.00';
      if (total % 2 !== 0) {
        total = total.toFixed(2);
      } else
        total += '.00';

      // Adds the list to tickets
      newListElement = $("" +
        "<li class='list-group-item'>" +
        "<span class='name-li-modal text-uppercase'>" + name + "</span> " +
        "<span class='cost-li-modal'>" + '$ ' + costBase + "</span>" +
        "<span class='quantity-li-modal'>" + quantity + "</span>" +
        "<span class='total-li-modal'>" + '$ ' + total + "</span> " +
        "</li>");

      salesListModal.append(newListElement);
    }

    function iteratePackages(element, index, array) {
      let cartridgesList = array[index].cartridges;
      let name = '';
      let costBase = parseFloat(element.total) / element.quantity;
      let total = parseFloat(element.total);
      let quantity = element.quantity;
      let newListElement;

      // Formats the names
      $.each(cartridgesList, function (index, item) {
        name += item.substring(0, 3) + ' ';
      });

      // Formats the cost_base and total
      if (costBase % 2 !== 0) {
        costBase = costBase.toFixed(2);
      } else
        costBase += '.00';
      if (total % 2 !== 0) {
        total = total.toFixed(2);
      } else
        total += '.00';

      // Adds the list to tickets
      newListElement = $("" +
        "<li class='list-group-item'>" +
        "<span class='name-li-modal text-uppercase'>" + name + "</span> " +
        "<span class='cost-li-modal'>" + '$ ' + costBase + "</span>" +
        "<span class='quantity-li-modal'>" + quantity + "</span>" +
        "<span class='total-li-modal'>" + '$ ' + total + "</span> " +
        "</li>");

      salesListModal.append(newListElement);
    }

    function showModal(ticketDetails) {
      let newListElement;

      // First reset the ticket
      salesListModal.empty();
      newListElement = ("" +
        "<li>" +
        "<span class='name-li-title-modal'>Nombre</span> " +
        "<span class='cost-li-title-modal'>Cost</span>" +
        "<span class='quantity-li-title-modal'>Cant</span>" +
        "<span class='total-li-title-modal'>Total</span> " +
        "</li>");
      salesListModal.append(newListElement);

      ticketDetails.cartridges.forEach(iterateCartridges);
      ticketDetails.packages.forEach(iteratePackages);

      $("#ticket-id").text(idElement);

      newListElement = $("" +
        "<li class='total-ticket-container mt-1'>" +
        " <span id='total-ticket'>$ <span class='total-ticket-cant'> " +
        " " + total + "</span></span> " +
        "</li>" +
        "");
      salesListModal.append(newListElement);

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
        'ticket_id': idElement,
        'type': 'ticket_details',
      },
      beforeSend: function (xhr) {
        swal({
          title: "Obteniendo datos del ticket",
          text: "Espere mientras obtenemos toda la información",
        });
        swal.enableLoading();
      }
    })
      .done(function (data) {
        swal.close();
        let ticketDetails = data.ticket_details;
        $('.ticket-order-container').find('#ticket-order').text(ticketDetails.ticket_order);
        setTimeout(function () {
          showModal(ticketDetails);
        }, 500);
        btnPrinter.on('click', function () {
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
  $(this).on('click', '.delete-ticket', function (event) {
    let idElement = $(this).parent().siblings('.header-id').text();

    function deleteTicket() {
      $.ajax({
        url: PATH,
        method: 'POST',
        data: {
          csrfmiddlewaretoken: csrftoken,
          'ticket_id': idElement,
        },
        traditional: true,
        dataType: 'json',
        beforeSend: function () {
          swal({
            title: "Eliminando ticket",
            text: "Espere mientras se realiza la petición",
          });
          swal.enableLoading();
        },
        success: function (result) {
          swal({
            title: "Éxito",
            text: "Ticket Eliminando",
            type: "warning",
            timer: 1000,
            showConfirmButton: false
          }).then(
            function () { },
            function (dismiss) {
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
      deleteTicket();
    },
      function (dismiss) { });
  });

  /**
   * Descarga el reporte de ventas
   */
  btnDownloadSalesReport.addEventListener('click', (event) => {
    let urlFile = '/ventas/reporte/';
    let sFileName;
    swal({
      title: "Generando reporte",
      text: "Espere mientras se generan los datos",
      allowOutsideClick: false,
      allowEscapeKey: false,
      allowEnterKey: false
    });
    swal.enableLoading();

    return fetch(urlFile, {
      method: 'GET'
    })
      .then((response) => {
        // Obtiene el nombre del archivo desde el header['content-disposition']
        sFileName = response.headers.get('content-disposition');
        sFileName = sFileName.split(';')[1].trim().split('=')[1];
        sFileName = sFileName.replace(/"/g, '');
        // Retorna el callback para el archivo blob
        return response.blob();
      })
      .then((blob) => {
        swal({
          title: "Éxito",
          text: "Reporte generado",
          type: "info",
          timer: 1000,
          showConfirmButton: false
        }).then(() => downloadBlob(sFileName, blob));
      });

  });
};