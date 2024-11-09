import 'dart:io';
import 'dart:math';

import 'package:file_upload/controller/upload_controller.dart';
import 'package:file_upload/widgets/build_drawer.dart';
import 'package:file_upload/widgets/custom_colors.dart';
import 'package:file_upload/widgets/reusable_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DrawingController _drawingController = DrawingController();
  final Map<String, File> _drawingAnswer = {};
  final Map<String, dynamic> _answers = {};
  final UploadController uploadController = UploadController();

  String generateUniqueId() {
    const length = 4;
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();

    String uniqueId = String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));

    return uniqueId;
  }

  @override
  void initState() {
    super.initState();
    _drawingController = DrawingController();
  }

  Future<void> saveAnswer(
    DrawingController drawingController,
    BuildContext context,
    Map<String, dynamic> answers,
    Function setState,
    String uniqueKey,
    Map<String, File> drawingFiles,
  ) async {
    try {
      final answerImage = await drawingController.getImageData();
      if (answerImage == null) {
        if (context.mounted) {
          ReusableSnackbar.showErrorSnackbar(
              context: context, description: "No image has been found");
          return;
        }
      }

      final answerImageDirectory = Directory("/storage/emulated/0/Pictures");
      if (!answerImageDirectory.existsSync()) {
        answerImageDirectory.create(recursive: true);
      }

      String answerFileName =
          "drawings_${DateTime.now().millisecondsSinceEpoch}.png";
      String answerImagePath = "${answerImageDirectory.path}/$answerFileName";

      final answerFile = File(answerImagePath);
      await answerFile.writeAsBytes(answerImage!.buffer.asUint8List());
      drawingFiles['${uniqueKey}_drawing'] = answerFile;
      // Store the File object in the answers map
      answers['${uniqueKey}_drawing'] = answerFileName;

      if (context.mounted) {
        ReusableSnackbar.showSuccessSnackbar(
            context: context, description: "Answer has been saved");
      }
    } catch (error) {
      if (context.mounted) {
        ReusableSnackbar.showErrorSnackbar(
            context: context, description: "No image has been found");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: const BuildDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                const Text('Home'),
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: buildDrawing(_drawingController),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Save as answer'),
                    IconButton(
                      onPressed: () {
                        saveAnswer(_drawingController, context, _answers,
                            setState, '1', _drawingAnswer);
                      },
                      icon: const Icon(
                        Icons.save_alt,
                        color: CustomColors.navyBlue,
                      ),
                    ),
                  ],
                ),
                const Text('audio ni sya diri'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (_drawingAnswer.containsKey('1_drawing')) {
                      await uploadController.sendDrawingToServer(
                        _drawingAnswer['1_drawing']!,
                        _answers,
                      );
                    } else {
                      // Show error if there is no saved drawing
                      ReusableSnackbar.showErrorSnackbar(
                        context: context,
                        description: "Please save the drawing first.",
                      );
                    }
                    print('_answers value: $_answers');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildDrawing(DrawingController drawingController) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return DrawingBoard(
        controller: drawingController,
        background: Container(
          color: Colors.grey[200],
          width: constraints.maxWidth,
          height: constraints.maxHeight,
        ),
        showDefaultActions: true,
        showDefaultTools: true,
      );
    },
  );
}
