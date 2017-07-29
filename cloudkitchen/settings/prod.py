from cloudkitchen.settings.base import *

DEBUG = False

ALLOWED_HOSTS = ['*']
TEMPLATES[0]['OPTIONS']['debug'] = DEBUG

SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True

# Database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.getenv('DABBANET_DB_NAME'),
        'USER': os.getenv('DABBANET_DB_USER'),
        'PASSWORD': os.getenv('DABBANET_DB_PASSWORD'),
        'HOST': os.getenv('DABBANET_DB_HOST'),
        'PORT': os.getenv('DABBANET_DB_PORT'),
    }
}

