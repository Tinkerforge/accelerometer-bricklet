program ExampleSimple;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletAccelerometer;

type
  TExample = class
  private
    ipcon: TIPConnection;
    acc: TBrickletAccelerometer;
  public
    procedure ReachedCB(sender: TBrickletAccelerometer; const x: SmallInt;
                        const y: SmallInt; const z: SmallInt);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'sad'; { Change to your UID }

var
  e: TExample;

{ Callback for acceleration threshold reached }
procedure TExample.ReachedCB(sender: TBrickletAccelerometer; const x: SmallInt;
                             const y: SmallInt; const z: SmallInt);
begin
    WriteLn(Format('Acceleration(X): %fG', [x/1000.0]));
    WriteLn(Format('Acceleration(Y): %fG', [y/1000.0]));
    WriteLn(Format('Acceleration(Z): %fG', [z/1000.0]));
    WriteLn('');
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  acc := TBrickletAccelerometer.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  acc.SetDebouncePeriod(10000);

  { Register threshold reached callback to procedure ReachedCB }
  acc.OnAccelerationReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for acceleration values X, Y or Z greather than 2000 }
  acc.SetAccelerationCallbackThreshold('>', 2000, 0, 2000, 0, 2000, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
