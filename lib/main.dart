import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AntManCard3D(),
      theme: ThemeData.dark(),
    );
  }
}

class AntManCard3D extends StatefulWidget {
  const AntManCard3D({super.key});

  @override
  State<AntManCard3D> createState() => _AntManCard3DState();
}

class _AntManCard3DState extends State<AntManCard3D>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late Animation? animation;

  @override
  void initState() {
    animation = CurveTween(
      curve: Curves.easeOut,
    ).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MouseRegion(
          onEnter: (_) => animationController.forward(),
          onExit: (_) => animationController.reverse(),
          child: SizedBox(
            width: 400,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (_, __) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    BackgroundImage(animation: animation),
                    FrontImage(animation: animation)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FrontImage extends StatelessWidget {
  const FrontImage({
    super.key,
    required this.animation,
  });

  final Animation? animation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (60 * animation!.value) + 52,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: animation!.value,
        child: Transform.scale(
          scale: 1 + (animation!.value as double) * .35,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/character.png",
              width: 157,
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.animation,
  });

  final Animation? animation;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(
          -.5 * animation!.value,
        ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
          )
        ], borderRadius: BorderRadius.circular(10)),
        child: Image.asset("assets/poster.png"),
      ),
    );
  }
}
