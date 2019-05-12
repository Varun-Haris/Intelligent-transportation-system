classdef Map_v2 < handle
    
    properties
        POI_List
        FunctionBeingExecuted
        Destination
        StateValue
        Count
%         Spot1Full
%         Spot2Full
%         Spot3Full
    end
    
    methods
        
        function obj = Map_v2()
            obj.POI_List{1} = POI('A', -0.675, -1.762);
            obj.POI_List{1}.AddFollowOnPOI('O', @obj.FromA_GotoO);
            
            obj.POI_List{2} = POI('B', -0.386, -1.400);
            obj.POI_List{2}.AddFollowOnPOI('C', @obj.FromB_GotoC);
            obj.POI_List{2}.AddFollowOnPOI('G', @obj.FromB_GotoG);
            
            obj.POI_List{3} = POI('C', -0.348, -1.874);
            obj.POI_List{3}.AddFollowOnPOI('D', @obj.FromC_GotoD);
            obj.POI_List{3}.AddFollowOnPOI('H', @obj.FromC_GotoH);
            
            obj.POI_List{4} = POI('D', -0.386, -2.112);
            obj.POI_List{4}.AddFollowOnPOI('F', @obj.FromD_GotoF);
            obj.POI_List{4}.AddFollowOnPOI('I', @obj.FromD_GotoI);
            
            obj.POI_List{5} = POI('E', -0.707, -2.373);
            obj.POI_List{5}.AddFollowOnPOI('A', @obj.FromE_GotoA);
            obj.POI_List{5}.AddFollowOnPOI('I', @obj.FromE_GotoI);
            
            obj.POI_List{6} = POI('F', -0.380, -2.756);
            obj.POI_List{6}.AddFollowOnPOI('K', @obj.FromF_GotoK);
            
            obj.POI_List{7} = POI('G', 1.766, -1.387);
            obj.POI_List{7}.AddFollowOnPOI('OnRamp', @obj.FromG_GotoOnRamp);
            obj.POI_List{7}.AddFollowOnPOI('ParkingEntrance', @obj.FromOnRamp_GotoParkingEntrance);
            
            obj.POI_List{8} = POI('H', 1.807, -1.864);
            obj.POI_List{8}.AddFollowOnPOI('G', @obj.FromH_GotoG);
            obj.POI_List{8}.AddFollowOnPOI('Y', @obj.FromH_GotoY);
            
            obj.POI_List{9} = POI('I', -0.545, -1.996);
            obj.POI_List{9}.AddFollowOnPOI('A', @obj.FromI_GotoA);
            obj.POI_List{9}.AddFollowOnPOI('C', @obj.FromI_GotoC);
            
            obj.POI_List{10} = POI('J', 1.794,  -2.081);
            obj.POI_List{10}.AddFollowOnPOI('D', @obj.FromJ_GotoD);
            obj.POI_List{10}.AddFollowOnPOI('H', @obj.FromJ_GotoH);
            
            obj.POI_List{11} = POI('K', 1.817,  -2.800);  %1.817,  -2.800
            obj.POI_List{11}.AddFollowOnPOI('F', @obj.FromK_GotoF);
            obj.POI_List{11}.AddFollowOnPOI('J', @obj.FromK_GotoJ);
            
            obj.POI_List{12} = POI('O', 2.139, -1.306);
            obj.POI_List{12}.AddFollowOnPOI('U', @obj.FromO_GotoU);
            obj.POI_List{12}.AddFollowOnPOI('Y', @obj.FromO_GotoY);
            
            obj.POI_List{13} = POI('U', 2.127,  -2.279);
            obj.POI_List{13}.AddFollowOnPOI('E', @obj.FromU_GotoE);
            
            obj.POI_List{14} = POI('Y', 1.977, -1.963);
            obj.POI_List{14}.AddFollowOnPOI('J', @obj.FromY_GotoJ);
            obj.POI_List{14}.AddFollowOnPOI('U', @obj.FromY_GotoU);

%           obj.POI_List{15} = POI('ParkingEntrance', -0.350, -1.010); %           Jeff curve
            obj.POI_List{15} = POI('ParkingEntrance', -0.375, -1.300); % This works for rotate
            obj.POI_List{15}.AddFollowOnPOI('B', @obj.FromParkingEntrance_GotoB);
            obj.POI_List{15}.AddFollowOnPOI('ParkingWaiting', @obj.FromParkingEntrance_GotoParkingWaiting);            

%            obj.POI_List{16} = POI('ParkingSpot1Entrance', 0.534,  -0.622, 0); %bot turned towards spot
            obj.POI_List{16} = POI('ParkingSpot1Entrance', 0.567,  -0.611, 0); %bot turned towards spot
            obj.POI_List{16}.AddFollowOnPOI('Parking1Backout', @obj.FromParkingSpot1Entrance_GotoParking1Backout);
            obj.POI_List{16}.AddFollowOnPOI('ParkingSpot1End', @obj.FromParkingSpot1Entrance_GotoParkingSpot1End);
            
            obj.POI_List{17} = POI('ParkingSpot2Entrance', 0.985,  -0.424, 0);
            obj.POI_List{17}.AddFollowOnPOI('Parking2Backout', @obj.FromParkingSpot2Entrance_GotoParking2Backout);
            obj.POI_List{17}.AddFollowOnPOI('ParkingSpot2End', @obj.FromParkingSpot2Entrance_GotoParkingSpot2End);
            
            obj.POI_List{18} = POI('ParkingSpot3Entrance', 1.383,  -0.292, 0);
            obj.POI_List{18}.AddFollowOnPOI('ParkingSpot3StartCurve', @obj.FromParkingSpot3Entrance_GotoParkingSpot3StartCurve);
            obj.POI_List{18}.AddFollowOnPOI('ParkingSpot3End', @obj.FromParkingSpot3Entrance_GotoParkingSpot3End);
            
            obj.POI_List{19} = POI('ParkingExit', 1.474,  -1.262, 90); % This is the parking exit at stop sign
            obj.POI_List{19}.AddFollowOnPOI('OnRampCurve', @obj.FromParkingExit_GotoOnRampCurve);
            
%            obj.POI_List{23} = POI('OnRamp', 1.83,   -0.907); % Changed
%            this to the turn out area
            obj.POI_List{20} = POI('OnRampCurve', 1.808, -.899, 0); % might tune this a little
            obj.POI_List{20}.AddFollowOnPOI('OnRamp', @obj.FromOnRampCurve_GotoOnRamp);
            
            obj.POI_List{21} = POI('ParkingSpot1End', 0.541,  -0.524, 0);
% doesn't seem right 4-26 Hahn           obj.POI_List{21} = POI('ParkingSpot1End', 0.577,  -0.449, 0); 
            obj.POI_List{21}.AddFollowOnPOI('ParkingSpot1Entrance', @obj.FromParkingSpot1End_GotoParkingSpot1Entrance);
            
            obj.POI_List{22} = POI('ParkingSpot2End', 0.985,  -0.191, 0);
            obj.POI_List{22}.AddFollowOnPOI('ParkingSpot2Entrance', @obj.FromParkingSpot2End_GotoParkingSpot2Entrance);
            
            obj.POI_List{23} = POI('ParkingSpot3End', 1.383,  -0.027, 0);
            obj.POI_List{23}.AddFollowOnPOI('ParkingSpot3Entrance', @obj.FromParkingSpot3End_GotoParkingSpot3Entrance);

            obj.POI_List{24} = POI('ParkingWaiting', -0.041, -1.262, 90); % works  
%            obj.POI_List{24} = POI('ParkingWaiting', 0.075, -1.262, 90);
            obj.POI_List{24}.AddFollowOnPOI('ParkingSpot1Entrance', @obj.FromParkingWaiting_GotoParkingSpot1Entrance);
            obj.POI_List{24}.AddFollowOnPOI('ParkingSpot2StartCurve', @obj.FromParkingWaiting_GotoParkingSpot2StartCurve);

            obj.POI_List{25} = POI('ParkingSpot2StartCurve', .267, -1.262, 90);
            obj.POI_List{25}.AddFollowOnPOI('ParkingSpot2Entrance', @obj.FromParkingSpot2StartCurve_GotoParkingSpot2Entrance);
            obj.POI_List{25}.AddFollowOnPOI('ParkingSpot3StartCurve', @obj.FromParkingSpot2StartCurve_GotoParkingSpot3StartCurve);

            obj.POI_List{26} = POI('ParkingSpot3StartCurve', .774,  -1.262, 90);
            obj.POI_List{26}.AddFollowOnPOI('ParkingSpot3Entrance', @obj.FromParkingSpot3StartCurve_GotoParkingSpot3Entrance);
            obj.POI_List{26}.AddFollowOnPOI('ParkingExit', @obj.FromParkingSpot3StartCurve_GotoParkingExit);

            obj.POI_List{27} = POI('Parking1Backout', .302, -.896, 90);
            obj.POI_List{27}.AddFollowOnPOI('ParkingExit', @obj.FromParking1Backout_GotoParkingExit);

            obj.POI_List{28} = POI('Parking2Backout', 0.650, -.965, 90 );
            obj.POI_List{28}.AddFollowOnPOI('ParkingExit', @obj.FromParking2Backout_GotoParkingExit);

            obj.POI_List{29} = POI('OnRamp', 1.808, -.750, 0);
            obj.POI_List{29}.AddFollowOnPOI('ParkingEntrance', @obj.FromOnRamp_GotoParkingEntrance);
            
            obj.FunctionBeingExecuted = NaN;
            obj.Destination = '';
            obj.StateValue = 1;
            obj.Count = 0;
%             obj.Spot1Full = 0;
%             obj.Spot2Full = 0; 
%             obj.Spot3Full = 0; 
        end
        
        function GetCommand(obj, EV3, DestinationPOI)
            NextStep = '';
            
            NearestPOI = obj.FindNearestPOI(EV3.myPosition.x, EV3.myPosition.z, EV3.myPosition.Get_yaw());
            
            if strcmp(NearestPOI,DestinationPOI)
                if ( abs( obj.DistanceToPOI(DestinationPOI, EV3.myPosition.x, EV3.myPosition.z) ) < 0.03 )
                    EV3.UpdateMyCommand('Speed',0);
                    fprintf('At destination.\n');
                end
                return
            elseif ( ~( isempty( obj.Destination ) ) && ~( strcmp( NearestPOI, obj.Destination ) ) )
                FunctionToBeExecuted = obj.FunctionBeingExecuted;
            else
                obj.FunctionBeingExecuted = NaN;
                obj.Destination = '';
                obj.StateValue = 1;
                AllPossibleDestinations = obj.FollowOnPOIsOf(NearestPOI);
                
                if ( length( AllPossibleDestinations ) < 2 )
                    AllPossibleDestinations = [AllPossibleDestinations, AllPossibleDestinations];
                end
                
                FollowOnPOIIndex = 1;
                
                while (1)                    
                    IndexOfDestinationPOI = obj.FindPOIInList(DestinationPOI, AllPossibleDestinations);
                    if ~( isnan(IndexOfDestinationPOI) )
                        IndexOfNextStep = IndexOfDestinationPOI;
                        
                        while ( IndexOfNextStep > 2 )
                            IndexOfNextStep = floor( ( IndexOfNextStep - 1 ) / 2 );
                        end
                        
                        break;
                    else
                        LengthOfAllPossibleDestinations = length(AllPossibleDestinations);
                        
                        for FollowOnPOIIndex = FollowOnPOIIndex:LengthOfAllPossibleDestinations
                            FollowOnPOIsOfPOIIndex = obj.FollowOnPOIsOf(AllPossibleDestinations{FollowOnPOIIndex});                           
                            if ( length(FollowOnPOIsOfPOIIndex) == 2 )
                                AllPossibleDestinations = [AllPossibleDestinations, FollowOnPOIsOfPOIIndex];
                            elseif ( length(FollowOnPOIsOfPOIIndex) == 1 )
                                AllPossibleDestinations = [AllPossibleDestinations, FollowOnPOIsOfPOIIndex, FollowOnPOIsOfPOIIndex];
                            else
                                fprintf('Error: Found no follow on POIs for %c.\n', AllPossibleDestinations(FollowOnPOIIndex));
                            end                             
                        end
                        
                        FollowOnPOIIndex = FollowOnPOIIndex + 1;
                    end
                end
                
                NextStep = AllPossibleDestinations{IndexOfNextStep};
                obj.Destination = NextStep;
                row = obj.POI_GetIndex(NearestPOI);
                SizeOfListOfFollowOnPOIs = size(obj.POI_List{row}.FollowOnPOIs);
                
                for index = 1:SizeOfListOfFollowOnPOIs(1)
                    if strcmp( NextStep, obj.POI_List{row}.FollowOnPOIs{index,1} )
                        col = index;
                        break
                    end
                end
                
                FunctionToBeExecuted = obj.POI_List{row}.FollowOnPOIs{col,2};
                obj.FunctionBeingExecuted = FunctionToBeExecuted;
                
            end
            FunctionToBeExecuted(EV3);
        end
        
        function POI = FindNearestPOI(obj, x, z, yaw)
            POI = '';
            POI_distance = 100;
            POI_yaw = 100;
            % Loop through complete POI list to find the nearest POI 
            for index = 1:length(obj.POI_List)
                distance = sqrt( ( ( x - ( obj.POI_List{index}.x ) )^2 ) + ( ( z - ( obj.POI_List{index}.z ) )^2 ) );
                if ( abs( distance - POI_distance ) < 0.03 )
                    POI_yaw_diff = abs( yaw - POI_yaw );
                    while ( POI_yaw_diff > 180 )
                        POI_yaw_diff = POI_yaw_diff - 360;
                    end
                    Index_yaw_diff = abs( yaw - obj.POI_List{index}.yaw );
                    while ( Index_yaw_diff > 180 )
                        Index_yaw_diff = Index_yaw_diff - 360;
                    end
                    if ( abs( POI_yaw_diff ) > abs ( Index_yaw_diff ) )
                        POI = obj.POI_List{index}.Name;
                        POI_distance = distance;
                        POI_yaw = obj.POI_List{index}.yaw;
                    end
                elseif distance < POI_distance
                    POI = obj.POI_List{index}.Name;
                    POI_distance = distance;
                    POI_yaw = obj.POI_List{index}.yaw;
                end
            end
        end
        
        function FollowOnPOIs = FollowOnPOIsOf(obj, POI)
            IndexOfPOI = obj.POI_GetIndex(POI);
            SizeOfListOfFollowOnPOIs = size(obj.POI_List{IndexOfPOI}.FollowOnPOIs);
            for index = 1:SizeOfListOfFollowOnPOIs(1)
                FollowOnPOIs{index} = obj.POI_List{IndexOfPOI}.FollowOnPOIs{index,1};
            end
        end
        
        function val = FindPOIInList(~, POI, List)
            val = NaN;
            for index = 1:length(List)
                if strcmp(POI,List(index))
                    val = index;
                    break;
                end
            end
        end
        
        function distance = DistanceToPOI(obj, POI, x, z)
            for index = 1:length(obj.POI_List)
                if strcmp(POI, obj.POI_List{index}.Name)
                    distance = sqrt( ( ( x - ( obj.POI_List{index}.x ) )^2 ) + ( ( z - ( obj.POI_List{index}.z ) )^2 ) );
                    break
                end
            end
        end
        
        function val = POI_GetIndex(obj, POI)
            val = NaN;
            for index = 1:length(obj.POI_List)
                if strcmp(POI, obj.POI_List{index}.Name)
                    val = index;
                    break
                end
            end
        end
        
        function POS = POI_GetPos(obj,POI)
            for index = 1:length(obj.POI_List)
                if strcmp(POI, obj.POI_List{index}.Name)
                    POS.x = obj.POI_List{index}.x;
                    POS.z = obj.POI_List{index}.z;
                    POS.yaw = obj.POI_List{index}.yaw;
                end
            end
        end

        function FromA_GotoO(~, EV3)
            %disp('Inside FromA_GotoO.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromB_GotoC(~, EV3)
            %disp('Inside FromB_GotoC.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromB_GotoG(~, EV3)
            %disp('Inside FromB_GotoG.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Left);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromC_GotoD(obj, EV3) %Complete
            %disp('Inside FromC_GotoD.')
            if(EV3.myPosition.Get_yaw()>0 && EV3.myPosition.Get_yaw()<90) %Approaching from I
                switch(obj.StateValue)
                    case 1
                        if ( obj.DistanceToPOI('C', EV3.myPosition.x, EV3.myPosition.z) < 0.08 )
                            %disp('Approaching C')
                            EV3.UpdateMyCommand('Speed', 30);
                            obj.StateValue = 2;
                        end
                    case 2
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed', 30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', (mod(EV3.myPosition.Get_yaw(),360)-290));
                        obj.StateValue = 3;
                    case 3
                        if(abs(EV3.myPosition.Get_yaw()+70) < 20) %Correct orientation EV3.myDataFromEV3.Left < 20
                            EV3.UpdateMyCommand('LineFollow',1);
                            EV3.UpdateMyCommand('Speed', 30);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', 0);
                            obj.StateValue = 4;
                        else
                            EV3.UpdateMyCommand('LineFollow',0);
                            EV3.UpdateMyCommand('Speed',30);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', (mod(EV3.myPosition.Get_yaw(),360)-290)/2);
                        end
                    case 4
                        %disp('resume line follow')
                end
            else
                EV3.UpdateMyCommand('LineFollow',1);
                EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                EV3.UpdateMyCommand('FollowDistance',0);
                EV3.UpdateMyCommand('StopCond', 0);
                EV3.UpdateMyCommand('Stop_Distance', 0);
                EV3.UpdateMyCommand('Stop_Degrees', 0);
            end
        end
        
        function FromC_GotoH(~, EV3)
            %disp('Inside FromC_GotoH.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
                
        function FromD_GotoF(obj, EV3) %Complete
            %disp('Inside FromD_GotoF.')
            if(abs(EV3.myPosition.Get_yaw())>175 && abs(EV3.myPosition.Get_yaw())<185) 
                EV3.UpdateMyCommand('LineFollow',1);
                EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                EV3.UpdateMyCommand('FollowDistance',0);
                EV3.UpdateMyCommand('StopCond', 0);
                EV3.UpdateMyCommand('Stop_Distance', 0);
                EV3.UpdateMyCommand('Stop_Degrees', 0);
            else
                switch(obj.StateValue)
                    case 1
                        if ( obj.DistanceToPOI('D', EV3.myPosition.x, EV3.myPosition.z) < 0.08 )
                            %disp('Approaching D')
                            EV3.UpdateMyCommand('Speed', 30);
                            obj.StateValue = 2;
                        end
                    case 2
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed', 30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', (mod(EV3.myPosition.Get_yaw(),360)-180));
                        obj.StateValue = 3;
                    case 3
                        if(abs(EV3.myPosition.Get_yaw()-170) < 10) %Correct orientation EV3.myDataFromEV3.Left < 20
                            EV3.UpdateMyCommand('LineFollow',1);
                            EV3.UpdateMyCommand('Speed', 30);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', 0);
                            obj.StateValue = 4;
                        else
                            EV3.UpdateMyCommand('LineFollow',0);
                            EV3.UpdateMyCommand('Speed',30);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', (mod(EV3.myPosition.Get_yaw(),360)-180)/2);
                        end
                    case 4
                        %disp('resume line follow')
                end
            end
        end
        
        function FromD_GotoI(obj, EV3) %Complete
            %disp('Inside FromD_GotoI.')
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('D', EV3.myPosition.x, EV3.myPosition.z) < 0.08 )
                        %disp('Approaching D')
                        EV3.UpdateMyCommand('Speed', 30);
                        obj.StateValue = 2;
                    end
                case 2
                    EV3.UpdateMyCommand('LineFollow',0);
                    EV3.UpdateMyCommand('Speed', 30);
                    EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                    EV3.UpdateMyCommand('FollowDistance',0);
                    EV3.UpdateMyCommand('StopCond', 0);
                    EV3.UpdateMyCommand('Stop_Distance', 0);
                    EV3.UpdateMyCommand('Stop_Degrees', (mod(EV3.myPosition.Get_yaw(),360)-290));
                    obj.StateValue = 3;
                case 3
                    if(abs(EV3.myPosition.Get_yaw()+70) < 20) %Correct orientation EV3.myDataFromEV3.Left < 20
                        EV3.UpdateMyCommand('LineFollow',1);
                        EV3.UpdateMyCommand('Speed', 30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', 0);
                        obj.StateValue = 4;
                    else
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed',30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', (mod(EV3.myPosition.Get_yaw(),360)-290)/2);
                    end
                case 4
                    %disp('resume line follow')
            end
        end
        
        function FromE_GotoA(~, EV3)
            %disp('Inside FromE_GotoA.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromE_GotoI(~, EV3)
            %disp('Inside FromE_GotoI.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Right);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromF_GotoK(~, EV3)
%             disp('Inside FromF_GotoK.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromG_GotoOnRamp(~, EV3)
            %disp('Inside FromG_GotoOnRamp.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromH_GotoC(obj,EV3) %Complete
            %disp('H to C')
            switch(obj.StateValue)
                case 1
                    if (abs(EV3.myPosition.Get_yaw()) < 10)
                        if(( obj.DistanceToPOI('H', EV3.myPosition.x, EV3.myPosition.z) < 0.2))
                            EV3.UpdateMyCommand('Speed', 30);
                            obj.StateValue = 2;
                        end
                    else 
                        %disp('Approaching H (No turn)')
                        obj.StateValue = 4;
                    end
                case 2
                    EV3.UpdateMyCommand('LineFollow',0);
                    EV3.UpdateMyCommand('Speed',30);
                    EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                    EV3.UpdateMyCommand('FollowDistance',0);
                    EV3.UpdateMyCommand('StopCond', 0);
                    EV3.UpdateMyCommand('Stop_Distance', 0);
                    EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw()-90);
                    obj.StateValue = 3;
                case 3
                    if(abs(EV3.myPosition.Get_yaw()) < 10) %Correct orientation EV3.myDataFromEV3.Left < 20
                        EV3.UpdateMyCommand('LineFollow',1);
                        EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', 0);
                        obj.StateValue = 4;
                    else
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed',30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', (EV3.myPosition.Get_yaw()-90)/3);
                    end
                case 4
                    %disp('resume line follow')
                    EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);                   
            end
        end
        
        function FromH_GotoG(obj, EV3) %Complete
            %disp('Inside FromH_GotoG.')
            switch(obj.StateValue)
                case 1
                    if (abs(EV3.myPosition.Get_yaw()) < 10)
                        %disp('Approaching H (but dont turn)')
                        obj.StateValue = 4;
                    elseif ( obj.DistanceToPOI('H', EV3.myPosition.x, EV3.myPosition.z) < 0.2)
                        %disp('Approaching H (turn right)')
                        EV3.UpdateMyCommand('Speed', 30);
                        obj.StateValue = 2;
                    end
                case 2
                    EV3.UpdateMyCommand('LineFollow',0);
                    EV3.UpdateMyCommand('Speed',30);
                    EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                    EV3.UpdateMyCommand('FollowDistance',0);
                    EV3.UpdateMyCommand('StopCond', 0);
                    EV3.UpdateMyCommand('Stop_Distance', 0);
                    EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw());
                    obj.StateValue = 3;
                case 3
                    if(abs(EV3.myPosition.Get_yaw()) < 10) %Correct orientation EV3.myDataFromEV3.Left < 20
                        EV3.UpdateMyCommand('LineFollow',1);
                        EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', 0);
                        obj.StateValue = 4;
                    else
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed',30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw()/3);
                    end
                case 4
                    %disp('resume line follow')
            end
        end
        
        function FromH_GotoY(obj, EV3) %Complete
            %disp('Inside FromH_GotoY.')
            if(EV3.myPosition.Get_yaw()<5)
                switch(obj.StateValue)
                    case 1
                        if (abs(EV3.myPosition.Get_yaw()) < 10)
                            %disp('Approaching H (but dont turn)')
                            obj.StateValue = 4;
                        elseif ( obj.DistanceToPOI('H', EV3.myPosition.x, EV3.myPosition.z) < 0.2)
                            %disp('Approaching H (turn right)')
                            EV3.UpdateMyCommand('Speed', 30);
                            obj.StateValue = 2;
                        end
                    case 2
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed',30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw()-120);
                        obj.StateValue = 3;
                    case 3
                        if(abs(EV3.myPosition.Get_yaw()) < 10) %Correct orientation EV3.myDataFromEV3.Left < 20
                            EV3.UpdateMyCommand('LineFollow',1);
                            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', 0);
                            obj.StateValue = 4;
                        else
                            EV3.UpdateMyCommand('LineFollow',0);
                            EV3.UpdateMyCommand('Speed',30);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', (EV3.myPosition.Get_yaw()-120)/3);
                        end
                    case 4
                        %disp('resume line follow')
                end
            else
                EV3.UpdateMyCommand('LineFollow',1);
                EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                EV3.UpdateMyCommand('FollowDistance',0);
                EV3.UpdateMyCommand('StopCond', 0);
                EV3.UpdateMyCommand('Stop_Distance', 0);
                EV3.UpdateMyCommand('Stop_Degrees', 0);
            end
        end
        
        function FromI_GotoA(~, EV3)
            %disp('Inside FromI_GotoA.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromI_GotoC(~, EV3)
            %disp('Inside FromI_GotoC.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromJ_GotoD(obj, EV3) %Complete
            %disp('Inside FromJ_GotoD.')
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('J', EV3.myPosition.x, EV3.myPosition.z) < 0.08 )
                        %disp('Approaching J')
                        EV3.UpdateMyCommand('Speed', 30);
                        obj.StateValue = 2;
                    end
                case 2
                    EV3.UpdateMyCommand('LineFollow',0);
                    EV3.UpdateMyCommand('Speed', 30);
                    EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                    EV3.UpdateMyCommand('FollowDistance',0);
                    EV3.UpdateMyCommand('StopCond', 0);
                    EV3.UpdateMyCommand('Stop_Distance', 0);
                    EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw()+90);
                    obj.StateValue = 3;
                case 3
                    if(abs(EV3.myPosition.Get_yaw()+90) < 10) %Correct orientation EV3.myDataFromEV3.Left < 20
                        EV3.UpdateMyCommand('LineFollow',1);
                        EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', 0);
                        obj.StateValue = 4;
                    else
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed',30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', (EV3.myPosition.Get_yaw()+90)/3);
                    end
                case 4
                    %disp('resume line follow')
            end
        end
        
        function FromJ_GotoH(obj, EV3) %Complete
            %disp('Inside FromJ_GotoH.')
            switch(obj.StateValue)
                case 1
                    if (abs(EV3.myPosition.Get_yaw()) < 10)
                        %disp('Approaching J (but dont turn)')
                        obj.StateValue = 4;
                    elseif ( obj.DistanceToPOI('J', EV3.myPosition.x, EV3.myPosition.z) < 0.08)
                        %disp('Approaching J')
                        EV3.UpdateMyCommand('Speed', 30);
                        obj.StateValue = 2;
                    end
                case 2
                    EV3.UpdateMyCommand('LineFollow',0);
                    EV3.UpdateMyCommand('Speed',30);
                    EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                    EV3.UpdateMyCommand('FollowDistance',0);
                    EV3.UpdateMyCommand('StopCond', 0);
                    EV3.UpdateMyCommand('Stop_Distance', 0);
                    EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw());
                    obj.StateValue = 3;
                case 3
                    if(abs(EV3.myPosition.Get_yaw()) < 5) %Correct orientation EV3.myDataFromEV3.Left < 20
                        EV3.UpdateMyCommand('LineFollow',1);
                        EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', 0);
                        obj.StateValue = 4;
                    else
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed',30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw()/3);
                    end
                case 4
                    %disp('resume line follow')
            end
        end
        
        function FromK_GotoF(~, EV3)
%             disp('Inside FromK_GotoF.')
            
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Left);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromK_GotoJ(~, EV3)
            %disp('Inside FromK_GotoJ.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromO_GotoU(~, EV3)
            %disp('Inside FromO_GotoU.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromO_GotoY(~, EV3)
            %disp('Inside FromO_GotoY.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Right);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromU_GotoE(~, EV3)
            %disp('Inside FromU_GotoE.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromY_GotoJ(~, EV3)
            %disp('Inside FromY_GotoJ.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', 40);
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        function FromY_GotoU(obj, EV3) %Complete
            %disp('Inside FromY_GotoU.')
            if(EV3.myPosition.Get_yaw()>0 && EV3.myPosition.Get_yaw()<90)
                switch(obj.StateValue)
                    case 1
                       if(obj.DistanceToPOI('Y', EV3.myPosition.x, EV3.myPosition.z) < 0.08)
                            %disp('Approaching Y')
                            EV3.UpdateMyCommand('Speed', 30);
                            obj.StateValue = 2;
                        end
                    case 2
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('Speed',30);
                        EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('StopCond', 0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Stop_Degrees', EV3.myPosition.Get_yaw()-120);
                        obj.StateValue = 3;
                    case 3
                        if(abs(EV3.myPosition.Get_yaw() - 120) < 5) %Correct orientation EV3.myDataFromEV3.Left < 20
                            EV3.UpdateMyCommand('LineFollow',1);
                            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', 0);
                            obj.StateValue = 4;
                        else
                            EV3.UpdateMyCommand('LineFollow',0);
                            EV3.UpdateMyCommand('Speed',30);
                            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                            EV3.UpdateMyCommand('FollowDistance',0);
                            EV3.UpdateMyCommand('StopCond', 0);
                            EV3.UpdateMyCommand('Stop_Distance', 0);
                            EV3.UpdateMyCommand('Stop_Degrees', (EV3.myPosition.Get_yaw()-120)/3);
                        end
                    case 4
                        %disp('resume line follow')
                end
            else
                EV3.UpdateMyCommand('LineFollow',1);
                EV3.UpdateMyCommand('Speed', 40);
                EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
                EV3.UpdateMyCommand('FollowDistance',0);
                EV3.UpdateMyCommand('StopCond', 0);
                EV3.UpdateMyCommand('Stop_Distance', 0);
                EV3.UpdateMyCommand('Stop_Degrees', 0);
            end
        end
        
        function FromParkingEntrance_GotoB(obj, EV3)
%             if ( obj.DistanceToPOI('B', EV3.myPosition.x, EV3.myPosition.z) < 0.3 )
%                 if ( abs( EV3.myPosition.Get_yaw()) < 170)
%                     EV3.UpdateMyCommand('LineFollow',1);
%                     EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
%                     EV3.UpdateMyCommand('StopCond',StopCond.None);
%                 end
%             end
        end

%         function FromParkingEntrance_GotoParkingWaiting(obj, EV3)
%             switch(obj.StateValue)
%                 case 1
%                     if ( obj.DistanceToPOI('ParkingEntrance', EV3.myPosition.x, EV3.myPosition.z) < 0.3 )
%                         disp('Approaching Parking Entrance')
%                         EV3.UpdateMyCommand('Speed', 40);
%                         EV3.UpdateMyCommand('StopCond', 0);
%                         EV3.UpdateMyCommand('CurrX', EV3.myPosition.z);
%                         EV3.UpdateMyCommand('CurrY', EV3.myPosition.x);
%                         EV3.UpdateMyCommand('GoalX', EV3.myPosition.z) ;
%                         EV3.UpdateMyCommand('GoalY', EV3.myPosition.x);
%                         obj.StateValue = 2;
%                     end
%                 case 2
%                     if ( obj.DistanceToPOI('ParkingEntrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
%                         % Need to make sure nobody is in transition to the
%                         % waiting spot.  If so, don't transition to state 3
%                         % yet oherwise will collide
%                         
%                         % add if else code here
%                         obj.StateValue = 3;
%                         disp('pause here')
% %                        pause(10)
%                         disp('Entrance turn')
%                     else
%                         LineFollow35(EV3);
%                     end
%                 case 3
%                     % Go to park waiting
%                     OptiNav(EV3,'ParkingWaiting');
%             end % end switch
%         end % end function

        function FromParkingEntrance_GotoParkingWaiting(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingEntrance', EV3.myPosition.x, EV3.myPosition.z) < 0.3 )
                        %disp('Approaching Parking Entrance')
                        EV3.UpdateMyCommand('Speed', 40);
                        obj.StateValue = 2;
                    end                  
                case 2
                    if ( obj.DistanceToPOI('ParkingEntrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Speed', 50);
                        EV3.UpdateMyCommand('Stop_Degrees',(mod(EV3.myPosition.Get_yaw(),360)-90)/2); 
                        obj.StateValue = 4;
                    end                    
                case 3
%                     if ( obj.DistanceToPOI('ParkingEntrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
%                         obj.StateValue = 3;
%                     else
%                         EV3.UpdateMyCommand('LineFollow',1);
%                         EV3.UpdateMyCommand('FollowDistance',0);
%                         EV3.UpdateMyCommand('StopCond', 0);
%                         EV3.UpdateMyCommand('Stop_Distance', 0);
%                         EV3.UpdateMyCommand('Stop_Degrees', 0);
%                         EV3.UpdateMyCommand('Speed', 40);
%                     end                    
                case 4  % Try to rotate a little and then curve to waiting spot
                    if(mod(EV3.myPosition.Get_yaw(),360) < 95 && mod(EV3.myPosition.Get_yaw(),360) > 85) %Correct orientation
                        OptiNavStop(EV3);
                        obj.StateValue = 5;
                    else
                        EV3.UpdateMyCommand('LineFollow',0);
                        EV3.UpdateMyCommand('FollowDistance',0);
                        EV3.UpdateMyCommand('Stop_Distance', 0);
                        EV3.UpdateMyCommand('Speed', 40);
                         EV3.UpdateMyCommand('Stop_Degrees',(mod(EV3.myPosition.Get_yaw(),360)-90)/2);
                    end
                case 5
                    % Go to park waiting
                    OptiNav(EV3,'ParkingWaiting');
            end
        end
        
        
        

        function FromParkingWaiting_GotoParkingSpot1Entrance(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingWaiting', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingWaiting');
                    end
                case 2
                    ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
                    %disp(ParkingAreaOpen)
                    if (ParkingAreaOpen == 1)
                        obj.StateValue = 3;
                    else % Need to stop and wait until parking area open
%                         EV3.UpdateMyCommand('LineFollow',0);
%                         EV3.UpdateMyCommand('FollowDistance',0);
%                         EV3.UpdateMyCommand('Stop_Distance', 0);
%                         EV3.UpdateMyCommand('Stop_Degrees', 0);
%                         EV3.UpdateMyCommand('StopCond', 0);
%                         EV3.UpdateMyCommand('Speed', 0);
%                         EV3.UpdateMyCommand('CurrX', EV3.myPosition.z);
%                         EV3.UpdateMyCommand('CurrY', EV3.myPosition.x);
%                         EV3.UpdateMyCommand('GoalX', EV3.myPosition.z) ;
%                         EV3.UpdateMyCommand('GoalY', EV3.myPosition.x);
                        OptiNavStop(EV3);
                        obj.StateValue = 2;
                    end
                case 3
                    OptiNav(EV3,'ParkingSpot1Entrance');
            end % end switch
        end % end function

        function FromParkingWaiting_GotoParkingSpot2StartCurve(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingWaiting', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingWaiting');
                    end
                case 2
                    OptiNav(EV3,'ParkingSpot2StartCurve');
            end % end switch
        end % end function

        function FromParkingSpot2StartCurve_GotoParkingSpot2Entrance(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot2StartCurve', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot2StartCurve'); 
                    end
                case 2
                    ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
                    %disp(ParkingAreaOpen)
                    if (ParkingAreaOpen == 1)
                        obj.StateValue = 3;
                    else % Need to stop and wait until parking area open
%                         EV3.UpdateMyCommand('LineFollow',0);
%                         EV3.UpdateMyCommand('FollowDistance',0);
%                         EV3.UpdateMyCommand('Stop_Distance', 0);
%                         EV3.UpdateMyCommand('Stop_Degrees', 0);
%                         EV3.UpdateMyCommand('StopCond', 0);
%                         EV3.UpdateMyCommand('Speed', 0);
%                         EV3.UpdateMyCommand('CurrX', EV3.myPosition.z);
%                         EV3.UpdateMyCommand('CurrY', EV3.myPosition.x);
%                         EV3.UpdateMyCommand('GoalX', EV3.myPosition.z) ;
%                         EV3.UpdateMyCommand('GoalY', EV3.myPosition.x);
                        OptiNavStop(EV3);
                        obj.StateValue = 2;
                    end
                case 3
                    OptiNav(EV3,'ParkingSpot2Entrance'); 
            end % end switch
        end % end function
        
        function FromParkingSpot2StartCurve_GotoParkingSpot3StartCurve(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot2StartCurve', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot2StartCurve');  
                    end
                case 2
                    OptiNav(EV3,'ParkingSpot3StartCurve');    
            end % end switch
        end % end function
        
        function FromParkingSpot3StartCurve_GotoParkingSpot3Entrance(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot3StartCurve', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot3StartCurve');    
                    end
                case 2
                    ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
                    %disp(ParkingAreaOpen)
                    if (ParkingAreaOpen == 1)
                        obj.StateValue = 3;
                    else % Need to stop and wait until parking area open
%                         EV3.UpdateMyCommand('LineFollow',0);
%                         EV3.UpdateMyCommand('FollowDistance',0);
%                         EV3.UpdateMyCommand('Stop_Distance', 0);
%                         EV3.UpdateMyCommand('Stop_Degrees', 0);
%                         EV3.UpdateMyCommand('StopCond', 0);
%                         EV3.UpdateMyCommand('Speed', 0);
%                         EV3.UpdateMyCommand('CurrX', EV3.myPosition.z);
%                         EV3.UpdateMyCommand('CurrY', EV3.myPosition.x);
%                         EV3.UpdateMyCommand('GoalX', EV3.myPosition.z) ;
%                         EV3.UpdateMyCommand('GoalY', EV3.myPosition.x);
                        OptiNavStop(EV3);
                        obj.StateValue = 2;
                    end
                case 3
                    OptiNav(EV3,'ParkingSpot3Entrance'); 
            end % end switch
        end % end function

        function FromParkingSpot3StartCurve_GotoParkingExit(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot3StartCurve', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot3StartCurve'); 
                    end
                case 2
                    OptiNav(EV3,'ParkingExit'); 
            end % end switch
        end % end function

        function FromParkingSpot1Entrance_GotoParking1Backout(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot1Entrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot1Entrance'); 
                    end
                case 2
                    OptiNav(EV3,'Parking1Backout'); 
            end % end switch
        end % end function

        function FromParkingSpot2Entrance_GotoParking2Backout(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot2Entrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot2Entrance'); 
                    end
                case 2
                    OptiNav(EV3,'Parking2Backout'); 
            end % end switch
        end % end function

        function FromParking1Backout_GotoParkingExit(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('Parking1Backout', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'Parking1Backout'); 
                    end
                case 2
                    OptiNav(EV3,'ParkingExit'); 
            end % end switch
        end % end function
        
        function FromParking2Backout_GotoParkingExit(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('Parking2Backout', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'Parking2Backout');    
                    end
                case 2
                    OptiNav(EV3,'ParkingExit');  
            end % end switch
        end % end function

        function FromParkingSpot3Entrance_GotoParkingSpot3StartCurve(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot3Entrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot3Entrance');    
                    end
                case 2
                    OptiNav(EV3,'ParkingSpot3StartCurve');  
            end % end switch
        end % end function

        
        function FromParkingExit_GotoOnRampCurve(obj, EV3)
           
%             persistent waitCounter;
%             
%             if isempty(waitCounter)
%                 waitCounter = 0;
%             end
            
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingExit', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                        EV3.ParkingArea.ReleaseParkingArea(EV3.Name); % Why is this needed?  Isn't already done my EV3 task?
                        EV3.ParkingArea.ReleaseParkingSpot(EV3.Name,EV3.myParkingSpot);
%                        waitCounter = 0;
                    else
                        OptiNav(EV3,'ParkingExit');    
                    end
%                 case 2 % Waits at stop sign (would be better to wait for vehicle to pass)
%                     waitCounter = waitCounter + 1;
%                     if (waitCounter == 50*3) % Wait for 150 20ms ticks which is 3 s
%                         obj.StateValue = 3;
%                     else
%                         obj.StateValue = 2;
%                     end
                case 2 % Curve to onramp
%                    waitCounter = 0;
                    OptiNav(EV3,'OnRampCurve');
                    obj.StateValue = 2;
            end % end switch            
        end

        function FromOnRampCurve_GotoOnRamp(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('OnRampCurve', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'OnRampCurve');    
                    end
                case 2
                    OptiNav(EV3,'OnRamp');  
            end % end switch
        end % end function
        
        
        function FromOnRamp_GotoParkingEntrance(~, EV3)
            %disp('Inside FromOnRamp_GotoParkingEntrance.')
            EV3.UpdateMyCommand('LineFollow',1);
            EV3.UpdateMyCommand('Speed', EV3.myCommand.Speed); 
            EV3.UpdateMyCommand('ErrorSignal',ErrorSignal.Straight);
            EV3.UpdateMyCommand('FollowDistance',0);
            EV3.UpdateMyCommand('StopCond', 0);
            EV3.UpdateMyCommand('Stop_Distance', 0);
            EV3.UpdateMyCommand('Stop_Degrees', 0);
        end
        
        
%          function FromParkingSpot1Entrance_GotoParkingSpot1End(obj, EV3)
%             switch(obj.StateValue)
%                 case 1
%                     if ( obj.DistanceToPOI('ParkingSpot1Entrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
%                         obj.StateValue = 2;
%                     else
%                         OptiNav(EV3,'ParkingSpot1Entrance');    
%                     end
%                 case 2
%                     OptiNav(EV3,'ParkingSpot1End');  
%             end % end switch
%         end % end function
%         
        
        function FromParkingSpot1Entrance_GotoParkingSpot1End(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot1Entrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        OptiNavStop(EV3);
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot1Entrance');    
                    end
                case 2
                    LineFollow35(EV3);
            end
        end


        function FromParkingSpot1End_GotoParkingSpot1Entrance(obj, EV3)
            ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
            if (ParkingAreaOpen == 1)
                OptiNav(EV3,'ParkingSpot1Entrance');
            end
        end % end function



%         function FromParkingSpot1End_GotoParkingSpot1Entrance(obj, EV3) 
% %             disp('FromParkingSpot1End_GotoParkingSpot1Entrance')
%             % is parking area open?
%             ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
% %             disp(ParkingAreaOpen)
%             if (ParkingAreaOpen == 1)
%                 EV3.UpdateMyCommand('LineFollow',0);
%                 EV3.UpdateMyCommand('StopCond', 0);
%                 EV3.UpdateMyCommand('FollowDistance',0);
%                 EV3.UpdateMyCommand('ErrorSignal', ErrorSignal.Straight);
%                 EV3.UpdateMyCommand('Speed',-30);
%                 EV3.UpdateMyCommand('Stop_Distance', obj.DistanceToPOI('ParkingSpot1Entrance', EV3.myPosition.x, EV3.myPosition.z)*100);
%                 EV3.UpdateMyCommand('Stop_Degrees', 0);
%                 EV3.UpdateMyCommand('CurrX', EV3.myPosition.z);
%                 EV3.UpdateMyCommand('CurrY', EV3.myPosition.x);
%                 EV3.UpdateMyCommand('GoalX', EV3.myPosition.z) ;
%                 EV3.UpdateMyCommand('GoalY', EV3.myPosition.x);
%             else
%                 
%             end
%         end
        
        function FromParkingSpot2Entrance_GotoParkingSpot2End(obj, EV3)
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot2Entrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        OptiNavStop(EV3);
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3, 'ParkingSpot2Entrance');                    
                    end
                case 2
                    %disp('At parking spot 2 entrance. Line-following to parking spot 2 end.\n')
                    LineFollow35(EV3);
            end            
        end


        function FromParkingSpot2End_GotoParkingSpot2Entrance(obj, EV3)
            ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
            if (ParkingAreaOpen == 1)
                OptiNav(EV3,'ParkingSpot2Entrance');
            end
        end % end function
        
%         function FromParkingSpot2End_GotoParkingSpot2Entrance(obj, EV3)
%             %disp('FromParkingSpot2End_GotoParkingSpot2Entrance')
%             ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
% %             disp(ParkingAreaOpen)
%             if (ParkingAreaOpen == 1)
%                 EV3.UpdateMyCommand('LineFollow',0);
%                 EV3.UpdateMyCommand('StopCond', 0);
%                 EV3.UpdateMyCommand('FollowDistance',0);
%                 EV3.UpdateMyCommand('ErrorSignal', ErrorSignal.Straight);
%                 EV3.UpdateMyCommand('Speed',-30);
%                 EV3.UpdateMyCommand('Stop_Distance', obj.DistanceToPOI('ParkingSpot2Entrance', EV3.myPosition.x, EV3.myPosition.z)*100);
%                 EV3.UpdateMyCommand('Stop_Degrees', 0);
%             else
%                 
%             end
%         end
        
        function FromParkingSpot3Entrance_GotoParkingSpot3End(obj, EV3)
            %disp('Inside FromParkingSpot3Entrance_GotoParkingSpot3End')
            
            switch(obj.StateValue)
                case 1
                    if ( obj.DistanceToPOI('ParkingSpot3Entrance', EV3.myPosition.x, EV3.myPosition.z) < 0.03 )
                        OptiNavStop(EV3);
                        obj.StateValue = 2;
                    else
                        OptiNav(EV3,'ParkingSpot3Entrance');
                    end
                case 2
                    %disp('At parking spot 2 entrance. Line-following to parking spot 2 end.\n')
                    LineFollow35(EV3);
                    if ( obj.DistanceToPOI('ParkingSpot3End', EV3.myPosition.x, EV3.myPosition.z) < 0.08 )
                        EV3.UpdateMyCommand('LineFollow',0)
                        EV3.UpdateMyCommand('Speed',0);
                    end
            end
        end
      
        function FromParkingSpot3End_GotoParkingSpot3Entrance(obj, EV3)
            ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
            if (ParkingAreaOpen == 1)
                OptiNav(EV3,'ParkingSpot3Entrance');
            end
        end % end function
        
        
%         function FromParkingSpot3End_GotoParkingSpot3Entrance(obj, EV3)
%             %disp('FromParkingSpot3End_GotoParkingSpot3Entrance')
%             ParkingAreaOpen = EV3.ParkingArea.ReserveParkingArea(EV3.Name);
% %             disp(ParkingAreaOpen)
%             if (ParkingAreaOpen == 1)
%                 EV3.UpdateMyCommand('LineFollow',0);
%                 EV3.UpdateMyCommand('StopCond', 0);
%                 EV3.UpdateMyCommand('FollowDistance',0);
%                 EV3.UpdateMyCommand('ErrorSignal', ErrorSignal.Straight);
%                 EV3.UpdateMyCommand('Speed',-30);
%                 EV3.UpdateMyCommand('Stop_Distance', obj.DistanceToPOI('ParkingSpot3Entrance', EV3.myPosition.x, EV3.myPosition.z)*100);
%                 EV3.UpdateMyCommand('Stop_Degrees', 0);
%             else
%                 
%             end
%         end
        
        
        
        
    end

    
    
end