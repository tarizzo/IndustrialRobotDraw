% Set up the socket
tc=tcpip('127.0.0.1',55555, 'Timeout', 60);

% Open the comms
fopen(tc);

% Receive message from robot
message = fread(tc)

% Send a message to the robot
fwrite(tc, 'Hello RobotStudio from MATLAB!');