// ignore_for_file: unused_field

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  final List<String> _templateNames = [];

  TemplateBloc() : super(TemplateFetched(templateNames: [])) {
    on<CreateTemplateEvent>(_createTemplate);
  }

  Future<void> _createTemplate(CreateTemplateEvent event, emit) async {
    emit(TemplateLoading());
    _templateNames.add(event.templateName);
    emit(TemplateFetched(templateNames: _templateNames));
  }
}
