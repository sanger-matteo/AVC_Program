function [ft_status] = usbio24_setup(handle);
% usbio24_setup
% Sets up the USBIO24 device.
% Sets all bits of a USBIO24 to output.
%
% [ft_status] = usbio24_setup(handle)
%
% handle = Integer handle to the device
% ft_status = Integer status flag
%
% R. Gomez-SJoberg 7/14/05
%
% Changed to use Matlab generated header files and lowercase library call
% Pass buffer pointer to FT_Write to accomodate Matlab prototype
% B Passarelli 8/4/08

ft_status = 0;
% Reset
[ft_status] = calllib('ftd2xx', 'FT_ResetDevice', handle);

% Set baud rate to max
[ft_status] = calllib('ftd2xx', 'FT_SetBaudRate', handle, 921600);

% Set WordLength = 8, StopBits = 0, Parity = 0
[ft_status] = calllib('ftd2xx', 'FT_SetDataCharacteristics', handle, 8, 0, 0);

% No flow control
[ft_status] = calllib('ftd2xx', 'FT_SetFlowControl', handle, 0, 0, 0);

% Purge Rx and Tx buffers
[ft_status] = calllib('ftd2xx', 'FT_Purge', handle, 1);
[ft_status] = calllib('ftd2xx', 'FT_Purge', handle, 2);
pause(0.1);

% Set DTR & RTS
[ft_status] = calllib('ftd2xx', 'FT_SetDtr', handle);
[ft_status] = calllib('ftd2xx', 'FT_SetRts', handle);

% Set all bit to output
buffer = uint8(['!A' 0 '!B' 0 '!C' 0]);
bufp = libpointer('voidPtr', buffer);
num_bytes = 9;
[ft_status, bufp, num_bytes] = calllib('ftd2xx', 'FT_Write', handle, bufp, num_bytes, num_bytes);



