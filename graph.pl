:- module(dss_graph, []).
:- use_module(cliopatria(hooks)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdfs)).

create_inverse_properties :-
	forall(rdf(P, owl:inverseOf, P2),
	       rdf_set_predicate(P, inverse_of(P2))).

:- initialization create_inverse_properties.

:- rdf_meta
	dss_context_predicate(r, r).

dss_context_predicate(_, mdb:bestemming).
dss_context_predicate(_, mdb:has_aanmonstering).
dss_context_predicate(_, mdb:persoon).
dss_context_predicate(_, mdb:rang).
dss_context_predicate(_, mdb:schip).
dss_context_predicate(_, mdb:ligplaats).
dss_context_predicate(_, mdb:thuishaven).
dss_context_predicate(_, mdb:vertrekhaven).
dss_context_predicate(_, mdb:woonplaats).
dss_context_predicate(_, dss:has_shiptype).
dss_context_predicate(_, dss:hasOriginalScan).
dss_context_predicate(_, mdb:has_person_contract).
dss_context_predicate(_, mdb:has_contract).
dss_context_predicate(_, dss:has_kb_link).

cliopatria:context_predicate(S, P) :-
	dss_context_predicate(S, P).

cliopatria:node_shape(URI, Shape, _Options) :-
	rdf(URI, schema:image, Image), !,
	rdfs_label(URI, Label),
	Shape = [ img([ src(Image),
			scale(true)
		      ]),
		  width('150'), height('120'),
		  cellpadding('0'),
		  fixedsize(true),
		  label(Label),
		  border(1)
		].
cliopatria:node_shape(Image, Shape, _Options) :-
	rdf(URI, dss:hasOriginalScan, Image), !,
	rdfs_label(URI, Label),
	Shape = [ img([ src(Image),
			scale(true)
		      ]),
		  width('150'), height('120'),
		  cellpadding('0'),
		  fixedsize(true),
		  label(Label),
		  border(1)
		].
cliopatria:node_shape(Ship, Shape, _Options) :-
	rdf(Ship, rdf:type, Type),
	rdf_reachable(Type, rdfs:subClassOf, dss:'Ship'), !,
	Shape = [ shape(invtrapezium), style(filled), fillcolor('#cc9966') ].
cliopatria:node_shape(Ship, Shape, _Options) :-
	rdf(Ship, rdf:type, Type),
	rdf_reachable(Type, rdfs:subClassOf, dss:'Place'), !,
	Shape = [ shape(house), style(filled), fillcolor('#ff9966') ].
cliopatria:node_shape(Ship, Shape, _Options) :-
	rdf(Ship, rdf:type, Type),
	rdf_reachable(Type, rdfs:subClassOf, dss:'Person'), !,
	Shape = [ shape(egg), style(filled), fillcolor('#ccffff') ].
cliopatria:node_shape(Ship, Shape, _Options) :-
	rdf(Ship, rdf:type, Type),
	rdf_reachable(Type, rdfs:subClassOf, dss:'Record'), !,
	Shape = [ shape(component), style(filled), fillcolor('#99ff99') ].
cliopatria:node_shape(Ship, Shape, _Options) :-
	rdf(Ship, rdf:type, Type),
	rdf_reachable(Type, rdfs:subClassOf, skos:'Concept'), !,
	Shape = [ shape(trapezium), style(filled), fillcolor('#cccccc') ].
