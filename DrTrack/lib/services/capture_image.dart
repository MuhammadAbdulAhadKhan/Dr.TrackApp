import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

Future<Map<String, String>> captureFrontAndBackPhotos() async {
  final cameras = await availableCameras();

  final frontCamera = cameras.firstWhere(
    (cam) => cam.lensDirection == CameraLensDirection.front,
    orElse: () => cameras.first,
  );
  final backCamera = cameras.firstWhere(
    (cam) => cam.lensDirection == CameraLensDirection.back,
    orElse: () => cameras.first,
  );

  Future<String> capturePhoto(CameraDescription camera) async {
    final controller = CameraController(camera, ResolutionPreset.medium);
    await controller.initialize();

    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_${camera.lensDirection.name}.jpg';

    final XFile file = await controller.takePicture();
    await file.saveTo(filePath);

    await controller.dispose();

    return filePath;
  }

  final frontPath = await capturePhoto(frontCamera);
  final backPath = await capturePhoto(backCamera);

  return {'front': frontPath, 'back': backPath};
}
