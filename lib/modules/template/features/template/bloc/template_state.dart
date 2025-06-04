part of 'template_bloc.dart';

abstract class TemplateState extends Equatable {
  const TemplateState();

  @override
  List<Object> get props => [];
}

class TemplateLoading extends TemplateState {}

class TemplateFetched extends TemplateState {
  final List<String> templateNames;

  const TemplateFetched({required this.templateNames});

  @override
  List<Object> get props => [
        templateNames
      ];
}
