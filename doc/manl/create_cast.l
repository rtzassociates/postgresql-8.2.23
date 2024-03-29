.\\" auto-generated by docbook2man-spec $Revision: 1.1.1.1 $
.TH "CREATE CAST" "" "2011-12-01" "SQL - Language Statements" "SQL Commands"
.SH NAME
CREATE CAST \- define a new cast

.SH SYNOPSIS
.sp
.nf
CREATE CAST (\fIsourcetype\fR AS \fItargettype\fR)
    WITH FUNCTION \fIfuncname\fR (\fIargtypes\fR)
    [ AS ASSIGNMENT | AS IMPLICIT ]

CREATE CAST (\fIsourcetype\fR AS \fItargettype\fR)
    WITHOUT FUNCTION
    [ AS ASSIGNMENT | AS IMPLICIT ]
.sp
.fi
.SH "DESCRIPTION"
.PP
\fBCREATE CAST\fR defines a new cast. A cast
specifies how to perform a conversion between
two data types. For example,
.sp
.nf
SELECT CAST(42 AS text);
.sp
.fi
converts the integer constant 42 to type \fBtext\fR by
invoking a previously specified function, in this case
text(int4). (If no suitable cast has been defined, the
conversion fails.)
.PP
Two types may be \fIbinary compatible\fR, which
means that they can be converted into one another ``for
free'' without invoking any function. This requires that
corresponding values use the same internal representation. For
instance, the types \fBtext\fR and \fBvarchar\fR are
binary compatible.
.PP
By default, a cast can be invoked only by an explicit cast request,
that is an explicit CAST(\fIx\fR AS
\fItypename\fR) or
\fIx\fR::\fItypename\fR
construct.
.PP
If the cast is marked AS ASSIGNMENT then it can be invoked
implicitly when assigning a value to a column of the target data type.
For example, supposing that foo.f1 is a column of
type \fBtext\fR, then
.sp
.nf
INSERT INTO foo (f1) VALUES (42);
.sp
.fi
will be allowed if the cast from type \fBinteger\fR to type
\fBtext\fR is marked AS ASSIGNMENT, otherwise
not.
(We generally use the term \fIassignment
cast\fR to describe this kind of cast.)
.PP
If the cast is marked AS IMPLICIT then it can be invoked
implicitly in any context, whether assignment or internally in an
expression. For example, since || takes \fBtext\fR
operands,
.sp
.nf
SELECT 'The time is ' || now();
.sp
.fi
will be allowed only if the cast from type \fBtimestamp\fR to
\fBtext\fR is marked AS IMPLICIT. Otherwise it
will be necessary to write the cast explicitly, for example
.sp
.nf
SELECT 'The time is ' || CAST(now() AS text);
.sp
.fi
(We generally use the term \fIimplicit
cast\fR to describe this kind of cast.)
.PP
It is wise to be conservative about marking casts as implicit. An
overabundance of implicit casting paths can cause
PostgreSQL to choose surprising
interpretations of commands, or to be unable to resolve commands at
all because there are multiple possible interpretations. A good
rule of thumb is to make a cast implicitly invokable only for
information-preserving transformations between types in the same
general type category. For example, the cast from \fBint2\fR to
\fBint4\fR can reasonably be implicit, but the cast from
\fBfloat8\fR to \fBint4\fR should probably be
assignment-only. Cross-type-category casts, such as \fBtext\fR
to \fBint4\fR, are best made explicit-only.
.PP
To be able to create a cast, you must own the source or the target
data type. To create a binary-compatible cast, you must be superuser.
(This restriction is made because an erroneous binary-compatible cast
conversion can easily crash the server.)
.SH "PARAMETERS"
.TP
\fB\fIsourcetype\fB\fR
The name of the source data type of the cast.
.TP
\fB\fItargettype\fB\fR
The name of the target data type of the cast.
.TP
\fB\fIfuncname\fB(\fIargtypes\fB)\fR
The function used to perform the cast. The function name may
be schema-qualified. If it is not, the function will be looked
up in the schema search path. The function's result data type must
match the target type of the cast. Its arguments are discussed below.
.TP
\fBWITHOUT FUNCTION\fR
Indicates that the source type and the target type are binary
compatible, so no function is required to perform the cast.
.TP
\fBAS ASSIGNMENT\fR
Indicates that the cast may be invoked implicitly in assignment
contexts.
.TP
\fBAS IMPLICIT\fR
Indicates that the cast may be invoked implicitly in any context.
.PP
Cast implementation functions may have one to three arguments.
The first argument type must be identical to the cast's source type.
The second argument,
if present, must be type \fBinteger\fR; it receives the type
modifier associated with the destination type, or -1
if there is none. The third argument,
if present, must be type \fBboolean\fR; it receives true
if the cast is an explicit cast, false otherwise.
(Bizarrely, the SQL spec demands different behaviors for explicit and
implicit casts in some cases. This argument is supplied for functions
that must implement such casts. It is not recommended that you design
your own data types so that this matters.)
.PP
.PP
Ordinarily a cast must have different source and target data types.
However, it is allowed to declare a cast with identical source and
target types if it has a cast implementation function with more than one
argument. This is used to represent type-specific length coercion
functions in the system catalogs. The named function is used to
coerce a value of the type to the type modifier value given by its
second argument. (Since the grammar presently permits only certain
built-in data types to have type modifiers, this feature is of no
use for user-defined target types, but we mention it for completeness.)
.PP
.PP
When a cast has different source and
target types and a function that takes more than one argument, it
represents converting from one type to another and applying a length
coercion in a single step. When no such entry is available, coercion
to a type that uses a type modifier involves two steps, one to
convert between data types and a second to apply the modifier.
.PP
.SH "NOTES"
.PP
Use DROP CAST [\fBdrop_cast\fR(l)] to remove user-defined casts.
.PP
Remember that if you want to be able to convert types both ways you
need to declare casts both ways explicitly.
.PP
Prior to PostgreSQL 7.3, every function that had
the same name as a data type, returned that data type, and took one
argument of a different type was automatically a cast function.
This convention has been abandoned in face of the introduction of
schemas and to be able to represent binary compatible casts in the
system catalogs. The built-in cast functions still follow this naming
scheme, but they have to be shown as casts in the system catalog
\fBpg_cast\fR as well.
.PP
While not required, it is recommended that you continue to follow this old
convention of naming cast implementation functions after the target data
type. Many users are used to being able to cast data types using a
function-style notation, that is
\fItypename\fR(\fIx\fR). This notation is in fact
nothing more nor less than a call of the cast implementation function; it
is not specially treated as a cast. If your conversion functions are not
named to support this convention then you will have surprised users.
Since PostgreSQL allows overloading of the same function
name with different argument types, there is no difficulty in having
multiple conversion functions from different types that all use the
target type's name.
.sp
.RS
.B "Note:"
There is one small lie in the preceding paragraph: there is still one
case in which \fBpg_cast\fR will be used to resolve the
meaning of an apparent function call. If a
function call \fIname\fR(\fIx\fR) matches no
actual function, but \fIname\fR is the name of a data type
and \fBpg_cast\fR shows a binary-compatible cast to this
type from the type of \fIx\fR, then the call will be construed
as an explicit cast. This exception is made so that binary-compatible
casts can be invoked using functional syntax, even though they lack
any function.
.RE
.sp
.SH "EXAMPLES"
.PP
To create a cast from type \fBtext\fR to type
\fBint4\fR using the function int4(text):
.sp
.nf
CREATE CAST (text AS int4) WITH FUNCTION int4(text);
.sp
.fi
(This cast is already predefined in the system.)
.SH "COMPATIBILITY"
.PP
The \fBCREATE CAST\fR command conforms to the
SQL standard,
except that SQL does not make provisions for binary-compatible
types or extra arguments to implementation functions.
AS IMPLICIT is a PostgreSQL 
extension, too.
.SH "SEE ALSO"
.PP
CREATE FUNCTION [\fBcreate_function\fR(l)],
CREATE TYPE [\fBcreate_type\fR(l)],
DROP CAST [\fBdrop_cast\fR(l)]
