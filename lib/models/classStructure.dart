// This class represents a structure for classes.
class Classes {
  // The month for the classes.
  final String month;
  // The list of lessons for the classes.
  final List<Lesson> lessons;

  // Constructor for the Classes class.
  Classes({required this.month, required this.lessons});
}

// This class represents a structure for a lesson.
class Lesson {
  // The name of the lesson.
  late String name;
  // The details of the lesson.
  late String details;
  // The month of the lesson.
  late String month;
  // The teacher of the lesson.
  late String teacher;
  // The completion status of the lesson.
  bool completed;

  // Constructor for the Lesson class.
  Lesson({
    required this.name,
    required this.details,
    required this.month,
    required this.teacher,
    this.completed = false,
  });

  // Creates a Lesson object from a JSON map.
  Lesson.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            details: json['details']! as String,
            month: json['month']! as String,
            teacher: json['teacher']! as String,
            completed: json['completed'] as bool);

  // Returns a copy of the Lesson object with the new values.
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

  // Converts the Lesson object to a JSON map.
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

// This class represents a structure for children.
class children {
  // The name of the child.
  late String name;
  // The teacher of the child.
  late String teacher;

  // Constructor for the children class.
  children({
    required this.name,
    required this.teacher,
  });

  // Creates a children object from a JSON map.
  children.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          teacher: json['teacher']! as String,
        );

  // Returns a copy of the children object with the new values.
  children copyWith({
    String? name,
    String? teacher,
  }) {
    return children(
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
    );
  }

  // Converts the children object to a JSON map.
  Map<String, Object?> toJson() {
    return {
      'name': name,
      'teacher': teacher,
    };
  }
}

// This class represents a structure for attendance.
class attendance {
  // The date of the attendance.
  late DateTime date;
  // The list of students for the attendance.
  late List<String> students;

  // Constructor for the attendance class.
  attendance({required this.date, required this.students});

  // Creates an attendance object from a JSON map.
  attendance.fromJson(Map<String, Object?> json)
      : this(
            date: json['date']! as DateTime,
            students: json['students'] as List<String>);

  // Returns a copy of the attendance object with the new values.
  attendance copyWith(
      {DateTime? date, String? attended, List<String>? students}) {
    return attendance(
        date: date ?? this.date, students: students ?? this.students);
  }

  // Converts the attendance object to a JSON map.
  Map<String, Object?> toJson() {
    return {'date': date, 'students': students};
  }
}

// This class represents a structure for attendance data.
class attendancedata {
  // The name of the student.
  late String studentName;
  // The total days of attendance for the student.
  late int totalDays;
  // The absent days of the student.
  late int absentDays;
  // The present days of the student.
  late int presentDays;

  // Constructor for the attendancedata class.
  attendancedata({
    required this.studentName,
    required this.totalDays,
    required this.absentDays,
    required this.presentDays,
  });
}