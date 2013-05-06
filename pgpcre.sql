SET client_min_messages = warning;

CREATE TYPE pcre;

CREATE FUNCTION pcre_in(cstring)
RETURNS pcre
AS '$libdir/pgpcre'
LANGUAGE C STRICT;

CREATE FUNCTION pcre_out(pcre)
RETURNS cstring
AS '$libdir/pgpcre'
LANGUAGE C STRICT;

CREATE TYPE pcre (
    INTERNALLENGTH = -1,
    INPUT = pcre_in,
    OUTPUT = pcre_out,
    STORAGE = extended
);

CREATE FUNCTION pcre_text_eq(subject text, pattern pcre) RETURNS boolean
IMMUTABLE
RETURNS NULL ON NULL INPUT
AS '$libdir/pgpcre'
LANGUAGE C;


CREATE OPERATOR =~ (
    PROCEDURE = pcre_text_eq,
    LEFTARG = text,
    RIGHTARG = pcre
);
