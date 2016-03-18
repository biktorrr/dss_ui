:- module(dss_label, []).
:- use_module(cliopatria(hooks)).
:- use_module(library(semweb/rdf11)).

rdf_label:display_label_hook(R, _Lang, Label) :-
	rdf(R, rdf:type, Type),
	rdf_reachable(Type, rdfs:subClassOf, foaf:'Person'),
	rdf_has_string(R, foaf:givenname, Givenname),
	rdf_has_string(R, foaf:familyName, FamilyName),
	(   woonplaats(R, WoonPlaats)
	->  format(atom(Label), '~w, ~w (uit ~w)',
		   [FamilyName, Givenname, WoonPlaats])
	;   format(atom(Label), '~w, ~w',
		   [FamilyName, Givenname])
	).
rdf_label:display_label_hook(R, Lang, Label) :-
	rdf(R, rdf:type, mdb:'PersoonsContract'), !,
	rang(R, Rang),
	rdf(R, mdb:persoon, Persoon),
	rdf_label:display_label_hook(Persoon, Lang, PersoonLabel),
	format(atom(Label), '~w: ~w', [Rang, PersoonLabel]).
rdf_label:display_label_hook(R, _Lang, Label) :-
	rdf(R, rdf:type, mdb:'Aanmonstering'),
	rdf(R, mdb:schip, Ship),
	rdf_has_string(Ship, rdfs:label, SchipName),
	rdf_has_string(R, mdb:datum, Datum),
	format(atom(Label), '~w (~w)', [SchipName, Datum]).

rang(R, RangLabel) :-
	rdf(R, mdb:rang, Rang),
	rdf(Rang, skos:prefLabel, literal(RangLabel)).

woonplaats(Person, Woonplaats) :-
	rdf_has(Person, mdb:woonplaats, WP),
	rdf_has(WP, rdfs:label, literal(Woonplaats)).

rdf_has_string(S,P,String) :-
	rdf_has(S,P,L),
	literal_string(L, String).

literal_string(Lit, String) :-
	atomic(Lit), !,
	atom_string(Lit, String).
literal_string(lang(Atom, _Lang), String) :-
	atom_string(Atom, String).
literal_string(type(Atom, _Type), String) :-
	atom_string(Atom, String).
literal_string(literal(Lit), String) :-
	literal_string(Lit, String).
literal_string(String@_Lang, String).
literal_string(Value^^Type, String) :-
	(   rdf_equal(Type, xsd:string)
	->  String = Value
	;   rdf_lexical_form(Value^^Type, String^^_)
	).

