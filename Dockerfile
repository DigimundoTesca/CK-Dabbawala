FROM python:3.6

ARG DJANGO_ENV

ENV PYTHONUNBUFFERED=1
ENV DJANGO_DIR=/CK-Dabbawala

RUN mkdir $DJANGO_DIR
ADD . $DJANGO_DIR

# Set the working directory to $DJANGO_DIR
WORKDIR $DJANGO_DIR

RUN pip install -r requirements/$DJANGO_ENV.txt

