from pytz import timezone
from datetime import datetime, date, timedelta, time


class Helper(object):
    def __init__(self):
        self.tz = timezone('America/Mexico_City')
        self.days_dict = {
            'MONDAY': 'Lunes',
            'TUESDAY': 'Martes',
            'WEDNESDAY': 'Miércoles',
            'THURSDAY': 'Jueves',
            'FRIDAY': 'Viernes',
            'SATURDAY': 'Sábado',
            'SUNDAY': 'Domingo'
        }
        self.number_days_dict = {
            'Lunes': 0,
            'Martes': 1,
            'Miércoles': 2,
            'Jueves': 3,
            'Viernes': 4,
            'Sábado': 5,
            'Domingo': 6,
        }
        super(Helper, self).__init__()

    def naive_to_datetime(self, nd):
        if type(nd) == datetime:
            if nd.tzinfo is not None and nd.tzinfo.utcoffset(nd) is not None:  # Is Aware
                return nd.astimezone(self.tz)
            else:  # Is Naive
                return self.tz.localize(nd)

        elif type(nd) == date:
            d = nd
            t = time(0, 0)
            new_date = datetime.combine(d, t)
            return self.tz.localize(new_date)

    def get_name_day(self, datetime_now):
        """
        :param datetime_now: the datetime to get its name
        :type datetime_now: datetime, date
        :return: datetime name
        :rtype: str
        """
        if type(datetime_now) == datetime:
            date_now = date(datetime_now.year, datetime_now.month, datetime_now.day)
            return self.days_dict[date_now.strftime('%A').upper()]
        else:
            return self.days_dict[datetime_now.strftime('%A').upper()]

    def get_number_day(self, dt):
        return self.number_days_dict[self.get_name_day(dt)]

    def start_datetime(self, back_days):
        """
        :param back_days: int
        :return: obtained datetime
        :rtype: datetime
        """
        start_date = date.today() - timedelta(days=back_days)
        return self.naive_to_datetime(start_date)

    def end_datetime(self, back_days):
        end_date = self.start_datetime(back_days) + timedelta(days=1)
        return self.naive_to_datetime(end_date)

    def parse_to_datetime(self, dt):
        day = int(dt.split('-')[0])
        month = int(dt.split('-')[1])
        year = int(dt.split('-')[2])
        parse_date = date(year, month, day)
        return self.naive_to_datetime(parse_date)

    def are_equal_lists(self, list_1, list_2):
        """
         Checks if two lists are identical
        """
        list_1 = self.items_list_to_int(list_1)
        list_2 = self.items_list_to_int(list_2)

        list_1.sort()
        list_2.sort()

        if len(list_1) != len(list_2):
            return False
        else:
            for element in range(0, len(list_1)):
                if list_1[element] != list_2[element]:
                    return False

        return True

    def get_initial_final_week_datetime(self):
        """
        :rtype: (datetime, datetime)
        :returns: returns the monday datetime and today datetime in actual week
        """
        final_datetime = datetime.now(self.tz)
        initial_datetime = self.start_datetime(self.get_number_day(final_datetime))
        print(initial_datetime, final_datetime)
        return initial_datetime, final_datetime

    @staticmethod
    def get_week_number(dt):
        return dt.isocalendar()[1]

    @staticmethod
    def items_list_to_int(list_to_cast):
        """
        Evaluates each of the elements of the list received and casts them to integers
        """
        cast_list = []
        for item in range(0, len(list_to_cast)):
            cast_list.append(int(list_to_cast[item]))

        return cast_list
