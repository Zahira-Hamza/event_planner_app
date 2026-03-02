class Event {
  //data class-model
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  double lat;
  double long;

  Event({
    this.id = "",
    required this.image,
    required this.title,
    required this.description,
    required this.eventName,
    required this.dateTime,
    required this.time,
    this.isFavorite = false,
    this.lat = 0,
    this.long = 0,
  });

  //todo:json=>object   ///from fireStore(الداتا اللى جايالى)
  Event.fromJson(Map<String, dynamic> jsonData)
    : this(
        id: jsonData['id'],
        image: jsonData['image'],
        title: jsonData['title'],
        description: jsonData['description'],
        eventName: jsonData['eventName'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(jsonData['dateTime']),
        time: jsonData['time'],
        isFavorite: jsonData['isFavorite'],
        lat: jsonData['lat'] ?? 0,
        long: jsonData['long'] ?? 0,
      );

  //todo:object=>json
  Map<String, dynamic> toJson() {
    ///to fireStore
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'eventName': eventName,
      'dateTime': dateTime.millisecondsSinceEpoch,

      ///string(object of dateTime)->int to do any operation on the time
      'time': time,
      'isFavorite': isFavorite,
      'lat': lat,
      'long': long,
    };
  }
}
