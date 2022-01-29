import 'package:demos_app/core/api/proposal.api.dart';
import 'package:demos_app/core/enums/proposal/proposal_option_type.enum.dart';
import 'package:demos_app/core/models/responses/proposal_response.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_option.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';

class ProposalService {
  Future<void> createNewProposalDraft(
    String spaceId,
    String? title,
    String? content,
    ProposalOptionType type,
    List<Map<String, dynamic>> options,
  ) async {
    final response = await ProposalApi()
        .createProposalDraft(spaceId, title, content, type, options);
    await _saveProposalResponseOnRepository(response);
  }

  
  Future<void> getProposal(String spaceId, String proposalId) async {
    ProposalResponse response = await ProposalApi().getProposal(spaceId, proposalId);

    await _saveProposalResponseOnRepository(response);
  }

  Future<void> _saveProposalResponseOnRepository(ProposalResponse response) async {
    await ManifestoRepository().insertOrUpdate(response.manifesto);
    for (final manifestoOption in response.manifestoOptions) {
      await ManifestoOptionRepository().insertOrUpdate(manifestoOption);
    }
    await ProposalRepository().insertOrUpdate(response.proposal);
  }
}
