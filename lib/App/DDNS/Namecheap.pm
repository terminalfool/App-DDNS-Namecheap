package App::DDNS::Namecheap;

use Moose;
use LWP::Simple qw($ua get);
$ua->agent("");
use Mozilla::CA;

has domain => ( is => 'ro', isa => 'Str', required => 1 );
has password => ( is => 'ro', isa => 'Str', required => 1 );
has hosts => ( is => 'ro', isa => 'ArrayRef', required => 1 );

sub update {
  my $self = shift;
  foreach ( @{ $self->{hosts} } ) {
    my $url = "https://dynamicdns.park-your-domain.com/update?domain=$self->{domain}&password=$self->{password}&host=$_";
    if ( my $return = get($url) ) {
      unless ( $return =~ /<errcount>0<\/errcount>/is ) {
	$return = ( $return =~ /<responsestring>(.*)<\/responsestring>/is ? $1 : "unknown error" );
        print "failure submitting host \"$_\.$self->{domain}\": $return\n";
      }
    }
  }
}

no Moose;

1;

__END__

=head1 NAME

App::DDNS::Namecheap - Dynamic DNS update utility for Namecheap registered domains

=head1 SYNOPSIS

    my $domain =  App::DDNS::Namecheap->new(
                      domain   => 'mysite.org',
         	      password => 'abcdefghijklmnopqrstuvwxyz012345',
		      hosts    => [ "@", "www", "*" ],
    );

    $domain->update();

=head1 DESCRIPTION

This module provides a method for setting the address records of your Namecheap registered 
domains to your external IP address. 

=head1 METHODS

=over 4

=item B<update>

Updates Namecheap A records using the three attributes listed above.

=back

=head1 AUTHOR

David Watson <dwatson@cpan.org>

=head1 SEE ALSO

scripts/ in the distribution

=head1 COPYRIGHT AND LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut
