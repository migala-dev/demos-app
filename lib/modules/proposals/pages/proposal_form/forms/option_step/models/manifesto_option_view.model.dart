
class ManifestoOptionView {
  String title;
  String? manifestoOptionId;

  ManifestoOptionView({ required this.title, this.manifestoOptionId });

  factory ManifestoOptionView.fromObject(dynamic o) => ManifestoOptionView(
    title: o['title'],
    manifestoOptionId: o['manifestoOptionId']
  );
}