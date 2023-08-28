FROM python:3-alpine 
LABEL maintainer="danquahwilliam89@gmail.com"
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app

RUN python -m venv /py && \
	/py/bin/pip install --upgrade pip && \
	apk add --no-cache --update postgresql-client && \
	apk add --no-cache --update --virtual .tmp-build-deps \
		build-base postgresql-dev musl-dev && \
	/py/bin/pip install -r /tmp/requirements.txt && \
	rm -rf /tmp && \
	adduser --disabled-password --no-create-home django-user
ENV PATH="/py/bin:$PATH" 
USER django-user 

