function my_stopwatch

global vc chipdata

 
%while chipdata.exp_status == 1
%    t_exp = clock;
%    set(handles.Tot_Timer, 'String' , datestr(clock,'hh : MM : ss'))
%    pause(0.1)   
%end

toc_it = set(handles.Tot_Timer,'String',toc);
t = timer('TimerFcn',toc_it, 'Period', 1.0);
tic
start(t);


end

