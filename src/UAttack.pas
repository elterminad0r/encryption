unit UAttack;

interface

uses UFiles, Math;

type
    norm_dist = array['A'..'Z'] of real;
    dist = array['A'..'Z'] of integer;

const
    eng_dist: norm_dist =
    (0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094,
     0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929,
     0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150,
     0.01974, 0.00074);
    alpha: set of char = ['A'..'Z', 'a'..'z'];

function fitness(pt_dist: norm_dist): real;
function IOC(d: dist): real;
function get_dist(pt: ansistring): dist;
function get_interval(pt: ansistring; start, interval: integer): ansistring;
function clean(pt: ansistring): ansistring;
function normalise(d: dist): norm_dist;

implementation

function normalise(d: dist): norm_dist;
var
    total: integer = 0;
    i: integer;
    dist_i: char;
begin
    for i in d do
        total := total + i;
    for dist_i := 'A' to 'Z' do
        normalise[dist_i] := d[dist_i] / total;
end;

function IOC(d: dist): real;
var
    total: integer = 0;
    freq: integer;
begin
    IOC := 0;
    for freq in d do begin
        IOC := IOC + freq * (freq - 1);
        total := total + freq;
    end;
    IOC := IOC / ((total * (total - 1)));
end;

function clean(pt: ansistring): ansistring;
var
    c: char;
begin
    clean := '';
    for c in pt do
        if c in alpha then
            clean := clean + c;
end;

function get_interval(pt: ansistring; start, interval: integer): ansistring;
var
    i: integer;
begin
    get_interval := '';
    for i := 0 to (length(pt) - start) div interval do
        get_interval := get_interval + pt[i * interval + start + 1];
end;

function get_dist(pt: ansistring): dist;
var
    c: char;
begin
    for c := 'A' to 'Z' do
        get_dist[c] := 0;
    for c in pt do
        if c in alpha then
            inc(get_dist[upcase(c)]);
end;

function fitness(pt_dist: norm_dist): real;
var
    i: char;
begin
    fitness := 0;
    for i := 'A' to 'Z' do
        fitness := fitness + power(pt_dist[i] - eng_dist[i], 2);
end;

end.
