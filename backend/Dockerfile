FROM python:3.10-slim

WORKDIR /app

RUN apt update && apt install ffmpeg -y

COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

CMD ["flask", "run", "--host=0.0.0.0"]
