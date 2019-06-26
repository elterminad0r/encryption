program PIOC;

uses UAttack, UFiles, Sysutils, Strutils;

function interval_ioc(pt: ansistring; interval: integer): real;
var
    start: integer;
begin
    interval_ioc := 0;
    for start := 0 to interval - 1 do
        interval_ioc := interval_ioc + IOC(get_dist(get_interval(pt, start, interval)));
    interval_ioc := interval_ioc / interval;
end;

procedure print_IOC(pt: ansistring; max_interval: integer);
var
    interval: integer;
begin
    for interval := 1 to max_interval do begin
        writeln(format('%2d (%.4f) %s', [interval,
                                         interval_ioc(pt, interval),
                                         dupestring('─',
                                                    trunc(interval_ioc(pt, interval) * 500))]));
    end;
end;

begin
    print_ioc(clean(read_file(input)), 20);
end.
