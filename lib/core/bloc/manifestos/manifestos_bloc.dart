import 'package:bloc/bloc.dart';
import 'package:demos_app/core/models/manifesto/manifesto.model.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:equatable/equatable.dart';

part 'manifestos_event.dart';
part 'manifestos_state.dart';

class ManifestosBloc extends Bloc<ManifestosEvent, ManifestosState> {
  static final ManifestosBloc _manifestosBloc = ManifestosBloc._internal();
  factory ManifestosBloc() => _manifestosBloc;

  ManifestosBloc._internal() : super(ManifestosLoadInProgress()) {
    on<ManifestosLoaded>((event, emit) async {
      emit(ManifestosLoadInProgress());

      final manifestos =
          await ManifestoRepository().findBySpaceId(event.spaceId);

      emit(ManifestosLoadSuccess(manifestos));
    });

    on<ManifestoAdded>((event, emit) {
      if (state is ManifestosLoadSuccess) {
        final currentState = (state as ManifestosLoadSuccess);
        emit(ManifestosLoadInProgress());
        emit(currentState.copyWithNewManifesto(event.newManifesto));
      }
    });
  }
}
