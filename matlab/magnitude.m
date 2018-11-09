%-------------------------------------------------------------------------
%                 Accelerometer Magnitude Source Code 
%-------------------------------------------------------------------------

% Updated: 5/14/2016
%
% This source code does the following:
% 1. Specifed the COM port that the arduino or Xbee is connected to with PC
% 2. Initialize the Serial Port - setupSerial()
% 3. Calibrate sensor - (not used currently)
% 4. Opens a new figure and customizes it by adding 'stop' and 'close serial' buttons
% 5. Initialize a rolling plot
% 6. Runs a loop that contunually reads the accelerometer vales - readAcc()
%
% The accelerometer data is placed in the variables [ax ay az].
% Updates the data on the rolling plot, tested to be 12.8 Hz sampling.

%% 0. Define global variables

global stopButton

% initialize value to zero, used to stop data streaming when == 1
stopButton = 0; 

%% 1. Specifies the COM port that the Arduino is connected to

comPort = '/dev/tty.usbserial-A603YBQ9';


%% 2 Initialize the Serial Port - setupSerial()

% connect Matlab to the accelerometer and create object if it does not aleady exist
if (~exist('serialFlag', 'var'))
    [accelerometer.s,serialFlag] = setupSerial(comPort);
end

%% 3. Skip - do not use calibration



%% 4. Open a new figure - add a 'stop' and 'close serial' buttons

% plot dimension
x_start = 200;
y_start = 200;
width = 1000;
height = 400;

% initilaze the figure that we will plot in if it does not exist
if(~exist('h', 'var')|| ~ishandle(h))
    h = figure(1);
    
    %xlabel('time (sec)');
    %ylabel('Acceleration magnitude, (m/s^2)');
    %legend('X-axis', 'Y-axis', 'Z-axis', 'Location', 'northeast');
    
    set(h, 'Position', [x_start y_start width height])
    ax = axes('box','on');
end

% add a start/stop and close serial button inside the figure
% keep in mind, the 'stop_call_wk3' function that this button calls
% everytime it is pressed

if(~exist('button','var'))
    button = uicontrol('Style','pushbutton','String','Stop', 'pos', [10 0 50 25], 'parent', h, 'Callback', 'stop_call_magnitude','UserData',1);
end

if(~exist('button2','var'))
    button2 = uicontrol('Style','pushbutton','String','Close Serial Port', 'pos', [(width-160) 0 150 25], 'parent', h, 'Callback', 'closeSerial','UserData',1);
end


%% 5. Initialize the Rolling Plot

buf_len = 100;
index = 1:buf_len;

% create variables for saving data to rolling plots
gxdata = zeros(buf_len,1);
gydata = zeros(buf_len,1);
gzdata = zeros(buf_len,1);
time = zeros(buf_len,1);

% create matrix for saving time and acceleraton data in the workspace,
% convienent if you want to export CSV file after collecting data
accData = zeros(10000,4);


%% 6. Data Collection and Plotting

% Start the Matlab timer object Tic
tStart = tic;

% Counter
n = 1;

% While the figure window is open.
%while(get(button, 'UserData'))

xlabel('time (sec)');
ylabel('Acceleration magnitude, (m/s^2)');
plot(0, 0, 'r', 0, 0, 'g', 0, 0, 'b');
legend('X-axis', 'Y-axis', 'Z-axis', 'Location', 'northeast');

while(stopButton == 0)
            
    [ax ay az] = readAcc(accelerometer,'2');
    
    
    % Update the rolling plot. Append the new readings to the end of the
    % rolling plot data. Drop the first valye.
    timeStamp = toc(tStart);
    time = [time(2:end); timeStamp];
    gxdata = [gxdata(2:end); ax];
    gydata = [gydata(2:end); ay];
    gzdata = [gzdata(2:end); az];
    
    % Save data to matrix
    accData(n,1) = timeStamp;
    accData(n,2) = ax;
    accData(n,3) = ay;
    accData(n,4) = az;
    
    plot(time, gxdata, 'r', time, gydata, 'g', time, gzdata, 'b');
    axis([time(1,1) time(100,1) -15.0 15.0]);
    
    drawnow;
 
    n = n+1;

end

