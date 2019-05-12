classdef OptiDSP < handle
    
    properties
        UDP
        UDPsend
        TrackableArray
        processed_counter
        failed_counter
        StartSend
        OptiTimer
        OptiPrint
        ObserverList_EV3
        ObserverList_GUI
    end
    
    methods
        
        function obj = OptiDSP()
            Trackable1 = Trackable('Iron Man',1);
            Trackable2 = Trackable('Thor',2);
            Trackable3 = Trackable('Hulk',3);
            Trackable4 = Trackable('Captain America',4);
            obj.TrackableArray = [Trackable1 Trackable2 Trackable3 Trackable4];
            obj.StartSend = 0;
          
            t = dsp.UDPSender('RemoteIPPort',1510,'LocalIPPortSource','Property','LocalIPPort',1512);
            t.RemoteIPAddress=('127.0.0.1');
            
            obj.processed_counter = 0;
            obj.failed_counter = 0;          

            %Send PING packet so server starts sending data
            %Server must be set for multicast and sent directly to this computer
            % Unitcast for some reason doesn't work 
            try
                txdata = ['0';'0';'0';'0'];
                %Convert to decimal format
                txdata_dec = hex2dec(txdata);
                %Write using the UINT8 data format
 %               fwrite(t,txdata_dec,'uint8');
                t(txdata_dec);
            catch
            end

%            fclose(t);
            release(t);
            delete(t);
            clear t;

            obj.UDP = dsp.UDPReceiver('LocalIPPort',1512);
            obj.UDP.RemoteIPAddress='127.0.0.1';
            obj.UDP.ReceiveBufferSize=1000;
            obj.UDP.MaximumMessageLength=1000; 
            obj.UDP.MessageDataType='uint8';
            setup(obj.UDP); 
   
            obj.OptiTimer = timer;
            obj.OptiTimer.TimerFcn = {@(src,event)obj.Update};
            obj.OptiTimer.StartDelay = 0;
            obj.OptiTimer.Period = .05;
            obj.OptiTimer.ExecutionMode = 'fixedRate';
            obj.OptiTimer.BusyMode='drop';
            start(obj.OptiTimer);
            
%             obj.OptiPrint = timer;
%             obj.OptiPrint.TimerFcn = {@(src,event)obj.PrintData};
%             obj.OptiPrint.StartDelay = 0;
%             obj.OptiPrint.Period = .05;
%             obj.OptiPrint.ExecutionMode = 'fixedRate';
%             obj.OptiPrint.BusyMode='drop';
%             start(obj.OptiPrint);
            
        end

        function delete(obj)
            
            stop(obj.OptiTimer);
            delete(obj.OptiTimer);
 
%             stop(obj.OptiPrint);
%             delete(obj.OptiPrint);

            release(obj.UDP);
            delete(obj.UDP);

        end
                            
        function Update(obj, event)
            %errors when there are no trackables

             persistent GUIsendCounter;
             
             if isempty(GUIsendCounter)
                 GUIsendCounter = 0;
             end
            
            try
                data = obj.UDP();
                
                % i don't think I need the for dataD loop anymore with UDPreceiver
                % I declare uint8 but it still uses double above! so I have to do type
                % conversion
               % for i=1:length(dataD) 
            %       data(i) = uint8(dataD(i));
             %  end
                length(data);
                index = 1;

                MessageID = typecast(data(index:index+1),'uint16');
                index = index + 2;

                ByteCount = typecast(data(index:index+1),'uint16');
                index = index + 6;

                MarkerSets = typecast(data(index:index+3),'uint32');
                index = index + 4;

                for i=1:MarkerSets

                    indexStop = index;
                    count = 0;
                    EndStringFound = 0;

                    %Find name of Markerset First
                    while (EndStringFound ~= 1)

                        if data(index+count) == uint8(0) 
                            indexStop = index + count;
                            EndStringFound = 1;
                        else
                            count = count + 1;
                        end

                    end
                    
                    index = indexStop+1;

                    MarkerCount = typecast(data(index:index+3),'uint32');
                    index = index + 4 + 12*MarkerCount;


                end % end of Markersets

                %Other Markers
                OtherMarkers = typecast(data(index:index+3),'uint32');
                index = index + 4 + OtherMarkers*12;

                %EV3s 
                EV3s = typecast(data(index:index+3),'uint32');
                index = index + 4;
                
                
                %disp('Start EV3 loop.');
                for count=1:EV3s
                    EV3ID = typecast(data(index:index+3),'uint32');
                 %   fprintf('count %d\n',count);
                    EV3ID = uint8(EV3ID);
                    index = index + 4;
                    obj.TrackableArray(EV3ID).x = typecast(data(index:index+3),'single');
                    index = index + 8;
                    obj.TrackableArray(EV3ID).z = typecast(data(index:index+3),'single');
                    index = index + 4; 
                    qx = typecast(data(index:index+3),'single');
                    index = index + 4; 
                    qy = typecast(data(index:index+3),'single');
                    index = index + 4; 
                    qz = typecast(data(index:index+3),'single');
                    index = index + 4; 
                    qw = typecast(data(index:index+3),'single');
                    index = index + 4;  

                    obj.TrackableArray(EV3ID).yaw = rad2deg(atan2(2.0*(qy*qw + qx*qz), 1 - 2*(qy*qy + qz*qz)));

                    RigidMarkers = typecast(data(index:index+3),'uint32');
                    index = index + 4;

                    index = index + RigidMarkers*20;
                    index = index + 4;
                  %  fprintf('count %d\n',count);
                  %  fprintf('count %d index %d ByteCount %d\n',count,index,ByteCount);
                end
                
                obj.processed_counter = obj.processed_counter+1;
                obj.StartSend = 1;
            catch ME
              %fprintf('fail\n')
            %    fprintf('processed_counter %d x %d index %d count %d datalength %d steps: %d MessageID %d ByteCount %d MarkerSets %d error %s\n',obj.processed_counter, obj.TrackableArray(2).yaw, index,count,length(dataD),steps,MessageID,ByteCount,MarkerSets,ME.message)
            end
            
            obj.NotifyEV3();
            
%            GUIsendCounter = GUIsendCounter + 1;
%            if (GUIsendCounter == 10)
                obj.NotifyGUI();
%                GUIsendCounter = 0;
%            end
            
        end % end of callback
        
        function PrintData(obj,event)
            % nothing
        end
        
        function PrintDataN(obj,event)
            try
                clc
                fprintf('time %s\n', datestr(now,'HH:MM:SS:FFF'));
                for pl=1:4
                    fprintf('X: %.0f Z: %.0f YAW: %.0f YAW %f ==> %s\n', 1000*(obj.TrackableArray(pl).x), 1000*(obj.TrackableArray(pl).z), obj.TrackableArray(pl).yaw, obj.TrackableArray(pl).yaw, obj.TrackableArray(pl).Name);
                end
            catch ME
                fprintf('error %s\n',ME.message)
            end
        end
        
        function AddObserverEV3(obj, obs)
            obj.ObserverList_EV3 = [obj.ObserverList_EV3, obs];
            obj.NotifyEV3();
        end
        
        function AddObserverGUI(obj, obs)
            obj.ObserverList_GUI = [obj.ObserverList_GUI, obs];
            obj.NotifyGUI();
        end
        
        function NotifyEV3(obj)
            if (~isempty(obj.ObserverList_EV3))
                for x = 1:length(obj.TrackableArray)
                    for y = 1:length(obj.ObserverList_EV3)
                        if (strcmp(obj.TrackableArray(x).Name, obj.ObserverList_EV3(y).Name))
                            obj.ObserverList_EV3(y).UpdatePosition(obj.TrackableArray(x));
                        end
                    end
                end
            end
        end
        
        function NotifyGUI(obj)
            if (~isempty(obj.ObserverList_GUI))
                for x = 1:length(obj.ObserverList_GUI)
                    obj.ObserverList_GUI(x).UpdateTrackableArray(obj.TrackableArray);
                end
            end
        end
        
    end
    
end