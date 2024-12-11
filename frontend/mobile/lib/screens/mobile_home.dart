import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import 'rent_car_form.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fleet Car Management')),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Fleet Car Management',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              _buildQuickActionCard(
                context,
                'Book a Car',
                Icons.directions_car,
                Colors.blue,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RentCarForm()),
                  );
                },
              ),
              SizedBox(height: 10),
              _buildQuickActionCard(
                context,
                'Return a Car',
                Icons.assignment_return,
                Colors.green,
                () {
                  // TODO: Implement Return a Car screen
                },
              ),
              SizedBox(height: 20),
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              _buildRecentActivityList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(width: 16),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityList() {
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
