FROM python:alpine3.6

RUN mkdir /app

COPY requirements.txt /app/
COPY hello.py /app

RUN pip install -r /app/requirements.txt

EXPOSE 5000:5000

CMD ["python", "/app/hello.py"]

