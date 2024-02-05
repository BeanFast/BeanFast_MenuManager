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

class RefreshButtonDataTable extends StatelessWidget {
  final void Function() refreshData;

  const RefreshButtonDataTable({
    super.key,
    required this.refreshData,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: refreshData, icon: const Icon(Icons.refresh_outlined));
  }
}

class DetailButtonDataTable extends StatelessWidget {
  final void Function() goToPage;

  const DetailButtonDataTable({
    super.key,
    required this.goToPage,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.remove_red_eye),
      onPressed: goToPage,
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
  final void Function() agree;

  const DeleteButtonDataTable({
    super.key,
    required this.agree,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_rounded),
      onPressed: DeleteDialog(agree: agree).showDialog,
    );
  }
}

class ManageMenuButtonTable extends StatelessWidget {
  final void Function() goTo;

  const ManageMenuButtonTable({
    super.key,
    required this.goTo,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: goTo,
    );
  }
}