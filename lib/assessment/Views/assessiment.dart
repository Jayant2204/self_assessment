import 'package:flutter/material.dart';
import 'package:self_assessment/assessment/Data/questions.dart';
import 'package:self_assessment/assessment/controller/testController.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({Key key, this.controller}) : super(key: key);
  final TestController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assessment"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: buildQuestionList(),
        ),
      ),
    );
  }

  getCorrectAnswerFromQuestion(Question question) {
    Answer correctAnswer = question.answeres
        .firstWhere((element) => element.code == question.answerId);
    return correctAnswer.value;
  }

  getUserAnswerFromQuestion(Question question) {
    var ansId = controller.submittedAnswers[question.qId];
    Answer userAnswer =
        question.answeres.firstWhere((element) => element.code == ansId);
    return userAnswer.value;
  }

  bool isUserAnswercorrect(Question question) {
    var ansId = controller.submittedAnswers[question.qId];
    return ansId == question.answerId;
  }

  List<Widget> buildQuestionList() {
    List<Widget> widgets = [];
    widgets.add(ListTile(
      title: Text("Total Marks "),
      trailing: Text("${controller.obtainedMarks.value}"),
    ));
    widgets.add(
      ListTile(
        title: Text("Total Correct Answers"),
        trailing: Text("${controller.correctAnswers.value}"),
      ),
    );
    widgets.add(
      ListTile(
        title: Text("Total Incorrect Answers"),
        trailing: Text("${controller.incorrectAnswers.value}"),
      ),
    );
    widgets.add(Divider(
      color: Colors.black87,
    ));

    controller.assessment.value.questions.forEach((element) {
      widgets.add(Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isUserAnswercorrect(element)
              ? Colors.green.withOpacity(0.65)
              : Colors.red.withOpacity(0.65),
        ),
        child: ListTile(
          title: Text(element.questions),
          isThreeLine: true,
          leading: isUserAnswercorrect(element)
              ? Icon(Icons.check_circle_outline)
              : Icon(Icons.cancel),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Correct answer : ${getCorrectAnswerFromQuestion(element)}"),
              Text("Your answer : ${getUserAnswerFromQuestion(element)} "),
            ],
          ),
        ),
      ));
    });

    return widgets;
  }
}
