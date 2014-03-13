package App::DDNS::Namecheap;
use Moose;

use LWP::Simple qw($ua get);
use Mozilla::CA;

has domain => ( is => 'ro', isa => 'Str', required => 1 );
has password => ( is => 'ro', isa => 'Str', required => 1 );
has hosts => ( is => 'ro', isa => 'ArrayRef', required => 1 );
has ip => ( is => 'rw', isa => 'Str', required => 0 );

sub update {
    my $self = shift;

    unless ($self->{ip}) {
                $self->{ip} = get("http://checkip.dyndns.org/");
       	        if ($self->{ip} =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/) {
		    $self->{ip} = $1;
		}
    }

    foreach ( @{ $self->{hosts} } ) {
        my $url = "https://dynamicdns.park-your-domain.com/update?host=$_&domain=$self->{domain}&password=$self->{password}&ip=$self->{ip}";
	get($url);
    }
}

no Moose;

1;

__END__

=head1 NAME

App::DDNS::Namecheap - Address record update utility for Namecheap registered domains.

=head1 SYNOPSIS

    my $domain =  App::DDNS::Namecheap->new(
                              domain   => 'website.com',
         		      password => 'abcdefghijklmnopqrstuvwxyz012345',
			      hosts    => [ "@", "www" ],
    #			      ip       => '127.0.0.1',        #defaults to host ip
    );

   $domain->update();

=head1 CAVEATS

Tested under darwin only.

=head1 AUTHOR

David Watson <dwatson@cpan.org>

=head1 SEE ALSO

scripts/ in the distribution

=head1 COPYRIGHT AND LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

=cut
