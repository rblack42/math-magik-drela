FROM python:3.10.8-slim-buster

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV PYTHONWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
	apt-get -y install netcat gcc postgresql && \
	apt-get clean

RUN pip install -U pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY . .
COPY ./entrypoint.sh .
RUN chmod +x /usr/src/app/entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
