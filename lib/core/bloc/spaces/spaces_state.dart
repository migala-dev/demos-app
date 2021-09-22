part of 'spaces_bloc.dart';

class SpacesState extends Equatable {
  final List<SpaceView> spaces;
  final List<SpaceView> invitations;
  const SpacesState({required this.spaces, required this.invitations});

  SpacesState copyWith(
          {List<SpaceView>? spaces, List<SpaceView>? invitations}) =>
      SpacesState(
          spaces: spaces ?? this.spaces,
          invitations: invitations ?? this.invitations);

  @override
  List<Object> get props => [this.spaces, this.invitations];
}
