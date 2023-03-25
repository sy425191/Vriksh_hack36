# Path: server\main.py
import urllib.request

def get_weather_data(lat, long):
    weather_api_endpoint = "http://api.openweathermap.org/data/2.5/air_pollution"
    weather_api_key = "ce48d24e380120ecc6703f73d38ac768"

    weather_data_link = weather_api_endpoint + "?lat=" + str(lat) + "&lon=" + str(long) + "&appid=" + weather_api_key
    # print(weather_data_link)
    weather_data = urllib.request.urlopen(weather_data_link).read()
    return weather_data