#!perl
use 5.010;
use strict;
use warnings;
use Test::More;

eval "use Digest::MD5 qw(md5_hex)";

plan skip_all => "Skipping tests: Digest::MD5 not available!" if $@;

plan tests => 11;

use Image::Square;

# Hashes of visually tested images
my %hash = (
    'hor_square'   => 'c97e63fc792ef75b5ff49c078046321e',
    'hor_left'     => '20a5c6517316ebef4c255c12f991dbc7',
    'hor_right'    => 'ed8cf4b01870b8ad9baf81da9283677a',
    'ver_square'   => '6d29d3b19bf4784eb205622feabf2aee',
    'ver_top'      => '4360c4fffb94546e898b10662aad7045',
    'ver_bottom'   => '6550147a58db0ef44fd0290b6d46d1a3',
);

# Test horizontal iamge
my $image = Image::Square->new('t/CoventryCathedral.bmp');

ok ($image, 'Instantiation');

diag('Testing horizontal image');

my $square1 = $image->square();
my $square2 = $image->square(100);
my $square3 = $image->square(150, 0);
my $square4 = $image->square(150, 1);

ok ($square1->width == $square1->height, 'Image is square from horizontal');

cmp_ok ( 100 == $square2->width, '&&', 100 == $square2->height, 'Correct resize from horizontal');

cmp_ok ( md5_hex($square2->gd), 'eq', $hash{'hor_square'}, 'Correct centre image from horizontal');

cmp_ok ( md5_hex($square3->gd), 'eq', $hash{'hor_left'}, 'Correct left image from horizontal');

cmp_ok ( md5_hex($square4->gd), 'eq', $hash{'hor_right'}, 'Correct right image from horizontal');

# Test vertical iamge
$image = Image::Square->new('t/decoration.png');

diag('Testing vertical image');

my $square5 = $image->square();
my $square6 = $image->square(100);
my $square7 = $image->square(150, 0);
my $square8 = $image->square(150, 1);

ok ($square5->width == $square5->height, 'Image is square from vertical');

cmp_ok ($square6->width == 100, '&&', $square6->height == 100, 'Correct resize from vertical');

cmp_ok ( md5_hex($square6->gd), 'eq', $hash{'ver_square'}, 'Correct centre image from vertical');

cmp_ok ( md5_hex($square7->gd), 'eq', $hash{'ver_top'}, 'Correct top image from vertical');

cmp_ok ( md5_hex($square8->gd), 'eq', $hash{'ver_bottom'}, 'Correct bottom image from vertical');

done_testing;



