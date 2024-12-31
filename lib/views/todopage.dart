import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/model/models.dart';
import 'package:todo_provider/providers/provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController addController = TextEditingController();
  TextEditingController updateController = TextEditingController();
  var data = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addController.dispose();
    updateController.dispose();
  }

//

  @override
  Widget build(BuildContext context) {
    final TextStyle title = TextStyle(
      fontFamily: 'fancy',
      fontSize: 40,
      color: Theme.of(context).colorScheme.secondary,
      decoration: TextDecoration.underline,
      decorationColor: Theme.of(context).colorScheme.secondary,
    );

//
    final TextStyle todoText = TextStyle(
      fontFamily: 'fancy',
      fontSize: 30,
      color: Theme.of(context).colorScheme.secondary,
    );

    final TextStyle todoInput = TextStyle(
      fontFamily: 'inter',
      fontSize: 18,
      color: Theme.of(context).colorScheme.secondary,
    );
    return Consumer<TodoProvider>(builder: (context, value, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog.adaptive(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Todo',
                            style: todoText,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                              ))
                        ],
                      ),
                      content: TextFormField(
                        maxLines: null,
                        minLines: null,
                        style: todoInput,
                        controller: addController,
                        onChanged: (value) {
                          data = value;
                        },
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (addController.text.isNotEmpty) {
                                Navigator.pop(context);
                                value.create(
                                  data,
                                );
                                addController.clear();
                              }
                            },
                            child: Text(
                              'add',
                              style: todoText,
                            ))
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              'Todo App',
              style: title,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/setting');
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.secondary,
                  ))
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: ValueListenableBuilder(
              valueListenable: value.data.listenable(),
              builder: (context, todo, child) {
                if (todo.isEmpty) {
                  return Center(
                    child: Text(
                      'Empty.',
                      style: todoText,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: value.data.length,
                  itemBuilder: (context, index) {
                    final box = todo;
                    final getTodo = box.getAt(index);
                    TextStyle todoInputs = TextStyle(
                        fontFamily: 'inter',
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                        decoration: getTodo.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: getTodo.isChecked
                            ? Theme.of(context).colorScheme.secondary
                            : null,
                        decorationThickness: 2);
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (_) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog.adaptive(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Update Todo',
                                          style: todoText,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ))
                                      ],
                                    ),
                                    content: TextFormField(
                                      maxLines: null,
                                      minLines: null,
                                      style: todoInput,
                                      controller: updateController,
                                      onChanged: (value) {
                                        data = value;
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            if (updateController
                                                .text.isNotEmpty) {
                                              Navigator.pop(context);
                                              value.update(data, index);
                                              updateController.clear();
                                            }
                                          },
                                          child: Text(
                                            'update',
                                            style: todoText,
                                          ))
                                    ],
                                  );
                                });
                          },
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.edit_document,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (_) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    title: Text(
                                      'Delete',
                                      style: todoText,
                                    ),
                                    content: Text(
                                      'Are you sure?',
                                      style: todoText,
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            value.remove(index);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: todoText,
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'No',
                                            style: todoText,
                                          ))
                                    ],
                                  );
                                });
                            //
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ]),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        color: Theme.of(context).colorScheme.primary,
                        child: ListTile(
                          title: Text(
                            getTodo.text,
                            style: todoInputs,
                          ),
                          trailing: Checkbox(
                            value: getTodo.isChecked,
                            onChanged: (_) {
                              var get = TodoModel(
                                  text: getTodo.text,
                                  isChecked: !getTodo.isChecked);
                              box.putAt(index, get);
                            },
                            checkColor:
                                Theme.of(context).colorScheme.background,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }));
    });
  }
}
