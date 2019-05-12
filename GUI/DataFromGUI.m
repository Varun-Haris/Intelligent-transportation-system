classdef DataFromGUI
    
    properties
        LineFollow
        myStopCond
        myErrorSignal
        Speed
        FollowDistance
        Stop_Distance
        Stop_Degrees
        myTask
        Connected
        IncrementPacketNum
        Coordinates
    end
    
    methods
        
        %{
        function obj = DataFromGUI(linefollow, stopcond, errsig, spd, fdist, stop_dist, stop_deg, task, connected)
            obj.LineFollow = linefollow;
            obj.myStopCond = stopcond;
            obj.myErrorSignal = errsig;
            obj.Speed = spd;
            obj.FollowDistance = fdist;
            obj.Stop_Distance = stop_dist;
            obj.Stop_Degrees = stop_deg;
            obj.myTask = task;
            obj.Connected = connected;
        end
        %}
        
        function obj = DataFromGUI()
            obj.LineFollow = 1;
            obj.myStopCond = StopCond.None;
            obj.myErrorSignal = ErrorSignal.Straight;
            obj.Speed = 0;
            obj.FollowDistance = 0;
            obj.Stop_Distance = 0;
            obj.Stop_Degrees = 0;
            obj.myTask = Task.DriveOuterLoopWhole;
            obj.Connected = 0;
            obj.IncrementPacketNum = 0;
        end
        
    end
    
end