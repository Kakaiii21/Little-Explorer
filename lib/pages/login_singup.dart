import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../auth_service.dart'; // Import AuthService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

// ------------------- LOGIN SCREEN -------------------
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true; // State variable for password visibility

  void loginUser() async {
    final user = await _authService.loginUserWithEmailAndPassword(
        emailController.text.trim(), passwordController.text.trim());

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Ensures the keyboard does not hide input fields
      body: LayoutBuilder(builder: (context, constraints) {
        double containerWidth = constraints.maxWidth * 0.85;
        double containerHeight = constraints.maxHeight * 0.7;

        return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pages/login/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                // Enables scrolling when needed
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: containerWidth.clamp(300, 400),
                      height: containerHeight.clamp(500, 650),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 255, 255, 1),
                            Color.fromRGBO(231, 199, 162, 1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                        ),
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(157, 135, 109, 1),
                            spreadRadius: 1,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "Little Explorer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "IrishGrover",
                              fontSize: 30,
                              color: Color.fromRGBO(198, 146, 63, 1),
                              shadows: [
                                Shadow(
                                  color: Color.fromRGBO(97, 65, 13, 1),
                                  offset: Offset(1.5, 1.5),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: containerWidth * .89,
                            height: containerHeight * .45,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Account",
                                  style: TextStyle(
                                    color: Color.fromRGBO(194, 139, 51, 1),
                                    fontSize: 25,
                                    fontFamily: "ADLaMDisplay",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 30),
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromRGBO(223, 223, 223, 1),
                                    labelText: "Email Address",
                                    prefixIcon:
                                        Icon(Icons.email, color: Colors.brown),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                  ),
                                ),
                                SizedBox(height: 35),
                                TextField(
                                  controller: passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromRGBO(223, 223, 223, 1),
                                    labelText: "Password",
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.brown),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          _obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.brown),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: loginUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(173, 125, 48, 1),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 90, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 25, fontFamily: 'ADLaMDisplay'),
                            ),
                          ),
                          TextButton(
                            onPressed: loginUser,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color.fromRGBO(2, 97, 186, 1),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Image.asset('assets/pages/login/line.png'),
                          Row(
                            mainAxisSize:
                                MainAxisSize.min, // Shrink to fit content
                            children: [
                              Text("Don't have an account?"),
                              SizedBox(width: 5), // Adjust spacing
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets
                                      .zero, // Removes default padding
                                  minimumSize:
                                      Size(0, 0), // Prevents extra space
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // Reduces touch area
                                ),
                                child: Text("Sign Up"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    // Overlapping Image Outside the Container
                    Positioned(
                      top: -90, // Moves the image higher above the container
                      child: Image.asset(
                        "assets/pages/login/logo.png",
                        width: 150, // Adjust size as needed
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}

// ------------------- SIGNUP SCREEN -------------------
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signupUser() async {
    final user = await _authService.createUserWithEmailAndPassword(
        emailController.text.trim(), passwordController.text.trim());

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Signup Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: signupUser, child: Text("Signup")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Already have an account? Login"))
          ],
        ),
      ),
    );
  }
}

// ------------------- HOME SCREEN -------------------
class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _authService.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              })
        ],
      ),
      body: Center(child: Text("Welcome to Home Screen!")),
    );
  }
}
