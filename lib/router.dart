import 'package:go_router/go_router.dart';
import './screens/list_screen.dart';
import './screens/edit_screen.dart';

final router = GoRouter(
  initialLocation: '/list', // 最初のルート
  routes: [
    GoRoute(
      path: '/list',
      builder: (context, state) =>  ListScreen(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
          return EditScreen(
            id: int.parse(id!),
          );
      },
    ),
  ]
);
