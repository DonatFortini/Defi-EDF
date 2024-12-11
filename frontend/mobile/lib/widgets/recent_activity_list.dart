import 'package:flutter/material.dart';

Widget buildRecentActivityList() {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 3,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.history),
        title: Text('Car rented: Toyota Corolla'),
        subtitle: Text('2 days ago'),
      );
    },
  );
}
