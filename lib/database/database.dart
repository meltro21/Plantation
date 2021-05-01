import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  final CollectionReference competitionDateTime = FirebaseFirestore.instance.collection('SetCompetitionTime');
  final CollectionReference position = FirebaseFirestore.instance.collection('Position');


  Stream<QuerySnapshot> get CompetitionDateTime{
    return  competitionDateTime.snapshots();
  }
   Stream<QuerySnapshot> get Position{
    return  position.snapshots();
  }
}