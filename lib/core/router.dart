import 'package:go_router/go_router.dart';

import '../features/file_upload/file_upload_screen.dart';
import '../features/output/output_screen.dart';

/// Application router configuration.
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const FileUploadScreen()),
    GoRoute(path: '/output', builder: (context, state) => const OutputScreen()),
  ],
);
