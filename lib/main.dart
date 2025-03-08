import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:little_explorer/pages/login_singup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const LittleExplorer());
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background color
            Container(
              width: screenWidth,
              height: screenHeight,
              color: const Color.fromARGB(255, 28, 196, 171),
            ),

            // Background circles
            _buildCircle(
                screenHeight * 0.09, screenWidth * 0.59, screenWidth * 0.3),
            _buildCircle(
                screenHeight * -0.10, screenWidth * -0.2, screenWidth * 0.5),
            _buildCircle(
                screenHeight * 0.2, screenWidth * 0.2, screenWidth * 0.18),
            _buildCircle(
                screenHeight * 0.5, screenWidth * 0.2, screenWidth * 0.4),
            _buildCircle(
                screenHeight * 0.35, screenWidth * 0.55, screenWidth * 0.4),
            _buildCircle(
                screenHeight * 0.9, screenWidth * 0.55, screenWidth * 0.3),
            _buildCircle(
                screenHeight * 0.78, screenWidth * 0.65, screenWidth * 0.1),
            _buildCircle(
                screenHeight * 0.8, screenWidth * 0.1, screenWidth * 0.2),
            _buildCircle(
                screenHeight * 0.1, screenWidth * 0.9, screenWidth * 0.8),

            // Centered content (logo + text)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo_littleEx.png",
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.8,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Little Explorers",
                    style: TextStyle(
                      fontSize: screenWidth * 0.08, // Responsive font size
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: "IrishGrover",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build circle images
  Widget _buildCircle(double top, double left, double size) {
    return Positioned(
      top: top,
      left: left,
      child: Image.asset(
        "assets/images/circle.png",
        width: size,
      ),
    );
  }
}
