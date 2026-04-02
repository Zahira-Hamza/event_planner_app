class Event {
  static const String collectionName = "Events";
  String id;
  String title;
  String description;
  String image;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  double lat;
  double long;
  String userId; // Added userId field

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.image,
    required this.eventName,
    required this.dateTime,
    required this.time,
    this.isFavorite = false,
    required this.lat,
    required this.long,
    required this.userId, // Added to constructor
  });

  Event.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        eventName: json['eventName'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
        time: json['time'],
        isFavorite: json['isFavorite'] ?? false,
        lat: json['lat'],
        long: json['long'],
        userId: json['userId'] ?? '', // Added to fromJson
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "eventName": eventName,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "time": time,
      "isFavorite": isFavorite,
      "lat": lat,
      "long": long,
      "userId": userId, // Added to toJson
    };
  }
}
