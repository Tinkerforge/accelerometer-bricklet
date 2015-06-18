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
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'sad'; { Change to your UID }

var
  e: TExample;

procedure TExample.Execute;
var x, y, z: smallint;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  acc := TBrickletAccelerometer.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Get current acceleration }
  acc.GetAcceleration(x, y, z);
  WriteLn(Format('Accelerometer(X): %fG', [x/1000.0]));
  WriteLn(Format('Accelerometer(Y): %fG', [y/1000.0]));
  WriteLn(Format('Accelerometer(Z): %fG', [z/1000.0]));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
