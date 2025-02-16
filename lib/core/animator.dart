import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState(); // استدعاء super.initState() بشكل صحيح

    _animationController = AnimationController(
      vsync: this, // استخدام this بعد إضافة SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 700), // مدة الأنيميشن
    )..repeat(reverse: true); // جعل الحركة مستمرة ذهابًا وإيابًا

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // تنظيف الموارد عند التخلص من الويدجت
    super.dispose(); // استدعاء super.dispose() بشكل صحيح
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation Example")),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
}
