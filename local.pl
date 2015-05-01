:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf_library)).
:- use_module(library(settings)).

:- set_setting_default(http:logfile, 'log/httpd.log').

:- rdf_register_prefix(mdb,    'http://purl.org/collections/nl/dss/mdb/').
:- rdf_register_prefix(gzmvoc, 'http://purl.org/collections/nl/dss/gzmvoc/').
:- rdf_register_prefix(das,    'http://purl.org/collections/nl/dss/das/').
:- rdf_register_prefix(dss,    'http://purl.org/collections/nl/dss/').
:- rdf_register_prefix(schema, 'http://schema.org/').

:- use_module(graph).
:- use_module(localview).
:- use_module(dss_queries).
:- use_module(label).

:- rdf_attach_library(.).
