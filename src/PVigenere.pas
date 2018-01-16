{$MODE OBJFPC}

program PVigenere;

uses
    UEncrypt, UFiles, SysUtils;

type
    crypt_func = function(pt: ansistring; pass: string): ansistring;

var
    pass: string;
    arg_i: integer;
    encryptor: crypt_func = @vigenere;
begin
    pass := 'n';
    for arg_i := 1 to paramcount do
        if paramstr(arg_i) = '--decrypt' then
            encryptor := @un_vigenere
        else
            pass := paramstr(arg_i);
    try
        pass := alph_s[1 + proper_mod(strtoint(paramstr(1)), 26)];
    except
        on EConvertError do;
    end;
    write(output, encryptor(read_file(input), pass));
end.
