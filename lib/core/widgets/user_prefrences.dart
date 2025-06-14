import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _onboardingKey = 'onboarding_completed';
  static const String _signInKey = 'user_signed_in';
  static const String _questionnaireKey = 'questionnaire_completed';

  // ⬛ حفظ حالة انتهاء الـ Onboarding
  static Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, value);
  }

  // ✅ هل أنهى المستخدم الـ Onboarding؟
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  // ⬛ حفظ حالة تسجيل الدخول
  static Future<void> setUserSignedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_signInKey, value);
  }

  // ✅ هل المستخدم مسجل دخول؟
  static Future<bool> isUserSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_signInKey) ?? false;
  }

  // ⬛ حفظ حالة انتهاء الاستبيان
  static Future<void> setQuestionnaireCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_questionnaireKey, value);
  }

  // ✅ هل أنهى المستخدم الاستبيان؟
  static Future<bool> isQuestionnaireCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_questionnaireKey) ?? false;
  }

  // ⬛ تقدر تضيف دوال حذف القيم لو حبيت تعمل Reset
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
    await prefs.remove(_signInKey);
    await prefs.remove(_questionnaireKey);
  }
}
