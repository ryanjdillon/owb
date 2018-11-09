%-------------------------------------------------------------------------
%                   Function to setup serial communication 
%-------------------------------------------------------------------------

function [s, flag] = setupSerial(comPort)

% Initialize the serial port communication between Arduino and MATLAB
% WE ensure that the arduino is also communicating with MATLAB at this
% time. A predefined code on the Arduino acknowledges this. 
% If setup is complete then the value of setup is returned as 1 else 0.

% Arduino serial port fomat -  /dev/cu.usbmodem1411s
flag = 1;

XBEE = 1; % set this equal to 1 if using Xbee to connect to laptop, set equal to 0 if using Arduino USB

s = serial(comPort);
set(s, 'DataBits', 8 );
set(s, 'StopBits', 1 );
set(s, 'BaudRate', 9600 ); % default 9600
set(s, 'Parity', 'none' );

fopen(s) ; % connects the serialport to the Arduino, open the serial object file 's'


% check is using Xbee or Arduino for communication
if (XBEE == 1)
    fprintf(s, '%c', 'a'); %write over the serial port the charecter 'a'
end


a = 'b'; 

% read the serial port until we see the charecter 'a'
while(a~= 'a')
    a = fread(s,1, 'uchar');
end

% when we read the charecter 'a', display a message
if (a == 'a')
    disp('serial read'); % display in command window
end


% check is using Xbee or Arduino for communication
if (XBEE == 0)
    fprintf(s, '%c', 'a'); %write over the serial port the charecter 'a'
end
   

mbox = msgbox('Serial Communication setup'); % create popup dialog box message box
uiwait(mbox); % wait for the message box to be closed

fscanf(s, '%u'); % read unsigned base ten integer format over serial port

end


