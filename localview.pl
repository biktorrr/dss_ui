:- module(dss_localview, []).
:- use_module(cliopatria(hooks)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).


cliopatria:list_resource(URI, _Options) -->
	{ file_name_extension(_Base, Img, URI),
	  image_extension(Img)
	},
	html_requires(css('dss.css')),
	html(img([class(monsterrol), src(URI)])).

image_extension(jpg).
image_extension(jpeg).
