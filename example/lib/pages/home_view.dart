import 'package:example/core/extensions/context_extensions.dart';
import 'package:example/pages/card_details_view.dart';
import 'package:flutter/material.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TRTextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TRTextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TestRecorderFlowWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home View'),
          actions: [
            IconButton(
              onPressed: () {
                for (var element in TestRocerderFlow.recordedEvents) {
                  print(element);
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 100,
                    color: Colors.blue,
                    margin: const EdgeInsets.all(8),
                    child: Center(
                      child: Text('Item $index'),
                    ),
                  );
                },
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            TextFormField(
              focusNode: _textEditingController.focusNode,
              controller: _textEditingController,
            ),
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    color: Colors.red,
                    margin: const EdgeInsets.all(8),
                    child: Center(
                      child: Text('Card $index'),
                    ),
                  );
                },
                itemCount: 10,
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      context.push(const CardDetailsView());
                    },
                    child: Container(
                      width: 150,
                      height: 100,
                      color: Colors.blue,
                      margin: const EdgeInsets.all(8),
                      child: Center(
                        child: Text('Item $index'),
                      ),
                    ),
                  );
                },
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
