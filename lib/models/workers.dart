class WorkerModel {
  String firestoreId, userName;

  WorkerModel({this.firestoreId, this.userName});

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return new WorkerModel(
        firestoreId: json['FirestoreId'].toString(),
        userName: json['UserName'].toString());
  }
}
