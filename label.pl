:- module(dss_label, []).
:- use_module(cliopatria(hooks)).
:- use_module(library(semweb/rdf_db)).

rdf_label:display_label_hook(R, _Lang, Label) :-
	rdf(R, rdf:type, Type),
	rdf_reachable(Type, rdfs:subClassOf, foaf:'Person'),
	rdf_has(R, foaf:givenname, literal(Givenname)),
	rdf_has(R, foaf:familyName, literal(FamilyName)),
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
	rdf_has(Ship, rdfs:label, literal(SchipName)),
	rdf_has(R, mdb:datum, literal(Datum)),
	format(atom(Label), '~w (~w)', [SchipName, Datum]).

rang(R, RangLabel) :-
	rdf(R, mdb:rang, Rang),
	rdf(Rang, skos:prefLabel, literal(RangLabel)).

woonplaats(Person, Woonplaats) :-
	rdf_has(Person, mdb:woonplaats, WP),
	rdf_has(WP, rdfs:label, literal(Woonplaats)).

