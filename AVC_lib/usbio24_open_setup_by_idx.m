function [ft_status, handle] = usbio24_open_setup_by_idx(index);
% usbio24_open_by_idx
% Opens a USBIO24 device by its index
% and returns a handle to it and a status flag.
% If the FTD2XX.dll library is not loaded, it loads it.
% For loading the library, the myFTD2XX.h file must be in a 
% folder included in the Matlab Path or in the current
% folder.
%
% The device is reset and all bits are set to output
%
% [ft_status, handle] = usbio24_open_setup_by_idx(index)
%
% index = Index of the device. First device that was connected has idx=0,
%         second device has idx=1, etc.
% ft_status = Integer status flag
% handle = Integer handle to the device
%
% R. Gomez-Sjoberg 4/18/08

[ft_status, handle] = usbio24_open_by_idx(index);
ft_status = usbio24_setup(handle);
