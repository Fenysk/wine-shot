import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../_shared/domain/entities/region_entity.dart';
import '../../../../../_shared/widgets/custom_dialog.dart';
import '../../../../../_shared/widgets/show_toast_notification.dart';
import '../../../bloc/producer_bloc.dart';
import '../../../data/dto/new_producer_dto.dart';
import '../bloc/new_producer_bloc.dart';

import '../../../../region/features/region_list/widgets/region_dropdown_field.dart';
import 'producer_name_field.dart';

class NewProducerDialog extends StatefulWidget {
  const NewProducerDialog({super.key});

  @override
  State<NewProducerDialog> createState() => _NewProducerDialogState();
}

class _NewProducerDialogState extends State<NewProducerDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameController = TextEditingController();

  RegionEntity? _selectedRegion;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      if (_selectedRegion == null) return;

      final producerDto = NewProducerDto(
        name: _nameController.text,
        regionId: _selectedRegion!.id,
      );

      context.read<NewProducerBloc>().add(AddProducerEvent(producerDto));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewProducerBloc, NewProducerState>(
      listener: (context, state) {
        if (state.status == NewProducerStatus.success) {
          Navigator.of(context).pop();
          context.read<ProducerBloc>().add(LoadProducersEvent());
        } else if (state.status == NewProducerStatus.failure) {
          CustomToast.showErrorNotification(
            title: 'Oups !',
            description: state.errorMessage ?? 'Une erreur est survenue : ${state.errorMessage}',
          );
        }
      },
      child: BlocBuilder<NewProducerBloc, NewProducerState>(
        builder: (context, state) {
          return CustomDialog(
            title: context.tr('producersPage.newProducerDialog.title'),
            content: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProducerNameField(controller: _nameController),
                  const SizedBox(height: 16),
                  RegionDropdownField(
                    selectedRegion: _selectedRegion,
                    onChanged: _updateSelectRegion,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.tr('common.cancel')),
              ),
              FilledButton(
                onPressed: state.status == NewProducerStatus.loading ? null : _submitForm,
                child: state.status == NewProducerStatus.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(context.tr('common.save')),
              ),
            ],
          );
        },
      ),
    );
  }

  void _updateSelectRegion(RegionEntity? value) {
    setState(() => _selectedRegion = value);
  }
}
