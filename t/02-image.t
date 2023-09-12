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
    'hor_square'   => '370f26d5fbc52ae93b1bd0928e38cd24',
    'hor_left'     => '807f6263746b7646f172b7b0928d9195',
    'hor_right'    => '65672407acff93b188d24bc9b0003bd7',
    'ver_square'   => 'c9958ec55ef446c41fdecb71b2c69d09',
    'ver_top'      => '024a3f36e32f1ad193e761b315e7be4c',
    'ver_bottom'   => 'aea5e4120e8459b226ea003a0d57a2b4',
);

# Test horizontal iamge
my $image = Image::Square->new('t/CoventryCathedral.jpg');

ok ($image, 'Instantiation');

diag('Testing horizontal image');

my $square1 = $image->square();
my $square2 = $image->square(100);
my $square3 = $image->square(150, 0);
my $square4 = $image->square(150, 1);

ok ($square1->width == $square1->height, 'Image is square from horizontal');

ok ( 100 == $square2->width && 100 == $square2->height, 'Correct resize from horizontal');

ok ( md5_hex($square2->jpeg(50)) eq $hash{'hor_square'}, 'Correct centre image from horizontal');

ok ( md5_hex($square3->jpeg(50)) eq $hash{'hor_left'}, 'Correct left image from horizontal');

ok ( md5_hex($square4->jpeg(50)) eq $hash{'hor_right'}, 'Correct right image from horizontal');

# Test vertical iamge
$image = Image::Square->new('t/decoration.jpg');

diag('Testing vertical image');

my $square5 = $image->square();
my $square6 = $image->square(100);
my $square7 = $image->square(150, 0);
my $square8 = $image->square(150, 1);

ok ($square5->width == $square5->height, 'Image is square from vertical');

ok ($square6->width == 100 && $square6->height == 100, 'Correct resize from vertical');

ok ( md5_hex($square6->jpeg(50)) eq $hash{'ver_square'}, 'Correct centre image from vertical');

ok ( md5_hex($square7->jpeg(50)) eq $hash{'ver_top'}, 'Correct top image from vertical');

ok ( md5_hex($square8->jpeg(50)) eq $hash{'ver_bottom'}, 'Correct bottom image from vertical');

done_testing;



