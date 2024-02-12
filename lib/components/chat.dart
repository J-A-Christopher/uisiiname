import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:usiiname/features/randomrecipes/presentation/widgets/chat_input_box.dart';

class ChartComponent extends StatefulWidget {
  const ChartComponent({super.key});

  @override
  State<ChartComponent> createState() => _ChartComponentState();
}

class _ChartComponentState extends State<ChartComponent> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 26)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            if (searchedText != null)
              MaterialButton(
                  color: const Color(0xff5BDDCD),
                  onPressed: () {
                    setState(() {
                      searchedText = null;
                      result = null;
                    });
                  },
                  child: Text('search: $searchedText')),
            Expanded(
                child: loading
                    ? Lottie.asset('assets/lottie/ai.json')
                    : result != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Markdown(data: result!),
                          )
                        : Center(
                            child: Text(
                            'Search something!',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontSize: 30),
                          ))),
            ChatInputBox(
              controller: controller,
              onSend: () {
                if (controller.text.isNotEmpty) {
                  searchedText = controller.text;
                  controller.clear();
                  loading = true;

                  gemini.text(searchedText!).then((value) {
                    result = value?.content?.parts?.last.text;
                    loading = false;
                  });
                }
              },
            ),
          ],
        ));
  }
}
