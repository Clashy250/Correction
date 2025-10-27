import '../../models/user_role.dart';

class DashboardController {
  final UserRole role;

  DashboardController(this.role);

  String get greeting =>
      role == UserRole.admin ? "Welcome back, Admin!" : "Good morning, John!";

  List<Map<String, String>> get metrics => role == UserRole.admin
      ? [
          {"title": "Total Bins", "value": "45"},
          {"title": "Need Attention", "value": "12"},
          {"title": "Collections Today", "value": "23"},
        ]
      : [
          {"title": "My Assigned Bins", "value": "8"},
          {"title": "Pending Tasks", "value": "3"},
          {"title": "Completed Today", "value": "5"},
        ];

  List<String> get quickActions => role == UserRole.admin
      ? ["View All Bins", "Analytics", "Schedule", "Map View"]
      : ["My Bins", "Report Issue", "Schedule", "Map View"];

  List<Map<String, String>> get alerts => role == UserRole.admin
      ? [
          {
            "binId": "A-101",
            "message": "Fill level critical",
            "time": "10:30 AM",
          },
          {"binId": "C-303", "message": "Temperature high", "time": "09:15 AM"},
        ]
      : [
          {
            "binId": "B-202",
            "message": "Missed collection",
            "time": "08:45 AM",
          },
        ];
}
