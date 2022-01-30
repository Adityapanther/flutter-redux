import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment }

int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }
  return state;
}

void main() {
  final store = Store<int>(counterReducer, initialState: 0);
  runApp(MyApp(
    store: store,
    title: "redux counter",
  ));
}

class MyApp extends StatelessWidget {
  final Store<int> store;
  final String title;
  const MyApp({Key? key, required this.store, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  StoreConnector<int, String>(
                      builder: (context, count) {
                        return Text(
                          count,
                          style: Theme.of(context).textTheme.headline4,
                        );
                      },
                      converter: (store) => store.state.toString())
                ],
              ),
            ),
            floatingActionButton:
                StoreConnector<int, VoidCallback>(builder: (context, callback) {
              return FloatingActionButton(
                onPressed: callback,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              );
            }, converter: (store) {
              return () => store.dispatch(Actions.Increment);
            }),
          ),
        ));
  }
}
