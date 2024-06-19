class TimelineEvent {
  final int id;
  final String itemType;
  final TimelineEventItem eventItem;
  final DateTime eventStartAt;
  final DateTime eventEndAt;
  final int progress;

  TimelineEvent({
    required this.id,
    required this.itemType,
    required this.eventItem,
    required this.eventEndAt,
    required this.eventStartAt,
    required this.progress,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) => TimelineEvent(
        id: json['id'],
        itemType: json['item_type'],
        eventItem: (json['item_type'] as String).contains('Meal')
            ? MealEventItem.fromJson(json['event_item'])
            : ExerciseEventItem.fromJson(json['event_item']),
        eventStartAt: DateTime.parse(json['event_date_start']),
        eventEndAt: DateTime.parse(json['event_date_end']),
        progress: json['progress'],
      );

  factory TimelineEvent.empty() => TimelineEvent(
        id: -1,
        itemType: "",
        eventItem: TimelineEventItem.empty(),
        eventEndAt: DateTime.now(),
        eventStartAt: DateTime.now(),
        progress: 0,
      );
}

class TimelineEventItem {
  final int id;
  final String name;

  TimelineEventItem({
    required this.id,
    required this.name,
  });

  factory TimelineEventItem.empty() => TimelineEventItem(
        id: -1,
        name: "name",
      );
}

class MealEventItem extends TimelineEventItem {
  final String type;
  final String qtyType;
  final String ingredients;
  final String description;
  final String qty;

  MealEventItem({
    required super.id,
    required super.name,
    required this.type,
    required this.qtyType,
    required this.ingredients,
    required this.description,
    required this.qty,
  });

  factory MealEventItem.fromJson(Map<String, dynamic> json) => MealEventItem(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        qtyType: json['qty_type'],
        ingredients: json['ingredients'],
        description: json['description'],
        qty: json['qty'],
      );
}

class ExerciseEventItem extends TimelineEventItem {
  final String media;
  final String type;
  final String equipment;
  final String duration;
  final String description;

  ExerciseEventItem({
    required super.id,
    required super.name,
    required this.media,
    required this.type,
    required this.equipment,
    required this.duration,
    required this.description,
  });

  factory ExerciseEventItem.fromJson(Map<String, dynamic> json) =>
      ExerciseEventItem(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        media: json['media'],
        equipment: json['equipment'],
        description: json['description'],
        duration: json['duration'],
      );
}
