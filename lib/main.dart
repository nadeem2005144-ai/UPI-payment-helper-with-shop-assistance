import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}
// Updated Data Model with Category
// Data Models
class ShopItem {
  int? id;
  String name;
  double price;
  String type; // 'unit' or 'weight'
  double currentStock;
  String? imageBase64;
  DateTime createdAt;

  ShopItem({
    this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.currentStock,
    this.imageBase64,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'currentStock': currentStock,
      'imageBase64': imageBase64,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ShopItem.fromMap(Map<String, dynamic> map) {
    return ShopItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      type: map['type'],
      currentStock: map['currentStock'],
      imageBase64: map['imageBase64'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}



// Storage Service Class
class StorageService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _languageKey = 'language';
  static const String _upiIdKey = 'upiId';
  static const String _isSetupCompletedKey = 'isSetupCompleted';
  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  // Save Login State
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Save Language
  static Future<void> setLanguage(String languageCode) async {
    final prefs = await _prefs;
    await prefs.setString(_languageKey, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString(_languageKey) ?? 'en';
  }

  // Save UPI ID
  static Future<void> setUpiId(String upiId) async {
    final prefs = await _prefs;
    await prefs.setString(_upiIdKey, upiId);
  }

  static Future<String> getUpiId() async {
    final prefs = await _prefs;
    return prefs.getString(_upiIdKey) ?? '';
  }

  // Setup Completion
  static Future<void> setSetupCompleted(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_isSetupCompletedKey, value);
  }

  static Future<bool> isSetupCompleted() async {
    final prefs = await _prefs;
    return prefs.getBool(_isSetupCompletedKey) ?? false;
  }

  // Logout - Clear all data
  static Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_upiIdKey);
    await prefs.remove(_isSetupCompletedKey);
    // Keep language preference for next user
  }
}
// Language Service Class
// Language Service Class
class LanguageService {
  static Map<String, Map<String, String>> translations = {
    'en': {
      'setup_upi': 'Setup Your UPI Account',
      'enter_upi_details': 'Enter your UPI ID and create a secure password',
      'upi_id': 'UPI ID',
      'upi_hint': 'example@ybl or example@paytm',
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
      // NEW TRANSLATIONS:
      'dashboard': 'Dashboard',
      'welcome': 'Welcome',
      'language': 'Language',
      'quick_actions': 'Quick Actions',
      'add_item': 'Add Item',
      'inventory': 'Inventory',
      'receive_payment': 'Receive Payment',
      'transaction_history': 'Transaction History',
      'logout': 'Logout',
      'logout_confirmation': 'Are you sure you want to logout?',
      'cancel': 'Cancel',
    },
    'hi': {
      'setup_upi': 'अपना UPI अकाउंट सेटअप करें',
      'enter_upi_details': 'अपना UPI ID दर्ज करें और एक सुरक्षित पासवर्ड बनाएं',
      'upi_id': 'UPI ID',
      'upi_hint': 'example@ybl या example@paytm',
      'create_password': 'पासवर्ड बनाएं',
      'password_hint': 'अपना पासवर्ड दर्ज करें',
      'confirm_password': 'पासवर्ड की पुष्टि करें',
      'confirm_hint': 'पासवर्ड फिर से दर्ज करें',
      'password_tip': 'अपने लेन-देन डेटा को सुरक्षित रखने के लिए एक मजबूत पासवर्ड का उपयोग करें',
      'save_continue': 'सहेजें और जारी रखें',
      'setup_complete': 'सेटअप पूरा हुआ!',
      'setup_success': 'आपका UPI अकाउंट सफलतापूर्वक सेटअप हो गया है। अब आप ऐप का उपयोग शुरू कर सकते हैं।',
      'get_started': 'शुरू करें',
      'enter_upi': 'कृपया अपना UPI ID दर्ज करें',
      'valid_upi': 'एक वैध UPI ID दर्ज करें (जैसे, example@ybl)',
      'enter_password': 'कृपया एक पासवर्ड दर्ज करें',
      'password_length': 'पासवर्ड कम से कम 6 वर्णों का होना चाहिए',
      'confirm_password_field': 'कृपया अपने पासवर्ड की पुष्टि करें',
      'password_mismatch': 'पासवर्ड मेल नहीं खाते',
      // NEW TRANSLATIONS:
      'dashboard': 'डैशबोर्ड',
      'welcome': 'स्वागत है',
      'language': 'भाषा',
      'quick_actions': 'त्वरित कार्य',
      'add_item': 'आइटम जोड़ें',
      'inventory': 'इन्वेंटरी',
      'receive_payment': 'भुगतान प्राप्त करें',
      'transaction_history': 'लेन-देन इतिहास',
      'logout': 'लॉगआउट',
      'logout_confirmation': 'क्या आप वाकई लॉगआउट करना चाहते हैं?',
      'cancel': 'रद्द करें',
    },
    'kn': {
      'setup_upi': 'ನಿಮ್ಮ UPI ಖಾತೆಯನ್ನು ಸೆಟಪ್ ಮಾಡಿ',
      'enter_upi_details': 'ನಿಮ್ಮ UPI ID ನಮೂದಿಸಿ ಮತ್ತು ಸುರಕ್ಷಿತ ಪಾಸ್ವರ್ಡ್ ರಚಿಸಿ',
      'upi_id': 'UPI ID',
      'upi_hint': 'example@ybl ಅಥವಾ example@paytm',
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
      // NEW TRANSLATIONS:
      'dashboard': 'ಡ್ಯಾಶ್ಬೋರ್ಡ್',
      'welcome': 'ಸ್ವಾಗತ',
      'language': 'ಭಾಷೆ',
      'quick_actions': 'ತ್ವರಿತ ಕ್ರಿಯೆಗಳು',
      'add_item': 'ಐಟಂ ಸೇರಿಸಿ',
      'inventory': 'ದಾಸ್ತಾನು',
      'receive_payment': 'ಪಾವತಿ ಸ್ವೀಕರಿಸಿ',
      'transaction_history': 'ವಹಿವಾಟು ಇತಿಹಾಸ',
      'logout': 'ಲಾಗ್ ಔಟ್',
      'logout_confirmation': 'ನೀವು ಖಚಿತವಾಗಿ ಲಾಗ್ ಔಟ್ ಮಾಡಲು ಬಯಸುವಿರಾ?',
      'cancel': 'ರದ್ದುಮಾಡಿ',
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

// Simple Splash Screen
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

  // Only 3 languages now
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
              // Header Section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo/Icon
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

                    // App Name
                    Text(
                      'Rural UPI Assistant',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tagline
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

              // Language Selection Section
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

                  // Language Buttons - Now only 3 in a column
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

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: selectedLanguage != null ? () {
                        // Navigate to next screen
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

// Language Button Widget - FIXED
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

// Next Screen - UPI Setup (We'll build this next)
class UpiSetupScreen extends StatefulWidget {
  final String selectedLanguage;

  const UpiSetupScreen({super.key, required this.selectedLanguage});

  @override
  _UpiSetupScreenState createState() => _UpiSetupScreenState();
}

class _UpiSetupScreenState extends State<UpiSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _upiIdController = TextEditingController();
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
          // Logout Button in AppBar
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
              // Header
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
                // Clear storage and logout
                await StorageService.logout();

                // Navigate back to Welcome Screen
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
      // Save to SharedPreferences
      await StorageService.setLoggedIn(true);
      await StorageService.setLanguage(widget.selectedLanguage);
      await StorageService.setUpiId(_upiIdController.text);
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
                // Navigate to Main Dashboard
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
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

// Temporary MainDashboard - We'll build this properly next
class MainDashboard extends StatelessWidget {
  final String language;

  const MainDashboard({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageService.getText(language, 'dashboard')),
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
        future: StorageService.getUpiId(),
        builder: (context, snapshot) {
          final upiId = snapshot.data ?? 'Not set';

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
                          '👋 ${LanguageService.getText(language, 'welcome')}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'UPI ID: $upiId',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Language: ${LanguageService.getText(language, 'language')}',
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
                  LanguageService.getText(language, 'quick_actions'),
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
                      Icons.add,
                      LanguageService.getText(language, 'add_item'),
                      Colors.blue,
                          () {
                        // TODO: Navigate to Add Item screen
                      },
                    ),
                    _buildActionButton(
                      context,
                      Icons.inventory,
                      LanguageService.getText(language, 'inventory'),
                      Colors.orange,
                          () {
                        // TODO: Navigate to Inventory screen
                      },
                    ),
                    _buildActionButton(
                      context,
                      Icons.qr_code,
                      LanguageService.getText(language, 'receive_payment'),
                      Colors.green,
                          () {
                        // TODO: Navigate to QR Generator
                      },
                    ),
                    _buildActionButton(
                      context,
                      Icons.history,
                      LanguageService.getText(language, 'transaction_history'),
                      Colors.purple,
                          () {
                        // TODO: Navigate to History screen
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LanguageService.getText(language, 'logout')),
          content: Text(LanguageService.getText(language, 'logout_confirmation')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LanguageService.getText(language, 'cancel')),
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
              child: Text(LanguageService.getText(language, 'logout')),
            ),
          ],
        );
      },
    );
  }
}