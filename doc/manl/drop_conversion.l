.\\" auto-generated by docbook2man-spec $Revision: 1.1.1.1 $
.TH "DROP CONVERSION" "" "2011-12-01" "SQL - Language Statements" "SQL Commands"
.SH NAME
DROP CONVERSION \- remove a conversion

.SH SYNOPSIS
.sp
.nf
DROP CONVERSION [ IF EXISTS ] \fIname\fR [ CASCADE | RESTRICT ]
.sp
.fi
.SH "DESCRIPTION"
.PP
\fBDROP CONVERSION\fR removes a previously defined conversion.
To be able to drop a conversion, you must own the conversion.
.SH "PARAMETERS"
.TP
\fBIF EXISTS\fR
Do not throw an error if the conversion does not exist. 
A notice is issued in this case.
.TP
\fB\fIname\fB\fR
The name of the conversion. The conversion name may be
schema-qualified.
.TP
\fBCASCADE\fR
.TP
\fBRESTRICT\fR
These key words do not have any effect, since there are no
dependencies on conversions.
.SH "EXAMPLES"
.PP
To drop the conversion named myname:
.sp
.nf
DROP CONVERSION myname;
.sp
.fi
.SH "COMPATIBILITY"
.PP
There is no \fBDROP CONVERSION\fR statement in the SQL
standard.
.SH "SEE ALSO"
ALTER CONVERSION [\fBalter_conversion\fR(l)], CREATE CONVERSION [\fBcreate_conversion\fR(l)]