import os

#  gunicorn settings file

# proc_name = '{}-{}'.format(os.getenv('SERVICE_NAME'), os.getenv('ENVIRONMENT'))
bind = os.getenv('GUNICORN_BIND', 'localhost:4000')
workers = os.getenv('GUNICORN_WORKERS', 2)
backlog = os.getenv('GUNICORN_BACKLOG', 1024)
worker_class = os.getenv('GUNICORN_WORKER_CLASS', 'sync')
threads = os.getenv('GUNICORN_THREADS', 1)
worker_connections = os.getenv('GUNICORN_WORKER_CONNECTIONS', 1000)
max_requests = os.getenv('GUNICORN_MAX_REQUESTS', 1000)
max_requests_jitter = os.getenv('GUNICORN_MAX_REQUESTS_JITTER', 10)
timeout = os.getenv('GUNICORN_TIMEOUT', 90)
graceful_timeout = os.getenv('GUNICORN_GRACEFUL_TIMEOUT', 30)

preload_app = True
accesslog = "-"
errorlog = "-"
infolog = "-"
log_file = "-"