%-------------------------------------------------------------------------
%                closeSerial.m - callback script for button2 
%-------------------------------------------------------------------------

% Description: close serial communications with MCU and send RESET command 
%              to MCU to reboot firmware so that it is ready establish 
%              a new connection

% check if variable comPort exists, if so reset the MCU
if (exist('comPort', 'var'))
    fprintf(accelerometer.s,'3');
end

% close seria port between arduino and matlab 
if~isempty(instrfind)
     fclose(instrfind);
     delete(instrfind);
end

% clean the workspace and close all figures 
clc
clear
close all

% wait for MCU to restart
display('Wait for MCU to reboot...');

% add delay of six seconds
tic;
    while toc < 6; % seconds
    end
    
clc
disp('Serial Port Closed')





