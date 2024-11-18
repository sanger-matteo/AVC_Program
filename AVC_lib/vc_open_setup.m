function [vc_out] = vc_open_setup(vc_in);
% vc_open_setup
% Open and setup all valve controllers specified in the
% vc struct
%
% [vc_out] = vc_open_setup(vc_in)
%
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

for ii = 1:vc_in.num
    [vc_out.info(ii).status, vc_out.info(ii).handle] = usbio24_open_setup_by_sn(vc_in.info(ii).sn);
end
