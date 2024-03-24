class Classes {
  final String month;
  final List<Lesson> lessons;
  Classes({required this.month, required this.lessons});
}

class Lesson {
  late String name;
  late String details;
  late String month;
  late String teacher;
  bool completed;

  Lesson({
    required this.name,
    required this.details,
    required this.month,
    required this.teacher,
    this.completed = false,
  });

  Lesson.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            details: json['details']! as String,
            month: json['month']! as String,
            teacher: json['teacher']! as String,
            completed: json['completed'] as bool);

  Lesson copyWith(
      {String? name,
      String? details,
      String? month,
      String? teacher,
      bool? completed}) {
    return Lesson(
        name: name ?? this.name,
        details: details ?? this.details,
        month: month ?? this.month,
        teacher: teacher ?? this.teacher,
        completed: completed ?? this.completed);
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'details': details,
      'month': month,
      'teacher': teacher,
      'completed': completed,
    };
  }
}

class children {
  late String name;
  late String teacher;

  children({
    required this.name,
    required this.teacher,
  });

  children.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          teacher: json['teacher']! as String,
        );

  children copyWith({
    String? name,
    String? teacher,
  }) {
    return children(
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'teacher': teacher,
    };
  }
}
