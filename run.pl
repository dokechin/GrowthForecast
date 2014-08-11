use strict;
use warnings;
use JSON;
use Getopt::Long;

my $port;
GetOptions ("port=i" => \$port)
         or die("Error in command line arguments\n");

my $json = JSON->new->allow_nonref;
my $vcap = $json->decode($ENV{VCAP_SERVICES});
my $cre = $vcap->{"mysql-5.5"}->{credentials};

$ENV{MYSQL_USER} = $cre->{user}; 
$ENV{MYSQL_PASSWORD} = $cre->{password}; 
my $mysql = "dbi:mysql:$cre->{name};hostname=$cre->{host}:$cre->{port}";

system("perl -Mlib=./local/lib/perl5 growthforecast.pl -with-mysql $mysql -port $port"); 

