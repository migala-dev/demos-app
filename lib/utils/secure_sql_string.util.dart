String secureSQLString(String? value) {
  if (value != null) {
    return value.replaceAll('`', '').replaceAll("'", "''");
  }

  return '';
}