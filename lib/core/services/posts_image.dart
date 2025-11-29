import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../features/auth/presentation/widget/button.dart';
import '../routing/router.dart';

class PostService {
  static Future<bool> _requestPermission() async {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      return true;
    } else {
      status = await Permission.photos.request();
      return status.isGranted;
    }
  }

  static Future<List<String>?> createPostWithMedia(BuildContext context) async {
    bool hasPermission = await _requestPermission();
    if (!hasPermission) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 80,
            child: Center(child: Text('تم رفض الإذن للوصول إلى التخزين.')),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: [
            ButtonAuth(
              text: 'حسنا',
              function: () {
                Navigator.pushNamed(context, Routers.createPosts);
              },
            ),
          ],
        ),
      );
      return null;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      List<String> filePaths = result.files.map((file) => file.path!).toList();
      return filePaths;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 80,
            child: Center(child: Text('لم يتم اختيار أي ملفات.')),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: [
            ButtonAuth(
              text: 'حسنا',
              function: () {
                Navigator.pushNamed(context, Routers.createPosts);
              },
            ),
          ],
        ),
      );
      return null;
    }
  }
}
