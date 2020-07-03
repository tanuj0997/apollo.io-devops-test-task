FROM python:3.6.11-slim

WORKDIR /opt/webserver

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD python app.py
