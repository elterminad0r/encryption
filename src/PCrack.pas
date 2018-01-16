{$MODE OBJFPC}

program PCrack;

uses UAttack, UEncrypt, UFiles, Sysutils;

function likely_caes(pt: ansistring): char;
var
    c, best_c: char;
    f, best_f: real;
begin
    best_f := -999;
    for c := 'A' to 'Z' do begin
        f := -fitness(normalise(get_dist(un_vigenere(pt, c))));
        if f > best_f then begin
            best_f := f;
            best_c := c;
        end;
    end;
    likely_caes := best_c;
end;

function likely_vig(pt: ansistring; keyl: integer): string;
var
    strpd: ansistring;
    start: integer;
begin
    strpd := clean(pt);
    likely_vig := '';
    for start := 0 to keyl - 1 do
        likely_vig := likely_vig + likely_caes(get_interval(strpd, start, keyl));
end;

var
    vg_key: string;
    pt: ansistring;
    keyl: integer;
begin
    if paramcount > 0 then
        try
            keyl := strtoint(paramstr(1));
        except
            on EConvertError do begin
                writeln(stderr, 'Invalid key length ', paramstr(1));
                exit;
            end;
        end
    else begin
        writeln(stderr, 'Key length required; see bin/IOC');
        exit;
    end;
    pt := read_file(input);
    vg_key := likely_vig(pt, keyl);
    writeln(output, 'key is ', vg_key);
    writeln(output, 'resulting pt: ', un_vigenere(pt, vg_key));
end.
