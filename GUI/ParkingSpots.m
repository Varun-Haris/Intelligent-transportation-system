classdef ParkingSpots < handle
    
    properties
        ParkingSpot1
        ParkingSpot2
        ParkingSpot3
        ParkingArea
        TotalSpots
    end
    
    methods
        
        function obj = ParkingSpots()
            obj.ParkingSpot1 = '';
            obj.ParkingSpot2 = '';
            obj.ParkingSpot3 = '';
            obj.ParkingArea = '';
            obj.TotalSpots = 3;
        end

        function ParkingSpotNum = ReserveParkingSpot(obj, Name)
            ParkingSpotNum = 0;
            for index = 1:obj.TotalSpots
                switch index
                    case 1
                        if (isempty(obj.ParkingSpot1))
                            ParkingSpotNum = index;
                            obj.ParkingSpot1 = Name;
                            break;
                        end
                    case 2
                        if (isempty(obj.ParkingSpot2))
                            ParkingSpotNum = index;
                            obj.ParkingSpot2 = Name;
                            break;
                        end
                    case 3
                        if (isempty(obj.ParkingSpot3))
                            ParkingSpotNum = index;
                            obj.ParkingSpot3 = Name;
                            break;
                        end
                end
            end
        end
        
        function Availability = ReserveParkingArea(obj, Name)
            Availability = 0;
            if (isempty(obj.ParkingArea)) || strcmp(obj.ParkingArea, Name)
            	Availability = 1;
                obj.ParkingArea = Name;
            end
        end
        
        function ReleaseParkingSpot(obj, Name, ParkingSpotNum)
            switch ParkingSpotNum
                case 1
                    if (strcmp(Name, obj.ParkingSpot1))
                        obj.ParkingSpot1 = '';
                    end
                case 2
                    if (strcmp(Name, obj.ParkingSpot2))
                        obj.ParkingSpot2 = '';
                    end
                case 3
                    if (strcmp(Name, obj.ParkingSpot3))
                        obj.ParkingSpot3 = '';
                    end
            end
        end
        
        function ReleaseParkingArea(obj, Name)
            if (strcmp(Name, obj.ParkingArea))
                obj.ParkingArea = '';
            end
        end
        
    end
    
end