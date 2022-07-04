import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  TextEditingController cityTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Searching a city'),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: cityTextController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a City',
                    hintText: 'Example: New York'
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.pop(context, cityTextController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
