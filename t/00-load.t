#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Plack::Middleware::RestAPI' ) || print "Bail out!\n";
}

diag( "Testing Plack::Middleware::RestAPI $Plack::Middleware::RestAPI::VERSION, Perl $], $^X" );
