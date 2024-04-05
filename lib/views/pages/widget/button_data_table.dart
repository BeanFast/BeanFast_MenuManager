import 'package:flutter/material.dart';

class CreateButtonDataTable extends StatelessWidget {
  final void Function() onPressed;

  const CreateButtonDataTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.add),
      onPressed: onPressed,
      label: const Text('Thêm'),
    );
  }
}

class RefreshButtonDataTable extends StatelessWidget {
  final void Function() onPressed;

  const RefreshButtonDataTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed, icon: const Icon(Icons.refresh_outlined));
  }
}

class DetailButtonDataTable extends StatelessWidget {
  final void Function() onPressed;

  const DetailButtonDataTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.remove_red_eye),
      onPressed: onPressed,
    );
  }
}

class EditButtonDataTable extends StatelessWidget {
  final void Function() onPressed;

  const EditButtonDataTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.mode_edit_outline),
      onPressed: onPressed,
    );
  }
}

class DeleteButtonDataTable extends StatelessWidget {
  final void Function() onPressed;

  const DeleteButtonDataTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_rounded),
      onPressed: onPressed,
    );
  }
}

class ManageMenuButtonTable extends StatelessWidget {
  final void Function() onPressed;

  const ManageMenuButtonTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: onPressed,
    );
  }
}
class EditOrderActivityButtonTable extends StatelessWidget {
  final void Function() onPressed;

  const EditOrderActivityButtonTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit_calendar),
      onPressed: onPressed,
    );
  }
}

class CancelOrderActivityButtonTable extends StatelessWidget {
  final void Function() onPressed;

  const CancelOrderActivityButtonTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: onPressed,
    );
  }
}