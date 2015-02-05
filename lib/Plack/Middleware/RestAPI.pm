package Plack::Middleware::RestAPI;

use 5.006;
use strict;
use warnings FATAL => 'all';

use parent qw( Plack::Middleware );

use HTTP::Exception '4XX';

=head1 NAME

Plack::Middleware::RestAPI - Perl PSGI middleware that just call GET, PUT, POST, DELETE from mounted class.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

	use Plack::Middleware::RestAPI;
	use Test::Root;

	builder {
		mount "/api" => builder {
			enable 'RestAPI';
			mount "/" => sub { 'Test::Root' };
		};
	};

	package Test::Root;

	sub GET {
		return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'app/root' ] ];
	}

=head1 DESCRIPTION

Plack::Middleware::RestAPI is simple middleware that call requested method directly from mounted class.

Method can be GET, PUT, POST, DELETE, HEAD. 

For complete RestAPI in Perl use: 

=over 4

=item * Plack::Middleware::ParseContent

=item * Plack::Middleware::SetAccept

=item * Plack::Middleware::FormatOutput

=back

=cut

sub call {
	my($self, $env) = @_;

	# Get class
	my $class = $self->app->($env);
	return $class if ref $class; # Return if returned value is not string

	my $method = $env->{REQUEST_METHOD};

	# Throw an exception if method is not defined
	if (!UNIVERSAL::can($class, $method)){
		HTTP::Exception::405->throw();
	}

	# Set rest api class to env
	$env->{'restapi.class'} = $class;

	# compatibility with Plack::Middleware::ParseContent
	my $data = $env->{'restapi.parseddata'} if exists $env->{'restapi.parseddata'};

	# Call method
	my $ret;
	no strict 'refs';
	$ret = "${class}::${method}"->($env, $data);
	use strict;

	return $ret;
}

=head1 STORED PARAMS TO ENV (Fulfill the PSGI specification)

=over 4

=item restapi.class

Store name of called class.

=back

=head1 TUTORIAL

L<http://psgirestapi.dovrtel.cz/>

=head1 AUTHOR

Vaclav Dovrtel, C<< <vaclav.dovrtel at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to github repository.

=head1 ACKNOWLEDGEMENTS

Inspired by L<https://github.com/towhans/hochschober>

=head1 REPOSITORY

L<https://github.com/vasekd/Plack-Middleware-RestAPI>

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Vaclav Dovrtel.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.

=cut

1; # End of Plack::Middleware::RestAPI
