import 'package:thanks/models/structs.dart';

List<Map<DiaryStructure, dynamic>> fakeRecentPosts = [
  {
    DiaryStructure.date: {
      DateConstants.dayName: "Tue",
      DateConstants.month: '8',
      DateConstants.day: '13',
      DateConstants.year: '2019',
    },
    DiaryStructure.title: "I'm so excited to start writing journal with you!",
  },
  {
    DiaryStructure.date: {
      DateConstants.dayName: "Mon",
      DateConstants.month: '8',
      DateConstants.day: '12',
      DateConstants.year: '2019',
    },
    DiaryStructure.title: "Let's start to write your story!",
  },
  {
    DiaryStructure.date: {
      DateConstants.dayName: "Sun",
      DateConstants.month: '8',
      DateConstants.day: '11',
      DateConstants.year: '2019',
    },
    DiaryStructure.title: "I hate math ★",
  },
];

Map<String, Map<DiaryStructure, dynamic>> fakeStories = {
  "2019-08-14": {
    DiaryStructure.date: {
      DateConstants.dayName: "Wed",
      DateConstants.month: '8',
      DateConstants.day: '14',
      DateConstants.year: '2019',
    },
    DiaryStructure.title: "I'm so excited to start writing journal with you!",
  }
};
