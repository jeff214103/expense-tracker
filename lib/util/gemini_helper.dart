import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_web/provider/setting_provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

FirebaseAI getFirebaseAI() {
  return FirebaseAI.googleAI(appCheck: FirebaseAppCheck.instance);
}

Future<List<InlineDataPart>> pickAndConvertFilesToDataParts(
    BuildContext context) {
  return FilePicker.platform.pickFiles(allowMultiple: true).then((result) {
    if (result == null) return []; // Handle user cancellation gracefully

    final List<PlatformFile> files =
        result.files.where((file) => file.bytes != null).toList();

    return files
        .map((file) {
          final mimeType = lookupMimeType(file.name);
          if (mimeType == null) {
            return null;
          }
          return InlineDataPart(mimeType, file.bytes!);
        })
        .whereType<InlineDataPart>()
        .toList();
  });
}

Future<GenerateContentResponse> geminiResponse(
    {required BuildContext context,
    required Iterable<Content> prompt,
    String? responseMimeType}) {
  GenerativeModel model = getFirebaseAI().generativeModel(
      model: Provider.of<SettingProvider>(context, listen: false).geminiModel,
      generationConfig: GenerationConfig(responseMimeType: responseMimeType));
  return model.generateContent(prompt);
}