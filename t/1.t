use Data::Dumper;

use Test::More tests => 5;

use lib "../lib/";
use App::DDNS::Namecheap;

my $domain = 'mysite.org';
my $password = 'abcdefghijklmnopqrstuvwxyz123456';
my $hosts = [ '@', 'www', '*' ];

my $update = App::DDNS::Namecheap->new( domain => $domain, password => $password, hosts => $hosts );

ok( defined $update );
ok( $update->isa('App::DDNS::Namecheap'));
ok( $update->{domain} eq $domain );
ok( $update->{password} eq $password );
ok( $update->{hosts} ~~ $hosts );
