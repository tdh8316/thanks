import 'package:thanks/models/structs.dart';

List<Map<DiaryStructure, dynamic>> fakeRecentPosts = [
  {
    DiaryStructure.date: {
      DateConstants.dayName:"Tue",
      DateConstants.month:'8',
      DateConstants.day:'13',
      DateConstants.year:'2019',
    },
    DiaryStructure.title: "Hello, world!",
  },{
    DiaryStructure.date: {
      DateConstants.dayName:"Mon",
      DateConstants.month:'8',
      DateConstants.day:'12',
      DateConstants.year:'2019',
    },
    DiaryStructure.title: "Awful day ;(",
  },{
    DiaryStructure.date: {
      DateConstants.dayName:"Sun",
      DateConstants.month:'8',
      DateConstants.day:'11',
      DateConstants.year:'2019',
    },
    DiaryStructure.title: "I hate math ★",
  },
];
