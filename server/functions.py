# Path: server\main.py
import urllib.request
import json

def get_weather_data(lat, long):
    weather_api_endpoint = "http://api.openweathermap.org/data/2.5/air_pollution"
    weather_api_key = "ce48d24e380120ecc6703f73d38ac768"

    weather_data_link = weather_api_endpoint + "?lat=" + str(lat) + "&lon=" + str(long) + "&appid=" + weather_api_key
    # print(weather_data_link)
    weather_data = urllib.request.urlopen(weather_data_link).read()
    return json.loads(weather_data)

def get_population_density(lat, long):
    population_density_endpoint = "https://ringpopulationsapi.azurewebsites.net/api/globalringpopulations?latitude=${lat}5&longitude=${long}&distance_km=1"

    population_data = urllib.request.urlopen(population_density_endpoint).read()
    population_data = json.loads(population_data)
    return population_data
