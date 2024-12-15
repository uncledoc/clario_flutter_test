part of '../screen.dart';

class _BackgroundWidget extends StatefulWidget {
  final Widget child;

  const _BackgroundWidget({
    required this.child,
  });

  @override
  State<_BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<_BackgroundWidget> {
  late Future<_Images> _image;

  @override
  void initState() {
    _image = _loadImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _image,
      builder: (context, snapshot) {
        return CustomPaint(
          painter: _BackgroundPainter(snapshot.data),
          child: widget.child,
        );
      },
    );
  }

  Future<_Images> _loadImages() async {
    return _Images(
      await loadImage(Assets.image.starBig.path),
      await loadImage(Assets.image.star.path),
      await loadImage(Assets.image.starSmall.path),
    );
  }

  Future<ui.Image> loadImage(String image) async {
    final data = await rootBundle.load(image);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class _BackgroundPainter extends CustomPainter {
  static const _origin = Size(375, 812);
  final _Images? images;

  _BackgroundPainter(this.images);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    _drawGradient(canvas, rect);
    if (images != null) {
      _drawStars(
        canvas,
        size.width / _origin.width,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) =>
      images != oldDelegate.images;

  void _drawGradient(Canvas canvas, Rect rect) {
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppTheme.colorBackgroundGradientStart,
        AppTheme.colorBackgroundGradientEnd,
      ],
    );
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawPaint(paint);
  }

  void _drawStars(Canvas canvas, double scaleX) {
    final paint = Paint();
    canvas.drawImage(images!.small, Offset(305 * scaleX, 57), paint);
    canvas.drawImage(images!.small, Offset(115 * scaleX, 137), Paint());
    canvas.drawImage(images!.star, Offset(76 * scaleX, 162), paint);
    canvas.drawImage(images!.starBig, Offset(280 * scaleX, 268), paint);
    canvas.drawImage(images!.starBig, Offset(90 * scaleX, 549), paint);
    canvas.drawImage(images!.star, Offset(260 * scaleX, 576), paint);
    canvas.drawImage(images!.small, Offset(70 * scaleX, 761), paint);
  }
}

class _Images {
  final ui.Image starBig;
  final ui.Image star;
  final ui.Image small;

  _Images(this.starBig, this.star, this.small);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Images &&
          runtimeType == other.runtimeType &&
          starBig == other.starBig &&
          star == other.star &&
          small == other.small;

  @override
  int get hashCode => starBig.hashCode ^ star.hashCode ^ small.hashCode;
}
