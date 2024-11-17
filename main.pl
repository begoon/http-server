#!/usr/bin/env perl

use strict;
use warnings;
use Mojolicious::Lite;
use JSON;

my $version_info = {
    version => "1.0.0",
};

get '/version' => sub {
    my $c = shift;
    $c->render(json => $version_info);
};

any '/*whatever' => sub {
    my $c = shift;
    $c->render(
        status => 404,
        json   => { error => "Not Found" }
    );
};

app->start('daemon', '-l', 'http://*:8000');
