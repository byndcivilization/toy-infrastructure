import os
basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SECRET_KEY = os.getenv('APP_SECRET_KEY', '')
    # db config
    DB_PORT = os.getenv('DB_PORT', '')
    DB_HOST = os.getenv('DB_HOST', '')
    DB_ROLE = os.getenv('DB_ROLE', '')
    # TODO: abstract auth stuff to kubernetes manifests
    DB_PASSWORD = os.getenv('DB_PASSWORD', '')
    DB_NAME = os.getenv('DB_NAME', '')
    SQLALCHEMY_DATABASE_URI = 'postgresql://{}:{}@{}:{}/{}'.format(
        DB_ROLE, DB_PASSWORD, DB_HOST, str(DB_PORT), DB_NAME)


class ProductionConfig(Config):
    DEBUG = False


class StagingConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
