part of 'manifestos_bloc.dart';

abstract class ManifestosEvent extends Equatable {
  const ManifestosEvent();

  @override
  List<Object> get props => [];
}

class ManifestosLoaded extends ManifestosEvent {
  final String spaceId;

  const ManifestosLoaded(this.spaceId);
}

class ManifestoAdded extends ManifestosEvent {
  final Manifesto newManifesto;

  const ManifestoAdded(this.newManifesto);
}
