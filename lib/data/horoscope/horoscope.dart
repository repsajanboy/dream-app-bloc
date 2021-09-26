import 'dart:convert';

class Horoscope {
    Horoscope({
        required this.dateRange,
        required this.currentDate,
        required this.description,
        required this.compatibility,
        required this.mood,
        required this.color,
        required this.luckyNumber,
        required this.luckyTime,
    });

    String dateRange;
    String currentDate;
    String description;
    String compatibility;
    String mood;
    String color;
    String luckyNumber;
    String luckyTime;

    factory Horoscope.fromJson(Map<String, dynamic> json) => Horoscope(
        dateRange: json["date_range"] as String,
        currentDate: json["current_date"] as String,
        description: json["description"] as String,
        compatibility: json["compatibility"] as String,
        mood: json["mood"] as String,
        color: json["color"] as String,
        luckyNumber: json["lucky_number"] as String,
        luckyTime: json["lucky_time"] as String,
    );

    Map<String, dynamic> toJson() => {
        "date_range": dateRange,
        "current_date": currentDate,
        "description": description,
        "compatibility": compatibility,
        "mood": mood,
        "color": color,
        "lucky_number": luckyNumber,
        "lucky_time": luckyTime,
    };
}
