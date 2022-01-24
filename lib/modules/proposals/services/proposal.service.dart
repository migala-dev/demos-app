import 'package:demos_app/core/api/proposal.api.dart';
import 'package:demos_app/core/enums/proposal/proposal_option_type.enum.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_option.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';

class ProposalService {
  Future<void> createNewProposalDraft(
    String spaceId,
    String title,
    String content,
    ProposalOptionType type,
    List<Map<String, dynamic>> options,
  ) async {
    final response = await ProposalApi()
        .sendProposalDraft(spaceId, title, content, type, options);

    await ManifestoRepository().insert(response.manifesto);
    for (final manifestoOption in response.manifestoOptions) {
      await ManifestoOptionRepository().insert(manifestoOption);
    }
    await ProposalRepository().insert(response.proposal);
  }
}
