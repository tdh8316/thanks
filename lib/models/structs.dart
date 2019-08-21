// TODO: Remove
enum DateConstants {
  dayName,
  month,
  day,
  year,
}

// TODO: Remove
enum DiaryStructure {
  title,
  date,
}

enum Emotions {
  happiness,
  sadness,
  fear,
  disgust,
  anger,
  surprise,
  // excitement,
}

class Journal {
  final DateTime date;

  final String title;

  final String body;
  final Emotions emotion;

  Journal({
    this.date,
    this.title,
    this.body,
    this.emotion,
  });
}
