import 'package:flutter/material.dart';
import '../auth/login_page.dart'; // Add this import

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.green[50]!],
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Icon(Icons.delete, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Smart Bin Monitoring System',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Revolutionizing waste management with smart technology',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Features
            _buildFeatureCard(
              icon: Icons.monitor_heart,
              title: 'Real-time Monitoring',
              description: 'Track bin levels in real-time',
              color: Colors.blue,
            ),
            _buildFeatureCard(
              icon: Icons.notifications,
              title: 'Smart Alerts',
              description: 'Get notified when bins need emptying',
              color: Colors.orange,
            ),
            _buildFeatureCard(
              icon: Icons.analytics,
              title: 'Data Analytics',
              description: 'Generate insights and reports',
              color: Colors.purple,
            ),
            _buildFeatureCard(
              icon: Icons.eco,
              title: 'Eco-Friendly',
              description: 'Reduce carbon footprint',
              color: Colors.green,
            ),

            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(Icons.login),
              label: Text('Get Started - Login Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 5)),
        ),
        child: ListTile(
          leading: Icon(icon, size: 40, color: color),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
