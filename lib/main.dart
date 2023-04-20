import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labhouse_app/response.view.dart';
import 'package:labhouse_app/services/openai_api.service.dart';

void main() => runApp(MaterialApp(
    title: "Flutter app",
    theme: ThemeData(primarySwatch: Colors.blue),
    home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  @override
  FirstPage createState() => FirstPage();
}

class FirstPage extends State<HomeScreen> {
  final TextEditingController inputController = TextEditingController();
  bool isLoading = false;
  bool validate = false;

  Future<String> fetchData(prompt) async {
    try {
      return await getResponse(prompt);
      // BEGIN TEST
      // await Future.delayed(const Duration(seconds: 1));
      // return "First\nhola\nsdasd\Cuarto\nsdasd\nsdasd\nSeptimo\nsdasd\nsdasd";
      // END TEST
    } catch (e) {
      print("Error fetching data: $e");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6098F9),
              Color(0xFF506CE7),
              Color(0xFF2D2E72),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset("assets/chatgpt.png"),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Talk to ChatGPT!',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(24)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: Icon(
                      Icons.abc,
                      color: Colors.grey[600],
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: inputController,
                      decoration: InputDecoration(
                        errorText: validate ? 'Value Can\'t Be Empty' : null,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                width: double.maxFinite,
                height: 55.0,
                decoration: BoxDecoration(
                  color:
                      isLoading ? Colors.grey.shade400 : Colors.blue.shade400,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    validate = inputController.text.isEmpty;
                    setState(() {});
                    if (!validate) {
                      setState(() {
                        isLoading = true;
                      });
                      fetchData(inputController.text).then((value) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyStatefulWidget(
                                  myArgument: value,
                                  query: inputController.text,
                                )));
                      });
                    }
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    )),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}
