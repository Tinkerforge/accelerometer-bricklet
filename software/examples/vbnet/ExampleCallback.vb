Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback subroutine for acceleration callback (parameters have unit g/1000)
    Sub AccelerationCB(ByVal sender As BrickletAccelerometer, ByVal x As Short, ByVal y As Short, ByVal z As Short)
        Console.WriteLine("Acceleration[X]: " + (x/1000.0).ToString() + " g")
        Console.WriteLine("Acceleration[Y]: " + (y/1000.0).ToString() + " g")
        Console.WriteLine("Acceleration[Z]: " + (z/1000.0).ToString() + " g")
        Console.WriteLine("")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim a As New BrickletAccelerometer(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register acceleration callback to subroutine AccelerationCB
        AddHandler a.Acceleration, AddressOf AccelerationCB

        ' Set period for acceleration callback to 1s (1000ms)
        ' Note: The acceleration callback is only called every second
        '       if the acceleration has changed since the last call!
        a.SetAccelerationCallbackPeriod(1000)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
