import json
from datetime import datetime, date, timedelta

from django.db.models import Min, Max
from django.utils import timezone

from diners.models import AccessLog, Diner, SatisfactionRating, ElementToEvaluate
from helpers.helpers import Helper


class DinersHelper(object):
    def __init__(self):
        self.__all_diners = None
        self.__all_access_logs = None
        super(DinersHelper, self).__init__()

    def get_all_diners_logs_list(self, initial_date, final_date):
        helper = Helper()
        diners_logs_list = []

        diners_logs_objects = self.get_access_logs(initial_date, final_date)

        for diner_log in diners_logs_objects:
            diner_log_object = {
                'rfid': diner_log.RFID,
                'access': datetime.strftime(timezone.localtime(diner_log.access_to_room), "%B %d, %I, %H:%M:%S %p"),
                'number_day': helper.get_number_day(diner_log.access_to_room),
            }
            if diner_log.diner:
                diner_log_object['SAP'] = diner_log.diner.employee_number
                diner_log_object['name'] = diner_log.diner.name
            else:
                diner_log_object['SAP'] = ''
                diner_log_object['name'] = ''
            diners_logs_list.append(diner_log_object)
        return diners_logs_list

    def get_weeks_entries(self, initial_dt, final_dt):
        """
        Gets the following properties for each week's day: Name, Date and Earnings
        """
        if self.__all_access_logs is None:
            self.set_all_access_logs()

        helper = Helper()
        limit_day = initial_dt + timedelta(days=1)
        weeks_list = []
        count = 1
        total_days = (final_dt - initial_dt).days

        while count <= total_days:
            diners_entries = self.__all_access_logs.filter(access_to_room__range=[initial_dt, limit_day])
            day_object = {
                'date': str(timezone.localtime(initial_dt).date().strftime('%d-%m-%Y')),
                'day_name': helper.get_name_day(initial_dt.date()), 'entries': diners_entries.count(),
                'number_day': helper.get_number_day(initial_dt)}

            weeks_list.append(day_object)

            # Reset data
            limit_day += timedelta(days=1)
            initial_dt += timedelta(days=1)
            count += 1

        return weeks_list

    def get_access_logs(self, initial_date, final_date):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_access_logs is None:
            self.set_all_access_logs()

        return self.__all_access_logs. \
            filter(access_to_room__range=(initial_date, final_date)). \
            order_by('-access_to_room')

    def get_access_logs_today(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_access_logs is None:
            self.set_all_access_logs()

        helper = Helper()
        year = int(datetime.now().year)
        month = int(datetime.now().month)
        day = int(datetime.now().day)
        initial_date = helper.naive_to_datetime(date(year, month, day))
        final_date = helper.naive_to_datetime(initial_date + timedelta(days=1))
        return self.__all_access_logs. \
            filter(access_to_room__range=(initial_date, final_date)). \
            order_by('-access_to_room')

    def get_all_access_logs(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_access_logs is None:
            self.set_all_access_logs()
        return self.__all_access_logs

    def get_diners_per_hour_json(self):
        hours_list = []
        hours_to_count = 12
        start_hour = 5
        customer_count = 0
        logs = self.get_access_logs_today()

        while start_hour <= hours_to_count:
            hour = {'count': None, }
            for log in logs:
                log_datetime = str(log.access_to_room)
                log_date, log_time = log_datetime.split(" ")

                if log_time.startswith("0" + str(start_hour)):
                    customer_count += 1
                hour['count'] = customer_count

            hours_list.append(hour)
            customer_count = 0
            start_hour += 1

        return json.dumps(hours_list)

    def get_diners_actual_week(self):
        if self.__all_access_logs is None:
            self.set_all_access_logs()
        helper = Helper()
        week_diners_list = []
        total_entries = 0
        days_to_count = helper.get_number_day(date.today())
        day_limit = days_to_count
        start_date_number = 0

        while start_date_number <= day_limit:
            day_object = {
                'date': str(helper.start_datetime(days_to_count).date().strftime('%d-%m-%Y')),
                'day_name': None,
                'entries': None,
                'number_day': helper.get_number_day(helper.start_datetime(days_to_count).date())
            }

            logs = self.__all_access_logs. \
                filter(access_to_room__range=[helper.start_datetime(days_to_count), helper.end_datetime(days_to_count)])

            for _ in logs:
                total_entries += 1

            day_object['entries'] = str(total_entries)
            day_object['day_name'] = helper.get_name_day(helper.start_datetime(days_to_count).date())

            week_diners_list.append(day_object)

            # restarting counters
            days_to_count -= 1
            total_entries = 0
            start_date_number += 1

        return json.dumps(week_diners_list)

    def get_all_diners(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_diners is None:
            self.set_all_diners()
        return self.__all_diners

    def set_all_access_logs(self):
        self.__all_access_logs = AccessLog.objects.select_related('diner').order_by('-access_to_room')

    def set_all_diners(self):
        self.__all_diners = Diner.objects.all()


class RatesHelper(object):
    def __init__(self):
        super(RatesHelper, self).__init__()
        self.__all_satisfaction_ratings = None
        self.__elements_to_evaluate = None

    @property
    def satisfaction_ratings(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__all_satisfaction_ratings is None:
            self.set_all_satisfaction_ratings()
        return self.__all_satisfaction_ratings

    @property
    def elements_to_evaluate(self):
        """
        :rtype: django.db.models.query.QuerySet
        """
        if self.__elements_to_evaluate is None:
            self.set_elements_to_evaluate()
        return self.__elements_to_evaluate

    def get_dates_range(self):
        """
        Returns a JSON with a years list.
        The years list contains years objects that contains a weeks list
            and the Weeks list contains a weeks objects with two attributes:
            start date and final date. Ranges of each week.
        """
        helper = Helper()
        try:
            min_year = self.satisfaction_ratings.aggregate(Min('creation_date'))['creation_date__min'].year
            max_year = self.satisfaction_ratings.aggregate(Max('creation_date'))['creation_date__max'].year
            years_list = []  # [2015:object, 2016:object, 2017:object, ...]
        except:
            min_year = datetime.now().year
            max_year = datetime.now().year
            years_list = []  # [2015:object, 2016:object, 2017:object, ...]

        while max_year >= min_year:
            year_object = {  # 2015:object or 2016:object or 2017:object ...
                'year': max_year,
                'weeks_list': [],
            }

            ratings_per_year = self.satisfaction_ratings.filter(
                creation_date__range=[
                    helper.naive_to_datetime(date(max_year, 1, 1)),
                    helper.naive_to_datetime(date(max_year, 12, 31))])

            for rating in ratings_per_year:
                if not year_object['weeks_list']:
                    """
                    Creates a new week_object in the weeks_list of the actual year_object
                    """
                    week_object = {
                        'week_number': rating.creation_date.isocalendar()[1],
                        'start_date': rating.creation_date.date().strftime("%d-%m-%Y"),
                        'end_date': rating.creation_date.date().strftime("%d-%m-%Y"),
                    }
                    year_object['weeks_list'].append(week_object)
                    # End if
                else:
                    """
                    Validates if exists some week with an similar week_number of the actual year
                    If exists a same week in the list validates the start_date and the end_date,
                    In each case valid if there is an older start date or a more current end date
                        if it is the case, update the values.
                    Else creates a new week_object with the required week number
                    """
                    existing_week = False
                    for week_object in year_object['weeks_list']:

                        if week_object['week_number'] == rating.creation_date.isocalendar()[1]:
                            # There's a same week number
                            if datetime.strptime(week_object['start_date'], "%d-%m-%Y").date() > \
                                    rating.creation_date.date():
                                week_object['start_date'] = rating.creation_date.date().strftime("%d-%m-%Y")
                            elif datetime.strptime(week_object['end_date'], "%d-%m-%Y").date() < \
                                    rating.creation_date.date():
                                week_object['end_date'] = rating.creation_date.date().strftime("%d-%m-%Y")

                            existing_week = True
                            break

                    if not existing_week:
                        # There's a different week number
                        week_object = {
                            'week_number': rating.creation_date.isocalendar()[1],
                            'start_date': rating.creation_date.date().strftime("%d-%m-%Y"),
                            'end_date': rating.creation_date.date().strftime("%d-%m-%Y"),
                        }
                        year_object['weeks_list'].append(week_object)

                        # End else
            # End While
            year_object['weeks_list'].reverse()
            years_list.append(year_object)
            max_year -= 1
        # End while
        return json.dumps(years_list)

    def get_satisfaction_ratings(self, initial_date: datetime, final_date: datetime):
        helper = Helper()
        initial_date = helper.naive_to_datetime(initial_date)
        final_date = helper.naive_to_datetime(final_date)
        if self.__all_satisfaction_ratings is None:
            self.set_all_satisfaction_ratings()
        return self.__all_satisfaction_ratings.filter(
            creation_date__range=[initial_date, final_date]).order_by('-creation_date')

    def get_info_rates_list(self, initial_date: datetime, final_date: datetime):
        """
        Returns a list with all the rates data for te selected range
        :rtype: list
        """
        helper = Helper()
        week_suggestions_list = []

        while initial_date <= final_date:
            day_object = {
                'date': str(initial_date.strftime('%d-%m-%Y')),
                'day_name': None,
                'total_rates': None,
                'number_day': helper.get_number_day(initial_date),
            }

            filtered_suggestions = self.satisfaction_ratings.filter(
                creation_date__range=[
                    helper.naive_to_datetime(initial_date),
                    helper.naive_to_datetime(initial_date + timedelta(days=1))])

            day_object['total_rates'] = str(filtered_suggestions.count())
            day_object['day_name'] = helper.get_name_day(initial_date)
            week_suggestions_list.append(day_object)

            # restarting counters
            initial_date = initial_date + timedelta(days=1)

        return week_suggestions_list

    def get_info_rates_actual_week(self):
        """
        Gets the following properties for each week's day: Day name, Date, number day and total rates
        :rtype: list
        """
        helper = Helper()
        week_suggestions_list = []
        days_to_count = helper.get_number_day(datetime.now())
        day_limit = days_to_count
        start_date_number = 0

        while start_date_number <= day_limit:
            day_object = {
                'date': str(helper.start_datetime(days_to_count).date().strftime('%d-%m-%Y')),
                'day_name': None,
                'total_rates': None,
                'number_day': helper.get_number_day(helper.start_datetime(days_to_count).date()),
            }

            filtered_suggestions = self.satisfaction_ratings.filter(
                creation_date__range=[helper.start_datetime(days_to_count), helper.end_datetime(days_to_count)])

            day_object['total_rates'] = str(filtered_suggestions.count())
            day_object['day_name'] = helper.get_name_day(helper.start_datetime(days_to_count).date())

            week_suggestions_list.append(day_object)

            # restarting counters
            days_to_count -= 1
            start_date_number += 1

        return json.dumps(week_suggestions_list)

    def get_info_suggestions_actual_week(self):
        """
        Gets the following properties for each week's day: Day name, Date, number day and total suggestions
        :rtype: list
        """
        helper = Helper()
        week_suggestions_list = []
        days_to_count = helper.get_number_day(datetime.now())
        day_limit = days_to_count
        start_date_number = 0

        while start_date_number <= day_limit:
            day_object = {
                'date': str(helper.start_datetime(days_to_count).date().strftime('%d-%m-%Y')),
                'day_name': None,
                'total_suggestions': None,
                'number_day': helper.get_number_day(helper.start_datetime(days_to_count).date()),
            }

            filtered_suggestions = self.satisfaction_ratings.filter(
                creation_date__range=[helper.start_datetime(days_to_count), helper.end_datetime(days_to_count)]). \
                exclude(suggestion__isnull=True)

            day_object['total_suggestions'] = str(filtered_suggestions.count())
            day_object['day_name'] = helper.get_name_day(helper.start_datetime(days_to_count).date())

            week_suggestions_list.append(day_object)

            # restarting counters
            days_to_count -= 1
            start_date_number += 1

        return json.dumps(week_suggestions_list)

    def set_all_satisfaction_ratings(self):
        self.__all_satisfaction_ratings = SatisfactionRating.objects \
            .prefetch_related('elements').all()

    def set_elements_to_evaluate(self):
        self.__elements_to_evaluate = ElementToEvaluate.objects.order_by('priority').all()
