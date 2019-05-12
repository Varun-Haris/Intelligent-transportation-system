clear all;

%Initialize OptiTrack Interface
OptiTrack = OptiDSP();

%Initialize EV3 objects
IronMan = EV3_v3('Iron Man', '192.168.0.201', 50001, 50000); %!!!!CHANGE LATER!!!! Or update the rest of the EV3s
Thor = EV3_v3('Thor', '192.168.0.202', 29001, 29000);
Hulk = EV3_v3('Hulk', '192.168.0.203', 27001, 27000);
%CaptainAmerica = EV3_v3('Captain America', '192.168.0.204', 28001, 28000);

%Add EV3 objects as observers to OptiTrack
OptiTrack.AddObserverEV3(IronMan); 
OptiTrack.AddObserverEV3(Thor);
OptiTrack.AddObserverEV3(Hulk);
%OptiTrack.AddObserverEV3(CaptainAmerica);

%Initialize parking spots tracker
ParkingArea = ParkingSpots();

%Give EV3 objects function handles for ParkingArea
IronMan.ParkingArea = ParkingArea;
Thor.ParkingArea = ParkingArea;
Hulk.ParkingArea = ParkingArea;
%CaptainAmerica.ParkingArea = ParkingArea;

%Initialize GUI
%GUI = GUI_v2_Tabbed_layout_20190404;
GUI = GUI_20190423;

%Add GUI as on observer to OptiTrack
OptiTrack.AddObserverGUI(GUI);

%Add GUI as an observer to each EV3
GUI.AddObserver(IronMan);
GUI.AddObserver(Thor);
GUI.AddObserver(Hulk);
%GUI.AddObserver(CaptainAmerica);

%Add GUI as an observer to each EV3
IronMan.AddObserver_GUI(GUI);
Thor.AddObserver_GUI(GUI);
Hulk.AddObserver_GUI(GUI);
%CaptainAmerica.AddObserver_GUI(GUI);