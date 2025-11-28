import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

// Text-to-Speech Service
class VoiceService {
  static final VoiceService _instance = VoiceService._internal();
  factory VoiceService() => _instance;
  VoiceService._internal();

  final FlutterTts _flutterTts = FlutterTts();

  Future<void> init() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  Future<void> setLanguage(String languageCode) async {
    switch (languageCode) {
      case 'hi':
        await _flutterTts.setLanguage("hi-IN");
        break;
      case 'kn':
        await _flutterTts.setLanguage("kn-IN");
        break;
      default:
        await _flutterTts.setLanguage("en-US");
    }
  }

  Future<void> setSpeed(double speed) async {
    await _flutterTts.setSpeechRate(speed);
  }
}

// Storage Service Class
class StorageService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _languageKey = 'language';
  static const String _upiIdKey = 'upiId';
  static const String _isSetupCompletedKey = 'isSetupCompleted';
  static const String _shopNameKey = 'shopName';

  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setLanguage(String languageCode) async {
    final prefs = await _prefs;
    await prefs.setString(_languageKey, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString(_languageKey) ?? 'en';
  }

  static Future<void> setUpiId(String upiId) async {
    final prefs = await _prefs;
    await prefs.setString(_upiIdKey, upiId);
  }

  static Future<String> getUpiId() async {
    final prefs = await _prefs;
    return prefs.getString(_upiIdKey) ?? '';
  }

  static Future<void> setShopName(String name) async {
    final prefs = await _prefs;
    await prefs.setString(_shopNameKey, name);
  }

  static Future<String> getShopName() async {
    final prefs = await _prefs;
    return prefs.getString(_shopNameKey) ?? 'My Shop';
  }

  static Future<void> setSetupCompleted(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_isSetupCompletedKey, value);
  }

  static Future<bool> isSetupCompleted() async {
    final prefs = await _prefs;
    return prefs.getBool(_isSetupCompletedKey) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_upiIdKey);
    await prefs.remove(_isSetupCompletedKey);
    await prefs.remove(_shopNameKey);
  }
}

// Language Service Class
class LanguageService {
  static Map<String, Map<String, String>> translations = {
    'en': {
      'setup_upi': 'Setup Your UPI Account',
      'enter_upi_details': 'Enter your UPI ID and shop details',
      'upi_id': 'UPI ID',
      'upi_hint': 'example@ybl or example@paytm',
      'shop_name': 'Shop Name',
      'shop_name_hint': 'Enter your shop name',
      'create_password': 'Create Password',
      'password_hint': 'Enter your password',
      'confirm_password': 'Confirm Password',
      'confirm_hint': 'Re-enter your password',
      'password_tip': 'Use a strong password to secure your transaction data',
      'save_continue': 'Save & Continue',
      'setup_complete': 'Setup Complete!',
      'setup_success': 'Your UPI account has been setup successfully. You can now start using the app.',
      'get_started': 'Get Started',
      'enter_upi': 'Please enter your UPI ID',
      'valid_upi': 'Enter a valid UPI ID (e.g., example@ybl)',
      'enter_password': 'Please enter a password',
      'password_length': 'Password must be at least 6 characters',
      'confirm_password_field': 'Please confirm your password',
      'password_mismatch': 'Passwords do not match',
      'enter_shop_name': 'Please enter your shop name',
      'dashboard': 'Dashboard',
      'welcome': 'Welcome',
      'language': 'Language',
      'quick_actions': 'Quick Actions',
      'logout': 'Logout',
      'logout_confirmation': 'Are you sure you want to logout?',
      'cancel': 'Cancel',
      'receive_payment': 'Receive Payment',
      'today_sales': 'Today Sales',
      'voice_help': 'Voice Help',
      'voice_settings': 'Voice Settings',
      'show_qr': 'Show QR Code',
      'payment_received': 'Payment Received',
      'share_upi': 'Share your UPI ID with customer',
      'scan_qr': 'Scan QR Code to Pay',
    },
    'hi': {
      'setup_upi': 'अपना UPI अकाउंट सेटअप करें',
      'enter_upi_details': 'अपना UPI ID और दुकान का विवरण दर्ज करें',
      'upi_id': 'UPI ID',
      'upi_hint': 'example@ybl या example@paytm',
      'shop_name': 'दुकान का नाम',
      'shop_name_hint': 'अपनी दुकान का नाम दर्ज करें',
      'create_password': 'पासवर्ड बनाएं',
      'password_hint': 'अपना पासवर्ड दर्ज करें',
      'confirm_password': 'पासवर्ड की पुष्टि करें',
      'confirm_hint': 'पासवर्ड फिर से दर्ज करें',
      'password_tip': 'अपने लेन-देन डेटा को सुरक्षित रखने के लिए एक मजबूत पासवर्ड का उपयोग करें',
      'save_continue': 'सहेजें और जारी रखें',
      'setup_complete': 'सेटअप पूरा हुआ!',
      'setup_success': 'आपका UPI अकाउंट सफलतापूर्वक सेटअप हो गया है। अब आप ऐप का उपयोग कर सकते हैं।',
      'get_started': 'शुरू करें',
      'enter_upi': 'कृपया अपना UPI ID दर्ज करें',
      'valid_upi': 'एक वैध UPI ID दर्ज करें (जैसे, example@ybl)',
      'enter_password': 'कृपया एक पासवर्ड दर्ज करें',
      'password_length': 'पासवर्ड कम से कम 6 वर्णों का होना चाहिए',
      'confirm_password_field': 'कृपया अपने पासवर्ड की पुष्टि करें',
      'password_mismatch': 'पासवर्ड मेल नहीं खाते',
      'enter_shop_name': 'कृपया अपने दुकान का नाम दर्ज करें',
      'dashboard': 'डैशबोर्ड',
      'welcome': 'स्वागत है',
      'language': 'भाषा',
      'quick_actions': 'त्वरित कार्य',
      'logout': 'लॉगआउट',
      'logout_confirmation': 'क्या आप वाकई लॉगआउट करना चाहते हैं?',
      'cancel': 'रद्द करें',
      'receive_payment': 'भुगतान प्राप्त करें',
      'today_sales': 'आज की बिक्री',
      'voice_help': 'वॉयस सहायता',
      'voice_settings': 'वॉयस सेटिंग्स',
      'show_qr': 'QR कोड दिखाएं',
      'payment_received': 'भुगतान प्राप्त हुआ',
      'share_upi': 'ग्राहक को अपना UPI ID शेयर करें',
      'scan_qr': 'भुगतान करने के लिए QR कोड स्कैन करें',
    },
    'kn': {
      'setup_upi': 'ನಿಮ್ಮ UPI ಖಾತೆಯನ್ನು ಸೆಟಪ್ ಮಾಡಿ',
      'enter_upi_details': 'ನಿಮ್ಮ UPI ID ಮತ್ತು ಅಂಗಡಿಯ ವಿವರಗಳನ್ನು ನಮೂದಿಸಿ',
      'upi_id': 'UPI ID',
      'upi_hint': 'example@ybl ಅಥವಾ example@paytm',
      'shop_name': 'ಅಂಗಡಿಯ ಹೆಸರು',
      'shop_name_hint': 'ನಿಮ್ಮ ಅಂಗಡಿಯ ಹೆಸರನ್ನು ನಮೂದಿಸಿ',
      'create_password': 'ಪಾಸ್ವರ್ಡ್ ರಚಿಸಿ',
      'password_hint': 'ನಿಮ್ಮ ಪಾಸ್ವರ್ಡ್ ನಮೂದಿಸಿ',
      'confirm_password': 'ಪಾಸ್ವರ್ಡ್ ದೃಢೀಕರಿಸಿ',
      'confirm_hint': 'ಪಾಸ್ವರ್ಡ್ ಮರು-ನಮೂದಿಸಿ',
      'password_tip': 'ನಿಮ್ಮ ವಹಿವಾಟು ಡೇಟಾವನ್ನು ಸುರಕ್ಷಿತವಾಗಿಡಲು ಬಲವಾದ ಪಾಸ್ವರ್ಡ್ ಬಳಸಿ',
      'save_continue': 'ಉಳಿಸಿ ಮತ್ತು ಮುಂದುವರಿಸಿ',
      'setup_complete': 'ಸೆಟಪ್ ಪೂರ್ಣಗೊಂಡಿದೆ!',
      'setup_success': 'ನಿಮ್ಮ UPI ಖಾತೆಯನ್ನು ಯಶಸ್ವಿಯಾಗಿ ಸೆಟಪ್ ಮಾಡಲಾಗಿದೆ. ಈಗ ನೀವು ಅಪ್ಲಿಕೇಶನ್ ಬಳಸಲು ಪ್ರಾರಂಭಿಸಬಹುದು.',
      'get_started': 'ಪ್ರಾರಂಭಿಸಿ',
      'enter_upi': 'ದಯವಿಟ್ಟು ನಿಮ್ಮ UPI ID ನಮೂದಿಸಿ',
      'valid_upi': 'ಮಾನ್ಯ UPI ID ನಮೂದಿಸಿ (ಉದಾ., example@ybl)',
      'enter_password': 'ದಯವಿಟ್ಟು ಪಾಸ್ವರ್ಡ್ ನಮೂದಿಸಿ',
      'password_length': 'ಪಾಸ್ವರ್ಡ್ ಕನಿಷ್ಠ 6 ಅಕ್ಷರಗಳಾಗಿರಬೇಕು',
      'confirm_password_field': 'ದಯವಿಟ್ಟು ನಿಮ್ಮ ಪಾಸ್ವರ್ಡ್ ದೃಢೀಕರಿಸಿ',
      'password_mismatch': 'ಪಾಸ್ವರ್ಡ್ಗಳು ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ',
      'enter_shop_name': 'ದಯವಿಟ್ಟು ನಿಮ್ಮ ಅಂಗಡಿಯ ಹೆಸರನ್ನು ನಮೂದಿಸಿ',
      'dashboard': 'ಡ್ಯಾಶ್ಬೋರ್ಡ್',
      'welcome': 'ಸ್ವಾಗತ',
      'language': 'ಭಾಷೆ',
      'quick_actions': 'ತ್ವರಿತ ಕ್ರಿಯೆಗಳು',
      'logout': 'ಲಾಗ್ ಔಟ್',
      'logout_confirmation': 'ನೀವು ಖಚಿತವಾಗಿ ಲಾಗ್ ಔಟ್ ಮಾಡಲು ಬಯಸುವಿರಾ?',
      'cancel': 'ರದ್ದುಮಾಡಿ',
      'receive_payment': 'ಪಾವತಿ ಸ್ವೀಕರಿಸಿ',
      'today_sales': 'ಇಂದಿನ ಮಾರಾಟ',
      'voice_help': 'ಧ್ವನಿ ಸಹಾಯ',
      'voice_settings': 'ಧ್ವನಿ ಸೆಟ್ಟಿಂಗ್ಗಳು',
      'show_qr': 'QR ಕೋಡ್ ತೋರಿಸಿ',
      'payment_received': 'ಪಾವತಿ ಸ್ವೀಕರಿಸಲಾಗಿದೆ',
      'share_upi': 'ಗ್ರಾಹಕರಿಗೆ ನಿಮ್ಮ UPI ID ಹಂಚಿಕೊಳ್ಳಿ',
      'scan_qr': 'ಪಾವತಿಸಲು QR ಕೋಡ್ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ',
    },
  };

  static String getText(String languageCode, String key) {
    return translations[languageCode]?[key] ?? translations['en']![key]!;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rural UPI Assistant',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: FutureBuilder(
        future: StorageService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          final isLoggedIn = snapshot.data ?? false;

          if (isLoggedIn) {
            return FutureBuilder(
              future: StorageService.getLanguage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                final language = snapshot.data ?? 'en';
                return MainDashboard(language: language);
              },
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.store,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              'Rural UPI Assistant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectedLanguage;

  final List<Map<String, String>> languages = [
    {'code': 'hi', 'name': 'हिन्दी'},
    {'code': 'en', 'name': 'English'},
    {'code': 'kn', 'name': 'ಕನ್ನಡ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.store,
                        size: 60,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Rural UPI Assistant',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your Digital Shop Partner',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'Choose Your Language',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: languages.map((lang) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: LanguageButton(
                          languageName: lang['name']!,
                          isSelected: selectedLanguage == lang['code'],
                          onTap: () {
                            setState(() {
                              selectedLanguage = lang['code'];
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: selectedLanguage != null ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpiSetupScreen(selectedLanguage: selectedLanguage!),
                          ),
                        );
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Continue →',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String languageName;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageButton({
    super.key,
    required this.languageName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : Colors.grey[50],
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            languageName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.green[800] : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}

class UpiSetupScreen extends StatefulWidget {
  final String selectedLanguage;

  const UpiSetupScreen({super.key, required this.selectedLanguage});

  @override
  _UpiSetupScreenState createState() => _UpiSetupScreenState();
}

class _UpiSetupScreenState extends State<UpiSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _upiIdController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageService.getText(widget.selectedLanguage, 'setup_upi')),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _showLogoutDialog,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                LanguageService.getText(widget.selectedLanguage, 'setup_upi'),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                LanguageService.getText(widget.selectedLanguage, 'enter_upi_details'),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // Shop Name Field
              Text(
                LanguageService.getText(widget.selectedLanguage, 'shop_name'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _shopNameController,
                decoration: InputDecoration(
                  hintText: LanguageService.getText(widget.selectedLanguage, 'shop_name_hint'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.store),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LanguageService.getText(widget.selectedLanguage, 'enter_shop_name');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // UPI ID Field
              Text(
                LanguageService.getText(widget.selectedLanguage, 'upi_id'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _upiIdController,
                decoration: InputDecoration(
                  hintText: LanguageService.getText(widget.selectedLanguage, 'upi_hint'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.payment),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LanguageService.getText(widget.selectedLanguage, 'enter_upi');
                  }
                  if (!value.contains('@')) {
                    return LanguageService.getText(widget.selectedLanguage, 'valid_upi');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Password Field
              Text(
                LanguageService.getText(widget.selectedLanguage, 'create_password'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: LanguageService.getText(widget.selectedLanguage, 'password_hint'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LanguageService.getText(widget.selectedLanguage, 'enter_password');
                  }
                  if (value.length < 6) {
                    return LanguageService.getText(widget.selectedLanguage, 'password_length');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Confirm Password Field
              Text(
                LanguageService.getText(widget.selectedLanguage, 'confirm_password'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: LanguageService.getText(widget.selectedLanguage, 'confirm_hint'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LanguageService.getText(widget.selectedLanguage, 'confirm_password_field');
                  }
                  if (value != _passwordController.text) {
                    return LanguageService.getText(widget.selectedLanguage, 'password_mismatch');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Text(
                LanguageService.getText(widget.selectedLanguage, 'password_tip'),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),

              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveUPIDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    LanguageService.getText(widget.selectedLanguage, 'save_continue'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout?'),
          content: const Text('Do you want to logout and setup a new user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await StorageService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _saveUPIDetails() async {
    if (_formKey.currentState!.validate()) {
      await StorageService.setLoggedIn(true);
      await StorageService.setLanguage(widget.selectedLanguage);
      await StorageService.setUpiId(_upiIdController.text);
      await StorageService.setShopName(_shopNameController.text);
      await StorageService.setSetupCompleted(true);

      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LanguageService.getText(widget.selectedLanguage, 'setup_complete')),
          content: Text(LanguageService.getText(widget.selectedLanguage, 'setup_success')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainDashboard(language: widget.selectedLanguage),
                  ),
                );
              },
              child: Text(LanguageService.getText(widget.selectedLanguage, 'get_started')),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _upiIdController.dispose();
    _shopNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class MainDashboard extends StatefulWidget {
  final String language;

  const MainDashboard({super.key, required this.language});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  void initState() {
    super.initState();
    _initializeVoice();
  }

  void _initializeVoice() async {
    await VoiceService().init();
    await VoiceService().setLanguage(widget.language);
    Future.delayed(const Duration(seconds: 1), () {
      _playVoiceConfirmation('Welcome to your shop! Ready to accept payments.');
    });
  }

  // NEW: Generate UPI URL method
  String _generateUpiUrl(String upiId, String shopName) {
    // Format: upi://pay?pa=UPI_ID&pn=SHOP_NAME&cu=INR
    return "upi://pay?pa=$upiId&pn=${Uri.encodeComponent(shopName)}&cu=INR";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageService.getText(widget.language, 'dashboard')),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context);
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([
          StorageService.getUpiId(),
          StorageService.getShopName(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final upiId = snapshot.data?[0] ?? 'Not set';
          final shopName = snapshot.data?[1] ?? 'My Shop';

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '👋 ${LanguageService.getText(widget.language, 'welcome')}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Shop: $shopName',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'UPI ID: $upiId',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Language: ${_getLanguageName(widget.language)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Quick Actions
                Text(
                  LanguageService.getText(widget.language, 'quick_actions'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Action Buttons Grid
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildActionButton(
                      context,
                      Icons.qr_code,
                      LanguageService.getText(widget.language, 'receive_payment'),
                      Colors.green,
                          () {
                        _startPaymentProcess(context);
                      },
                    ),
                    _buildActionButton(
                      context,
                      Icons.history,
                      LanguageService.getText(widget.language, 'today_sales'),
                      Colors.purple,
                          () {
                        _showTodaySales(context);
                      },
                    ),
                    _buildActionButton(
                      context,
                      Icons.volume_up,
                      LanguageService.getText(widget.language, 'voice_help'),
                      Colors.blue,
                          () {
                        _playHelpInstructions();
                      },
                    ),
                    _buildActionButton(
                      context,
                      Icons.settings_voice,
                      LanguageService.getText(widget.language, 'voice_settings'),
                      Colors.orange,
                          () {
                        _voiceSetup(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String text,
      Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिन्दी';
      case 'kn':
        return 'ಕನ್ನಡ';
      default:
        return 'English';
    }
  }

  void _startPaymentProcess(BuildContext context) {
    _playVoiceConfirmation('Opening payment. Show your UPI ID to customer for payment.');

    showDialog(
      context: context,
      builder: (context) => FutureBuilder(
        future: Future.wait([
          StorageService.getUpiId(),
          StorageService.getShopName(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            );
          }

          final upiId = snapshot.data?[0] ?? 'not-set@ybl';
          final shopName = snapshot.data?[1] ?? 'My Shop';

          return AlertDialog(
            title: Text(LanguageService.getText(widget.language, 'receive_payment')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.payment, size: 50, color: Colors.green),
                const SizedBox(height: 16),
                Text(
                  LanguageService.getText(widget.language, 'share_upi'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    upiId,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    const Text(
                      'Customer can pay using:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '• Any UPI app\n• Your UPI ID: $upiId\n• Any amount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _playVoiceConfirmation('Payment cancelled.');
                },
                child: Text(LanguageService.getText(widget.language, 'cancel')),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showQRCode(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  LanguageService.getText(widget.language, 'show_qr'),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showQRCode(BuildContext context) {
    _playVoiceConfirmation('Showing QR code for payment.');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FutureBuilder(
        future: Future.wait([
          StorageService.getUpiId(),
          StorageService.getShopName(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Dialog(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading QR Code...'),
                  ],
                ),
              ),
            );
          }

          final upiId = snapshot.data?[0] ?? 'not-set@ybl';
          final shopName = snapshot.data?[1] ?? 'My Shop';
          final upiUrl = _generateUpiUrl(upiId, shopName);

          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Payment Header
                  const Icon(Icons.payment, size: 50, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    LanguageService.getText(widget.language, 'receive_payment'),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // UPI ID Display
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'YOUR UPI ID:',
                          style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          upiId,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          LanguageService.getText(widget.language, 'share_upi'),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // REAL QR CODE - FIXED
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        QrImageView(
                          data: upiUrl,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          LanguageService.getText(widget.language, 'scan_qr'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Shop: $shopName',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Instructions
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.phone_android, size: 24, color: Colors.orange),
                        const SizedBox(height: 8),
                        const Text(
                          'Customer can scan QR code with any UPI app to pay any amount',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _playVoiceConfirmation('Payment cancelled.');
                          },
                          child: Text(LanguageService.getText(widget.language, 'cancel')),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _confirmPayment(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            LanguageService.getText(widget.language, 'payment_received'),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmPayment(BuildContext context) {
    String message;
    switch (widget.language) {
      case 'hi':
        message = 'भुगतान सफलतापूर्वक प्राप्त हुआ! धन्यवाद!';
        break;
      case 'kn':
        message = 'ಪಾವತಿ ಯಶಸ್ವಿಯಾಗಿ ಪಡೆಯಲಾಗಿದೆ! ಧನ್ಯವಾದಗಳು!';
        break;
      default:
        message = 'Payment received successfully! Thank you!';
    }

    _playVoiceConfirmation(message);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Payment recorded successfully!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void _playVoiceConfirmation(String message) async {
    try {
      await VoiceService().speak(message);
    } catch (e) {
      print('Voice error: $e');
    }
  }

  void _playHelpInstructions() {
    final voiceMessage = 'Welcome to Rural UPI Assistant. '
        'Press green button for payment. '
        'Press purple button for sales summary. '
        'Press blue button for voice help. '
        'Press orange button for voice settings.';
    _playVoiceConfirmation(voiceMessage);
  }

  void _voiceSetup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LanguageService.getText(widget.language, 'voice_settings')),
        content: const Text('Choose voice speed:'),
        actions: [
          TextButton(
            onPressed: () {
              VoiceService().setSpeed(0.3);
              _playVoiceConfirmation('Slow voice activated');
              Navigator.pop(context);
            },
            child: const Text('Slow'),
          ),
          TextButton(
            onPressed: () {
              VoiceService().setSpeed(0.5);
              _playVoiceConfirmation('Normal voice activated');
              Navigator.pop(context);
            },
            child: const Text('Normal'),
          ),
          TextButton(
            onPressed: () {
              VoiceService().setSpeed(0.8);
              _playVoiceConfirmation('Fast voice activated');
              Navigator.pop(context);
            },
            child: const Text('Fast'),
          ),
        ],
      ),
    );
  }

  void _showTodaySales(BuildContext context) {
    _playVoiceConfirmation('Showing today sales summary.');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LanguageService.getText(widget.language, 'today_sales')),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total Sales: ₹0', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Transactions: 0'),
            SizedBox(height: 10),
            Text('Simple summary for easy understanding'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _playVoiceConfirmation('Closing sales summary.');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LanguageService.getText(widget.language, 'logout')),
          content: Text(LanguageService.getText(widget.language, 'logout_confirmation')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LanguageService.getText(widget.language, 'cancel')),
            ),
            TextButton(
              onPressed: () async {
                await VoiceService().stop();
                await StorageService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      (route) => false,
                );
              },
              child: Text(LanguageService.getText(widget.language, 'logout')),
            ),
          ],
        );
      },
    );
  }
}