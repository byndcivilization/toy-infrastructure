# This is the base image from which all python images are derived.

**This image should be rebuilt on an at least monthly basis**

This image is intended for use only as the base for another, derived
image and is not intended to stand on its own.

Features of this image along with expectations of any derived containers
built:

#### Installed packages
python2
gcloud
psycopg2
pytz
requests
sendgrid
simplejson
six
urllib3
wheel
yappi

_**Extra packages can be added on request**_

#### Features
$HOME is /usr/local/app

Upon building a derived image, the following triggers are fired:

* gCloud tools are updated
* All files from the **root** of the derived Dockerfile are copied to **/usr/local/app** in the container.
* A **requirements.txt** is expected to also live in the same directory as the Dockerfile **(even an empty one is fine)** which will be copied into the container and **pip installed**
* A small init daemon is run and will run the command given as **CMD** (_vs ENTRYPOINT which should **not** be overridden_)



