part of 'new_wine_bloc.dart';

abstract class NewWineEvent extends Equatable {
  const NewWineEvent();

  @override
  List<Object?> get props => [];
}

class CreateWineEvent extends NewWineEvent {
  final NewWineDto wineDto;

  const CreateWineEvent(this.wineDto);

  @override
  List<Object?> get props => [
        wineDto
      ];
}
