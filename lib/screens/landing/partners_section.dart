import 'package:flutter/material.dart';

class PartnersSection extends StatelessWidget {
  const PartnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[50]!, Colors.red[50]!],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Our Partners',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.orange[800],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'We collaborate with leading organizations in waste management and smart city solutions',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildPartnerCard('Eco Solutions Inc.', Icons.eco, Colors.green),
              _buildPartnerCard(
                'Green Tech Ltd.',
                Icons.engineering,
                Colors.blue,
              ),
              _buildPartnerCard(
                'Urban Waste Mgmt',
                Icons.business,
                Colors.purple,
              ),
              _buildPartnerCard(
                'Smart City Initiative',
                Icons.location_city,
                Colors.orange,
              ),
              _buildPartnerCard(
                'Environmental Agency',
                Icons.public,
                Colors.teal,
              ),
              _buildPartnerCard(
                'Tech Innovations',
                Icons.lightbulb,
                Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard(String name, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Container(
        width: 150,
        height: 120,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
