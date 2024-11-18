function varargout = MS7Chip(varargin)
%MS7CHIP M-file for MS7Chip.fig
%      MS7CHIP, by itself, creates a new MS7CHIP or raises the existing
%      singleton*.
%
%      H = MS7CHIP returns the handle to a new MS7CHIP or the handle to
%      the existing singleton*.
%
%      MS7CHIP('Property','Value',...) creates a new MS7CHIP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to MS7Chip_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MS7CHIP('CALLBACK') and MS7CHIP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MS7CHIP.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MS7Chip

% Last Modified by GUIDE v2.5 23-Jan-2016 18:18:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MS7Chip_OpeningFcn, ...
                   'gui_OutputFcn',  @MS7Chip_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MS7Chip is made visible.
function MS7Chip_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% Choose default command line output for MS7Chip
handles.output = hObject;

%%%

global vc;
global chipdata;

%% Parameters for connecting to two controller boxes
% Number of boxes
vc.num = 2;

% Serial number of USB interface in box #1
vc.info(1).sn = 'ELZ26DJK';     % My System - valves 0-23
vc.info(1).handle = 0;
vc.info(1).status = 0;
vc.info(1).polarity = logical([ones(1, 24)]);

% Serial number of USB interface in box #2
vc.info(2).sn = 'ELYLE6IZ';     % My system first valves 24-47
vc.info(2).handle = 0;
vc.info(2).status = 0;
vc.info(2).polarity = logical([ones(1, 3)]);

%% OPEN CONNECTION TO CONTROLLER BOXES
vc = vc_open_setup(vc);
% Check status of both connections
disp(['Status of box#1 = ' num2str(vc.info(1).status)]);
disp(['Status of box#2 = ' num2str(vc.info(2).status)]);

%% SPECIFY NEEDED PARAMETERS
chipdata.No_Valves = 26; % Specify the number of valves this chip has

chipdata.P01v01 = 1 ;           % set pump valve #s here
chipdata.P01v02 = 2 ;           % set pump valve #s here
chipdata.P01v03 = 3 ;           % set pump valve #s here
chipdata.P01NoCyc = 100 ;       % should match default values on .fig
chipdata.P01timing = 100/1000 ; % should match default values on .fig

% Valves buttons colors
chipdata.color.valve_close = [0.9 0 0];             % red
chipdata.color.valve_open = [0 0.9 0];              % green

%General buttons colors
chipdata.color.button_ready =[0.94 0.94 0.94];      % grey
chipdata.color.button_busy = [0.9 0 0] ;            % red
chipdata.color.button_on =[0 0.9 0];                % green

% Observation Chambers colors
chipdata.color.O_chmb_empty = [0 0.9 0.9] ;         % cyan
chipdata.color.O_chmb_cells = [1 0.6 0.2] ;         % orange
chipdata.color.O_chmb_wash  = [1 0 0 ] ;            % red
chipdata.color.O_chmb_r_new = [0.2 0.9 0.2] ;       % m. green
chipdata.color.O_chmb_r_used = [0.8 0.2 0.2] ;      % d. red

% Main Chamber colors
chipdata.color.M_chmb_close = [1 0.6 0.2] ;         % orange
chipdata.color.M_chmb_open =  [0 0.9 0.9] ;         % cyan


% need to MANUALLY set to # of valves
chipdata.names={'V_01','V_02','V_03','V_04','V_05','V_06','V_07','V_08',...
    'V_09','V_10','V_11','V_12','V_13','V_14','V_15','V_16','V_17','V_18',...
    'V_19','V_20','V_21','V_22','V_23','V_24','V_25','V_26'};

% MANUALLY specify here so that other commands will update button color
chipdata.aux_names={'Cell_Remote', 'Cell_Chamber_Bypass_Remote', ...
    'bottom_flow', 'top_flow', 'cc_01', 'cc_02', 'cc_03', 'cc_04', 'cc_05', 'cc_06',...
    'cc_07', 'cc_08', 'cc_09', 'cc_10'};

%need to MANUALLY set to # of valves    
chipdata.All_valves = [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,...
    18,19,20,21,22,23,24,25,26];
%%%

% Valve Names 
chipdata.Pump = [1,2,3] ;
chipdata.in_A = 4 ;
chipdata.in_B = 6 ;
chipdata.in_C = 7 ;
chipdata.A_to_B = 5 ;
chipdata.out1 = 13 ;
chipdata.out2 = 11 ;
chipdata.out2 = 10 ;

chipdata.M_Chmb_In = 8 ;
chipdata.M_Chmb_Out = 9 ;
chipdata.Harvest1 = 12 ;
chipdata.Harvest2 = 14 ;
chipdata.Obs_Chmb = [15:26] ;

chipdata.W_time = 0 ;  % [s], time to flush and wash chamber
chipdata.F_time = 0 ;  % [min], time to wait for a closed growth chamber
                       % to create new swarmer cells
chipdata.sele_C = 0 ;  % selected chamber from the popoup menu

chipdata.exp_status = 1 ;
chipdata.t = timer('TimerFcn', @Tot_Timer, 'Period', 1.0, 'ExecutionMode', 'fixedRate');
tic
start(chipdata.t);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MS7Chip wait for user response (see UIRESUME)
% uiwait(handles.figure1);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t = datestr(now,'yymmdd') ;
global log_file_name ;       log_file_name = ['AVC_code/', t, '_Log_MS7.txt'];

fileID = fopen(log_file_name,'wt');
fprintf(fileID, '\n\n----------------- LOG FILE EXPERIMENT ON CHIP MS7 ----------------------------\n\n' );
fprintf(fileID, ' ->  File Name :     %s \n', log_file_name);
fprintf(fileID, ' ->  Program :       MS7CHIP.m \n' );
fprintf(fileID, ' ->  GUI :           MS7CHIP.fig \n' );
fprintf(fileID, ' ->  Start Date :    %s \n', datestr(now,'dd-mm-yyyy') );
fprintf(fileID, ' ->  End Date :      XXXXX \n' );
fprintf(fileID, ' ->  Duration :      YYYYY \n\n\n' );
fprintf(fileID, '------------------------------------------------------------------------------\n' );
fprintf(fileID, '   yy.mm.dd    hh:MM:ss            Info on Command executed\n' );
fprintf(fileID, '==============================================================================\n' );

fclose(fileID);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Outputs from this function are returned to the command line.
function varargout = MS7Chip_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;

function edit_F_time_Callback(hObject, eventdata, handles)
% On typing in edit area, save the filling time value [minutes]
global chipdata
chipdata.F_time = str2double(get(hObject,'String'));
clear chipdata

function edit_W_time_Callback(hObject, eventdata, handles)
% On typing in edit area, save the washing time value [seconds]
global chipdata
chipdata.W_time = str2double(get(hObject,'String'));
clear chipdata

function popupmenu_Chmb_Callback(hObject, eventdata, handles)
% On selection change in popupmenu_Chmb, save the Chamber number
global chipdata
chipdata.sele_C = get(hObject,'Value') +14 ;
clear chipdata




%% ---- MAIN BUTTON FUNCTIONS -------------------------------------------%%

function Fill_Chamber_XX_Callback(hObject, eventdata, handles)
% Fill observation chamber with swarmers, after F_time for division of newborn
global vc chipdata log_file_name;
t2 = 5 ;      % [sec]
ObC_num = chipdata.sele_C ;
C_panel = ['handles.uipanel_C' num2str(ObC_num -14)] ;
set(hObject, 'BackgroundColor', chipdata.color.button_busy);      % set button BUSY
% Deactivate buttons
set(handles.Wash_Chamber_XX , 'Enable', 'off');
set(handles.Fill_Chamber_XX , 'Enable', 'off');
set(handles.GROWTH_MODE , 'Enable', 'off');
set(handles.Load_Cells , 'Enable', 'off');
set(handles.STOP_FLOW , 'Enable', 'off');

% Close Main Chamb and wait for prediv cells to generate new swarmers               
CLOSE_valves([5, 8, 9, 14, 04], hObject, eventdata, handles);               % close 
OPEN_valves([1, 2, 3, 7, 6], hObject, eventdata, handles);                      % open 
set(handles.M_Chamb_Text , 'String', ['New swarmer are dividing'] );
set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_close );

set(handles.Status_Text , 'String', [' Filling... ']);
set(handles.Load_Bar, 'BackgroundColor', [0 0.5 1]);
pos = get(handles.Load_Bar, 'Position');
width = pos(3);
step = width / [chipdata.F_time + t2];
pos(3) = 0.01;
set(handles.Load_Bar, 'Position', pos);
for j = 1 : chipdata.F_time
    pause(1) ;
    pos(3) = pos(3) + step ;
    set(handles.Load_Bar, 'Position', pos) ;
end

% Transfer swarmers in Observation chamber C_num
CLOSE_valves([7, 10, 11], hObject, eventdata, handles);             % close 
OPEN_valves([6, 8, 9, 12, 13, ObC_num], hObject, eventdata, handles);     % open 
set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_open );
set(handles.M_Chamb_Text , 'String', ['Transfering in Chamber: ' num2str(ObC_num)] );
set(eval(C_panel) , 'BackgroundColor', chipdata.color.O_chmb_wash );
set(eval(C_panel)  , 'HighlightColor', chipdata.color.O_chmb_r_used );
for j = 1 : t2
    pause(1) ;
    pos(3) = pos(3) + step ;
    set(handles.Load_Bar, 'Position', pos) ;
end

% Close Observation chamber and set again Growth Flow on
CLOSE_valves([12, 13, 14, ObC_num], hObject, eventdata, handles); 
OPEN_valves([11], hObject, eventdata, handles);    

set(handles.Status_Text , 'String', ['Chambers status']);
set(handles.Load_Bar, 'BackgroundColor', [0.9 0.9 0.9]);
set(hObject, 'BackgroundColor', chipdata.color.button_ready);

% Reactivate Buttons
set(handles.Wash_Chamber_XX , 'Enable', 'on');
set(handles.Fill_Chamber_XX , 'Enable', 'on');
set(handles.GROWTH_MODE , 'Enable', 'on');
set(handles.Load_Cells , 'Enable', 'on');
set(handles.STOP_FLOW , 'Enable', 'on');
GROWTH_MODE_Callback(handles.GROWTH_MODE, eventdata, handles)

% Update Log_File with executed FILL command
fileID = fopen(log_file_name,'at');
fprintf(fileID, '   %s    --->    FILL  -  Chmb: %d ,   wait = %d ,    \n',...
        datestr(now,'yy.mm.dd -- hh:MM:ss'), ObC_num , chipdata.F_time );
fclose(fileID);
clear vc chipdata



function Wash_Chamber_XX_Callback(hObject, eventdata, handles)
% Wash a specific Observation chamber for the amount of W_time specified.
global vc chipdata log_file_name;
ObC_num = chipdata.sele_C ;
t2 = 10 ;       % [sec]
set(hObject, 'BackgroundColor', chipdata.color.button_busy) ;
C_panel = ['handles.uipanel_C' num2str(ObC_num - 14)] ;
% Deactivate buttons
set(handles.Wash_Chamber_XX , 'Enable', 'off');
set(handles.Fill_Chamber_XX , 'Enable', 'off');
set(handles.GROWTH_MODE , 'Enable', 'off');
set(handles.Load_Cells , 'Enable', 'off');
set(handles.STOP_FLOW , 'Enable', 'off');

% Prepare and wait a bit for flow from inA to be 13 to be on and regular
CLOSE_valves([5, 12, ObC_num], hObject, eventdata, handles);
OPEN_valves([4, 14, 13], hObject, eventdata, handles);

set(handles.Status_Text , 'String', [' Washing... '] );
set(handles.Load_Bar, 'BackgroundColor', [0 0.5 1]);
pos = get(handles.Load_Bar, 'Position');
width = pos(3);
step = width / [chipdata.W_time + t2];
pos(3) = 0.01;
set(handles.Load_Bar, 'Position', pos);
for j = 1 : t2
    pause(1) ;
    pos(3) = pos(3) + step ;
    set(handles.Load_Bar, 'Position', pos) ;
end
% Divert flow to inA---Obs._chamber---13
CLOSE_valves([14], hObject, eventdata, handles);
OPEN_valves([ObC_num], hObject, eventdata, handles);
set(eval(C_panel) , 'BackgroundColor', chipdata.color.O_chmb_wash );
for j = 1 : chipdata.W_time
    pause(1) ;
    pos(3) = pos(3) + step ;
    set(handles.Load_Bar, 'Position', pos) ;
end
% Close Chamber
CLOSE_valves([ObC_num], hObject, eventdata, handles);
set(hObject, 'BackgroundColor', chipdata.color.button_ready) ;
set(eval(C_panel) , 'BackgroundColor', chipdata.color.O_chmb_empty );

set(handles.Status_Text , 'String', ['Chambers status']);
set(handles.Load_Bar, 'BackgroundColor', [0.9 0.9 0.9]);

% Reactivate Buttons
set(handles.Wash_Chamber_XX , 'Enable', 'on');
set(handles.Fill_Chamber_XX , 'Enable', 'on');
set(handles.GROWTH_MODE , 'Enable', 'on');
set(handles.Load_Cells , 'Enable', 'on');
set(handles.STOP_FLOW , 'Enable', 'on');
GROWTH_MODE_Callback(handles.GROWTH_MODE, eventdata, handles)

% Update Log_File with executed WASH command
fileID = fopen(log_file_name,'at');
fprintf(fileID, '   %s    --->    WASH  -  Chmb: %d ,   wash time = %d  \n',...
        datestr(now,'yy.mm.dd -- hh:MM:ss'), ObC_num , chipdata.W_time );
fclose(fileID);
clear vc chipdata



function GROWTH_MODE_Callback(hObject, eventdata, handles)
% Set a direct path InB---MChamb---out2 to feed cells in M chamb.
global vc chipdata log_file_name;
set(handles.GROWTH_MODE , 'Enable', 'off', 'BackgroundColor', chipdata.color.button_on );
set(handles.Load_Cells , 'Enable', 'off');
set(handles.STOP_FLOW , 'Enable', 'on', 'BackgroundColor', chipdata.color.button_ready);

% open path inB---MainChamb---out3 and close everything else
OPEN_valves([1,2,3,6,8,9,11], hObject, eventdata, handles);    
CLOSE_valves([5,7,14,13,12,10], hObject, eventdata, handles);  
set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_open );
set(handles.M_Chamb_Text , 'String', ['>---- Chmb OPEN ---->'] , 'ForegroundColor' , [0 0.3 0.5]);

% Close all Observation chambers
for C_ith = 15:26                       
    vc = vc_set_1bit(vc, C_ith, 0);
    [vc, value] = vc_get_1bit(vc, C_ith);
    set(eval(['handles.V_', num2str( C_ith )]) , 'BackgroundColor', chipdata.color.valve_close);
end

% Update Log_File with executed GROWTH command
fileID = fopen(log_file_name,'at');
fprintf(fileID, '   %s    --->    Growth Mode \n',...
        datestr(now,'yy.mm.dd -- hh:MM:ss'));
fclose(fileID);
clear vc chipdata


function STOP_FLOW_Callback(hObject, eventdata, handles)
% Divert media flow and isolate M Chamb.
global vc chipdata log_file_name;
set(handles.STOP_FLOW, 'Enable', 'on', 'BackgroundColor', chipdata.color.button_on ); 
set(handles.GROWTH_MODE, 'Enable', 'on', 'BackgroundColor', chipdata.color.button_ready);
set(handles.Load_Cells , 'Enable', 'on');

% Open path inB---inC and close everything else
OPEN_valves([1,2,3,6,7], hObject, eventdata, handles);              
CLOSE_valves([8,9,10,11,12], hObject, eventdata, handles);  

set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_close );
set(handles.M_Chamb_Text , 'String', ['||--- Chmb CLOSE ---||'] , 'ForegroundColor' , [0.7 0.1 0.1]);

% Update Log_File with executed STOP command
fileID = fopen(log_file_name,'at');
fprintf(fileID, '   %s    --->    STOP flow \n',...
        datestr(now,'yy.mm.dd -- hh:MM:ss'));
fclose(fileID);
clear vc chipdata



function Load_Cells_Callback(hObject, eventdata, handles)
% Load cells in M chambers (supply from inlet C).
global vc chipdata log_file_name;
t1 = 5;     % [sec]
t2 = 5;     % [sec]
set(hObject, 'BackgroundColor', [1 0.6 0.2] );
set(handles.GROWTH_MODE , 'Enable', 'off');
set(handles.STOP_FLOW , 'Enable', 'off', 'BackgroundColor', chipdata.color.button_ready);
set(handles.Load_Cells , 'Enable', 'off');

% close everything else 
CLOSE_valves([5,6,7,11,12],hObject, eventdata, handles);

set(handles.Status_Text , 'String', [' Loading Cells... '] );
set(handles.Load_Bar, 'BackgroundColor', [0 0.5 1]);
pos = get(handles.Load_Bar, 'Position');
width = pos(3);
step = width / [t1 + t2];
pos(3) = 0.01;
set(handles.Load_Bar, 'Position', pos);
for j = 1 : t1
    pause(1) ;
    pos(3) = pos(3) + step ;
    set(handles.Load_Bar, 'Position', pos) ;
end

% Load cells throught path inC---7---Main chamb---out3 .
OPEN_valves([7,8,9,10],hObject, eventdata, handles);                
set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_open );
set(handles.M_Chamb_Text , 'String', ['... Chmb Loading ...'] , 'ForegroundColor' , [0.7 0.1 0.1]);
set(hObject, 'BackgroundColor', chipdata.color.button_on , 'ForegroundColor' , [0 0 0]);
for j = 1 : t2
    pause(1) ;
    pos(3) = pos(3) + step ;
    set(handles.Load_Bar, 'Position', pos) ;
end
set(handles.Status_Text , 'String', [' Chamber Status... '] );
set(handles.Load_Bar, 'BackgroundColor', [0.9 0.9 0.9]);

% Close inC and Main chamber
CLOSE_valves([8,9,7],hObject, eventdata, handles);                 
set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_close );
set(handles.M_Chamb_Text , 'String', ['||--- Chmb CLOSE ---||'] , 'ForegroundColor' , [0.7 0.1 0.1]);
set(hObject, 'BackgroundColor', [1 0.84 0]);

% Update Log_File with executed GROWTH command
fileID = fopen(log_file_name,'at');
fprintf(fileID, '   %s    --->    Loading Cells :   time: %d  \n',...
        datestr(now,'yy.mm.dd -- hh:MM:ss'), t2 );
fclose(fileID);

set(handles.GROWTH_MODE , 'Enable', 'on');
set(handles.STOP_FLOW , 'Enable', 'on');
set(handles.Load_Cells , 'Enable', 'on');

clear vc chipdata



function CLOSE_ALL_Callback(hObject, eventdata, handles)
% On CLOSE ALL button press, all valves are closed
global vc chipdata log_file_name
numbers = 0:(chipdata.No_Valves -1);
values =  zeros(1, chipdata.No_Valves);
vc = vc_set_bits_ac(vc, numbers, values);
for i= 1 : chipdata.No_Valves;
    set(handles.(chipdata.names{(i)}), 'BackgroundColor', chipdata.color.valve_close); % resets color of buttons
    pause(0.05);
end
set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_close );
set(handles.M_Chamb_Text , 'String', ['||--- Chmb CLOSE ---||'] , 'ForegroundColor' , [0.7 0.1 0.1]);
clear vc chipdata



% --- Executes on button press in Open_All.
function OPEN_ALL_Callback(hObject, eventdata, handles)
% On OPEN ALL button press, all valves are opened
global vc chipdata log_file_name
numbers2 = 0:(chipdata.No_Valves -1);
values =  ones(1, chipdata.No_Valves);
vc = vc_set_bits_ac(vc, numbers2, values);
for j = 1 : chipdata.No_Valves;    
    set(handles.(chipdata.names{(j)}), 'BackgroundColor', chipdata.color.valve_open); % resets color of buttons
    pause(0.05);
end
set(handles.M_Chamb_Text , 'BackgroundColor', chipdata.color.M_chmb_open );
clear vc chipdata




%% ---- REMOTE VALVE OPENING/CLOSING ------------------------------------%%
% switch on/off and change color of mulriple valse at the same time.

function OPEN_valves(NUMBERS,hObject, eventdata, handles)% ***MANUALLY*** % ***MANUALLY*** % ***MANUALLY*** 
global vc chipdata
values = ones(1,length(NUMBERS));
N_v = size(NUMBERS,2);
vc = vc_set_bits_ac(vc, NUMBERS, values);
for i = 1:N_v;
    if values(i)==0;
      set(handles.(chipdata.names{NUMBERS(i)}), 'BackgroundColor', chipdata.color.valve_close);
    elseif values(i)==1;
      set(handles.(chipdata.names{NUMBERS(i)}), 'BackgroundColor', chipdata.color.valve_open);
    end
end
clear vc chipdata


function CLOSE_valves(NUMBERS,hObject, eventdata, handles)% ***MANUALLY*** % ***MANUALLY*** % ***MANUALLY*** 
global vc chipdata
values =  zeros(1,length(NUMBERS));
b = size(NUMBERS,2);
vc = vc_set_bits_ac(vc, NUMBERS, values);
for i = 1:b;
    if values(i)==0;
      set(handles.(chipdata.names{NUMBERS(i)}), 'BackgroundColor', chipdata.color.valve_close);
    elseif values(i)==1;
      set(handles.(chipdata.names{NUMBERS(i)}), 'BackgroundColor', chipdata.color.valve_open);
    end
end
clear vc chipdata




%% --- BASIC VALVE FUNCTION ---------------------------------------------%%

function V_XX_Callback(hObject, eventdata, handles)
% Basic function to specifically control a single valve open/close state
global vc chipdata;
V_num = str2double(get(hObject,'String'));
[vc, value] = vc_get_1bit(vc, V_num);
if value == 1
    vc = vc_set_1bit(vc, V_num, 0);
    [vc, value] = vc_get_1bit(vc, V_num);
    set(hObject, 'BackgroundColor', chipdata.color.valve_close);
else   %if value == 0
    vc = vc_set_1bit(vc, V_num, 1);
    [vc, value] = vc_get_1bit(vc, V_num);
    set(hObject, 'BackgroundColor', chipdata.color.valve_open);
end
clear vc chipdata




%% --- EXECUTE ON PRESS OF SPECIFIC VALVE V_XX BUTTON -------------------%%

function V_01_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_02.
function V_02_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_03.
function V_03_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_04.
function V_04_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_05.
function V_05_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_06.
function V_06_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_07.
function V_07_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_08.
function V_08_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_09.
function V_09_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_10.
function V_10_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_11.
function V_11_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_12.
function V_12_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_13.
function V_13_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_14.
function V_14_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_15.
function V_15_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_16.
function V_16_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_17.
function V_17_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_18.
function V_18_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_19.
function V_19_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_20.
function V_20_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_21.
function V_21_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_22.
function V_22_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_23.
function V_23_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_24.
function V_24_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_25.
function V_25_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata


% --- Executes on button press in V_26.
function V_26_Callback(hObject, eventdata, handles)
global vc chipdata;
V_XX_Callback(hObject, eventdata, handles) %executes the called function
clear vc chipdata

% ----------------------------------------------------------------------

% --- Executes on button press in Safe_Switch.
function Safe_Switch_Callback(hObject, eventdata, handles)
global vc chipdata;
if get(hObject, 'Value') == 0        % Disable all buttons
    act = 'off' ;
    set(hObject, 'String', 'OFF', 'BackgroundColor', [1 0.25 0.25]);
elseif get(hObject, 'Value') == 1    % Enable all button
    act = 'on' ;
    set(hObject, 'String', 'ON', 'BackgroundColor', [0.1 1 0.1]);
end
% Switch ON/OFF all general and valves buttons
set(handles.Wash_Chamber_XX , 'Enable', act);
set(handles.Fill_Chamber_XX , 'Enable', act);
set(handles.edit_F_time , 'Enable', act);
set(handles.edit_W_time , 'Enable', act);
set(handles.GROWTH_MODE , 'Enable', act);
set(handles.Load_Cells , 'Enable', act);
set(handles.STOP_FLOW , 'Enable', act);
set(handles.OPEN_ALL , 'Enable', act);
set(handles.CLOSE_ALL , 'Enable', act);
set(handles.popupmenu_Chmb , 'Enable', act);
for i = 1 : chipdata.No_Valves;
    set(handles.(chipdata.names{(i)}), 'Enable', act);
end


function Tot_Timer(~,~,handles)
h = guidata(handles)
toc
set(h.Tot_Timer,'String', datestr(toc / 86400,'HH : MM : SS'));



% --- Executes on button press in Quit.
%function Quit_Callback(hObject, eventdata, handles)
%global vc;
%opt = YesNoQuestion('Title', 'Close Controllers', 'String', ...
%    'Are you sure you want to Close Valve Controllers?');
%switch lower(opt)
%    case 'yes'
%        vc = vc_close(vc, 1);
%        'contollers closed'
%end
%clear vc
  
