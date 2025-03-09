import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:little_explorer/pages/login_singup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const splashScreen());
}

// Singleton AudioManager to manage background music
class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  Future<void> playBackgroundMusic() async {
    await _audioPlayer.play(AssetSource("audio/bgmusic.mp3"));
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void stopMusic() {
    _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

class LittleExplorer extends StatefulWidget {
  const LittleExplorer({super.key});

  @override
  State<LittleExplorer> createState() => _LittleExplorerState();
}

class _LittleExplorerState extends State<LittleExplorer>
    with WidgetsBindingObserver {
  final AudioManager _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audioManager.playBackgroundMusic();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioManager.stopMusic();
    } else if (state == AppLifecycleState.resumed) {
      _audioManager.playBackgroundMusic();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // 🔹 Background Image (Fully Responsive)
            Image.asset(
              'assets/splashScrn/SplashScreen.png',
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight, // Responsive height
            ),

            // 🔹 Bigger Logo in AnimatedSplashScreen (Responsive Scaling)
            Center(
              child: AnimatedSplashScreen(
                duration: 3500,
                splash: Transform.scale(
                  scale: screenWidth / 100, // Adjust dynamically
                  child: Image.asset('assets/splashScrn/logo.png'),
                ),
                nextScreen: LoginScreen(),
                backgroundColor: Colors.transparent,
                splashTransition: SplashTransition.fadeTransition,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
