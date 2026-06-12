import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:quick_job/core/common/widgets/loading_progress_indicator.dart';
import 'package:quick_job/core/services/auth_service.dart';
import 'package:quick_job/core/utils/logging/logger.dart';

class MultipartNetworkCaller {
  /// Form field request
  static Future<bool> multiFormApiCall({
    required apiUrl,
    Map<String, dynamic>? requestBody,
    String? imagePath,
    List<String>? galleryImagesPath,
    String? loaderMessage,
    required String method,
    String? imageFieldName,
  }) async {
    try {
      loadingProgressIndicator(title: loaderMessage);
      var request = http.MultipartRequest(method, Uri.parse(apiUrl));

      /// Assign Body
      if (requestBody != null) {
        request.fields['data'] = jsonEncode(requestBody);
        AppLoggerHelper.info("body for server is: ${requestBody.toString()}");
      }

      request.headers['Authorization'] = 'Bearer ${AuthService.token}';
      request.headers['Accept'] = 'application/json';

      /// Submitting one image
      if (imagePath != null && imagePath.isNotEmpty) {
        final mimeType = lookupMimeType(imagePath) ?? "image/jpeg";
        final splitMime = mimeType.split('/');

        request.files.add(
          await http.MultipartFile.fromPath(
            imageFieldName ?? "profileImage",
            imagePath,
            contentType: MediaType(splitMime[0], splitMime[1]),
          ),
        );
      }

      // / submit multiple img list
      // Multiple images with same field name
      if (galleryImagesPath != null && galleryImagesPath.isNotEmpty) {
        for (final img in galleryImagesPath) {
          final mime = lookupMimeType(img) ?? "image/jpeg";
          final split = mime.split('/');

          request.files.add(
            await http.MultipartFile.fromPath(
              "uploadGallery",
              img,
              contentType: MediaType(split[0], split[1]),
            ),
          );
          log("image added : $img");
        }
      }

      // if (galleryImagesPath != null && galleryImagesPath.isNotEmpty) {
      //   for (final img in galleryImagesPath) {
      //     if (img.startsWith("http")) {
      //       final file = await convertUrlToFile(img);

      //       request.files.add(
      //         http.MultipartFile(
      //           "galleryImages",
      //           file.openRead(),
      //           await file.length(),
      //           filename: file.path.split('/').last,
      //         ),
      //       );

      //       log("server image converted & added: $img");
      //       continue;
      //     }

      //     final mime = lookupMimeType(img) ?? "image/jpeg";
      //     final split = mime.split('/');

      //     request.files.add(
      //       await http.MultipartFile.fromPath(
      //         "galleryImages",
      //         img,
      //         contentType: MediaType(split[0], split[1]),
      //       ),
      //     );

      //     log("local image added: $img");
      //   }
      // }

      /// sending request
      final response = await request.send();
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      /// checking response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        log(response.statusCode.toString());
        final message = await response.stream.bytesToString();
        log(message.toString());
      }
    } catch (error) {
      Get.back();
      AppLoggerHelper.error(error.toString());
    }
    return false;
  }
}

// Future<File> convertUrlToFile(String imageUrl) async {
//   final response = await http.get(Uri.parse(imageUrl));
//   final dir = await getTemporaryDirectory();

//   final file = File('${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');

//   await file.writeAsBytes(response.bodyBytes);
//   return file;
// }
