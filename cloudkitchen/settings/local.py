from cloudkitchen.settings.base import *

ALLOWED_HOSTS = ['*']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(os.path.dirname(BASE_DIR), 'db_dabbanet.sqlite3'),
    }
}

GRAPH_MODELS = {
  'all_applications': True,
  'group_models': True,
}

INTERNAL_IPS = ['127.0.0.1', 'localhost']

if os.getenv('DJANGO_TOOLBAR_IP'):
    INTERNAL_IPS += [os.getenv('DJANGO_TOOLBAR_IP')]

INSTALLED_APPS += (
    'django_extensions',
    'debug_toolbar',
)

DEBUG_TOOLBAR_PANELS = [
    'debug_toolbar.panels.versions.VersionsPanel',
    'debug_toolbar.panels.timer.TimerPanel',
    'debug_toolbar.panels.settings.SettingsPanel',
    'debug_toolbar.panels.headers.HeadersPanel',
    'debug_toolbar.panels.request.RequestPanel',
    'debug_toolbar.panels.sql.SQLPanel',
    'debug_toolbar.panels.staticfiles.StaticFilesPanel',
    'debug_toolbar.panels.templates.TemplatesPanel',
    'debug_toolbar.panels.cache.CachePanel',
    'debug_toolbar.panels.signals.SignalsPanel',
    'debug_toolbar.panels.logging.LoggingPanel',
    'debug_toolbar.panels.redirects.RedirectsPanel',
]

DEBUG_TOOLBAR_CONFIG = {
    'INTERCEPT_REDIRECTS': False,
}

MIDDLEWARE = [
    'debug_toolbar.middleware.DebugToolbarMiddleware', ] + MIDDLEWARE
