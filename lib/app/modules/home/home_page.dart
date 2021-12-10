import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:munatasks2/app/modules/home/home_store.dart';
import 'package:munatasks2/app/modules/home/models/version_model.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  final HomeStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      appBar: AppBarWidget(title: widget.title, context: context, size: altura, settings: true, back: false, user: store.auth.user,),
      body: Observer(builder: (_) {
        if (controller.versionList!.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.versionList!.hasError) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.getList,
              child: const Text('Error'),
            ),
          );
        } else {
          List<VersionModel> list = controller.versionList!.data;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var model = list[index];
                return ListTile(
                  onTap: () {
                    _showDialog(model: model);
                  },
                  title: Text(model.title),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      controller.delete(model);
                    },
                  ),
                  trailing: Checkbox(
                    value: model.check,
                    onChanged: (v) {
                      model.check = v!;
                      controller.save(model);
                    },
                  ),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  _showDialog({VersionModel? model}) {
    model ??= VersionModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(model!.reference == null ? 'Adicionar' : 'Alterar'),
            content: TextFormField(
              initialValue: model.title,
              onChanged: (v) => model!.title = v,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'escreva...',
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.save(model!);
                  Modular.to.pop();
                },
                child: const Text('Adicionar'),
              ),
            ],
          );
        });
  }
}