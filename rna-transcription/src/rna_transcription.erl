-module(rna_transcription).

-define(DNA_TO_RNA, #{$G => "C", $C => "G", $T => "A", $A => "U"}).

-export([to_rna/1, test_version/0]).

to_rna(Strand) -> to_rna(Strand, "").

test_version() -> 2.

to_rna([], RNA) -> RNA;
to_rna([LeadingDNA | RemainingDNA], RNA) ->
	case maps:get(LeadingDNA, ?DNA_TO_RNA, invalid) of
		invalid -> error;
		RNATranslation -> to_rna(RemainingDNA, string:concat(RNA, RNATranslation))
	end.
