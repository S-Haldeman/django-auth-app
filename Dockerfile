FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1
ENV PORT=8080
WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

# Run migrations without prompting, then launch gunicorn
CMD python manage.py migrate --noinput && exec gunicorn --bind 0.0.0.0:${PORT:-8080} --workers 1 --threads 8 --timeout 0 myproject.wsgi:application