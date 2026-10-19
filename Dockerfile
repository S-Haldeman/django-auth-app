FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1
WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

CMD sh -c "python manage.py migrate && gunicorn --bind 0.0.0.0:$PORT myproject.wsgi:application"