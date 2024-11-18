function [ft_status, info] = usbio24_get_device_info(handle);
% usbio24_get_device_info
% Gets information from a USBIO24 device
%
% [ft_status, info] = usbio24_get_device_info(handle)
%
% handle = Integer handle to the device
%
% ft_status = Integer status flag
% info = Structure with information:
%        info.Type = Integer that indicates device type
%        info.ID = Integer that indicates device ID
%        info.SerialNumber = String with serial number
%        info.Description = String with device description
%
% R. Gomez-SJoberg 4/18/08

info.Type = uint32(0);
info.ID = uint32(0);
sn =  char(32*ones(1, 1000));
desc =  char(32*ones(1, 1000));

dummy = uint16(0);

[ft_status, info.Type, info.ID, sn, desc, dummy] = calllib('ftd2xx', 'FT_GetDeviceInfo', handle, info.Type, info.ID, sn, desc, dummy);

info.SerialNumber = sn;
info.Description = desc;