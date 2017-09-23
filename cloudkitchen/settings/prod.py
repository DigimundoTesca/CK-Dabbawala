from cloudkitchen.settings.base import *
from boto.s3.connection import ProtocolIndependentOrdinaryCallingFormat
from boto.s3.connection import S3Connection

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

# AWS STATICS
AWS_HEADERS = {
    'Expires': 'Thu, 15 Apr 2099 20:00:00 GMT',
    'Cache-Control': 'max-age=956080000',
}

STATICFILES_LOCATION = 'static'
MEDIAFILES_LOCATION = 'media'

AWS_STORAGE_BUCKET_NAME = os.getenv('DABBANET_S3_STORAGE_BUCKET_NAME')
AWS_ACCESS_KEY_ID = os.getenv('DABBANET_S3_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = os.getenv('DABBANET_S3_SECRET_ACCESS_KEY')

STATICFILES_STORAGE = 'custom_storages.StaticStorage'
DEFAULT_FILE_STORAGE = 'custom_storages.MediaStorage'
AWS_S3_CUSTOM_DOMAIN = '%s.s3-us-west-2.amazonaws.com' % AWS_STORAGE_BUCKET_NAME
AWS_S3_SECURE_URLS = False

AWS_S3_CALLING_FORMAT = ProtocolIndependentOrdinaryCallingFormat()
S3Connection.DefaultHost = 's3-us-west-2.amazonaws.com'

STATIC_URL = "http://%s/%s/" % (AWS_S3_CUSTOM_DOMAIN, STATICFILES_LOCATION)
MEDIA_URL = "http://%s/%s/" % (AWS_S3_CUSTOM_DOMAIN, MEDIAFILES_LOCATION)