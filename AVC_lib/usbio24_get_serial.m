%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Retrieve the serial number of controller at index 0
% To get the serial number of each controller, please connect only
% one controller at a time and run this script for each controller
%
% R. Gomez-Sjoberg 5/2/12

% Index of controller box
idx = 0;

% Open connection to the controller
[status, handle] = usbio24_open_by_idx(idx);

% Get information about the controller (serial number, description, etc.)
[status, info] = usbio24_get_device_info(handle);
info

% Close connection to the controller
status = usbio24_close(handle);
