import urllib.request
import json
import sys


def get_weather():
    try:
        # Dò IP tự động qua ipinfo.io
        req = urllib.request.Request("https://ipinfo.io/json")
        req.add_header("User-Agent", "Mozilla/5.0")
        geo_req = urllib.request.urlopen(req, timeout=3)
        geo_data = json.loads(geo_req.read().decode("utf-8"))

        # Tách Vĩ độ, Kinh độ
        loc = geo_data.get("loc", "0,0").split(",")
        lat = float(loc[0])
        lon = float(loc[1])
        city = geo_data.get("city", "Unknown")

        # 2. Free siêu tốc Weather API via Open-Meteo
        weather_url = f"https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}&current_weather=true"
        weather_req = urllib.request.urlopen(weather_url, timeout=3)
        weather_data = json.loads(weather_req.read().decode("utf-8"))

        temp = int(weather_data["current_weather"]["temperature"])
        code = weather_data["current_weather"]["weathercode"]
        is_day = weather_data["current_weather"]["is_day"]

        # WMO Weather interpretation codes (Simple translation to emoji)
        icon = "⛅"  # default
        if code == 0:
            icon = "☀️" if is_day else "🌙"  # Clear sky
        elif code == 1:
            icon = "🌤️" if is_day else "🌑"  # Mainly clear
        elif code == 2:
            icon = "⛅" if is_day else "☁️"  # Partly cloudy
        elif code == 3:
            icon = "☁️"  # Overcast
        elif code in [45, 48]:
            icon = "🌫️"  # Fog
        elif code in [51, 53, 55, 56, 57]:
            icon = "🌧️"  # Drizzle
        elif code in [61, 63, 65, 66, 67]:
            icon = "🌦️" if is_day else "🌧️"  # Rain
        elif code in [71, 73, 75, 77]:
            icon = "❄️"  # Snow
        elif code in [80, 81, 82]:
            icon = "�️"  # Rain showers
        elif code in [85, 86]:
            icon = "🌨️"  # Snow showers
        elif code in [95, 96, 99]:
            icon = "⛈️"  # Thunderstorm

        print(f"{city}: {icon} +{temp}°C")

    except Exception as e:
        print("")  # Return empty if failed


if __name__ == "__main__":
    get_weather()
