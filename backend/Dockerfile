FROM python:3.10-slim

RUN apt-get update && apt-get install -y gcc libasound2-dev

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app

CMD ["flask", "run", "--host=0.0.0.0"]
