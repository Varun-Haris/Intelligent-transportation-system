classdef Command < handle
    
    properties
        PacketNum
        LineFollow
        myStopCond
        myErrorSignal
        Speed
        FollowDistance
        Stop_Distance
        Stop_Degrees
        Message
        CurrX
        CurrY
        CurrTheta
        GoalX
        GoalY
        GoalTheta
    end
    
    methods
        
        function obj = Command()
            obj.PacketNum = 0;
            obj.LineFollow = 1;
            obj.myStopCond = StopCond.None;
            obj.myErrorSignal = ErrorSignal.Straight;
            obj.Speed = 0;
            obj.FollowDistance = 20;
            obj.Stop_Distance = 0;
            obj.Stop_Degrees = 0;
            obj.CurrX = 0;
            obj.CurrY = 0;
            obj.CurrTheta = 0;
            obj.GoalX = 0;
            obj.GoalY = 0;
            obj.GoalTheta = 0;
        end
        
        function UpdatePacketNum(obj)
            %disp('Inside UpdatePacketNum.');
            if (obj.PacketNum < (intmax('uint8') - 1) )
                obj.PacketNum = obj.PacketNum + 1;
            else
                obj.PacketNum = 0;
            end
        end
        
        function set.LineFollow(obj, val)
            %disp('Inside set.LineFollow.');
            obj.LineFollow = val;
            obj.UpdatePacketNum();
        end
        
        function set.myStopCond(obj, val)
            %disp('Inside set.myStopCond.');
            obj.myStopCond = val;
            obj.UpdatePacketNum();
        end
        
        function set.myErrorSignal(obj, val)
            %disp('Inside set.myErrorSignal.');
            obj.myErrorSignal = val;
            obj.UpdatePacketNum();
        end
        
        function set.Speed(obj, val)
            %disp('Inside set.Speed.');
            obj.Speed = val;
            obj.UpdatePacketNum();
        end
        
        function set.FollowDistance(obj, val)
            %disp('Inside set.FollowDistance.');
            obj.FollowDistance = val;
            obj.UpdatePacketNum();
        end
        
        function set.Stop_Distance(obj, val)
            %disp('Inside set.Stop_Distance.');
            obj.Stop_Distance = val;
            obj.UpdatePacketNum();
        end
        
        function set.Stop_Degrees(obj, val)
            %disp('Inside set.Stop_Degrees.');
            obj.Stop_Degrees = val;
            obj.UpdatePacketNum();
        end
        
        function msg = get.Message(obj)
            %disp('Inside get.Message.')
            msg(1) = double(obj.PacketNum);
            %disp('msg(1)')
            %disp(msg(1))
            msg(2) = double( bitor( uint8(obj.LineFollow), uint8(bitor( uint8(obj.myStopCond)*(2^1), uint8(obj.myErrorSignal)*(2^4) ) ) ) );
            %disp('msg(2)')
            %disp(msg(2))
            msg(3) = double(obj.Speed);
            %disp('msg(3)')
            %disp(msg(3))
            msg(4) = double(obj.FollowDistance);
            %disp('msg(4)')
            %disp(msg(4))
            msg(5) = double(obj.Stop_Distance);
            %disp('msg(5)')
            %disp(msg(5))
            msg(6) = double(obj.Stop_Degrees);
            %disp('msg(6)')
            %disp(msg(6))
            msg(7) = double(obj.CurrX);
            %disp('msg(7)')
            %disp(msg(7))
            msg(8) = double(obj.CurrY);
            %disp('msg(8)')
            %disp(msg(8))
            msg(9) = double(obj.CurrTheta);
            %disp('msg(9)')
            %disp(msg(9))
            msg(10) = double(obj.GoalX);
            %disp('msg(10)')
            %disp(msg(10))
            msg(11) = double(obj.GoalY);
            %disp('msg(11)')
            %disp(msg(11))
            msg(12) = double(obj.GoalTheta);
            %disp('msg(12)')
            %disp(msg(12))
        end
        
    end
    
end
