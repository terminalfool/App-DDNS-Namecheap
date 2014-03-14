use Data::Dumper;

use Test::More tests => 6;

use lib "../lib/";
use App::DDNS::Namecheap;

my $domain = 'site.com';
my $ip = '127.0.0.1';
my $password = 'abcdefghijklmnopqrstuvwxyz123456';
my $hosts = [ '@', 'www' ];

my $update = App::DDNS::Namecheap->new( domain => $domain, ip => $ip, password => $password, hosts => $hosts );

ok( defined $update );
ok( $update->isa('App::DDNS::Namecheap'));
ok( $update->{domain} eq $domain );
ok( $update->{ip} eq $ip );
ok( $update->{password} eq $password );
ok( $update->{hosts} ~~ $hosts );
