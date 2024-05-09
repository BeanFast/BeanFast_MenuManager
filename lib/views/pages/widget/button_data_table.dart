import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateButtonDataTable extends StatelessWidget {
  final void Function() onPressed;

  const CreateButtonDataTable({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child:  Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add_outlined, size: 20,),
          Text('Thêm', style: Get.textTheme.bodyMedium),
        ],
      ),
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
      icon: const Icon(Icons.remove_red_eye_outlined),
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
      icon: const Icon(Icons.delete_outlined),
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
      icon: const Icon(Icons.menu_outlined),
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
      icon: const Icon(Icons.edit_calendar_outlined),
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
      icon: const Icon(Icons.cancel_outlined),
      onPressed: onPressed,
    );
  }
}
