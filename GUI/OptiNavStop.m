function OptiNavStop(EV3)
    EV3.UpdateMyCommand('LineFollow',0);
    EV3.UpdateMyCommand('FollowDistance',0);
    EV3.UpdateMyCommand('StopCond', 1); % I guess this is for OPtiMode?
    EV3.UpdateMyCommand('Stop_Distance', 0);
    EV3.UpdateMyCommand('Stop_Degrees', 0);
    EV3.UpdateMyCommand('Speed', 50);
    EV3.UpdateMyCommand('CurrX', EV3.myPosition.z);
    EV3.UpdateMyCommand('CurrY', EV3.myPosition.x);
    EV3.UpdateMyCommand('CurrTheta', EV3.myPosition.Get_yaw());
    EV3.UpdateMyCommand('GoalX', EV3.myPosition.z) ;
    EV3.UpdateMyCommand('GoalY', EV3.myPosition.x);
    EV3.UpdateMyCommand('GoalTheta', EV3.myPosition.Get_yaw());
end