# MyAppName

<hr>

## Purpose

MyAppName is a Flutter application designed to [describe the purpose or functionality of the app].
Backend

MyAppName depends on the backend, a [RESTFul API built with Django which uses a local PostgreSQL database].

<hr>

## How to Run and Setup
### Prerequisites
Before running MyAppName, ensure you have the following installed:
* [Flutter SDK](https://flutter-ko.dev/get-started/install)
* [Docker](https://docs.docker.com/compose/install/)

### App Setup
Clone the application from GitHub.
```bash
git clone https://github.com/NikolaOgnjenovic/EESTech.git
```

#### Backend Setup
Navigate to the backend directory and run docker-compose.yml.
```bash
cd backend
docker-compose up --build
```

#### Flutter setup
```bash
cd ../frontend
flutter pub get
```
To run MyAppName on a connected device or emulator, use the following command:
```bash
flutter run
```

#### API Docs
When the application starts, you can access the [Swagger documentation](http://localhost:5000/apidocs/).

####
