clear
% Set up the socket
tc=tcpip('127.0.0.1',55000)%, 'Timeout', 60);

% Open the comms
fopen(tc);

tc.terminator = "";

%recieve message
message = fread(tc, 1, 'uint8')

writeInt(tc, 200, 250)

% Send a message to the robot


% tc = tcpclient('127.0.0.1',55000)
% fopen(tc);
% readData = read(tc);
% while isempty(readData)
%     readData = read(tc);
% end
% 
% fwrite(tc, [200, 250])

