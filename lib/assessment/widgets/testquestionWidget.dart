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
  final Function(String index, String selectedAnswer) onSelectAnswer;
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
    widget.onSelectAnswer(widget.question.qId, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "Qusetion ${widget.index + 1}",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
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
      widgets.add(Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: RadioListTile<String>(
            title: Text(element.value),
            value: element.code,
            groupValue: selectedAnswer,
            selected: selectedAnswer == element.code,
            activeColor: Colors.green,
            onChanged: (String answer) {
              setSelectedAnswer(answer);
            }),
      ));
    });
    return widgets;
  }
}
