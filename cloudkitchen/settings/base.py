"""
Django settings  CloudKitchen project.

Updated project with Django 2.0.2
https://docs.djangoproject.com/en/2.0/releases/2.0.2/
"""

import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

PAGE_TITLE = 'Dabbawala - Desayunos Ya!'

DEBUG = True

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv('DABBANET_SECRET_KEY')

# Application definition
DJANGO_APPS = [
    'jet',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'django.contrib.humanize',
]

THIRD_APPS = [
    'rest_framework',
    'fcm',
]

USER_APPS = [
    'users.apps.UsersConfig',
    'branchoffices.apps.BranchofficesConfig',
    'products.apps.ProductsConfig',
    'sales.apps.SalesConfig',
    'orders.apps.OrdersConfig',
    'kitchen.apps.KitchenConfig',
    'diners.apps.DinersConfig',
    'api.apps.ApiConfig',
    'webpack_loader'
]

INSTALLED_APPS = DJANGO_APPS + THIRD_APPS + USER_APPS

SITE_ID = 1

AUTH_USER_MODEL = 'users.User'

FCM_APIKEY = os.getenv('FCM_SERVER_KEY')

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'core.middlewares.HostMiddleware',
]

ROOT_URLCONF = 'cloudkitchen.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'templates'),
        ],
        'OPTIONS': {
            'debug': True,
            'loaders': [
                'django.template.loaders.filesystem.Loader',
                'django.template.loaders.app_directories.Loader',
            ],
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.template.context_processors.i18n',
                'django.template.context_processors.media',
                'django.template.context_processors.static',
                'django.template.context_processors.tz',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'cloudkitchen.wsgi.application'

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
LANGUAGE_CODE = 'es-mx.UTF-8'

TIME_ZONE = 'America/Mexico_City'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static')
]

WEBPACK_LOADER = {
    'CSS': {
        'CACHE': not DEBUG,
        'BUNDLE_DIR_NAME': '../static/css/',  # must end with slash
        'STATS_FILE': os.path.join(os.path.dirname(BASE_DIR), 'webpack-stats.json'),
        'POLL_INTERVAL': 0.1,
        'TIMEOUT': None,
        'IGNORE': ['.+\.hot-update.js', '.+\.map']
    },
    'JS': {
        'CACHE': not DEBUG,
        'BUNDLE_DIR_NAME': '../static/js/',  # must end with slash
        'STATS_FILE': os.path.join(os.path.dirname(BASE_DIR), 'webpack-stats.json'),
        'POLL_INTERVAL': 0.1,
        'TIMEOUT': None,
        'IGNORE': ['.+\.hot-update.js', '.+\.map']
    },
}

STATIC_URL = '/static/'

STATIC_ROOT = os.path.join(os.path.dirname(BASE_DIR), 'staticfiles/')

MEDIA_URL = '/media/'

MEDIA_ROOT = os.path.join(os.path.dirname(BASE_DIR), 'media/')

LOGIN_URL = '/auth/'

LOGIN_REDIRECT_URL = '/'
