unit UEncrypt;

interface

uses SysUtils;

const
    alph_s: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    alpha: set of char = ['A'..'Z', 'a'..'z'];
    upper: set of char = ['A'..'Z'];

function vigenere(pt: ansistring; pass: string): ansistring;
function un_vigenere(pt: ansistring; pass: string): ansistring;
function proper_mod(a, b: integer): integer;

implementation

function proper_mod(a, b: integer): integer;
begin
    proper_mod := a mod b;
    if proper_mod < 0 then
        proper_mod := proper_mod + b;
end;

function alpha_ord(c: char): integer;
begin
    alpha_ord := proper_mod(ord(upcase(c)) - 65, 26);
end;

function vigenere(pt: ansistring; pass: string): ansistring;
var
    i: integer = 0;
    c: char;
begin
    vigenere := '';
    for c in pt do
        if c in alpha then begin
            if c in upper then
                vigenere := vigenere + chr(65 + (alpha_ord(c)
                                               + alpha_ord(pass[i + 1])) mod 26)
            else
                vigenere := vigenere + chr(97 + (alpha_ord(c)
                                               + alpha_ord(pass[i + 1])) mod 26);
            i := (i + 1) mod length(pass);
        end else
            vigenere := vigenere + c;
end;

function un_vigenere(pt: ansistring; pass: string): ansistring;
var
    i: integer;
begin
    for i := 1 to length(pass) do
        pass[i] := alph_s[1 + proper_mod(-alpha_ord(pass[i]), 26)];
    un_vigenere := vigenere(pt, pass);
end;

end.
