class RoomTime {
  String id, roomId, endDate, batchNo;

  RoomTime({this.id, this.roomId, this.endDate, this.batchNo});

  factory RoomTime.fromJson(Map<String, dynamic> json) {
    return new RoomTime(
      id: json['_id'].toString(),
      roomId: json['RoomId'].toString(),
      endDate: json['EndDate'].toString(),
      batchNo: json['BatchNo'].toString(),
    );
  }
}
