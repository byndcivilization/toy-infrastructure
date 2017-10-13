#
# gcr.io/civis-demo-181920/flask-app
#
FROM us.gcr.io/civis-demo-181920/python3:latest
MAINTAINER <cperry1848@gmail.com>

LABEL co.civis-demo.image=us.gcr.io/civis-demo-181920/flask-app

#
# ONBUILD commands that run as a reuslt of instructions from
#         the parent container:
#
#    * requirements.txt is copied to the container
#    * pip install of the requirements is run
#    * All source co-located with the Dockerfile is copied
#      to /usr/local/app
#

CMD ["bash", "./run.sh"]