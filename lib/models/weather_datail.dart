// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals, prefer_typing_uninitialized_variables

class WeatherDetail {
  var lat;
  var lon;
  String? timezone;
  var timezoneOffset;
  Current? current;
  List<Minutely>? minutely;
  List<Hourly>? hourly;
  List<Daily>? daily;

  WeatherDetail(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.minutely,
      this.hourly,
      this.daily});

  WeatherDetail.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    if (json['minutely'] != null) {
      minutely = <Minutely>[];
      json['minutely'].forEach((v) {
        minutely!.add(new Minutely.fromJson(v));
      });
    }
    if (json['hourly'] != null) {
      hourly = <Hourly>[];
      json['hourly'].forEach((v) {
        hourly!.add(new Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily!.add(new Daily.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['timezone_offset'] = this.timezoneOffset;
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.minutely != null) {
      data['minutely'] = this.minutely!.map((v) => v.toJson()).toList();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.map((v) => v.toJson()).toList();
    }
    if (this.daily != null) {
      data['daily'] = this.daily!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Current {
  var dt;
  var sunrise;
  var sunset;
  var temp;
  var feelsLike;
  var pressure;
  var humidity;
  var dewPovar;
  var uvi;
  var clouds;
  var visibility;
  var windSpeed;
  var windDeg;
  List<Weather>? weather;

  Current(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPovar,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.weather});

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPovar = json['dew_povar '];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_povar '] = this.dewPovar;
    data['uvi'] = this.uvi;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather {
  var id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Minutely {
  var dt;
  var precipitation;

  Minutely({this.dt, this.precipitation});

  Minutely.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    precipitation = json['precipitation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['precipitation'] = this.precipitation;
    return data;
  }
}

class Hourly {
  var dt;
  var temp;
  var feelsLike;
  var pressure;
  var humidity;
  var dewPovar;
  var uvi;
  var clouds;
  var visibility;
  var windSpeed;
  var windDeg;
  var windGust;
  List<Weather>? weather;
  var pop;

  Hourly(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPovar,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.pop});

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPovar = json['dew_povar '];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    pop = json['pop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_povar '] = this.dewPovar;
    data['uvi'] = this.uvi;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    data['pop'] = this.pop;
    return data;
  }
}

class Daily {
  var dt;
  var sunrise;
  var sunset;
  var moonrise;
  var moonset;
  var moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  var pressure;
  var humidity;
  var dewPovar;
  var windSpeed;
  var windDeg;
  var windGust;
  List<Weather>? weather;
  var clouds;
  var pop;
  var uvi;
  var rain;

  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPovar,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.uvi,
      this.rain});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? new FeelsLike.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPovar = json['dew_povar '];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    uvi = json['uvi'];
    rain = json['rain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['moonrise'] = this.moonrise;
    data['moonset'] = this.moonset;
    data['moon_phase'] = this.moonPhase;
    if (this.temp != null) {
      data['temp'] = this.temp!.toJson();
    }
    if (this.feelsLike != null) {
      data['feels_like'] = this.feelsLike!.toJson();
    }
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_povar '] = this.dewPovar;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    data['clouds'] = this.clouds;
    data['pop'] = this.pop;
    data['uvi'] = this.uvi;
    data['rain'] = this.rain;
    return data;
  }
}

class Temp {
  var day;
  var min;
  var max;
  var night;
  var eve;
  var morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['min'] = this.min;
    data['max'] = this.max;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}

class FeelsLike {
  var day;
  var night;
  var eve;
  var morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
    data['eve'] = this.eve;
    data['morn'] = this.morn;
    return data;
  }
}
