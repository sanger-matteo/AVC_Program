function [ft_status, handle] = usbio24_open_by_idx(index)
% usbio24_open_by_idx
% Opens a USBIO24 device by its index
% and returns a handle to it and a status flag.
% If the FTD2XX.dll library is not loaded, it loads it.
% For loading the library, the myFTD2XX.h file must be in a 
% folder included in the Matlab Path or in the current
% folder.
%
% [ft_status, handle] = usbio24_open_by_idx(index)
%
% index = Index of the device. First device that was connected has idx=0,
%         second device has idx=1, etc.
% ft_status = Integer status flag
% handle = Integer handle to the device

%
% R. Gomez-SJoberg 4/18/08

if ~libisloaded('ftd2xx')
    loadlibrary('ftd2xx', @ftd2xx);
end;

handle = uint32(0);
idx = int16(index);
ft_status = uint32(0);

[ft_status, handle] = calllib('ftd2xx', 'FT_Open', idx, handle);
