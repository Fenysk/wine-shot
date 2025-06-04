part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object> get props => [];
}

class CreateTemplateEvent extends TemplateEvent {
  final String templateName;

  const CreateTemplateEvent({required this.templateName});

  @override
  List<Object> get props => [
        templateName
      ];
}
