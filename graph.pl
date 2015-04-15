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

cliopatria:context_predicate(S, P) :-
	dss_context_predicate(S, P).
