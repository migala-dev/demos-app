class SpacePath {
  String _spaceServiceUrl = 'http://10.0.2.2:3001/v1';

  //  Space paths
  String _getSpacePath() {
    return '$_spaceServiceUrl/auth';
  }
}
