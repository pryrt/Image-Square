#!perl
use 5.010;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Image::Square' ) || print "Bail out!\n";
}

diag( "Testing Image::Square $Image::Square::VERSION" );
diag( "- GD module v", $GD::VERSION );
diag( "- GD libgd  v", GD::VERSION_STRING() ) if eval { GD->VERSION(2.57); };
diag( "- Perl $], $^X" );
