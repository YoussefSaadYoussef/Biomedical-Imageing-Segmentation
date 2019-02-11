function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 24-Nov-2018 00:35:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

set(handles.axes6,'visible','off')
set(handles.axes7,'visible','off')
set(handles.axes8,'visible','off')
set(handles.axes5,'visible','off')
set(handles.otsu,'visible','off')
set(handles.Global_Treshold,'visible','off')
set(handles.region,'visible','off')
set(handles.edge,'visible','off')
set(handles.voting,'visible','off')
set(handles.equalization,'visible','off')
set(handles.load,'visible','off')
set(handles.start,'visible','on')
set(handles.p2,'visible','off')
set(handles.p3,'visible','off')


x=imread('back.jpg');
imshow(x,'parent',handles.axes5);

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in otsu.
function otsu_Callback(hObject, eventdata, handles)
% hObject    handle to otsu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes6,'reset')
global i ;
axes(handles.axes7);
imhist(i) ;
xlim([0 260])
ylim([0 2*10^4])
global otsu_t  ;
global thresh ;
[otsu_t,thresh]=Otsus_threshs(i);
axes(handles.axes6)
imshow(otsu_t);
axes(handles.axes7)
line([thresh, thresh], ylim, 'LineWidth', 2, 'Color', 'r');


% --- Executes on button press in Global_Treshold.
function Global_Treshold_Callback(hObject, eventdata, handles)
% hObject    handle to Global_Treshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes6,'reset')
global i ;
global g  ;

g=globalthrsh(i);
imshow(g,'parent',handles.axes6);
axes(handles.axes7);
imhist(i) ;


% --- Executes on key press with focus on Global_Treshold and none of its controls.
function Global_Treshold_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Global_Treshold (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in region.
function region_Callback(hObject, eventdata, handles)
% hObject    handle to region (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes6,'reset')
global i  ;
global r  ;
axes(handles.axes6);
r=regGrow(i);
imshow(r,'parent',handles.axes6);
axes(handles.axes7);
imhist(i) ;

% --- Executes on button press in edge.
function edge_Callback(hObject, eventdata, handles)
% hObject    handle to edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes6,'reset')
global i ;
axes(handles.axes6);
e=edge_detect(i);
imshow(e)
axes(handles.axes7);
imhist(i) ;



% --- Executes on button press in voting.
function voting_Callback(hObject, eventdata, handles)
% hObject    handle to voting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes6,'reset')
global g  ;
global r   ;
global otsu_t  ;
global i ;
m=majVoting(g,r,otsu_t);
axes(handles.axes6);
imshow(m)
axes(handles.axes7);
imhist(i) ;

% --- Executes on button press in equalization.
function equalization_Callback(hObject, eventdata, handles)
% hObject    handle to equalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes6,'reset')
cla(handles.axes7,'reset')
global i 
axes(handles.axes6);
he=hisEqu(i);
imshow(he,[])
axes(handles.axes7);
imhist(histeq(i))


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes6,'reset')
cla(handles.axes7,'reset')
cla(handles.axes8,'reset')

global i ;
path =imgetfile();
i=imread(path);
if size(i,3)==3
i=rgb2gray(i);
end
axes(handles.axes8);
imshow(i,[])
axes(handles.axes7);
imhist(i) ;

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes5,'reset')
set(handles.axes5,'visible','off')
set(handles.otsu,'visible','on')
set(handles.Global_Treshold,'visible','on')
set(handles.region,'visible','on')
set(handles.edge,'visible','on')
set(handles.voting,'visible','on')
set(handles.equalization,'visible','on')
set(handles.load,'visible','on')
set(handles.p2,'visible','on')
set(handles.p3,'visible','on')
set(handles.start,'visible','off')
