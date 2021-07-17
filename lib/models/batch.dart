class Batch {
  String id, batchNo;
  // enterRoomName,
  // enterRoomDate,
  // noOfPlantsHarvested,
  // harvestDate;

  Batch({this.id, this.batchNo
      // this.enterRoomDate,
      // this.enterRoomName,
      // this.noOfPlantsHarvested,
      // this.harvestDate
      });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return new Batch(
      id: json['_id'].toString(),
      batchNo: json['BatchNo'].toString(),
      // enterRoomName: json['EnterRoomName'].toString(),
      // enterRoomDate: json['EnterRoomDate'].toString(),
      // noOfPlantsHarvested: json['NoOfPlantsHarvested'].toString(),
      // harvestDate: json['HarvestDate'].toString(),
    );
  }
}
