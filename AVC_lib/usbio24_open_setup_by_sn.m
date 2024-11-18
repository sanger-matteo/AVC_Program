function [ft_status, handle] = usbio24_open_setup_by_sn(ser_num);
% usbio24_open_by_sn
% Opens a USBIO24 device by its serial number
% and returns a handle to it and a status flag.
% If the FTD2XX.dll library is not loaded, it loads it.
% For loading the library, the myFTD2XX.h file must be in a 
% folder included in the Matlab Path or in the current
% folder.
%
% The device is reset and all bits are set to output
%
% [ft_status, handle] = usbio24_open_setup_by_sn(ser_num)
%
% ser_num = String with device serial number
% ft_status = Integer status flag
% handle = Integer handle to the device
%
% R. Gomez-Sjoberg 7/14/05
%



[ft_status, handle] = usbio24_open_by_sn(ser_num);
ft_status = usbio24_setup(handle);
