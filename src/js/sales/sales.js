import swal from 'sweetalert2';
import 'bootstrap';
import { Chart } from 'chart.js';
import jsPDF from 'jspdf-customfonts';
import { downloadBlob } from 'download.js';
import {
  loadPathname,
  getCookie,
  findParentBySelector,
  numberFormat
} from '../app.js';

require('../../scss/app.scss');
require('../utils/default_vfs.js');

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
        // Default export is a4 paper, portrait, using millimeters for units
        let doc,
          docAux,
          link,
          ticketFrame,
          imgData,
          tableTop,
          ticketDetails,
          totalCartridges,
          totalPackages,
          heightDoc;

        let textSize = 25,
          totalTicket = 0;

        ticketDetails = response['ticket_details'];
        totalCartridges = ticketDetails['cartridges'].length;
        totalPackages = ticketDetails['packages'].length;
        tableTop = 53;
        heightDoc = 70;
        console.log(ticketDetails);
        docAux = new jsPDF();
        docAux.setFontSize(7);

        //  Calcula el alto requerido para el ticket
        for (let i = 0; i < totalCartridges; i++) {
          let text = ticketDetails['cartridges'][i]['name'],
            lines = formatTicketText(text, 27);
          heightDoc += (2 * lines.length) + 1;
        }
        for (let i = 0; i < totalPackages; i++) {
          let text = ticketDetails['packages'][i]['cartridges'];
          let lines = 'DABBA - ' + text[0] + ', ' + text[1] + ', ' + text[2];
          lines = formatTicketText(lines, 27);
          heightDoc += (2 * lines.length) + 1;
        }

        doc = new jsPDF({
          unit: 'mm',
          format: [58, heightDoc]
        });

        // Agrega imagen de encabezado
        imgData = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD/wAARCAJYAlgDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9UKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAp/8svx/pTPMk/vH86f/AMsvx/pUL/coAwzqlj4f043LQeUjsFVd7Nnnnnmom13SNa04T3fk20Ab5c7iD09ga8D/AGlP2gvCXwb8IyeLvGuoCMxr5VvCjEz3DkgBRtUgfj6V+UHxr/b5+OHxVll03Rdcn8L+H2iaA2Nmyb5lzw0kgQEHGOFwB70AfrR8Uf27P2bfg/HFpPivx3bLdTAstpBb3FxKCCeqwxFQD6kjrXmFt/wVb/ZXiH2aLXL6GInJZtKuzz/wGIV+J9FAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Zf8PVf2Zv+h7uf/BTef/ItH/D1X9mb/oe7n/wU3n/yLX4m0UAftl/w9V/Zm/6Hu5/8FN5/8i0f8PVf2Zv+h7uf/BTef/ItfibRQB+2X/D1X9mb/oe7n/wU3n/yLR/w9V/Zm/6Hu5/8FN5/8i1+JtFAH7Xf8PWf2bP+hzuf/BXef/ItH/D1n9mz/oc7n/wV3n/yLX4o0UAftVa/8FR/2Yhai1u/Hs0oJ3FG0e/2dRwXMBfpnoK93+EP7THwc+M+irrXw98WWjwMcSwiC5d1bOMESIpHUV/O9VjT9QvtJvoNS026ltrq2kEsM0bbWRgcgg0Af04W8elQQjyrKG3iJIJEzPk/jU1qiTHZYjzQM+38/rX5dfsh/wDBSq+8W63p3wv+PMsYkvAsFlrICRwzXB2qqSpHGPKBwTuHGTg44r9KLDVdPsIFtJp4liuQksbbDjB5zj8aAPQfnp9Qp9+pqACiiigAooooAKKKKACiiigDjrnS7OSK11COTdJbgui4Izg8jOfavnP9rH9pL4YfA/4aPqfjC3GqNqsudN0sPMkl1cJk+WkiodijB+Y4HIHevorWvEGkaPCY3hIHkyyoNzcbQzHtjsa/nq/al+PGu/tCfF/WfGupXJOnxzyW2k24xsgtVbjGFXO85c5GfmxngUAcP8RPiJ4q+KXiq78X+MNRN1fXLEKAAscEW5mWKNR91F3HArmqKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACv0z/AOCVnxztfFut2nwS8VKsmraJbzXGgTuWJntihE0BCrtHlrggsxJBwBxX5mV0fw58d658MvHOi+PvDk7Rahol2l1EV25YDhk+YMBuUsucHrQB/TRfI05SOIbgmeenXFXEgEECwsOh/OsPwrqMWoWMV/bc+ZEJFH/Af/110KOdrO3O3HFAFmiiigAooooAKKKKACiiigDyT4h3Eth4W8byxnDx6cZD/wCAxFfza1/SP8ZCU8NeOAvGdMk/9Jq/m4oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigD+kz4Rxf8AFA6FL/07Q/8AoK16BddZ/qP515/8Jf8AkQNB/wCvGL+S16BddZ/qP50AbNFFFABRRRQAUUUUAFFFFAHjfxj/AORV8d/9gyb/ANJq/m+r+kH4x/8AIq+O/wDsGTf+k1fzfUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFexfs5fswePP2kdbu7Dwy0en6bp6/wClancJmJJT9yIDILMeuB0HJ6jOX+0B+z546/Z18ZDwn4zhjljuE82w1CAgwXiALuKEE4ILDIJyMj1FAHmNFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAH9Jnwl/5EDQf+vGL+S16BddZ/qP515/8Jf8AkQNB/wCvGL+S16BddZ/qP50AbNFFFABRRRQAUUUUAFFFFAHjfxj/AORV8d/9gyb/ANJq/m+r+kH4x/8AIq+O/wDsGTf+k1fzfUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFWrDSdU1WQxaXpt1eOOq28LSEfgoNAFWiu78P8AwI+MfiiSKLRPhxrszTHEe+1MIbp0Mm0dxXo2lfsC/tca0oaw+D1wQ3I87VtPh/SScetAHz9RX1Z4Z/4Jo/tO6/Mkd7pGiaUrd59VikPXHSMsP1r0nRf+CP8A8ctSjEt54t0e1U9Nsay/ykHtQB7z/wAErbCx8QfB6yls5wkmiX1/b3xX7w86QFu//PNo/WvX/wBsL4J2/wAX/hn4w8F6YkdxeWtitxpqhtm2dCjxOeRwSNpznrV39gf9mWP9nL4d65pcvih9bn1q9ad3+xmFA0YChoxvbso79q9/1d7DSo7/AFN4i+0CKUbmG9GIUjvj8KAP5pqK/Tn9p3/gmh4Dh8N694v+CV/fjVbRprxLBxmC6beSYIzLJ8gAPDZPQA9a/My9srzTbyfTtQtpba6tZWhnhlQq8cikhlYHkEEEEH0oAhooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigD+kz4S/8iBoP/XjF/Ja9Auus/1H868/+Ev/ACIGg/8AXjF/Ja9Auus/1H86ANmiiigAooooAKKKKACiiigDxv4x/wDIq+O/+wZN/wCk1fzfV/SD8Y/+RV8d/wDYMm/9Jq/m+oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAr0b4L/ALPXxb/aB1O+0v4VeF/7Xk0xY2vHe7ht44BJu2bmlZfvbGwBnpXnNe2/sw/tV+M/2YdZ1e88Oadb6np+uwxw39lK4jL7CdrLIUYocO44H8XtQB6rpP8AwSn/AGuNQkVbvw/oVird31iFyPwQn+ddnp//AASJ+LzbRrvjrS9PLHpHafaPr0lFeyfDj/gpx+zhqEUf/Ca+B9V0K4YjzDJeXFxGD65hQkjOe1fVPw+/aY+AvjqzSTwl4g0p4SAQst64H5lKAPiTT/8AgjLr8k0a33xpOD95IvD8QP03G8/pXoGg/wDBGv4f2YYa38QvEOpSDBx9jitx+kua+67Hxhb3IxZ6nbSEf8tU+X+YrVXUr9/u3mc/9NVoA+LrP/gk38BbRg13oWpXSjnEmpyrn/viYV1Gkf8ABN/9mrQNpj+EFrfkYyb3UZXyR/v3Br6mZ9bGFaCDnpytJNPq6H/j13E9fmUUAeZaB+zb8LtAxBpPhvS4CoAGLFXz+bmulsfht4J0/A/sKCTbyrFHH6bq71/ENhZxMI5kGcfNg/4Vh3XxGtbV8LcwBT08yQ//ABNAFE+DrYz4NnbEenl//XqwPA9k/wDy52Zz6wD/ABrzK5/aO8CaeftN58VNJgA6kSwn+SVymu/t5/ADw3JJFqHxh0ctF0Ece8g/RYjmgD3GfwR4amtFGrWsFmXBC/u3k4/4C30rlfE3wS8A6ZbDVYvDuk37SHLDykjI6YOS3NfH/wAQP+CnPwO8NaPPqXw/im8Qa3C+6ztlimhUtkfM8ssW0Ac8YP0r4/8AF/8AwUm/an1/xDPrHh3xnD4YtJZTIthZWUEqY9HaZGLn34+lAH7JW3hXw3bgTT+F4d6jCrvcYH51uWdpYWYAj8NJCR6yn+tfhk3/AAUB/a3K7IvizLEP+mek2I/9o1BL+3t+1vPjzfjHeHH/AFDLEfyhoA/eq1S4ciObToz6nzgP5VqxWDOMNokJI7/aBX8/R/bq/avIx/wuC9Uei6fZL/KGom/bk/avb73xo1f/AMB7b/43QB++v9o+GbtRN/adw4BwB5Djr+FQDTdAnAHlSvvxgb3Gf1r8Dpf22/2pZhiX4uX7f9uNp/8AGqrn9s79p4/81d1Rf92C3X+UdAH786nrVrZpGLW82Aqf+WZ4xj1Fbfh/ULjU7ZpIrnOfukgD09vrX86d1+1D+0FeyCW7+LOvysP704P6Yr9Hv+CYf7T3i74i+E/FXgzxzr0mo6noTxXEM7xqJpIJ5Rg5VADtdT7/ADUAfXfxau9K8JafqXj3xReLa6P4Us5Lue8dt7RxYL4AB3ctgdD+VfgJ8XfHrfE/4l+IfHf2NbWPV71pYIAP9VAoCRKfUhFUE9zk1+5H7XkEfxk/Z18f+CdGjMmqyaWZLWPn95OrAxLyABnp+NfgRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB/SZ8Jf+RA0H/rxi/ktegXXWf6j+def/CX/kQNB/68Yv5LXoF11n+o/nQBs0UUUAFFFFABRRRQAUUUUAeN/GP/AJFXx3/2DJv/AEmr+b6v6QfjH/yKvjv/ALBk3/pNX831ABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAVestd1zTE8vTdZvrRD/DBcPGPyBqjRQBt/wDCdeNsbf8AhMdcx6f2hN/8VRJ468bTf67xjrj/AO9qEx/9mrEooAsXOo6he/8AH5f3E/8A11lZv5mq9FFABRRRQAUUUUAFFFFABRRRQAUUUUAFe1fsefHb/hnb496B8Qrt5v7IJfT9XSI4L2cuMnoeFdY5OBk+Xgc14rRQB/Sj4r1SV9Ai06EI010dzGPuAwIPT3r8F/2y/Ab/AA6/aY8eaEsLpb3GqSalblhwyXH71scnIDu6/VTX6mf8E6Pji3xz+E1tba9cefrXh5BZXryALh41VPMGxVGGRkOOxJHavmf/AIK7fCaxg8Q6F8X9GhbzJ86Xqe1WIGMmMklsDBz0XkzDJ6ZAPziooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigD+kz4S/wDIgaD/ANeMX8lr0C66z/Ufzrz/AOEv/IgaD/14xfyWvQLrrP8AUfzoA2aKKKACiiigAooooAKKKKAPG/jH/wAir47/AOwZN/6TV/N9X9IPxj/5FXx3/wBgyb/0mr+b6gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA+t/+CZ/xcg+G37QdtoN/IkVp4rVLXzHyQs0RZ4xgKc5Bcduor9Kv2svgLefGD9nvxn4Z8OZnubm0S+sFBEf7+3cSQx5dxgNs2kn+9mvwn0vU77RdTtNY0ycwXlhPHc28oUNslRgytggg4IBwRiv6APCHi0fGH9m3w54r0cpC3iKzt2XeNxjV3Uv1AHf0FAH8+1Fen/tM/D1/hj8cvFvhVVYWq37XlmxUgG3n/eoBknIXftznqprzCgAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP6TPhL/AMiBoP8A14xfyWvQLrrP9R/OvP8A4S/8iBoP/XjF/Ja9Auus/wBR/OgDZooooAKKKKACiiigAooooA8b+Mf/ACKvjv8A7Bk3/pNX831f0g/GP/kVfHf/AGDJv/Sav5vqACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAr9Bv+CWfjrw7dR+K/hfr1y8N1aOPEGnBFkZ5Y2VYLkgqML5Q8pxk8ljgcE1+fNdx8EfiZf/B74q+G/iLYFidIvUknQY/e27fLKnIPVGYZwcHB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AUUUUAFFFFABRRRQAUUUUAFFFFABTNnvT6KAGbPnp9FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRs96KKADZ70zZ70+igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAqy/wCpH4VClFFAGdZf65Px/ka3bf8A1K/j/OiigCSiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAP/2Q==';
        doc.addImage(imgData, 'JPEG', 15 , 4 , 28, 28);

        // Añade fuentes necesarias para el ticket
        // Instrucciones en el siguiente enlace: https://github.com/sphilee/jsPDF-CustomFonts-support/issues/16#issuecomment-307174041
        doc.addFont('dosis-regular.ttf', 'Dosis', 'normal');
        doc.addFont('dosis-bold.ttf', 'Dosis', 'bold');
        doc.addFont('camingocode-regular.ttf', 'Camingo', 'normal');
        doc.addFont('camingocode-bold.ttf', 'Camingo', 'bold');

        doc.setFontSize(10);
        doc.setFont('Dosis', 'bold');
        doc.text('ORDEN ' + ticketDetails['ticket_order'], 29, 35, null, null, 'center');
        doc.setFont('Dosis', 'normal');
        doc.setFontSize(6);
        doc.text('Calle Hidalgo #78, San Lucas Tepetlaco,', 29, 40, null, null, 'center');
        doc.text('54055, Tlalnepantla, Méx', 29, 43, null, null, 'center');
        doc.setFont('Camingo', 'bold');
        doc.setFontSize(6);
        doc.text('NOMBRE \t\t  COST   CANT   TOTAL', 3, 50, null);
        doc.setFont('Camingo', 'normal');
        doc.setFontSize(5);

        // Obtiene la información del ticket para imprimirla
        for (let i = 0; i < totalCartridges; i++) {
          let quantity = ticketDetails['cartridges'][i]['quantity'],
            total = ticketDetails['cartridges'][i]['total'],
            cost = numberFormat(parseFloat(total) / quantity, 2),
            text = ticketDetails['cartridges'][i]['name'],
            lines = formatTicketText(text, textSize);

          doc.text(3, tableTop, lines, null, null, null);
          doc.text(textSize + 13, tableTop, '$ ' + cost, null, null, 'right');
          doc.text(textSize + 18, tableTop, quantity.toString(), null, null, 'center');
          doc.text(textSize + 30, tableTop, '$ ' + total, null, null, 'right');
          tableTop += (2 * lines.length) + 1;
          totalTicket += parseFloat(total);
        }

        for (let i = 0; i < totalPackages; i++) {
          let quantity = ticketDetails['packages'][i]['quantity'],
            total = ticketDetails['packages'][i]['total'],
            cost = numberFormat(parseFloat(total) / quantity, 2),
            text = ticketDetails['packages'][i]['cartridges'],
            lines = 'DABBA - ' + text[0] + ', ' + text[1] + ', ' + text[2];

          lines = formatTicketText(lines, textSize);
          doc.text(3, tableTop, lines, null, null, null);
          doc.text(textSize + 13, tableTop, '$ ' + cost, null, null, 'right');
          doc.text(textSize + 18, tableTop, quantity.toString(), null, null, 'center');
          doc.text(textSize + 30, tableTop, '$ ' + total, null, null, 'right');
          tableTop += (2 * lines.length) + 1;
          totalTicket += parseFloat(total);
        }

        // Añade Total del ticket
        doc.setFont('Camingo', 'bold');
        doc.text(textSize + 30, tableTop, '$ ' + numberFormat(totalTicket, 2), null, null, 'right');

        doc.setFont('Dosis', 'bold');
        doc.setFontSize(6);
        doc.text('ID: ' + ticketDetails['ticket_id'], 2, tableTop + 4, null);
        doc.text('Whatsapp: 55 8107 4807', 29, tableTop + 7, null, null, 'center');
        doc.setFont('Dosis', 'bold');
        doc.setFontSize(8);
        doc.text('¡GRACIAS POR SONREIR! :D', 29, tableTop + 12, null, null, 'center');

        link = doc.output('datauristring', null);
        ticketFrame = document.getElementById('ticket-modal-frame');
        ticketFrame.setAttribute("src", link);

        $('#modal-ticket').modal('show');

        // doc.save('a4.pdf');
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
   * Función que permite modificar el texto que se requiere para la información del ticket
   * @param text {string} Cadena original
   * @param size {int} Tamaño en que se separará la cadena
   */
  function formatTicketText(text, size) {
    text = text.toUpperCase();
    let aux = [];
    while (text.length > size) {
        aux.push(text.slice(0, size).trim());
        text = text.slice(size);
    }
    if (text.length > 3) {
      aux.push(text.trim());
    }
    return aux;
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
