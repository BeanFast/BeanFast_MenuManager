import 'package:beanfast_menumanager/views/dialog/delete_food_dialog.dart';
import 'package:flutter/material.dart';

class CreateButtonDataTable extends StatelessWidget {
  final void Function() showDialog;

  const CreateButtonDataTable({
    super.key,
    required this.showDialog,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.add),
      onPressed: showDialog,
      label: const Text('Thêm'),
    );
  }
}

class EditButtonDataTable extends StatelessWidget {
  final void Function() showDialog;

  const EditButtonDataTable({
    super.key,
    required this.showDialog,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.mode_edit_outline),
      onPressed: showDialog,
    );
  }
}

class DeleteButtonDataTable extends StatelessWidget {
  final void Function() fnAgree;

  const DeleteButtonDataTable({
    super.key,
    required this.fnAgree,
  });

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      icon: const Icon(Icons.delete_rounded),
      onPressed: DeleteDialog(agree: fnAgree).showDialog,
    );
  }
}
