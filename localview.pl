:- module(dss_localview, []).
:- use_module(cliopatria(hooks)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(http/html_write)).
:- use_module(library(http/html_head)).


cliopatria:list_resource(URI, _Options) -->
	{ rdf(_, schema:image, URI), !
	},
	html_requires(css('dss.css')),
	html(img([class(example), src(URI)])).
cliopatria:list_resource(URI, _Options) -->
	{ file_name_extension(_Base, Img, URI),
	  image_extension(Img)
	},
	html_requires(css('dss.css')),
	html([ h2([ 'Resource: ', a(href(URI), URI)]),
	       img([class(monsterrol), src(URI)])
	     ]).
cliopatria:list_resource(URI, _Options) -->
	{ atom_concat(Base, ':ocr', URI)
	},
	html_requires(css('dss.css')),
	html([ h2([ 'Resource: ', a(href(URI), URI)]),
	       iframe([class('kb-artikel'), src(Base)], [])
	     ]).

image_extension(jpg).
image_extension(jpeg).
