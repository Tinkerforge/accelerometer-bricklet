Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Accelerometer Bricklet

    ' Callback subroutine for acceleration reached callback (parameters have unit g/1000)
    Sub AccelerationReachedCB(ByVal sender As BrickletAccelerometer, ByVal x As Short, _
                              ByVal y As Short, ByVal z As Short)
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

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        a.SetDebouncePeriod(10000)

        ' Register acceleration reached callback to subroutine AccelerationReachedCB
        AddHandler a.AccelerationReached, AddressOf AccelerationReachedCB

        ' Configure threshold for acceleration "greater than 2 g, 2 g, 2 g" (unit is g/1000)
        a.SetAccelerationCallbackThreshold(">"C, 2*1000, 0, 2*1000, 0, 2*1000, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
