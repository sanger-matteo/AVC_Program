function [vc_out] = vc_close(vc_in, unload);
% vc_close
% Close all valve controllers specified in the
% vc struct
%
% [vc_out] = vc_close(vc_in, {unload})
%
% unload = Optional argument. 0 (default) --> Do NOT unload library
%                             1 --> Unload library
% vc.num = Number of controllers to use
% vc.info(i).handle = Handle of ith controller
% vc.info(i).sn = Serial number of ith controller
% vc.info(i).status = Status of ith controller
% vc.info(i).polarity = Arrays with valve polarities of ith controller
%                       polarity(j) = 0 --> jth valve is normally open
%                       polarity(j) = 1 --> jth valve is normally closed
%
% R. Gomez-Sjoberg 7/14/05

vc_out = vc_in;

if nargin == 1
    unload = 0;
end

for ii = 1:vc_in.num
    vc_out.info(ii).status = usbio24_close(vc_in.info(ii).handle, unload*(ii == vc_in.num));
end
