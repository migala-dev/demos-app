part of 'manifestos_bloc.dart';

abstract class ManifestosState extends Equatable {
  const ManifestosState();

  @override
  List<Object> get props => [];
}

class ManifestosLoadInProgress extends ManifestosState {}

class ManifestosLoadSuccess extends ManifestosState {
  final List<Manifesto> manifestos;

  const ManifestosLoadSuccess(this.manifestos);

  ManifestosLoadSuccess copyWithNewManifesto(Manifesto manifesto) =>
      ManifestosLoadSuccess([...manifestos, manifesto]);
}
