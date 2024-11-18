function [ft_status, handle] = usbio24_open_by_sn(ser_num)
% usbio24_open_by_sn
% Opens a USBIO24 device by it s serial number
% and returns a handle to it and a status flag.
% If the FTD2XX.dll library is not loaded, it loads it.
% For loading the library, the myFTD2XX.h file must be in a 
% folder included in the Matlab Path or in the current
% folder.
%
% [ft_status, handle] = usbio24_open_by_sn(ser_num)
%
% ser_num = String with device serial number
% ft_status = Integer status flag
% handle = Integer handle to the device

%
% R. Gomez-SJoberg 7/14/05
%
%
% Updates to use Matlab prototype file for compatibility with later versions 
% B Passarelli      8/6/08

if ~libisloaded('ftd2xx')
    loadlibrary('ftd2xx', @ftd2xx);
end;

handle = uint32(0);
flags = uint32(1); % Open by serial number
ft_status = uint32(0);

[ft_status, ser_num, handle] = calllib('ftd2xx', 'FT_OpenEx', ser_num, flags, handle);

