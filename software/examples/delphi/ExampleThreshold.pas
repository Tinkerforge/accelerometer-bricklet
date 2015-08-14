program ExampleThreshold;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletAccelerometer;

type
  TExample = class
  private
    ipcon: TIPConnection;
    a: TBrickletAccelerometer;
  public
    procedure ReachedCB(sender: TBrickletAccelerometer; const x: smallint;
                        const y: smallint; const z: smallint);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback for acceleration threshold reached }
procedure TExample.ReachedCB(sender: TBrickletAccelerometer; const x: smallint;
                             const y: smallint; const z: smallint);
begin
    WriteLn(Format('Acceleration(X): %f g', [x/1000.0]));
    WriteLn(Format('Acceleration(Y): %f g', [y/1000.0]));
    WriteLn(Format('Acceleration(Z): %f g', [z/1000.0]));
    WriteLn('');
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  a := TBrickletAccelerometer.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  a.SetDebouncePeriod(10000);

  { Register threshold reached callback to procedure ReachedCB }
  a.OnAccelerationReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for acceleration values X, Y or Z "greather than 2g" (unit is g/1000) }
  a.SetAccelerationCallbackThreshold('>', 2*1000, 0, 2*1000, 0, 2*1000, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
