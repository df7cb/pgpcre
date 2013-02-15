CREATE FUNCTION pcre_text_eq(subject text, pattern text) RETURNS boolean
IMMUTABLE
RETURNS NULL ON NULL INPUT
AS '$libdir/pgpcre'
LANGUAGE C;


CREATE OPERATOR =~ (
    PROCEDURE = pcre_text_eq,
    LEFTARG = text,
    RIGHTARG = text,
    RESTRICT = regexeqsel,
    JOIN = regexeqjoinsel
);
