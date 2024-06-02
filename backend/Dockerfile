FROM python:3.10-slim

WORKDIR /app

RUN apt update && apt install -y ffmpeg libasound2-dev build-essential

COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]
