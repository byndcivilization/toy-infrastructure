import os
from flask.ext.script import Server, Manager
from flask.ext.migrate import Migrate, MigrateCommand

from app import app, db

RUN_HOST = os.getenv('RUN_HOST', '')
RUN_PORT = os.getenv('RUN_PORT', '')


app.config.from_object(os.environ['APP_SETTINGS'])

migrate = Migrate(app, db)
manager = Manager(app)

manager.add_command('db', MigrateCommand)

manager.add_command("runserver", Server(host=RUN_HOST, port=RUN_PORT))


if __name__ == '__main__':
    manager.run()
