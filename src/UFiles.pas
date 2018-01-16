unit UFiles;

interface

uses SysUtils;

function read_file(var f: textfile): ansistring;

implementation

function read_file(var f: textfile): ansistring;
var
    c: char;
begin
    read_file := '';
    while not eof(f) do begin
        read(f, c);
        read_file := read_file + c;
    end;
end;

end.
