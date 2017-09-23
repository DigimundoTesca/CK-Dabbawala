from django.shortcuts import redirect
from django.utils.deprecation import MiddlewareMixin


class HostMiddleware(MiddlewareMixin):
    @staticmethod
    def process_request(request):
        try:
            host = request.META['HTTP_HOST'] + request.META['PATH_INFO']
            if host == 'dabbanet.dabbawala.com.mx/':
                print('hola')
                return redirect('users:login')
        except KeyError:
            return None
