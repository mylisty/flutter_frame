
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frame/page/provider/counter_model.dart';
import 'package:provider/provider.dart';
/// 状态管理方式 全局状态
/*class ProviderPageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
          return _ProviderPageDemoState();
  }

}*/
class ProviderPageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count  = 0;
   return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),

            /// Extracted as a separate widget for performance optimization.
            /// As a separate widget, it will rebuild independently from [MyHomePage].
            ///
            /// This is totally optional (and rarely needed).
            /// Similarly, we could also use [Consumer] or [Selector].
            const Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: ()  {
          var calculateInstallmentModel = CalculateInstallmentModel();
      /*    var s = calculateInstallmentModel.fqNum ;
          var b = s++;*/
          calculateInstallmentModel.fqNum  = count++;
          context.read<Counter>().changeCalculateInstallmentModel(calculateInstallmentModel);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        /// Calls `context.watch` to make [MyHomePage] rebuild when [Counter] changes.
        '${context.watch<Counter>().calculateInstallmentModel?.fqNum}',
        style: Theme.of(context).textTheme.headline4);
  }
}
