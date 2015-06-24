Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "sad" ' Change to your UID

    ' Callback function for acceleration callback (parameters have unit g/1000)
    Sub AccelerationCB(ByVal sender As BrickletAccelerometer, ByVal x As Short, _
                       ByVal y As Short, ByVal z As Short)
        System.Console.WriteLine("Acceleration(X): " + (x/1000.0).ToString() + " g")
        System.Console.WriteLine("Acceleration(Y): " + (y/1000.0).ToString() + " g")
        System.Console.WriteLine("Acceleration(Z): " + (z/1000.0).ToString() + " g")
        System.Console.WriteLine("")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim acc As New BrickletAccelerometer(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set Period for acceleration callback to 1s (1000ms)
        ' Note: The acceleration callback is only called every second if the 
        '       acceleration has changed since the last call!
        acc.SetAccelerationCallbackPeriod(1000)

        ' Register acceleration callback to function AccelerationCB
        AddHandler acc.Acceleration, AddressOf AccelerationCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
