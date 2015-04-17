:- use_module(library(semweb/rdf_db)).

:- rdf_register_prefix(mdb,    'http://purl.org/collections/nl/dss/mdb/').
:- rdf_register_prefix(dss,    'http://purl.org/collections/nl/dss/').
:- rdf_register_prefix(schema, 'http://schema.org/').

:- use_module(graph).
:- use_module(localview).
:- use_module(dss_queries).
:- use_module(label).
