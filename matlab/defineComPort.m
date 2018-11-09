%-------------------------------------------------------------------------
%                          defineComPort.m
%-------------------------------------------------------------------------

% Description: creates a serial port structure (object) used to 
%              connect matlab with MCU


%% 1. Specifies the COM port that the Arduino is connected to

% specific to your USB port and hardware, below is an example from Mac
comPort = '/dev/tty.usbserial-A603YBQ9';


%% 2 Initialize the Serial Port - setupSerial()

% connect Matlab to the accelerometer by creating a structure in the workspace
if (~exist('serialFlag', 'var'))
    [accelerometer.s,serialFlag] = setupSerial(comPort);
end

