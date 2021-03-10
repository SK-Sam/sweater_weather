# Sweater Weather

## Cloning Instructions
Please click on `Code`, the green button on this Repo. Copy the HTTPS URL and open your Terminal and `cd` to whichever directory you would like to clone down to.

In your Terminal, run `git clone https://github.com/SK-Sam/sweater_weather.git` and `cd` into the dir.

Run `bundle install` in the root dir of the project. If there are GemConflicts, please switch to `Ruby 2.5.3` and `Ruby on Rails 5.2.4.5` and `Bundler 2.1.4`. If all else fails, please reach out to me and we can solve the problem! Pending Docker to be able to run `Sweater Weather`!

## Learning Goals
Mastering rendering JSON with varying statuses was a challenge to get down muscle-memory wise. Also just naturally reading through JSON and seeing what's off or going through nested data is another learning goal. After Rails Engine project and pushing to complete this, I realized I still have more to learn in terms of dynamic testing with live API's. I had troubles running VCR early on due to the queries changing often.

## API Key
You will receive an API key upon account creation, so make sure to create an account and you will be sent the API key. Please email me if the API key must be reset or changed.

## Endpoints
**Retrieve weather for a city**

`GET /api/v1/forecast?location=denver,co`

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-03-10T06:48:29.000-07:00",
                "sunrise": "2021-03-10T06:18:55.000-07:00",
                "sunset": "2021-03-10T18:01:32.000-07:00",
                "temperature": 34.50200000000008,
                "feels_like": 28.022000000000038,
                "humidity": 88,
                "uvi": 0.21,
                "visibility": 201,
                "conditions": "overcast clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "2021-03-10",
                    "sunrise": "2021-03-10T06:18:55.000-07:00",
                    "sunset": "2021-03-10T18:01:32.000-07:00",
                    "max_temp": 51.81800000000008,
                    "min_temp": 34.50200000000008,
                    "conditions": "moderate rain",
                    "icon": "10d"
                },
                {
                    "date": "2021-03-11",
                    "sunrise": "2021-03-11T06:17:20.000-07:00",
                    "sunset": "2021-03-11T18:02:34.000-07:00",
                    "max_temp": 48.38000000000004,
                    "min_temp": 34.44800000000002,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-03-12",
                    "sunrise": "2021-03-12T06:15:45.000-07:00",
                    "sunset": "2021-03-12T18:03:36.000-07:00",
                    "max_temp": 45.338000000000044,
                    "min_temp": 34.57400000000001,
                    "conditions": "rain and snow",
                    "icon": "13d"
                },
                {
                    "date": "2021-03-13",
                    "sunrise": "2021-03-13T06:14:09.000-07:00",
                    "sunset": "2021-03-13T18:04:38.000-07:00",
                    "max_temp": 38.04800000000002,
                    "min_temp": 30.848000000000024,
                    "conditions": "rain and snow",
                    "icon": "13d"
                },
                {
                    "date": "2021-03-14",
                    "sunrise": "2021-03-14T07:12:33.000-06:00",
                    "sunset": "2021-03-14T19:05:39.000-06:00",
                    "max_temp": 31.964000000000034,
                    "min_temp": 25.628000000000064,
                    "conditions": "snow",
                    "icon": "13d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "06:00:00",
                    "temperature": 34.50200000000008,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "07:00:00",
                    "temperature": 36.05,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "08:00:00",
                    "temperature": 36.95,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "09:00:00",
                    "temperature": 39.254000000000055,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "10:00:00",
                    "temperature": 41.99000000000002,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {
                    "time": "11:00:00",
                    "temperature": 45.122000000000035,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "12:00:00",
                    "temperature": 48.88399999999999,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "13:00:00",
                    "temperature": 51.458000000000006,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                }
            ]
        }
    }
}
```

**Backgrond image for the city**

`GET /api/v1/backgrounds?location=san francisco,ca`
```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "san francisco,ca",
                "image_url": "https://images.unsplash.com/photo-1601358525171-1ebae27bc4d8?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyMTMwMzV8MHwxfHNlYXJjaHwxfHxzYW4lMjBmcmFuY2lzY28sY2F8ZW58MHx8fHwxNjE1MzgxOTU5&ixlib=rb-1.2.1&q=85"
            },
            "credit": {
                "source": "https://unsplash.com",
                "author_username": "mcardosog",
                "author_name": "Marco Cardoso",
                "author_profile": "https://unsplash.com/@mcardosog"
            }
        }
    }
}
```

**User creation request**

POST /api/v1/users
Content-Type: application/json
Accept: application/json
```
Send user information through JSON like so:
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

```
response:
{
    "data": {
        "id": "2",
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "TEJKZFGZB5ayaB6SRzmJU3j5"
        }
    }
}
```

**User login request**

POST /api/v1/sessions
Content-Type: application/json
Accept: application/json
```
Send user information through JSON like so:
{
  "email": "whatever@example.com",
  "password": "password",
}
```

```
response:
{
    "data": {
        "id": "2",
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "TEJKZFGZB5ayaB6SRzmJU3j5"
        }
    }
}
```

**Roadtrip**
Make note that API key needs to be submitted to repo in order to create a roadtrip.

POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

```
Send user information through JSON like so:
{
    "origin": "madison,wi",
    "destination": "denver,co",
    "api_key": "FQq3UXADFcamViXvpVeb2oaV"
}
```

```
response:
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "madison,wi",
            "end_city": "denver,co",
            "travel_time": "13 hours 58 min",
            "weather_at_eta": {
                "conditions": "moderate rain",
                "temperature": 34.5
            }
        }
    }
}
```