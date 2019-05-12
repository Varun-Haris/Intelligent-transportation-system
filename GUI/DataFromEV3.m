classdef DataFromEV3 < handle
    properties
        Left
        Middle
        Right
        Ultrasonic
        Speed
        BatteryVoltage
    end
    
    methods
        function obj = DataFromEV3()
            obj.Left = 0;
            obj.Middle = EV3_Colors.None;
            obj.Right = 0;
            obj.Ultrasonic = 0;
            obj.Speed = 0;
            obj.BatteryVoltage = 0;
        end
        
        function Depacketize(obj, msg)
            %disp('Inside Depacketize.')
            obj.Left = uint8(msg(1));
            %disp('Left')
            %disp(obj.Left)
            obj.Middle = uint8(msg(2));
            %disp('Middle')
            %disp(obj.Middle)
            obj.Right = uint8(msg(3));
            %disp('Right')
            %disp(obj.Right)
            obj.Ultrasonic = uint8(msg(4));
            %disp('Ultrasonic')
            %disp(obj.Ultrasonic)
            obj.Speed = uint8(msg(5));
            %disp('Speed')
            %disp(obj.Speed)
            obj.BatteryVoltage = uint8(msg(6));
            %disp('BatteryVoltage')
            %disp(obj.BatteryVoltage)
        end
    end
end