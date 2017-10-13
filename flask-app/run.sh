#!/bin/bash
gunicorn --daemon --config gunicorn.py app:app 
python worker.py