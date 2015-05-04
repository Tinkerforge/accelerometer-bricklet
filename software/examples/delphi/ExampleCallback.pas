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
    procedure AccelerationCB(sender: TBrickletAccelerometer; const x: SmallInt; 
 	                         const y: SmallInt; const z: SmallInt);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'sad'; { Change to your UID }

var
  e: TExample;

{ Callback function for acceleration callback }
procedure TExample.AccelerationCB(sender: TBrickletAccelerometer; const x: SmallInt;
                                  const y: SmallInt; const z: SmallInt);
begin
    WriteLn(Format('Acceleration(X): %f', [x/1000.0]));
    WriteLn(Format('Acceleration(Y): %f', [y/1000.0]));
    WriteLn(Format('Acceleration(Z): %f', [z/1000.0]));
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

  { Set Period for acceleration callback to 1s (1000ms)
    Note: The callback is only called every second if the
          acceleration has changed since the last call! }
  acc.SetAccelerationCallbackPeriod(1000);

  { Register acceleration callback to procedure AccelerationCB }
  acc.OnAcceleration := {$ifdef FPC}@{$endif}AccelerationCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
