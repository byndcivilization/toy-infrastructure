import os

import redis
from rq import Worker, Queue, Connection

listen = ['default']

REDIS_HOST = os.getenv('REDIS_HOST', '')
REDIS_PORT = str(os.getenv('REDIS_PORT', ''))

conn = redis.from_url('redis://{}:{}'.format(REDIS_HOST, REDIS_PORT))

if __name__ == '__main__':
    with Connection(conn):
        worker = Worker(list(map(Queue, listen)))
        worker.work()