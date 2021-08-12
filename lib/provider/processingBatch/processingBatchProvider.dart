import 'package:flutter/material.dart';
import 'package:fluttertest/models/batch.dart';

class PProcessingBatch with ChangeNotifier {
  List<Batch> lProcessingBatch = [];
  bool loading = true;
}
