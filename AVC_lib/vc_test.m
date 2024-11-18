%% Parameters for connecting to two controller boxes
% Number of boxes
vc.num = 2;
% Serial number of USB interface in box #1
vc.info(1).sn = 'ELZ26DJK';
vc.info(1).handle = 0;
vc.info(1).status = 0;
% Polarity of valves in box #1 (see help of function vc_open_setup for
% a description of how the polarity works
vc.info(1).polarity = logical([zeros(1, 16) ones(1, 8)]);

% Serial number of USB interface in box #2
vc.info(2).sn = 'ELYLE6IZ';
vc.info(2).handle = 0;
vc.info(2).status = 0;
% Polarity of valves in box #2
vc.info(2).polarity = logical([zeros(1, 16) ones(1, 8)]);

%% Open connection to controller boxes
vc = vc_open_setup(vc);
% Check status of both connections
disp(['Status of box#1 = ' num2str(vc.info(1).status)]);
disp(['Status of box#2 = ' num2str(vc.info(2).status)]);

%% Set all bits (0 to 47) to zeros
numbers = 0:47;
values =  zeros(1, 48);
vc = vc_set_bits_ac(vc, numbers, values);

%% Set bits 0, 5, 10, 24, 47 to ones
vc = vc_set_bits_ac(vc, [0 5 10 24 47], [1 1 1 1 1]);

%% Set bit 25 to one
vc = vc_set_1bit(vc, 25, 1);

%% Read state of bits 24 to 47
[vc, values] = vc_get_bits(vc, [24:47]);
values

%% read state of bit 26
[vc, value] = vc_get_1bit(vc, 26);
value

%% Close connection to the controllers
vc = vc_close(vc, 1);
