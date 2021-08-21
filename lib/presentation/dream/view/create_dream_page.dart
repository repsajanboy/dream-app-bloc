import 'package:flutter/material.dart';

class CreateDreamPage extends StatefulWidget {
  const CreateDreamPage({Key? key}) : super(key: key);

  @override
  _CreateDreamPageState createState() => _CreateDreamPageState();
}

class _CreateDreamPageState extends State<CreateDreamPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          tooltip: 'Back',
          onPressed: () {
            if (_pageController.page == 0) {
              Navigator.of(context).pop();
            } else {
              _pageController.previousPage(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 200));
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _pageController.nextPage(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 200),
              );
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Next'),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          _dreamForm(),
          _categoryAndRating(),
          _save(),
        ],
      ),
    );
  }

  Widget _dreamForm() {
    return Column(
      children: [
      ],
    );
  }

  Widget _categoryAndRating() {
    return Container(
      child: Center(
        child: Text('Category and Rating'),
      ),
    );
  }

  Widget _save() {
    return Container(
      child: Center(
        child: Text('Save'),
      ),
    );
  }
}
