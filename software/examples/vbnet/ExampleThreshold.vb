Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback for acceleration threshold reached
    Sub ReachedCB(ByVal sender As BrickletAccelerometer, ByVal x As Short, _
                  ByVal y As Short, ByVal z As Short)
        System.Console.WriteLine("Acceleration(X): " + (x/1000.0).ToString() + " g")
        System.Console.WriteLine("Acceleration(Y): " + (y/1000.0).ToString() + " g")
        System.Console.WriteLine("Acceleration(Z): " + (z/1000.0).ToString() + " g")
        System.Console.WriteLine("")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim a As New BrickletAccelerometer(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        a.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler a.AccelerationReached, AddressOf ReachedCB

        ' Configure threshold for acceleration values X, Y, Z "greater than 2g" (unit is g/1000)
        a.SetAccelerationCallbackThreshold(">"C, 2*1000, 0, 2*1000, 0, 2*1000, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
