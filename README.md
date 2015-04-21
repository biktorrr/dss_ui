# ClioPatria setup of Dutch Ships and Sailors

## Installation

  - Install SWI-Prolog version 7 (development) from
    http://www.swi-prolog.org (depends on platform)
  - Install ClioPatria using

	```
	git clone https://github.com/SWI-Prolog/ClioPatria.git
	```

  - Install this ClioPatria configuration *next* to
    ClioPatria using

	```
	git clone https://github.com/biktorrr/dss_ui.git
	```

  - Download the data from the `dss_ui` directory:

	```
	git submodule update --init
	```

  - Configure ClioPatria in the `dss_ui` directory using this
    command.  Use the `--with-localhost` if you plan to use
    it from localhost only.  Omit this if you want to make
    the data available from outside.

	```
	../ClioPatria/configure --with-localhost
	```

  - Start ClioPatria with

	```
	./run.pl
	```

  - Point your browser at the indicated address (default
    `http://localhost:3020/` and enter a password for the
    `admin` user.

  - Install the ClioPatria extensions from the Prolog command
    line:

	```{prolog}
	?- cpack_install(skos).
	?- cpack_install(isearch).
	?- cpack_install(swish).
	```
  - Login as `admin` using the password you set before.  Load the
    data by using _Repository/Load from library_ and choos the
    first (_00-dss-all -- All Dutch Schips and Sailors (DSS) data_)

# Running the server

With the above steps, the server is fully configured.  Restarting
is easy: just run (double click on Windows):

   ```
   ./run.pl
   ```

The script `daemon.pl` can be used to run the server as a service
on Unix based systems.
