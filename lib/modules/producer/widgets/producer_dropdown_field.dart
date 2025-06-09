import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../bloc/producer_bloc.dart';
import '../domain/entities/producer_entity.dart';

class ProducerDropdownField extends StatelessWidget {
  final ProducerEntity? selectedProducer;
  final ValueChanged<ProducerEntity?> onChanged;
  final bool required;

  const ProducerDropdownField({
    super.key,
    required this.selectedProducer,
    required this.onChanged,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProducerBloc, ProducerState>(
      builder: (context, state) {
        if (state is ProducerLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProducerLoaded) {
          final producers = state.producers;
          return FormBuilderDropdown<ProducerEntity>(
            name: 'producer_id',
            decoration: InputDecoration(
              labelText: context.tr('producersPage.newProducerDialog.producerDropdownField.label'),
              border: OutlineInputBorder(),
            ),
            initialValue: producers.contains(selectedProducer) ? selectedProducer : null,
            items: producers.map<DropdownMenuItem<ProducerEntity>>((producer) {
              return DropdownMenuItem<ProducerEntity>(
                value: producer,
                child: Text(producer.name),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (required && value == null) {
                return context.tr('producersPage.newProducerDialog.producerDropdownField.validator');
              }
              return null;
            },
          );
        } else if (state is ProducerError) {
          return Text(state.errorMessage, style: const TextStyle(color: Colors.red));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
