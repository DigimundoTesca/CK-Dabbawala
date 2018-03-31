import swal from 'sweetalert2';
import 'bootstrap';
import { Chart } from 'chart.js';
import jsPDF from 'jspdf';
import { downloadBlob } from 'download.js';
import {
  loadPathname,
  getCookie,
  findParentBySelector
} from '../app.js';

require('../../scss/app.scss');

window.onload = function () {
  const PATH = window.location.pathname;

  // Declaración de elementos
  const btnDownloadSalesReport = document.getElementById('btn-save-reports'),
    selectOptionWeek = document.getElementById('dt-week'),
    selectOptionYear = document.getElementById('dt-year');

  let csrfToken = getCookie('csrftoken');
  let canvasChartWeek = document.getElementById("canvas-week-sales"),
    canvasChartDay = document.getElementById("canvas-day-sales"),
    earningsPerDayChart,
    earningsPerHourChart,
    todayDate,
    salesWeek;

  loadPathname(PATH);

  /**
   * Función que se encarga de disparar las peticiones ajax para
   * la carga de las fechas y datos de las ventas
   */
  (function init() {
    let data = new FormData();

    // Asigna la fecha de hoy dd-mm-YYYY
    todayDate = new Date();
    todayDate = todayDate.getDate() + '-' + (todayDate.getMonth() + 1) + '-' + todayDate.getFullYear();

    // Petición al servidor para la carga los campos de rangos de fechas
    data.append('csrfmiddlewaretoken', csrfToken);
    data.append('type', 'dates_range');

    swal({
      title: 'Obteniendo ventas',
      text: 'Espere mientras obtenemos toda la información',
      customClass: 'nyan-cat',
      allowOutsideClick: false,
      allowEscapeKey: false,
      allowEnterKey: false
    });
    swal.enableLoading();

    fetch(PATH, {
      method: 'POST',
      body: data,
      credentials: 'same-origin',
    })
      .then(res => res.json())
      .then(response => {
        let datesRange = response.data;
        fillDatesRangeFilter(datesRange);
        setSalesData();
      })
      .catch(err => {
        console.error(err);
        swal({
          type: 'error',
          title: 'Oops...',
          text: 'Falló la consulta de las fechas',
          footer: 'Avisa a Soporte!',
        })
      });

    // Petición al servidor para la carga la información de ventas de la semana actual
    function setSalesData() {
      let data = new FormData();
      data.append('csrfmiddlewaretoken', csrfToken);
      data.append('type', 'sales_actual_week');

      fetch(PATH, {
        method: 'POST',
        body: data,
        credentials: 'same-origin',
      })
        .then(res => res.json())
        .then(response => {
          salesWeek = response.data;
          drawCharts();
          setTotalEarnings();
          setSalesTable();
        })
        .catch(err => {
          console.error(err);
          swal({
            type: 'error',
            title: 'Oops...',
            text: 'Falló la consulta para obtener las ventas',
            footer: 'Avisa a Soporte!',
          })
        });


    }
  })([]);

  /**
   * Función que permite formatear una fecha del formato dd-mm-yyyy a un string con mes corto
   * @param sDate - Parámetro con la fechaa convertir
   * @returns {string} - String con la fecha formateada
   */
  function convertDateToString(sDate) {
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
    sDate = sDate.split('-');
    return sDate[0] + " " + months[parseInt(sDate[1])] + " " + sDate[2];
  }

  /**
   * Rellena el filtro de fechas
   */
  function fillDatesRangeFilter(datesRange) {
    let selectYear = document.getElementsByName('select-year')[0],
      selectWeek = document.getElementsByName('select-week')[0];

    // Carga la lista de años con registros en el select list
    for (let index in datesRange) {
      if (datesRange.hasOwnProperty(index)) {
        let option = document.createElement("option");
        option.text = datesRange[index].year;
        selectYear.add(option);
      }
    }

    // Obtiene el último año cargado - Año actual
    setYearsSelect(parseInt(selectYear.value));

    function setYearsSelect(selectYearValue) {
      for (let index in datesRange) {
        if (datesRange.hasOwnProperty(index)) {
          if (datesRange[index].year === selectYearValue) {
            let weeksList = datesRange[index]['weeks_list'];
            setWeeksSelect(weeksList);
          }
        }
      }
    }

    function setWeeksSelect(weeksList) {
      for (let index in weeksList) {
        if (weeksList.hasOwnProperty(index)) {
          let option = document.createElement("option");
          let weekNumber = weeksList[index].week_number,
            startDate = weeksList[index].start_date,
            endDate = weeksList[index].end_date,
            fStartDate = convertDateToString(weeksList[index].start_date),
            fEndDate = convertDateToString(weeksList[index].end_date);

          option.text = `S-${weekNumber}: ${fStartDate}-${fEndDate}`;
          option.value = `${startDate},${endDate}`;
          selectWeek.add(option);
        }
      }
    }

  }

  /**
   * Dibuja las gráficas de ChartJS
   */
  function drawCharts() {
    /**
     * Dibuja la gráfica de ganancias de la semana
     */
    earningsPerDayChart = new Chart(canvasChartWeek, {
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
     * Dibuja la gráfica de ganancias de día
     */
    earningsPerHourChart = new Chart(canvasChartDay, {
      type: 'horizontalBar',
      data: {
        labels: [
          "Out", "15:00 - 16:00", "14:00 - 15:00", "13:00 - 14:00", "12:00 - 13:00", "11:00 - 12:00", "10:00 - 11:00", "09:00 - 10:00",
          "08:00 - 09:00", "07:00 - 08:00", "06:00 - 07:00"],
        datasets: [{
          label: 'Ventas en este horario',
          data: [],
          backgroundColor: [
            'rgba(255,235,59,0.7)',
            'rgba(255,235,59,0.7)',
            'rgba(255,235,59,0.7)',
            'rgba(255,235,59,0.7)',
            'rgba(255,235,59,0.7)',
            'rgba(77,208,225,0.7)',
            'rgba(77,208,225,0.7)',
            'rgba(77,208,225,0.7)',
            'rgba(77,208,225,0.7)',
            'rgba(77,208,225,0.7)',
            'rgba(77,208,225,0.7)'
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
    document.getElementById('total-earnings-text').textContent = totalEarnings;
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
        if (parseInt(salesList[j].number_day) === i + 1) {
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
  function setSalesDayChart(sDate) {
    let data = new FormData();

    // Petición para obtener detalles del ticket seleccionado
    data.append('csrfmiddlewaretoken', csrfToken);
    data.append('date', sDate);
    data.append('type', 'sales_day');

    swal({
      title: "Generando gráficas del día",
      text: "Espere mientras se calculan los datos",
      customClass: 'nyan-cat'
    });
    swal.enableLoading();

    fetch(PATH, {
      method: 'POST',
      body: data,
      credentials: 'same-origin',
    })
      .then(res => res.json())
      .then(response => {
        let salesDayEarningsList;
        let initialHour = '06:00',
          finalHour = '16:00',
          separationTime = 60; // In minutes
        let salesDayObjectList = response['sales_day_list'];

        salesDayEarningsList = getSalesDayList(initialHour, finalHour, separationTime, salesDayObjectList);

        earningsPerHourChart.data.datasets[0].data = salesDayEarningsList;
        earningsPerHourChart.update();
        swal.close();
      })
      .catch(err => {
        console.error(err);
        swal({
          type: 'error',
          title: 'Oops...',
          text: 'Falló la consulta del ticket',
          footer: 'Avisa a Soporte!',
        })
      });

  }

  /**
   * Obtiene la información del ticket específico y la muestra para impresión
   *    TODO: Make an iframe to print the ticket
   */
  function printTicket(event) {
    let target = event.target;
    let idElement = findParentBySelector(target, '.table-row').querySelector('.table-row-id').textContent;
    let data = new FormData();

    // Petición para obtener detalles del ticket seleccionado
    data.append('csrfmiddlewaretoken', csrfToken);
    data.append('ticketId', idElement);
    data.append('type', 'ticket_details');

    swal({
      title: "Obteniendo datos del ticket",
      text: "Espere mientras obtenemos toda la información",
      customClass: 'nyan-cat'
    });
    swal.enableLoading();

    fetch(PATH, {
      method: 'POST',
      body: data,
      credentials: 'same-origin',
    })
      .then(res => res.json())
      .then((response) => {
        // Default export is a4 paper, portrait, using milimeters for units
        let doc = new jsPDF();

        doc.text('Hello world!', 10, 10);

        let link = doc.output('datauristring'),
          ticketFrame =document.getElementById('ticket-modal-frame');
        ticketFrame.setAttribute("src", link);

        $('#modal-ticket').modal('show');

        // doc.save('a4.pdf');
        console.log(response);
        swal.close();
      })
      .catch(err => {
        console.error(err);
        swal({
          type: 'error',
          title: 'Oops...',
          text: 'Falló la consulta del ticket',
          footer: 'Avisa a Soporte!',
        })
      });
  }

  /**
   * Función que permite cargar la información de las ventas en la tabla de ventas
   */
  function setSalesTable() {
    // Get the option values
    let dtYearOption = selectOptionYear.options[selectOptionYear.selectedIndex].value,
      dtWeekOption = selectOptionWeek.options[selectOptionWeek.selectedIndex].value;

    let data = new FormData();

    // Petición para obtener detalles del ticket seleccionado
    data.append('csrfmiddlewaretoken', csrfToken);
    data.append('dt_year', dtYearOption);
    data.append('dt_week', dtWeekOption);
    data.append('type', 'sales_week');

    if (!swal.isVisible()) {
      swal({
        title: 'Obteniendo ventas',
        text: 'Espere mientras obtenemos toda la información',
        customClass: 'nyan-cat',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false
      });
      swal.enableLoading();
    }
    fetch(PATH, {
      method: 'POST',
      body: data,
      credentials: 'same-origin',
    })
      .then(res => res.json())
      .then(response => {
        let ticketsObjects = response['tickets'],
          weekNumber = response['week_number'];

        // Crea la lista de objetos para las ventas
        salesWeek = response['sales'];

        // Envía el objeto de tickets a la función para la creación de las filas de la tabla de ventas
        updateSalesTableRows(ticketsObjects);

        // Actualiza las gráficas de ventas
        earningsPerDayChart.data.datasets[0].data = getEarningsWeekRange(salesWeek);
        earningsPerDayChart.update();

        document.getElementById('week-number').textContent = weekNumber;

        swal({
          title: "Éxito",
          text: "Ventas obtenidss",
          type: "info",
          timer: 750,
          showConfirmButton: false
        }).then(
          function () { },
          function (dismiss) { });
      })
      .catch(err => {
        console.log(err);
        swal({
          type: 'error',
          title: 'Oops...',
          text: 'Falló la consulta del los datos',
          footer: 'Avisa a Soporte!',
        })
      });

    // Rellena las filas de la tabla
    function updateSalesTableRows(ticketsObjects) {
      let salesDetailsTable = document.getElementById('sales-details-table').getElementsByTagName('tbody')[0],
        weekEarnings = 0;

      // Limpia la tabla de filas anteriores
      while (salesDetailsTable.firstChild) {
        salesDetailsTable.removeChild(salesDetailsTable.firstChild);
      }

      // Ingresa una a una las nuevas filas
      for (let i = 0; i < ticketsObjects.length; i++) {
        weekEarnings += parseFloat(ticketsObjects[i].total);
        let cartridgesList = "",
          packagesList = "";

        let rowTable,
          cellTable,
          iconContainer,
          iconAction;

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

        rowTable = salesDetailsTable.appendChild(document.createElement('tr'));
        // Ticket id
        rowTable.className = 'table-row';
        cellTable = rowTable.appendChild(document.createElement('th'));
        cellTable.className = 'table-row-id';
        cellTable.innerHTML = ticketsObjects[i].id;
        // Número de orden
        cellTable = rowTable.appendChild(document.createElement('th'));
        cellTable.className = 'table-row-order';
        cellTable.innerHTML = ticketsObjects[i].order_number;
        // Fecha
        cellTable = rowTable.appendChild(document.createElement('td'));
        cellTable.className = 'table-row-date';
        cellTable.innerHTML = ticketsObjects[i].created_at;
        // Productos
        cellTable = rowTable.appendChild(document.createElement('td'));
        cellTable.className = 'table-row-products';
        cellTable.innerHTML = cartridgesList;
        // Paquetes
        cellTable = rowTable.appendChild(document.createElement('td'));
        cellTable.className = 'table-row-packages';
        cellTable.innerHTML = packagesList;
        // Vendedor
        cellTable = rowTable.appendChild(document.createElement('td'));
        cellTable.className = 'table-row-seller';
        cellTable.innerHTML = ticketsObjects[i].cashier;
        // Total
        cellTable = rowTable.appendChild(document.createElement('td'));
        cellTable.className = 'table-row-total';
        cellTable.innerHTML = ticketsObjects[i].total;
        // Acciones
        cellTable = rowTable.appendChild(document.createElement('td'));
        cellTable.className = 'table-row-actions';
        // Acciones -> boton eliminar
        iconContainer = document.createElement('span');
        iconContainer.className = 'delete-ticket sales-actions';
        iconAction = iconContainer.appendChild(document.createElement('i'));
        iconAction.innerHTML = 'delete';
        iconAction.className = 'material-icons text-muted';
        cellTable.appendChild(iconContainer);

        // Agrega el listener al botón de eliminar creado
        document.addEventListener('click', deleteTicketListener(iconAction));

        // Acciones -> Botón imprimir
        iconContainer = document.createElement('span');
        iconContainer.className = 'delete-ticket print-ticket';
        iconAction = iconContainer.appendChild(document.createElement('i'));
        iconAction.innerHTML = 'local_printshop';
        iconAction.className = 'material-icons text-primary';
        cellTable.appendChild(iconContainer);
        // Agrega el listener al botón de impresión creado
        document.addEventListener('click', printTicketListener(iconAction));
      }

      // Actualiza la etiqueta de ventas de la semana
      document.getElementById('total-earnings-text').textContent = weekEarnings.toFixed(2);

    }

  }

  /**
   * Función encargada de realizar la eliminación del ticket
   */
  function deleteTicket(idTicket) {
    let data = new FormData();

    // Petición para obtener detalles del ticket seleccionado
    data.append('csrfmiddlewaretoken', csrfToken);
    data.append('ticketId', idTicket);

    swal({
      title: "Eliminando ticket",
      text: "Espere mientras se realiza la petición",
      customClass: 'nyan-cat'
    });
    swal.enableLoading();

    fetch(PATH + 'eliminar/', {
      method: 'POST',
      body: data,
      credentials: 'same-origin',
    })
      .then(res => res.json())
      .then(response => {
        swal({
          title: "Éxito",
          text: "Ticket Eliminando",
          type: "warning",
          timer: 2000,
          showConfirmButton: false
        })
          .then((result) => {
            location.reload();
          });
      })
      .catch(err => {
        console.error(err);
        swal({
          type: 'error',
          title: 'Oops...',
          text: 'Falló la eliminación del ticket',
          footer: 'Avisa a Soporte!',
        })
      });
  }

  /**
   * Función encargada de solicitar confirmación para eliminar el ticket
   */
  function deleteTicketConfirm(event) {
    let target = event.target;
    let idElement = findParentBySelector(target, '.table-row').querySelector('.table-row-id').textContent;

    swal({
      title: '¿Estás seguro?',
      text: "No podras recuperar el ticket!",
      type: 'warning',
      showCancelButton: true,
      cancelButtonColor: '#3085d6',
      confirmButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar ticket!'
    })
      .then((result) => {
        if (result.value) {
          deleteTicket(idElement);
        }
      });
  }

  /**
   * LISTENERS
   *
   */

  /**
   * Agrega a un eemento .delete-ticket un listener para la eliminación de tickets
   */
  function deleteTicketListener(el) {
    el.addEventListener('click', deleteTicketConfirm);
  }

  /**
   * Agregar a un elemento .print-ticket un listener para la impresión de tickets
   */
  function printTicketListener(el) {
    el.addEventListener('click', printTicket);
  }

  /**
   * Descarga el reporte de ventas
   */
  btnDownloadSalesReport.addEventListener('click', (event) => {
    let urlFile = '/ventas/reporte/';
    let sFileName;
    swal({
      title: "Generando reporte",
      text: "Espere mientras se generan los datos",
      customClass: 'nyan-cat',
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

  /**
   * Refresca los datos de las gráficas y tabla con la semana y el año elegido
   */
  selectOptionWeek.addEventListener('click', setSalesTable);
};
