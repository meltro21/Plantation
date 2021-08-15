class VarietyProcessModel {
  String varietyId,
      preProcessing,
      aGrade,
      bGrade,
      shake,
      compost,
      totalHours,
      noOfPlantsHarvested,
      workerName;

  VarietyProcessModel(
      {this.varietyId,
      this.preProcessing,
      this.aGrade,
      this.bGrade,
      this.shake,
      this.compost,
      this.totalHours,
      this.noOfPlantsHarvested,
      this.workerName});

  VarietyProcessModel.empty() {
    varietyId = "0";
    varietyId = "0";
    preProcessing = "0";
    bGrade = "0";
    shake = "0";
    compost = "0";
    totalHours = "0";
    noOfPlantsHarvested = "0";
    workerName = "0";
  }

  factory VarietyProcessModel.fromJson(Map<String, dynamic> json) {
    return new VarietyProcessModel(
        varietyId: json['_id'].toString(),
        preProcessing: json['PreProcessing'].toString(),
        aGrade: json['AGrade'].toString(),
        bGrade: json['BGrade'].toString(),
        shake: json['Shake'].toString(),
        compost: json['Compost'].toString(),
        totalHours: json['TotalHours'].toString(),
        noOfPlantsHarvested: json['NoOfPlantsHarvested'].toString(),
        workerName: json['WorkerName'].toString());
  }
}
