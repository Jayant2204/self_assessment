import 'package:flutter/material.dart';
import 'package:self_assessment/assessment/Data/questions.dart';

class TestQuestionWidget extends StatefulWidget {
  const TestQuestionWidget(
      {Key key,
      this.question,
      this.index,
      this.onSelectAnswer,
      this.previouslySelectedAnswer})
      : super(key: key);

  final Question question;
  final int index;
  final Function(int index, String selectedAnswer) onSelectAnswer;
  final String previouslySelectedAnswer;

  @override
  _TestQuestionWidgetState createState() => _TestQuestionWidgetState();
}

class _TestQuestionWidgetState extends State<TestQuestionWidget> {
  String selectedAnswer;
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedAnswer = widget.previouslySelectedAnswer;
    });
  }

  setSelectedAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
    widget.onSelectAnswer(widget.index, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            widget.question.questions,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Column(
            children: answerList(),
          )
        ],
      ),
    );
  }

  List<Widget> answerList() {
    List<Widget> widgets = [];

    widget.question.answeres.forEach((element) {
      widgets.add(RadioListTile<String>(
          title: Text(element.value),
          value: element.code,
          groupValue: selectedAnswer,
          selected: selectedAnswer == element.code,
          activeColor: Colors.green,
          onChanged: (String answer) {
            setSelectedAnswer(answer);
          }));
    });
    return widgets;
  }
}
