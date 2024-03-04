import 'package:example/core/extensions/context_extensions.dart';
import 'package:example/pages/card_details_view.dart';
import 'package:flutter/material.dart';
import 'package:test_recorder_flow/test_recorder_flow.dart';

enum ScrollableWidgetKey {
  horizontalList,
  verticalList,
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _horizontalGlobalKey = GlobalKey();
  final _verticalGlobalKey = GlobalKey();

  late TRScrollController _scrollController;
  late TRScrollController _horizontalScrollController;
  late TRTextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _scrollController = TRScrollController();
    _horizontalScrollController = TRScrollController();
    _textEditingController = TRTextEditingController();

    Future.microtask(() {
      _scrollController.setKey(_verticalGlobalKey, Axis.vertical);
      _horizontalScrollController.setKey(_horizontalGlobalKey, Axis.horizontal);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home View'),
          actions: [
            IconButton(
              onPressed: () {
                for (var element in TestRocerderFlow.instance.recordedEvents) {
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
                key: _horizontalGlobalKey,
                physics: const ClampingScrollPhysics(),
                controller: _horizontalScrollController,
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
              key: _textEditingController.key,
              focusNode: _textEditingController.focusNode,
              controller: _textEditingController,
            ),
            Expanded(
              child: ListView.builder(
                key: _verticalGlobalKey,
                controller: _scrollController,
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
                  return TRGestureDetector(
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
