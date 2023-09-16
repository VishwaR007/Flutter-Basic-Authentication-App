import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:third_app_two/notification_manager/notification_manager.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // final useStream = FirebaseFirestore.instance.collection('demo').snapshots();
  // final useStreamNotification =
  //     FirebaseFirestore.instance.collection('notification').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              "Hello Welcome ",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notification')
                  .snapshots(),
              builder: (context, snapshot) {
                List<Row> clientWidgets = [];
                if (snapshot.hasData) {
                  final clients = snapshot.data?.docs.reversed.toList();
                  for (var client in clients!) {
                    print(client['isThere']);
                    if (client['isThere'] == '1') {
                      NotificationManager().simpleNotificationShow();
                    }
                    final clientWidget = Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // children: [Text(client['isThere'])],
                    );
                    clientWidgets.add(clientWidget);
                  }
                }

                return Expanded(
                  child: ListView(
                    children: clientWidgets,
                  ),
                );
              }),

          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: TextButton(
              onPressed: () {
                NotificationManager().simpleNotificationShow();
              },
              child: Text("Get Notification"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ),

          // StreamBuilder(
          //   stream: useStreamNotification,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text("Connection Error");
          //     }
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Text("Loading ....");
          //     }

          //     var docs = snapshot.data!.docs;

          //     // return Text('${docs.length}');
          //     return ListView.builder(
          //         itemCount: docs.length,
          //         itemBuilder: (context, index) {
          //           if ((docs[index]['isThere']) == '1') {
          //             NotificationManager().simpleNotificationShow();
          //           }
          //           return ListTile(
          //             // leading: const Icon(Icons.person),
          //             title: Text(docs[index]['isThere']),
          //             // subtitle: Text(docs[index]['Lname']),
          //           );
          //         });
          //   },
          // ),
        ],
      ),
    );
  }
}
