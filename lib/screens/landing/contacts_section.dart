import 'package:flutter/material.dart';

class ContactsSection extends StatelessWidget {
  const ContactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green[50]!, Colors.teal[50]!],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          SizedBox(height: 30),
          _buildContactInfo(
            Icons.email,
            'Email',
            'info@smartbin.com',
            Colors.red,
          ),
          _buildContactInfo(
            Icons.phone,
            'Phone',
            '+1 (555) 123-4567',
            Colors.green,
          ),
          _buildContactInfo(
            Icons.location_on,
            'Address',
            '123 Green Street, Eco City',
            Colors.blue,
          ),
          _buildContactInfo(
            Icons.access_time,
            'Business Hours',
            'Mon-Fri: 8:00 AM - 6:00 PM',
            Colors.orange,
          ),
          SizedBox(height: 40),
          Text(
            'Follow us on social media:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.facebook, Colors.blue[800]!),
              _buildSocialIcon(Icons.camera_alt, Colors.pink),
              _buildSocialIcon(Icons.link, Colors.blue[700]!),
              _buildSocialIcon(Icons.email, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(
    IconData icon,
    String type,
    String info,
    Color color,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          type,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        subtitle: Text(info, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }
}
