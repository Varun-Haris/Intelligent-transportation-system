classdef EV3_v3 < handle
    
    properties
        Name
        Connected
        UDPR
        UDPS
        Timer
        myPosition
        myTask
        TaskState
        myCommand
        myDataFromEV3
        ObserverList_GUI
        myMap
        ParkingArea
        myParkingSpot
        Coordinates
        Pause
    end
    
    methods
        
        function obj = EV3_v3(name, ip, to_pc_port, from_pc_port)
            obj.Name = name;
            obj.Connected = 0;
            obj.UDPR = dsp.UDPReceiver('RemoteIPAddress',ip,'LocalIPPort',to_pc_port,'ReceiveBufferSize',100);
            setup(obj.UDPR);
            obj.UDPS = dsp.UDPSender('RemoteIPAddress',ip,'RemoteIPPort',from_pc_port);
            obj.Timer = timer('Period',0.05,'ExecutionMode','fixedSpacing','BusyMode','drop');
            obj.Timer.TimerFcn = {@(src, event)obj.SendReceiveEV3Data};
            obj.myTask = Task.DriveOuterLoopWhole;
            obj.myCommand = Command();
            obj.myPosition = Position();
            obj.myDataFromEV3 = DataFromEV3();
            obj.myMap = Map_v2();
            obj.TaskState = 1;
            obj.myParkingSpot = 0;
            obj.Pause = 0;
            start(obj.Timer);
        end
        
        function UpdatePosition(obj, TrackableObj)
            %fprintf('TrackableObj.x: %f\tisnan( TrackableObj.x ): %d\t~( isnan( TrackableObj.x ) ): %d\n',TrackableObj.x,isnan( TrackableObj.x ),(~( isnan( TrackableObj.x ) )));
            %fprintf('TrackableObj.z: %f\tisnan( TrackableObj.z ): %d\t~( isnan( TrackableObj.z ) ): %d\n',TrackableObj.z,isnan( TrackableObj.z ),(~( isnan( TrackableObj.z ) )));
            if ( ~( isnan( TrackableObj.x ) ) && ~( isnan( TrackableObj.z ) ) )
                if ( ~( TrackableObj.x == 0 ) && ~( TrackableObj.z == 0 ) )
                    obj.myPosition.x = TrackableObj.x;
                    obj.myPosition.z = TrackableObj.z;
                    obj.myPosition.Add_yaw(TrackableObj.yaw);
                    %fprintf('Trackable yaw: %f\tEV3 yaw: %f\n',TrackableObj.yaw,obj.myPosition.Get_yaw());
                end
            end
        end
        
        function SendReceiveEV3Data(obj, event)
            %disp('Inside SendReceive.')
            
            persistent ReceiveCounter;
            
            if isempty(ReceiveCounter)
                ReceiveCounter = 0;
            end
            
            if (obj.Connected)
                ReceiveCounter = ReceiveCounter + 1;
                if (ReceiveCounter == 5) % Try this every 50ms * 5 = 250ms
                    try
                        obj.myDataFromEV3.Depacketize(obj.UDPR());
                        obj.Notify_GUI();
                    catch
                        %disp('Could not receive data from EV3.')
                    end
                    ReceiveCounter = 0;
                end
                
                obj.UpdateCommand();
                if (obj.myCommand.myStopCond == 1) % If in OptiNavMode check if good data
                    if ((obj.myCommand.CurrX ~= 0) && (obj.myCommand.CurrY ~= 0))
                        obj.UDPS(obj.myCommand.Message);
                    end
                else % non-OptiNavMode
                    obj.UDPS(obj.myCommand.Message);
                end
            end
            %disp('End of SendReceive.')
        end
        
        function UpdateDataFromGUI(obj, NewGUIData)
            %disp('Inside UpdataDataFromGUI.');
            obj.Connected = NewGUIData.Connected;
            %disp('Connected')
            %disp(obj.Connected)
            %disp('Task')
            if ~( obj.myTask == NewGUIData.myTask )
                obj.myTask = NewGUIData.myTask;
                obj.TaskState = 1;
            end
            %disp(obj.myTask)
            obj.UpdateMyCommand('LineFollow', NewGUIData.LineFollow);
            obj.UpdateMyCommand('StopCond', NewGUIData.myStopCond);
            obj.UpdateMyCommand('ErrorSignal', NewGUIData.myErrorSignal);
            obj.UpdateMyCommand('Speed', NewGUIData.Speed);
            obj.UpdateMyCommand('FollowDistance', NewGUIData.FollowDistance);
            obj.UpdateMyCommand('Stop_Distance', NewGUIData.Stop_Distance);
            obj.UpdateMyCommand('Stop_Degrees', NewGUIData.Stop_Degrees);
            if (NewGUIData.IncrementPacketNum)
                obj.UpdateMyCommand('PacketNum',1);
            end
            obj.Coordinates = NewGUIData.Coordinates;
        end
        
        function UpdateMyCommand(obj, name, val)
            switch(name)
                case 'PacketNum'
                    obj.myCommand.UpdatePacketNum();
                case 'LineFollow'
                    if ~(obj.myCommand.LineFollow == val)
                        obj.myCommand.LineFollow = val;
                        %disp('LineFollow')
                        %disp(obj.myCommand.LineFollow)
                    end
                case 'StopCond'
                    if ~(obj.myCommand.myStopCond == val)
                        obj.myCommand.myStopCond = val;
                        %disp('StopCond')
                        %disp(obj.myCommand.myStopCond)
                    end
                case 'ErrorSignal'
                    if ~(obj.myCommand.myErrorSignal == val)
                        obj.myCommand.myErrorSignal = val;
                        %disp('ErrorSignal')
                        %disp(obj.myCommand.myErrorSignal)
                    end
                case 'Speed'
                    if ~(obj.myCommand.Speed == val)
                        obj.myCommand.Speed = val;
                        %disp('Speed')
                        %disp(obj.myCommand.Speed)
                    end
                case 'FollowDistance'
                    if ~(obj.myCommand.FollowDistance == val)
                        obj.myCommand.FollowDistance = val;
                        %disp('FollowDistance')
                        %disp(obj.myCommand.FollowDistance)
                    end
                case 'Stop_Distance'
                    if ~(obj.myCommand.Stop_Distance == val)
                        obj.myCommand.Stop_Distance = val;
                        %disp('Stop_Distance')
                        %disp(obj.myCommand.Stop_Distance)
                    end
                case 'Stop_Degrees'
                    if ~(obj.myCommand.Stop_Degrees == val)
                        obj.myCommand.Stop_Degrees = val;
                        %disp('Stop_Degrees')
                        %disp(obj.myCommand.Stop_Degrees)
                    end
                case 'CurrX'
                    if ~(obj.myCommand.CurrX == val)
                        obj.myCommand.CurrX = val;
                        %disp('CurrX')
                        %disp(obj.myCommand.CurrX)
                    end
                case 'CurrY'
                    if ~(obj.myCommand.CurrY == val)
                        obj.myCommand.CurrY = val;
                        %disp('CurrY')
                        %disp(obj.myCommand.CurrY)
                    end
                case 'CurrTheta'
                    if ~(obj.myCommand.CurrTheta == val)
                        obj.myCommand.CurrTheta = val;
                        %disp('CurrTheta')
                        %disp(obj.myCommand.CurrTheta)
                    end
                case 'GoalX'
                    if ~(obj.myCommand.GoalX == val)
                        obj.myCommand.GoalX = val;
                        %disp('GoalX')
                        %disp(obj.myCommand.GoalX)
                    end
                case 'GoalY'
                    if ~(obj.myCommand.GoalY == val)
                        obj.myCommand.GoalY = val;
                        %disp('GoalY')
                        %disp(obj.myCommand.GoalY)
                    end
                case 'GoalTheta'
                    if ~(obj.myCommand.GoalTheta == val)
                        obj.myCommand.GoalTheta = val;
                        %disp('GoalTheta')
                        %disp(obj.myCommand.GoalTheta)
                    end
                    
            end
        end
        
        function UpdateCommand(obj)
            switch(obj.myTask)
                case Task.DriveOuterLoopWhole
                    switch(obj.TaskState)
                        case 1
                            if ( abs( obj.myMap.DistanceToPOI('O', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'O')
                            else
                                obj.TaskState = 2;
                            end
                        case 2
                            if ( abs( obj.myMap.DistanceToPOI('U', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'U')
                            else
                                obj.TaskState = 3;
                            end
                        case 3
                            if ( abs( obj.myMap.DistanceToPOI('A', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'A')
                            else
                                obj.TaskState = 1;
                            end
                    end
                case Task.DriveOuterLoopLeft
                    switch(obj.TaskState)
                        case 1
                            if ( abs( obj.myMap.DistanceToPOI('A', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'A')
                            else
                                obj.TaskState = 2;
                            end
                        case 2
                            if ( abs( obj.myMap.DistanceToPOI('O', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'O')
                            else
                                obj.TaskState = 3;
                            end
                        case 3
                            if ( abs( obj.myMap.DistanceToPOI('J', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'J')
                            else
                                obj.TaskState = 4;
                            end
                        case 4
                            if ( abs( obj.myMap.DistanceToPOI('D', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'D')
                            else
                                obj.TaskState = 1;
                            end
                    end
                case Task.DriveOuterLoopRight
                    switch(obj.TaskState)
                        case 1
                            if ( abs( obj.myMap.DistanceToPOI('E', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'E')
                            else
                                obj.TaskState = 2;
                            end
                        case 2
                            if ( abs( obj.myMap.DistanceToPOI('C', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'C')
                            else
                                obj.TaskState = 3;
                            end
                        case 3
                            if ( abs( obj.myMap.DistanceToPOI('H', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'H')
                            else
                                obj.TaskState = 4;
                            end
                        case 4
                            if ( abs( obj.myMap.DistanceToPOI('U', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'U')
                            else
                                obj.TaskState = 1;
                            end
                    end
                case Task.DriveInnerLoopWhole
                    switch(obj.TaskState)
                        case 1
                            if ( abs( obj.myMap.DistanceToPOI('B', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'B')
                            else
                                obj.TaskState = 2;
                            end
                        case 2
                            if ( abs( obj.myMap.DistanceToPOI('K', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'K')
                            else
                                obj.TaskState = 1;
                            end
                    end
                case Task.DriveInnerLoopLeft
                    switch(obj.TaskState)
                        case 1
                            if ( abs( obj.myMap.DistanceToPOI('B', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'B')
                            else
                                obj.TaskState = 2;
                            end
                        case 2
                            if ( abs( obj.myMap.DistanceToPOI('G', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'G')
                            else
                                obj.TaskState = 1;
                            end
                    end
                case Task.DriveInnerLoopRight
                    switch(obj.TaskState)
                        case 1
                            if ( abs( obj.myMap.DistanceToPOI('F', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'F')
                            else
                                obj.TaskState = 2;
                            end
                        case 2
                            if ( abs( obj.myMap.DistanceToPOI('K', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'K')
                            else
                                obj.TaskState = 1;
                            end
                    end
                case Task.DriveRandom
                    switch(obj.TaskState)
                        case 1
                            NearestPOI = obj.myMap.FindNearestPOI(obj.myPosition.x,obj.myPosition.z, obj.myPosition.Get_yaw());
                            CurrentFollowOnPOIs = obj.myMap.FollowOnPOIsOf(NearestPOI);
                            SizeOfCurrentFollowOnPOIs = size(CurrentFollowOnPOIs);
                            RandomPOI = CurrentFollowOnPOIs(ceil(rand(1)*SizeOfCurrentFollowOnPOIs(2)));
                            switch (string(RandomPOI))
                                case 'A'
                                    obj.TaskState = 2;
                                case 'B'
                                    obj.TaskState = 3;
                                case 'C'
                                    obj.TaskState = 4;
                                case 'D'
                                    obj.TaskState = 5;
                                case 'E'
                                    obj.TaskState = 6;
                                case 'F'
                                    obj.TaskState = 7;
                                case 'G'
                                    obj.TaskState = 8;
                                case 'H'
                                    obj.TaskState = 9;
                                case 'I'
                                    obj.TaskState = 10;
                                case 'J'
                                    obj.TaskState = 11;
                                case 'K'
                                    obj.TaskState = 12;
                                case 'O'
                                    obj.TaskState = 13;
                                case 'U'
                                    obj.TaskState = 14;
                                case 'Y'
                                    obj.TaskState = 15;
                                case 'ParkingEntrance'
                                    obj.TaskState = 16;
                                case 'ParkingWaiting'
                                    obj.TaskState = 17;
                                case 'ParkingSpot1Turn'
                                    obj.TaskState = 18;
                                case 'ParkingSpot1Entrance'
                                    obj.TaskState = 19;
                                case 'ParkingSpot2Turn'
                                    obj.TaskState = 20;
                                case 'ParkingSpot2Entrance'
                                    obj.TaskState = 21;
                                case 'ParkingSpot3Turn'
                                    obj.TaskState = 22;
                                case 'ParkingSpot3Entrance'
                                    obj.TaskState = 23;
                                case 'ParkingExit'
                                    obj.TaskState = 24;
                                case 'OnRamp'
                                    obj.TaskState = 25;
                            end
                        case 2
                            if ( abs( obj.myMap.DistanceToPOI('A', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'A')
                            else
                                obj.TaskState = 1;
                            end
                        case 3
                            if ( abs( obj.myMap.DistanceToPOI('B', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'B')
                            else
                                obj.TaskState = 1;
                            end
                        case 4
                            if ( abs( obj.myMap.DistanceToPOI('C', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'C')
                            else
                                obj.TaskState = 1;
                            end
                        case 5
                            if ( abs( obj.myMap.DistanceToPOI('D', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'D')
                            else
                                obj.TaskState = 1;
                            end
                        case 6
                            if ( abs( obj.myMap.DistanceToPOI('E', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'E')
                            else
                                obj.TaskState = 1;
                            end
                        case 7
                            if ( abs( obj.myMap.DistanceToPOI('F', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'F')
                            else
                                obj.TaskState = 1;
                            end
                        case 8
                            if ( abs( obj.myMap.DistanceToPOI('G', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'G')
                            else
                                obj.TaskState = 1;
                            end
                        case 9
                            if ( abs( obj.myMap.DistanceToPOI('H', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'H')
                            else
                                obj.TaskState = 1;
                            end
                        case 10
                            if ( abs( obj.myMap.DistanceToPOI('I', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'I')
                            else
                                obj.TaskState = 1;
                            end
                        case 11
                            if ( abs( obj.myMap.DistanceToPOI('J', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'J')
                            else
                                obj.TaskState = 1;
                            end
                        case 12
                            if ( abs( obj.myMap.DistanceToPOI('K', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'K')
                            else
                                obj.TaskState = 1;
                            end
                        case 13
                            if ( abs( obj.myMap.DistanceToPOI('O', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'O')
                            else
                                obj.TaskState = 1;
                            end
                        case 14
                            if ( abs( obj.myMap.DistanceToPOI('U', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'U')
                            else
                                obj.TaskState = 1;
                            end
                        case 15
                            if ( abs( obj.myMap.DistanceToPOI('Y', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'Y')
                            else
                                obj.TaskState = 1;
                            end
                        case 16
                            if ( abs( obj.myMap.DistanceToPOI('ParkingEntrance', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingEntrance')
                            else
                                obj.TaskState = 1;
                            end
                        case 17
                            if ( abs( obj.myMap.DistanceToPOI('ParkingWaiting', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingWaiting')
                            else
                                obj.TaskState = 1;
                            end
                        case 18
                            if ( abs( obj.myMap.DistanceToPOI('ParkingSpot1Turn', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingSpot1Turn')
                            else
                                obj.TaskState = 1;
                            end
                        case 19
                            if ( abs( obj.myMap.DistanceToPOI('ParkingSpot1Entrance', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingSpot1Entrance')
                            else
                                obj.TaskState = 1;
                            end
                        case 20
                            if ( abs( obj.myMap.DistanceToPOI('ParkingSpot2Turn', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingSpot2Turn')
                            else
                                obj.TaskState = 1;
                            end
                        case 21
                            if ( abs( obj.myMap.DistanceToPOI('ParkingSpot2Entrance', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingSpot2Entrance')
                            else
                                obj.TaskState = 1;
                            end
                        case 22
                            if ( abs( obj.myMap.DistanceToPOI('ParkingSpot3Turn', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingSpot3Turn')
                            else
                                obj.TaskState = 1;
                            end
                        case 23
                            if ( abs( obj.myMap.DistanceToPOI('ParkingSpot3Entrance', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingSpot3Entrance')
                            else
                                obj.TaskState = 1;
                            end
                        case 24
                            if ( abs( obj.myMap.DistanceToPOI('ParkingExit', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'ParkingExit')
                            else
                                obj.TaskState = 1;
                            end
                        case 25
                            if ( abs( obj.myMap.DistanceToPOI('OnRamp', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                obj.myMap.GetCommand(obj, 'OnRamp')
                            else
                                obj.TaskState = 1;
                            end
                    end
                case Task.Park
                    switch(obj.TaskState)
                        case 1
                            if ( abs( obj.myMap.DistanceToPOI('ParkingWaiting', obj.myPosition.x, obj.myPosition.z) ) > 0.1 )
                                obj.myMap.GetCommand(obj, 'ParkingWaiting')
                            else
                                obj.TaskState = 2;
                            end
                        case 2
                            % is parking area open?
                            if ~(obj.myParkingSpot)
                                obj.myParkingSpot = obj.ParkingArea.ReserveParkingSpot(obj.Name);
                            end
                            
%                              disp(ParkingAreaOpen)
                            if (obj.myParkingSpot)
                                ParkingAreaOpen = obj.ParkingArea.ReserveParkingArea(obj.Name);
                                if (ParkingAreaOpen == 1)
                                    obj.TaskState = 3;
                                end
                            else
                                obj.TaskState = 2;
                            end
                            OptiNavStop(obj);
                        case 3
                            switch (obj.myParkingSpot) % This releases the parking area once near entranceway .  Should wait till 30mm near right?
                                case 1
                                    if ( abs( obj.myMap.DistanceToPOI('ParkingSpot1End', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                        obj.myMap.GetCommand(obj, 'ParkingSpot1End')
                                        if (strcmp('ParkingSpot1Entrance',obj.myMap.FindNearestPOI(obj.myPosition.x, obj.myPosition.z, obj.myPosition.Get_yaw())))
                                            obj.ParkingArea.ReleaseParkingArea(obj.Name);
                                        end
                                    end
                                case 2
                                    if ( abs( obj.myMap.DistanceToPOI('ParkingSpot2End', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                        obj.myMap.GetCommand(obj, 'ParkingSpot2End')
                                        if (strcmp('ParkingSpot2Entrance',obj.myMap.FindNearestPOI(obj.myPosition.x, obj.myPosition.z, obj.myPosition.Get_yaw())))
                                            obj.ParkingArea.ReleaseParkingArea(obj.Name);
                                        end
                                    end
                                case 3
                                    if ( abs( obj.myMap.DistanceToPOI('ParkingSpot3End', obj.myPosition.x, obj.myPosition.z) ) > 0.03 )
                                        obj.myMap.GetCommand(obj, 'ParkingSpot3End')
                                        if (strcmp('ParkingSpot3Entrance',obj.myMap.FindNearestPOI(obj.myPosition.x, obj.myPosition.z, obj.myPosition.Get_yaw())))
                                            obj.ParkingArea.ReleaseParkingArea(obj.Name);
                                        end
                                    end
%                                 case 1 % release it only when in parking spot.  Had issues with parking area being open when still in parking area
%                                     if ( abs( obj.myMap.DistanceToPOI('ParkingSpot1End', obj.myPosition.x, obj.myPosition.z) ) < 0.05 )
%                                         obj.ParkingArea.ReleaseParkingArea(obj.Name);
%                                     end
%                                 case 2
%                                     if ( abs( obj.myMap.DistanceToPOI('ParkingSpot2End', obj.myPosition.x, obj.myPosition.z) ) < 0.05 )
%                                         obj.ParkingArea.ReleaseParkingArea(obj.Name);
%                                     end
%                                 case 3
%                                     if ( abs( obj.myMap.DistanceToPOI('ParkingSpot3End', obj.myPosition.x, obj.myPosition.z) ) < 0.05 )
%                                         obj.ParkingArea.ReleaseParkingArea(obj.Name);
%                                     end
                            end
                        otherwise
                            %Do nothing
                    end
                case Task.DeadReckonPath
                    if (obj.TaskState <= length(obj.Coordinates))
                        %CHECK USE OF myPosition.x AND myPosition.z
                        if sqrt( ( obj.myPosition.x - obj.Coordinates(obj.TaskState,1) )^2 + ( obj.myPosition.z - obj.Coordinates(obj.TaskState,2) )^2 ) > 0.03
                            OptiNavCoord(obj, obj.Coordinates(obj.TaskState,:));
                            %disp( sqrt( ( obj.myPosition.x - obj.Coordinates(obj.TaskState,1) )^2 + ( obj.myPosition.z - obj.Coordinates(obj.TaskState,2) )^2 ) );
                        else
                            obj.TaskState = obj.TaskState + 1;
                        end
                    else
                        OptiNavStop();
                    end                        
                case Task.DeadReckonCircuit
                    %CHECK USE OF myPosition.x AND myPosition.z
                    if sqrt( ( obj.myPosition.x - obj.Coordinates(obj.TaskState,1) )^2 + ( obj.myPosition.z - obj.Coordinates(obj.TaskState,2) )^2 ) > 0.03
                        OptiNavCoord(obj, obj.Coordinates(obj.TaskState,:));
                        %disp( sqrt( ( obj.myPosition.x - obj.Coordinates(obj.TaskState,1) )^2 + ( obj.myPosition.z - obj.Coordinates(obj.TaskState,2) )^2 ) );
                    else
                        obj.TaskState = obj.TaskState + 1
                        if (obj.TaskState > length(obj.Coordinates))
                            obj.TaskState = 1;
                        end
                    end
            end
        end
        
        function AddObserver_GUI(obj, obs)
            obj.ObserverList_GUI = [obj.ObserverList_GUI, obs];
            obj.Notify_GUI();
        end
        
        function Notify_GUI(obj)
            %disp('Inside Notify (GUI).')
            if (~isempty(obj.ObserverList_GUI))
                for x = 1:length(obj.ObserverList_GUI)
                    obj.ObserverList_GUI(x).UpdateDataFromEV3(obj.Name, obj.myDataFromEV3);
                end
            end
        end
        
        function AddParkingArea(obj, obs)
            obj.ParkingArea = obs;
        end
        
        function delete(obj)
            stop(obj.Timer);
            delete(obj.Timer);
            release(obj.UDPR);
            release(obj.UDPS);
        end
        
    end
    
end
