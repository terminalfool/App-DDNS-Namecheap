#!/usr/bin/env perl

use lib "../lib/";
use strict;
use warnings;

use App::DDNS::Namecheap;

my $timeout = 24;  # 24 hour timeout
$timeout *= 3600;

while (1) {

  my $ip = App::DDNS::Namecheap->external_ip;

  App::DDNS::Namecheap->new(
                  domain   => 'mysite.org',
		  password => 'abcdefghijklmnopqrstuvwxyz012345',
		  hosts    => [ "@", "www", "*" ],
		  ip       => $ip,
  )->update;

  App::DDNS::Namecheap->new(
                  domain   => 'myothersite.org',
		  password => 'abcdefghijklmnopqrstuvwxyz012345',
		  hosts    => [ "@", "www", "*" ],
		  ip       => $ip,
  )->update;

# ...

  sleep ($timeout);
}

=head1 NAME

update_numerous.pl - command line stub

=head1 SYNOPSIS

   perl update_numerous.pl

=head1 DESCRIPTION

Dynamic DNS update stub for Namecheap registered domains

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
