#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  Data::Str2Num;

use strict;
use 5.001;
use warnings;
use warnings::register;

#####
# Connect up with the event log.
#
use vars qw( $VERSION $DATE $FILE);
$VERSION = '0.04';
$DATE = '2004/04/25';
$FILE = __FILE__;

use vars qw(@ISA @EXPORT_OK);
require Exporter;
@ISA=('Exporter');
@EXPORT_OK = qw(str2int);

use Data::SecsPack;

######
# 
#
sub str2int
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     my $num = Data::SecsPack->str2int(@_); # force scalar context
     $num;  
}

1

__END__

=head1 NAME

Data::Str2int - int, int str to int; else undef. No warnings

=head1 SYNOPSIS

 int, int str to int; else undef. No warnings.

 #####
 # Subroutine interface
 #  
 use Data::Str2Num qw(str2int);

 $integer = str2int($string);

=head1 DESCRIPTION

The L<Data::SecsPack|Data::SecsPack> program module
supercedes this program module. 
The C<Data::SecsPack::str2int> subroutine,
in a scalar context, behaves the same and 
supercedes C&<Data::StrInt::str2int>.
In time, this module will vanish.

The C<str2int> subroutine translates an scalar numeric string 
and a scalar number to a scalar integer; otherwsie it returns
an C<undef>.

Perl itself has a documented function, '0+$x', that converts 
a number scalar 
so that its internal storage is an integer
(See p.351, 3rd Edition of Programming Perl).
"If it cannot perform the conversion, it leaves the integer 0."
In addition the C<0 +> also produces a warning.

So how do you tell a conversion failure from the number 0?
Compare the output to the input?
Trap the warning?
Surprising not all Perls, some Microsoft Perls in particular, may leave
the internal storage as a scalar string and do not do numeric strings.
Perl 5.6 under Microsoft has a broken '0+' and is
no longer actively supported.
It is still very popular and widely used on web hosting computers.

What is C<$x> for the following, Perl 5.6, Microsoft:

 my $x = 0 + '0x100';  # $x is 0 with a warning  

The C<str2int> provides a different behavior that
is more usefull in many situations as follows:

 $x = str2int('033');   # $x is 27
 $x = str2int('0xFF');  # $x is 255
 $x = str2int('255');   # $x is 255
 $x = str2int('hello'); # $x is undef no warning
 $x = str2int(0.5);     # $x is undef no warning
 $x = str2int(1E0);     # $x is 1 
 $x = str2int(0xf);     # $x is 15
 $x = str2int(1E30);    # $x is undef no warning

The C<str2int> pulls out
anything that resembles an integer; otherwise it returns undef
with no warning.
This makes the C<str2int> subroutine not only useful for forcing an
integer conversion but also for parsing scalars from
strings. 

The Perl code is a few lines without starting any whatevers
with a Perl C<eval> and attempting to trap all the warnings
and dies, and without the regular expression 
engine with its overhead.
The code works on broken Microsoft 5.6 Perls.

=head1 SEE ALSO

=over 4

=item L<Data::SecsPack|Data::SecsPack> 

=back

=cut

### end of script  ######