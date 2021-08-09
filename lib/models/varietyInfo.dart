class VarietyInfoModel {
  String id, enterRoomName, stage, enterRoomDate, noOfPlants, createdAt;

  VarietyInfoModel(
      {this.id,
      this.enterRoomDate,
      this.stage,
      this.enterRoomName,
      this.noOfPlants,
      this.createdAt});

  factory VarietyInfoModel.fromJson(Map<String, dynamic> json) {
    return new VarietyInfoModel(
      id: json['_id'].toString(),
      enterRoomName: json['EnterRoomName'].toString(),
      stage: json['Stage'].toString(),
      enterRoomDate: json['EnterRoomDate'].toString(),
      noOfPlants: json['NoOfPlants'].toString(),
      createdAt: json['CreatedAt'].toString(),
    );
  }
}
