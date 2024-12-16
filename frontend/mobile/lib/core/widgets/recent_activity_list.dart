import 'package:flutter/material.dart';
//TODO: Connect this widget to the backend

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
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
}
