function [C1, C2, C3] = EV3_eval_source(time, RLI, Ultra)
% Inputs
% "time" : (n by 1) column vector that contains 1 second resolution
% timestamps
% "RLI" : (n by 1) column vector that contains right light sensor readings
% "Ultra" : (n by 1) column vector that contains ultrasonic sensor readings

% Outputs
% C1 : tracking error
% C2 : tracking smoothness
% C3 : Platooning performance

%% Main Code
try   
    % Normalize the sensor readings to (0 ~ 100) range
    norm_RLI = RLI.*(100/max(RLI));
    
    % Reference value for each trial
    RLI_ref = median(norm_RLI);
    
    % Data sampling time
    delta_T = min(mean(diff(time)), median(diff(time)));
    
    % Check sampling time for 1 sec plus minus 0.2 sec
    if abs(delta_T - 1) > 0.2
        disp('Disqualified');
        C1 = inf;
        C2 = inf;
        C3 = inf;
        return
    end
    
    % C1 evaluation panelize time and tracking error
    C1 = sum(abs(norm_RLI - RLI_ref).*delta_T);
    
    % C2 smoothness
    C2 = sum(abs(diff(norm_RLI - RLI_ref))./delta_T);
    
    % C3 platooning performance
    C3 = sum(abs(Ultra - 20).*delta_T);
    
    disp(['C1 value is: ', num2str(C1)]);
    disp(['C2 value is: ', num2str(C2)]);
    disp(['C3 value is: ', num2str(C3)]);
    
catch ME
    disp('Bad input data. Check your input data.');
end
end