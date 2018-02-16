-module(nucleotide_count).

-export([count/2, nucleotide_counts/1, test_version/0]).

count(Dna, N) ->
	case is_valid_nucleotide(N) of
		true -> count_selected_nucleotide(Dna, hd(N));
		false -> error("Invalid nucleotide")
	end.


nucleotide_counts(Dna) ->
	NucleotideFunc = fun(Nucleotide) -> {Nucleotide, count(Dna, Nucleotide)} end,
	lists:map(
		fun(SelectedNucleotide) -> NucleotideFunc(SelectedNucleotide) end,
		["A", "T", "C", "G"]
	).

count_selected_nucleotide(Dna, DesiredNucleotide) ->
	lists:foldl(
  	fun(Nucleotide, Count) ->
  		case Nucleotide =:= DesiredNucleotide of
  			true -> Count + 1;
  			false -> Count
  		end
  	end,
  	0,
  	Dna
	).

is_valid_nucleotide("A") -> true;
is_valid_nucleotide("T") -> true;
is_valid_nucleotide("C") -> true;
is_valid_nucleotide("G") -> true;
is_valid_nucleotide(_) -> false.

test_version() -> 1.
