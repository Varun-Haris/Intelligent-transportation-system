classdef Position < handle
    properties
        x
        z
        yaw
        MovingAverageFilterLength
    end
    
    methods
        function obj = Position()
            obj.MovingAverageFilterLength = 5;
            obj.x = zeros(obj.MovingAverageFilterLength);
            obj.z = zeros(obj.MovingAverageFilterLength);
            obj.yaw = zeros(obj.MovingAverageFilterLength);
        end
        
        function Add_x(obj, val)
            obj.x = [obj.x(2:length(obj.x)), val];
        end
        
        function Add_z(obj, val)
            obj.z = [obj.z(2:length(obj.z)), val];
        end
        
        function Add_yaw(obj, val)
            obj.yaw = [obj.yaw(2:length(obj.yaw)), val];
        end
        
        function result = Get_x(obj)
            result = mean(obj.x);
        end
        
        function z = get.z(obj)
            z = mean(obj.z);
        end
        
        function result = Get_yaw(obj)
            %result = mean(obj.yaw);
            result = obj.yaw(obj.MovingAverageFilterLength);
        end
        
    end
end