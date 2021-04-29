%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Open communication with the box using an index

%% Index of controller box
% Index = 0 if only one box is connected
idx = 0;

%% Open connection to the controller
[status, handle] = usbio24_open_setup_by_idx(idx);

%% Get information about the controller (serial number, description, etc.)
[status, info] = usbio24_get_device_info(handle);
info

%% Set all bits to zero
status = usbio24_set_bits(handle, [0:23], zeros(1, 24));

%% Set bits 0, 5, 8, 12, 15, 20 to ones
status = usbio24_set_bits(handle, [0 5 8 12 15 20], [1 1 1 1 1 1 1 1]);

%% Read back the state of bit 9
[status, values] = usbio24_get_bits(handle, 9);
disp(values);

%% Close connection to the controller
status = usbio24_close(handle)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Open communication with the box using a serial number

%% Serial number of USB interface in the controller box
ser_num = 'ELR0F3IC';

%% Open connection to the controller
[status, handle] = usbio24_open_setup_by_sn(ser_num);
disp(['Open by serial number. status = ' num2str(status)]);

%% Set all bits to zero
status = usbio24_set_bits(handle, [0:23], zeros(1, 24));

%% Set bits 0, 5, 8, 12, 15, 20 to ones
status = usbio24_set_bits(handle, [0 5 8 12 15 20], [1 1 1 1 1 1 1 1]);

%% Read back the state of bit 5
[status, values] = usbio24_get_bits(handle, 5);
disp(values);

%% Close connection to the controller
status = usbio24_close(handle)


