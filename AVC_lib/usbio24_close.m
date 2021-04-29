function [ft_status] = usbio24_close(handle, unload);
% usbio24_close
% Closes the USBIO24 device.

%% [ft_status] = usbio24_close(handle, {unload})
%
% handle = Integer handle to the device
% unload =  >1 --> unload FTD2XX library
%          ==0 --> Do NOT unload library
%          unload is an optional argument. If it is not provided,
%          the library is NOT unloaded.
% ft_status = Integer status flag
%
% R. Gomez-SJoberg 7/14/05

if nargin == 1
    unload = 0;
end

[ft_status] = calllib('ftd2xx', 'FT_Close', handle);

if unload
    unloadlibrary('ftd2xx');
end
