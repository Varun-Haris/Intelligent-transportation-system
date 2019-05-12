classdef Trackable
    
    properties
        Name
        OptiID
        x
     %   y
        z
     %   roll
     %   pitch
        yaw
    end
    
    methods
        
        function obj = Trackable(name, opti_id)
            if nargin > 0
                obj.Name = name;
                obj.OptiID = opti_id;
            end
        end
        
    end
    
end