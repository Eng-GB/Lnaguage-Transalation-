import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  TextEditingController controller = TextEditingController();

  var languages = ['Hindi', 'Arabic', 'English', 'Somali'];

  String getLanguageCode(String language) {
    switch (language) {
      case 'Hindi':
        return 'hi';
      case 'English':
        return 'en';
      case 'Arabic':
        return 'ar';
      case 'Somali':
        return 'so';
      default:
        return '---';
    }
  }

  String originLanguage = 'From';
  String destinationLanguage = 'To';
  String output = "";

  Future<void> translate(String src, String dest, String input) async {
    if (src == '---' || dest == '---') {
      setState(() {
        output = 'Failed to translate. Please select valid languages.';
      });
      return;
    }

    try {
      GoogleTranslator translator = GoogleTranslator();
      var translation = await translator.translate(input, from: src, to: dest);

      setState(() {
        output = translation.toString();
      });
    } catch (e) {
      setState(() {
        output = 'Translation failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Language Translation',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    }),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.arrow_right_alt_outlined,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 40,
                ),
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Please enter your text!',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                ),
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Text!";
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                translate(
                  getLanguageCode(originLanguage),
                  getLanguageCode(destinationLanguage),
                  controller.text,
                );
              },
              child: Text('Translate'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '$output',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff10223d),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '@Eng GB',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white60,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
