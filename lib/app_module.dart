import 'package:flutter_modular/flutter_modular.dart';

import 'features/news/presentation/modules/sources/source_module.dart';

class AppModule extends Module {
  @override
  void binds(i) async {
  }

  @override
  void routes(r) {
    // r.module(Modular.initialRoute, module: BottomNavigationModule(), guards: [
    //   AuthGuard()
    // ]);
    r.module('/sources', module: SourceModule());
  }
}
