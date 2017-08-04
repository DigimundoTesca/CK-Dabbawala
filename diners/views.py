# -*- encoding: utf-8 -*-
from __future__ import unicode_literals
import json
from datetime import date, datetime, timedelta
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.utils import timezone
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from django.db.models import Max, Min

from .models import AccessLog, Diner, ElementToEvaluate, SatisfactionRating
from cloudkitchen.settings.base import PAGE_TITLE
from helpers.diners_helper import DinersHelper, RatesHelper
from helpers.helpers import Helper

def diners_paginator(request, queryset, num_pages):
    result_list = Paginator(queryset, num_pages)

    try:
        num_page = int(request.GET['num_page'])
    except:
        num_page = 1

    if num_page <= 0:
        num_page = 1

    if num_page > result_list.num_pages:
        num_page = result_list.num_pages

    if result_list.num_pages >= num_page:
        page = result_list.page(num_page)

        context = {
            'queryset': page.object_list,
            'num_page': num_page,
            'pages': result_list.num_pages,
            'has_next': page.has_next(),
            'has_prev': page.has_previous(),
            'next_page': num_page + 1,
            'prev_page': num_page - 1,
            'first_page': 1,
        }
    return context

# ------------------------- Django Views ----------------------------- #
@csrf_exempt
def RFID(request):
    helper = Helper()
    diners_helper = DinersHelper()

    if request.method == 'POST':
        rfid = str(request.body).split('"')[3].replace(" ", "")
        if settings.DEBUG:
            print(rfid)

        if rfid is None:
            if settings.DEBUG:
                print('no se recibio rfid')
            return HttpResponse('No se recibió RFID\n')
        else:
            access_logs = diners_helper.get_access_logs_today()
            exists = False

            for log in access_logs:
                if rfid == log.RFID:
                    exists = True
                    break

            if exists:
                if settings.DEBUG:
                    print('El usuario ya se ha registrado')
                return HttpResponse('El usuario ya se ha registrado')
            else:
                if len(rfid) < 7:
                    try:
                        diner = Diner.objects.get(RFID=rfid)
                        new_access_log = AccessLog(diner=diner, RFID=rfid)
                        new_access_log.save()
                    except Diner.DoesNotExist:
                        new_access_log = AccessLog(diner=None, RFID=rfid)
                        new_access_log.save()
                else:
                    if settings.DEBUG:
                        print('RFID Inválido\n')
                    return HttpResponse('RFID Inválido\n')

        return HttpResponse('Operacion Terminada\n')

    else:
        return redirect('diners:diners')


def diners_login(request):
    template = 'auth/diners_login.html'
    context = {}
    return render(request, template, context)


@login_required(login_url='users:login')
def diners(request):
    diners_helpers = DinersHelper()
    diners_objects = diners_helpers.get_access_logs_today()
    total_diners = diners_objects.count()
    pag = diners_paginator(request, diners_objects, 50)
    template = 'diners.html'
    title = 'Comensales del Dia'

    context = {
        'title': PAGE_TITLE + ' | ' + title,
        'page_title': title,
        'diners': pag['queryset'],
        'paginator': pag,
        'total_diners': total_diners,
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def diners_logs(request):
    helper = Helper()
    diners_helper = DinersHelper()

    def get_diners_per_hour():
        hours_list = []
        hours_to_count = 12
        start_hour = 5
        customter_count = 0
        logs = diners_helper.get_access_logs_today()

        while start_hour <= hours_to_count:

            hour = {
                'count': None,
            }

            for log in logs:
                datetime = str(log.access_to_room)
                date, time = datetime.split(" ")
                if (time.startswith("0" + str(start_hour))):
                    customter_count += 1
                hour['count'] = customter_count

            hours_list.append(hour)
            customter_count = 0
            start_hour += 1
            total_entries = 0

        return json.dumps(hours_list)

    if request.method == 'POST':
        if request.POST['type'] == 'diners_logs_week':
            dt_year = request.POST['dt_year']
            initial_date = request.POST['dt_week'].split(',')[0]
            final_date = request.POST['dt_week'].split(',')[1]
            initial_date = helper.parse_to_datetime(initial_date)
            final_date = helper.parse_to_datetime(final_date) + timedelta(days=1)

            diners_logs = diners_helper.get_all_diners_logs_list(initial_date, final_date)
            entries = diners_helper.get_access_logs(initial_date, final_date)
            data = {
                'diners': diners_logs,
                'entries': entries,
            }
            return JsonResponse(data)

        elif request.POST['type'] == 'diners_logs_day':
            """
            Returns a list with objects:
            Each object has the following characteristics
            """
            access_logs_day_list = []
            start_date = helper.naive_to_datetime(datetime.strptime(request.POST['date'], '%d-%m-%Y').date())
            end_date = helper.naive_to_datetime(start_date + timedelta(days=1))
            access_logs = diners_helper.get_all_diners().filter(access_to_room__range=[start_date, end_date])

            for access_log in access_logs:
                """
                Filling in the sales list of the day
                """
                earnings_sale_object = {
                    'access_id': access_log.id,
                    'datetime': timezone.localtime(access_log.access_to_room),
                    'number_day': helper.get_number_day(start_date),
                }

                access_logs_day_list.append(earnings_sale_object)
            return JsonResponse({'access_logs_day_list': access_logs_day_list})

        if request.POST['type'] == 'diners_logs':
            diners_objects_list = []

            for entry in diners_helper.get_all_access_logs():
                diner_object = {
                    'id': entry.id,
                    'Nombre': '',
                    'RFID': entry.RFID,
                    'SAP': '',
                    'Fecha de Acceso': timezone.localtime(entry.access_to_room).date(),
                    'Hora de Acceso': timezone.localtime(entry.access_to_room).time(),
                }
                for diner in diners:
                    if entry.RFID == diner.RFID:
                        diner_object['SAP'] = diner.employee_number
                        diner_object['Nombre'] = diner.name

                diners_objects_list.append(diner_object)

            return JsonResponse({'diner_logs': diners_objects_list})

    else:
        all_diners_objects = diners_helper.get_all_access_logs()
        today_diners_objects = diners_helper.get_access_logs_today()
        total_diners = all_diners_objects.count()
        total_diners_today = today_diners_objects.count()

        def get_dates_range():
            """
            Returns a JSON with a years list.
            The years list contains years objects that contains a weeks list
                and the Weeks list contains a weeks objects with two attributes:
                start date and final date. Ranges of each week.
            """
            try:
                min_year = all_diners_objects.aggregate(Min('access_to_room'))['access_to_room__min'].year
                max_year = all_diners_objects.aggregate(Max('access_to_room'))['access_to_room__max'].year
                years_list = [] # [2015:object, 2016:object, 2017:object, ...]
            except Exception as e:
                if settings.DEBUG:
                    print('Error:' , e)
                return HttpResponse('No hay registros')

            while max_year >= min_year:
                year_object = { # 2015:object or 2016:object or 2017:object ...
                    'year': max_year,
                    'weeks_list': []
                }

                diners_per_year = all_diners_objects.filter(
                    access_to_room__range=[helper.naive_to_datetime(date(max_year, 1, 1)), helper.naive_to_datetime(date(max_year,12,31))])

                for diner in diners_per_year:
                    if len(year_object['weeks_list']) == 0:
                        """
                        Creates a new week_object in the weeks_list of the actual year_object
                        """
                        week_object = {
                            'week_number': diner.access_to_room.isocalendar()[1],
                            'start_date': diner.access_to_room.date().strftime("%d-%m-%Y"),
                            'end_date': diner.access_to_room.date().strftime("%d-%m-%Y"),
                        }
                        year_object['weeks_list'].append(week_object)

                        # End if
                    else:
                        """
                        Validates if exists some week with an indentical week_number of the actual year
                        If exists a same week in the list validates the start_date and the end_date,
                        In each case valid if there is an older start date or a more current end date
                            if it is the case, update the values.
                        Else creates a new week_object with the required week number
                        """
                        existing_week = False
                        for week_object in year_object['weeks_list']:
                            if week_object['week_number'] == diner.access_to_room.isocalendar()[1]:
                                # There's a same week number
                                existing_week = True
                                if datetime.strptime(week_object['start_date'], "%d-%m-%Y").date() > diner.access_to_room.date():
                                    exists = True
                                    week_object['start_date'] = diner.access_to_room.date().strftime("%d-%m-%Y")
                                elif datetime.strptime(week_object['end_date'], "%d-%m-%Y").date() < diner.access_to_room.date():
                                    week_object['end_date'] = diner.access_to_room.date().strftime("%d-%m-%Y")
                                existing_week = True
                                break

                        if not existing_week:
                            # There's a different week number
                            week_object = {
                                'week_number': diner.access_to_room.isocalendar()[1],
                                'start_date': diner.access_to_room.date().strftime("%d-%m-%Y"),
                                'end_date': diner.access_to_room.date().strftime("%d-%m-%Y"),
                            }
                            year_object['weeks_list'].append(week_object)

                        #End else
                years_list.append(year_object)
                max_year -= 1
            # End while
            return json.dumps(years_list)

        pag = diners_paginator(request, all_diners_objects, 50)
        template = 'diners_logs.html'
        title = 'Registro de comensales'
        page_title = PAGE_TITLE

        context={
            'title': PAGE_TITLE + ' | ' + title,
            'page_title': title,
            'diners': pag['queryset'],
            'paginator': pag,
            'total_diners': total_diners,
            'total_diners_today': total_diners_today,
            'diners_hour': get_diners_per_hour(),
            'diners_week': diners_helper.get_diners_actual_week(),
            'dates_range': get_dates_range(),
        }
        return render(request, template, context)


def satisfaction_rating(request):
    if request.method == 'POST':
        if request.POST['type'] == 'satisfaction_rating':
            satisfaction_rating_value = request.POST['satisfaction_rating']
            if int(satisfaction_rating_value) > 4:
                satisfaction_rating_value = 4
            elements_list = json.loads(request.POST['elements_id'])

            if request.POST['suggestion']:
                new_satisfaction_rating = SatisfactionRating.objects.create(
                    satisfaction_rating=satisfaction_rating_value,
                    suggestion=request.POST['suggestion'],
                )
            else:
                new_satisfaction_rating = SatisfactionRating.objects.create(
                    satisfaction_rating=satisfaction_rating_value
                )
            new_satisfaction_rating.save()

            for element in elements_list:
                new_element = ElementToEvaluate.objects.get(id=element)
                new_satisfaction_rating.elements.add(new_element)
                new_satisfaction_rating.save()
            return JsonResponse({'status': 'ready'})

    template = 'satisfaction_rating.html'
    title = 'Rating'
    elements = ElementToEvaluate.objects.order_by('priority').all()
    context = {
        'title': PAGE_TITLE + ' | ' + title,
        'page_title': title,
        'elements': elements,
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def analytics(request):
    helper = Helper()
    rates_helper = RatesHelper()

    if request.method == 'POST':
        if request.POST['type'] == 'reactions_day':
            start_date = helper.naive_to_datetime(datetime.strptime(request.POST['date'], '%d-%m-%Y').date())
            end_date = helper.naive_to_datetime(start_date + timedelta(days=1))
            today_suggestions = rates_helper.get_satisfaction_ratings(start_date, end_date)
            reactions_list = []
            for element_to_evaluate in rates_helper.elements_to_evaluate:
                """ For every element chart """
                element_object = {
                    'id': element_to_evaluate.id,
                    'name': element_to_evaluate.element,
                    'reactions': {
                        0: {'reaction': 'Enojado', 'quantity': 0},
                        1: {'reaction': 'Triste', 'quantity': 0},
                        2: {'reaction': 'Feliz', 'quantity': 0},
                        3: {'reaction': 'Encantado', 'quantity': 0},
                    },
                }
                for suggestion in today_suggestions:
                    for element_in_suggestion in suggestion.elements.all():
                        if element_in_suggestion == element_to_evaluate:
                            element_object['reactions'][suggestion.satisfaction_rating-1]['quantity'] += 1

                reactions_list.append(element_object)
            return JsonResponse(reactions_list, safe=False)
        elif request.POST['type'] == 'reactions_week':
            initial_date = helper.parse_to_datetime(request.POST['dt_week'].split(',')[0])
            final_date = helper.parse_to_datetime(request.POST['dt_week'].split(',')[1])
            data = {
                'week_number': helper.get_week_number(initial_date),
                'reactions': rates_helper.get_info_rates_list(initial_date, final_date),
            }
            return JsonResponse(data)

    template = 'analytics.html'
    title = 'Analytics'
    context = {
        'title': PAGE_TITLE + ' | ' + title,
        'page_title': title,
        'dates_range': rates_helper.get_dates_range(),
        'reactions_week': rates_helper.get_info_rates_actual_week(),
        'suggestions_week': rates_helper.get_info_suggestions_actual_week(),
        'elements': rates_helper.elements_to_evaluate,
        'total_elements': rates_helper.elements_to_evaluate.count(),
    }
    return render(request, template, context)


@login_required(login_url='users:login')
def suggestions(request):
    template = 'suggestions.html'
    title = 'Analytics'
    # ratings = SatisfactionRating.objects.all()
    tests = SatisfactionRating.objects.order_by('-creation_date')
    context = {
        'title': PAGE_TITLE + ' | ' + title,
        'page_title': title,
        # 'ratings': ratings,
        'tests': tests,
    }
    return render(request, template, context)


# --------------------------- TEST ------------------------
@login_required(login_url='users:login')
def test(request):
    return HttpResponse('Hola')
