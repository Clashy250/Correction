import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../landing/landing_page.dart';

class DashboardPage extends StatelessWidget {
  final String userName;
  final String email;

  const DashboardPage({super.key, required this.userName, required this.email});

  @override
  Widget build(BuildContext context) {
    final isAdmin = email == 'admin@smartbin.com';
    final screenSize = MediaQuery.of(context).size;

    final greeting = isAdmin
        ? "Welcome back, Admin!"
        : "Good morning, $userName!";

    // Define metrics with proper typing
    final List<Map<String, dynamic>> metrics = isAdmin
        ? [
            {
              "title": "Total Bins",
              "value": "45",
              "color": Colors.blue,
              "icon": Icons.delete,
            },
            {
              "title": "Need Attention",
              "value": "12",
              "color": Colors.orange,
              "icon": Icons.warning,
            },
            {
              "title": "Collections Today",
              "value": "23",
              "color": Colors.green,
              "icon": Icons.check_circle,
            },
          ]
        : [
            {
              "title": "My Assigned Bins",
              "value": "8",
              "color": Colors.blue,
              "icon": Icons.delete,
            },
            {
              "title": "Pending Tasks",
              "value": "3",
              "color": Colors.orange,
              "icon": Icons.pending_actions,
            },
            {
              "title": "Completed Today",
              "value": "5",
              "color": Colors.green,
              "icon": Icons.task_alt,
            },
          ];

    // Define quickActions with proper typing
    final List<Map<String, dynamic>> quickActions = isAdmin
        ? [
            {
              "title": "View All Bins",
              "icon": Icons.view_list,
              "color": Colors.blue,
            },
            {
              "title": "Analytics",
              "icon": Icons.analytics,
              "color": Colors.purple,
            },
            {
              "title": "Schedule",
              "icon": Icons.schedule,
              "color": Colors.green,
            },
            {"title": "Map View", "icon": Icons.map, "color": Colors.red},
          ]
        : [
            {"title": "My Bins", "icon": Icons.delete, "color": Colors.blue},
            {
              "title": "Report Issue",
              "icon": Icons.report_problem,
              "color": Colors.orange,
            },
            {
              "title": "Schedule",
              "icon": Icons.schedule,
              "color": Colors.green,
            },
            {"title": "Map View", "icon": Icons.map, "color": Colors.red},
          ];

    final alerts = isAdmin
        ? [
            {
              "binId": "A-101",
              "message": "Fill level critical",
              "time": "10:30 AM",
              "priority": "high",
            },
            {
              "binId": "C-303",
              "message": "Temperature high",
              "time": "09:15 AM",
              "priority": "medium",
            },
          ]
        : [
            {
              "binId": "B-202",
              "message": "Missed collection",
              "time": "08:45 AM",
              "priority": "medium",
            },
          ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: screenSize.height * 0.2,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade600, Colors.green.shade600],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  greeting,
                                  style: TextStyle(
                                    fontSize:
                                        _getResponsiveFontSize(screenSize) *
                                        1.2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Here's your waste management overview",
                                  style: TextStyle(
                                    fontSize:
                                        _getResponsiveFontSize(screenSize) *
                                        0.8,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                isAdmin
                                    ? Icons.admin_panel_settings
                                    : Icons.person,
                                color: Colors.blue.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  Provider.of<AuthService>(context, listen: false).logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
                },
              ),
            ],
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenSize.width * 0.04),
              child: Column(
                children: [
                  // Metrics Cards
                  SizedBox(height: screenSize.height * 0.02),
                  Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(screenSize) * 1.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenSize.width < 600 ? 3 : 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: metrics.length,
                    itemBuilder: (context, index) {
                      final metric = metrics[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                (metric['color'] as Color).withOpacity(0.1),
                                (metric['color'] as Color).withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                metric['icon'] as IconData,
                                size: screenSize.width * 0.08,
                                color: metric['color'] as Color,
                              ),
                              SizedBox(height: 10),
                              Text(
                                metric['value'] as String,
                                style: TextStyle(
                                  fontSize:
                                      _getResponsiveFontSize(screenSize) * 1.3,
                                  fontWeight: FontWeight.bold,
                                  color: metric['color'] as Color,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                metric['title'] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      _getResponsiveFontSize(screenSize) * 0.7,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Quick Actions
                  SizedBox(height: screenSize.height * 0.04),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenSize.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(screenSize) * 1.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: screenSize.width < 600 ? 2 : 4,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 2.5,
                              ),
                          itemCount: quickActions.length,
                          itemBuilder: (context, index) {
                            final action = quickActions[index];
                            return ElevatedButton.icon(
                              onPressed: () {
                                // Add action functionality here
                              },
                              icon: Icon(
                                action['icon'] as IconData,
                                size: _getResponsiveFontSize(screenSize) * 0.9,
                              ),
                              label: Text(
                                action['title'] as String,
                                style: TextStyle(
                                  fontSize:
                                      _getResponsiveFontSize(screenSize) * 0.8,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: action['color'] as Color,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.03,
                                  vertical: screenSize.height * 0.02,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Recent Alerts
                  SizedBox(height: screenSize.height * 0.04),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenSize.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning, color: Colors.orange),
                            SizedBox(width: 10),
                            Text(
                              "Recent Alerts",
                              style: TextStyle(
                                fontSize:
                                    _getResponsiveFontSize(screenSize) * 1.1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        ...alerts.map((alert) {
                          return Card(
                            margin: EdgeInsets.only(bottom: 10),
                            color: _getAlertColor(alert['priority'] as String),
                            child: ListTile(
                              leading: Icon(
                                Icons.warning,
                                color: _getAlertIconColor(
                                  alert['priority'] as String,
                                ),
                              ),
                              title: Text(
                                "Bin ${alert['binId']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      _getResponsiveFontSize(screenSize) * 0.9,
                                ),
                              ),
                              subtitle: Text(
                                alert['message'] as String,
                                style: TextStyle(
                                  fontSize:
                                      _getResponsiveFontSize(screenSize) * 0.8,
                                ),
                              ),
                              trailing: Text(
                                alert['time'] as String,
                                style: TextStyle(
                                  fontSize:
                                      _getResponsiveFontSize(screenSize) * 0.7,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getResponsiveFontSize(Size screenSize) {
    if (screenSize.width < 350) {
      return 14;
    } else if (screenSize.width < 600) {
      return 16;
    } else if (screenSize.width < 900) {
      return 18;
    } else {
      return 20;
    }
  }

  Color _getAlertColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red.shade50;
      case 'medium':
        return Colors.orange.shade50;
      default:
        return Colors.yellow.shade50;
    }
  }

  Color _getAlertIconColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.yellow.shade700;
    }
  }
}
