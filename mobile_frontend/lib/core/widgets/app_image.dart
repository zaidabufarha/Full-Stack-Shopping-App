import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//centralized image handling. ai generated

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ?? const Icon(Icons.broken_image, color: Colors.grey),
      );
    } else if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? const Icon(Icons.broken_image, color: Colors.grey),
      );
    } else if (File(path).existsSync()) {
      return Image.file(
        File(path),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? const Icon(Icons.broken_image, color: Colors.grey),
      );
    } else {
      return Image.asset(
        'assets/blank_profile_picture.png',
        width: width,
        height: height,
        fit: fit,
      );
    }
  }
}

ImageProvider appImageProvider(String? path) {
  if (path == null || path.isEmpty) {
    return const AssetImage('assets/blank_profile_picture.png');
  }
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return CachedNetworkImageProvider(path);
  }
  if (path.startsWith('assets/')) {
    return AssetImage(path);
  }
  final file = File(path);
  if (file.existsSync()) {
    return FileImage(file);
  }
  return const AssetImage('assets/blank_profile_picture.png');
}
