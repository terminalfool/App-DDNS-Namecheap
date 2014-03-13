#!/usr/bin/env perl

use lib "../lib/";
use strict;
use warnings;

use App::DDNS::Namecheap;
use Try::Tiny;

my $timeout = 1;  # 1 day timeout
$timeout *= 86400;

my $domain =  App::DDNS::Namecheap->new(
                  domain   => 'website.com',
		  password => 'abcdefghijklmnopqrstuvwxyz012345',
		  hosts    => [ "@", "www" ],
#		  ip       => '127.0.0.1',        #defaults to external ip
);

while (1) {
   try {
         local $SIG{ALRM} = sub { die "alarm\n" };
         alarm $timeout;
         main();
         alarm 0;
       }

   catch {
         die $_ unless $_ eq "alarm\n";
 	 kill HUP => $$;
         print "ddns cycled.\n";
       };
}

sub main {
   $domain->update();
}

=head1 NAME

update.pl - command line stub

=head1 SYNOPSIS

   perl update.pl

=head1 DESCRIPTION

Address record update utility for Namecheap registered domains.

=head1 CAVEATS

Tested on darwin only.

=head1 AUTHOR

David Watson <dwatson@cpan.org>

=head1 SEE ALSO

App::DDNS::Namecheap

=head1 COPYRIGHT

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
