
      class ThingSpeakFeed {
        final int entryId;
        final DateTime createdAt;
        final double fieldValue;
      
        ThingSpeakFeed({
          required this.entryId,
          required this.createdAt,
          required this.fieldValue,
        });
      
        factory ThingSpeakFeed.fromJson(Map<String, dynamic> json) {
          return ThingSpeakFeed(
            entryId: json['entry_id'],
            createdAt: DateTime.parse(json['created_at']),
            fieldValue: double.tryParse(json['field1'] ?? '0.0') ?? 0.0,
          );
        }
      }
