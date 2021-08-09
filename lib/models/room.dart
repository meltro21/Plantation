class Room {
  String id, name;
  Room({this.id, this.name});
  factory Room.fromJson(Map<String, dynamic> json) {
    return new Room(
      id: json['_id'].toString(),
      name: json['RoomName'].toString(),
    );
  }
}
