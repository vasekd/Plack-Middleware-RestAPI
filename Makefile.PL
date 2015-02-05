use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Plack::Middleware::RestAPI',
    AUTHOR           => q{Vaclav Dovrtel <vaclav.dovrtel@gmail.com>},
    VERSION_FROM     => 'lib/Plack/Middleware/RestAPI.pm',
    ABSTRACT_FROM    => 'lib/Plack/Middleware/RestAPI.pm',
    LICENSE          => 'Perl_5',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
        'Plack::Builder' => 0,
        'Plack::Test' => 0,
        'HTTP::Request::Common' => 0,
        'Plack::App::URLMap' => 0,
    },
    PREREQ_PM => {
        'HTTP::Exception' => 0,
        'Plack::Middleware' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Plack-Middleware-RestAPI-*' },
);
