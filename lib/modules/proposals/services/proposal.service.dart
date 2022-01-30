import 'package:demos_app/core/api/proposal.api.dart';
import 'package:demos_app/core/models/responses/proposal_response.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_option.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/modals/proposal_form_view.model.dart';

class ProposalService {
  Future<void> createNewProposalDraft(
    String spaceId,
    ProposalFormView proposalFormView
  ) async {
    final response = await ProposalApi()
        .createProposalDraft(spaceId, proposalFormView.title, proposalFormView.content, proposalFormView.optionType, []);
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
