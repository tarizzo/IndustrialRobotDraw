% Set up the socket
tc=tcpip('127.0.0.1',55000, 'Timeout', 60);

% Open the comms
fopen(tc);

% Send a message to the robot

