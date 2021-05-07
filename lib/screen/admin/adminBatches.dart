import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/screen/admin/addBatch.dart';

import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:intl/intl.dart';


import '../../services/auth.dart';

class AdminBatches extends StatefulWidget {
  @override
  _AdminBatchesState createState() => _AdminBatchesState();
}

class _AdminBatchesState extends State<AdminBatches> {
  
   final AuthService _auth = AuthService();
 
  @override
  
  Widget build(BuildContext context) {
    
    PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();
    DateTime dateTime;
       return 
         Scaffold(
        appBar: AppBar(title: Text('Batches'),
        actions: [
              FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign out'))
            ],
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBatch()));
        }, label: Text('Add Batch')),

        body: Container(
          child: RefreshIndicator(
            child: PaginateFirestore(
              itemBuilderType: PaginateBuilderType.listView,
              itemBuilder: (index,context,batch){
                return GestureDetector(
                  onTap: (){
                    print('OnTap Pressed');
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualMatch(match.data()["Team1"],
                    // match.data()["Team2"], 
                    // match.data()["MatchId"],
                    // match.data()["DateTime"], match.data()['GuessTossTime'],match.data()['GuessWinTime'])));
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal:5,vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            
                            children: [
                            Text('Batch# ${batch.data()['Batch#']}',
                            style: TextStyle(
                              fontSize: 16,
                            ),),
                            Text(DateFormat().format(DateTime.parse(batch.data()['CreatedOn'])),
                            style: TextStyle(
                              fontSize: 16,
                            ),),
                            
                          ],
                          ),
                      ],)
                    ),
                  )
                );
              },
              query: FirebaseFirestore.instance.collection('Batches').orderBy('CreatedOn'),
              isLive: true,
              ), 
            onRefresh: ()async{
              refreshChangeListener.refreshed = true;
            })
        )
           );
  }
    
}

