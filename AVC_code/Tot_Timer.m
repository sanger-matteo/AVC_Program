function Tot_Timer(~,~,handle)
set(handles.Tot_Timer,'String', datestr(toc / 86400,'HH : MM : SS'));
end