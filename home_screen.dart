import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  // 18: Create call back function
  final Function(bool) onThemeChange;
  const HomeScreen({
    super.key, 
    required this.onThemeChange,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1: object from TextEditingController
  final TextEditingController _emailcontroller = TextEditingController();
  // 2: Variable to save the user Email
  late String usersEmail;
  // 4: Create a method to save Shared Preferences data
  void saveData (String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email',email);
    usersEmail = email;
  } 
  // 7: Create a method to read Shared Preferences data
  void readData() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usersEmail = prefs.getString('email') ?? 'no email?!';
  }
  // 8: Call the initState method
  @override
  void initState() {
    super.initState();
    readData();
     
  }

  // 9: Call the dispose method
  @override
  void dispose() {
    // : implement dispose
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 19: Create a variable to change the theme
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shared Preferences Demo',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 20),
                ),
                Switch.adaptive(
                    // 21: Change the value properity
                    value: isDark,
                    // 22: callback the method to change the theme
                    onChanged: widget.onThemeChange),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                // 3: Access to User's Text by Controller
                controller: _emailcontroller,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(fontSize: 20),
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 20),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 5: Call the Method to save the data
                    saveData(_emailcontroller.text);
                    // 6: Clear Text Field
                    _emailcontroller.clear();
                  },
                  child: const Text('Save Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'You Entered this Email:',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // 10: Show User Email in Text widget
                                    Text(usersEmail),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: const Text('Show Data'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
