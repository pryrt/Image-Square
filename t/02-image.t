#!perl
use 5.010;
use strict;
use warnings;
use Test::More;

plan tests => 6;

use Image::Square;

# Test horizontal image
my $image = Image::Square->new('t/3x1.png');
isa_ok ($image, 'Image::Square', '$image Instantiation');

my $square100 = $image->square(100);
isa_ok ($square100, 'GD::Image', '$square100');

cmp_ok ($square100->width, '==', $square100->height, 'Image output is square from horizontal input');
is $square100->width, 100, 'Image output width correctly resized from horizontal input';

# Test vertical image
$image = Image::Square->new('t/1x3.png');

my $square150 = $image->square(150);

cmp_ok ($square150->width, '==', $square150->height, 'Image output is square from vertical input');
is $square150->height, 150, 'Image output height correctly resized from vertical input';

done_testing;



