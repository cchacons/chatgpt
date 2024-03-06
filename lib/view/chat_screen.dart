import 'dart:async';

import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:chatgpt/api_key.dart';
import 'package:chatgpt/model/question_answer.dart';
import 'package:chatgpt/theme.dart';
import 'package:chatgpt/view/components/chatgpt_answer_widget.dart';
import 'package:chatgpt/view/components/loading_widget.dart';
import 'package:chatgpt/view/components/text_input_widget.dart';
import 'package:chatgpt/view/components/user_question_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<QuestionAnswer> questionAnswers = [];
  late TextEditingController inputQuestionController;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    inputQuestionController = TextEditingController();
    scrollController = ScrollController();
  }


  @override
  void dispose() {
    inputQuestionController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg500Color,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.white12,
        centerTitle: true,
        title: Text(
          "ChatGPT",
          style: kWhiteText.copyWith(fontSize: 20, fontWeight: kSemiBold),
        ),
        backgroundColor: kBg300Color,
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildChatList(),
            TextInputWidget(
              textController: inputQuestionController,
              onSubmitted: () => _sendMessage(),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildChatList() {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16, top: 16),
        itemCount: questionAnswers.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questionAnswers[index].question;
          final answer = questionAnswers[index].answer.toString().trim();
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              UserQuestionWidget(question: question),
              const SizedBox(height: 16),
              ChatGptAnswerWidget(answer: answer),
            ],
          );
        },
      ),
    );
  }


StringBuffer _processUserMessage(String question) {
  // Create a StringBuffer with the question followed by an exclamation mark
  return StringBuffer("$question!");
}

void _sendMessage() {
  final question = inputQuestionController.text.trim();
  if (question.isEmpty) return;

  setState(() {
    // Add user question with the processed answer from _processUserMessage function
    questionAnswers.add(QuestionAnswer(question: question, answer: _processUserMessage(question)));
  });

  inputQuestionController.clear();
  _scrollToBottom();
}

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
