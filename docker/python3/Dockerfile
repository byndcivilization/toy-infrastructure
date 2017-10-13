#
# gcr.io/civis-demo-181920/python3
#
FROM python:3
MAINTAINER <cperry1848@gmail.com>

ENV LC_ALL en_US.utf8
RUN apt-get autoremove -y

RUN apt-get update \
   && apt-get install -y libblas-dev libatlas-dev g++ \
      libatlas-dev libatlas3-base build-essential \
      libblas3gf libopenblas-dev  \
      liblapack3 liblapacke-dev liblapacke \
      fftw-dev sfftw-dev libfftw3-dev python2.7-dev \
      libpython2.7-dev liblapack-dev \
      gfortran postgresql-client python-software-properties  \
      libpq-dev libpq5 libpqxx-dev libhiredis-dev \
      libjansson4 libmatheval1 libonig2 libperl4-corelibs-perl \
      vim libqdbm14 libsodium13 \
   && apt-get clean -y

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Add a base set of common requirements
COPY requirements.txt /usr/src/app/
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Allow for new requirements to be added when a subsequent build occurs
ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN  pip install --no-cache-dir -r requirements.txt
#ONBUILD RUN  pip install -U gcloud

# Copy source into the app folder
ONBUILD COPY . /usr/src/app

LABEL co.advisorconnect.image=gcr.io/civis-demo-181920/python3

