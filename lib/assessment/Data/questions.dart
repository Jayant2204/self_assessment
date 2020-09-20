// To parse this JSON data, do
//
//     final assessment = assessmentFromJson(jsonString);

import 'dart:convert';

class Assessment {
  Assessment({
    this.questions,
  });

  List<Question> questions;

  factory Assessment.fromRawJson(String str) =>
      Assessment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    this.qId,
    this.questions,
    this.answerId,
    this.answeres,
    this.selectedAnswer, //Used for answer selection
  });

  String qId;
  String questions;
  String answerId;
  String selectedAnswer;
  List<Answer> answeres;

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      qId: json["qId"],
      questions: json["questions"],
      answerId: json["answerId"],
      answeres:
          List<Answer>.from(json["answeres"].map((x) => Answer.fromJson(x))),
      selectedAnswer: "");

  Map<String, dynamic> toJson() => {
        "qId": qId,
        "questions": questions,
        "answerId": answerId,
        "answeres": List<dynamic>.from(answeres.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    this.code,
    this.value,
  });

  String code;
  String value;

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        code: json["code"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "value": value,
      };
}
