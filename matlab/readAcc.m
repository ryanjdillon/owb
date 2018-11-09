%-------------------------------------------------------------------------
%                    Function to read values from IMU
%-------------------------------------------------------------------------

function [ ax ay az ] = readAcc(out,mode)
 
% 'out' is the name of the structure that we want to read, connected to a
% serial port.
% 'mode' must be a string 1,2 or 3 to tell the arduino which mode to choose

        
    % Send '2' over serial to trigger data read from MCU
    fprintf(out.s,mode);
    
    % Add delay to allow data to transfer over Serial before reading buffer
    tic;
    while (toc < 0.050)
        % delay...
    end
    
    % Read valyes from serial port
    %readings(1) = fscanf(out.s, '%u');
    %readings(2) = fscanf(out.s, '%u');
    %readings(3) = fscanf(out.s, '%u');
    
    % Determine what gains and offset valyes to use
    %offset = calCo.offset;
    %gain = calCo.g;
    %accel = (readings - offset) ./ gain;
    
    % Check to see if serial buffer has data
    if (out.s.BytesAvailable < 1)
        
        ax = 00.00;
        ay = 00.00;
        az = 00.00;
        
    else
        ax = fscanf(out.s, '%f');
        ay = fscanf(out.s, '%f');
        az = fscanf(out.s, '%f');
    end
    
    
   
    