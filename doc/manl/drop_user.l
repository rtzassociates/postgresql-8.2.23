.\\" auto-generated by docbook2man-spec $Revision: 1.1.1.1 $
.TH "DROP USER" "" "2011-12-01" "SQL - Language Statements" "SQL Commands"
.SH NAME
DROP USER \- remove a database role

.SH SYNOPSIS
.sp
.nf
DROP USER [ IF EXISTS ] \fIname\fR [, ...]
.sp
.fi
.SH "DESCRIPTION"
.PP
\fBDROP USER\fR is now an alias for
DROP ROLE [\fBdrop_role\fR(l)].
.SH "COMPATIBILITY"
.PP
The \fBDROP USER\fR statement is a
PostgreSQL extension. The SQL standard
leaves the definition of users to the implementation.
.SH "SEE ALSO"
DROP ROLE [\fBdrop_role\fR(l)]
