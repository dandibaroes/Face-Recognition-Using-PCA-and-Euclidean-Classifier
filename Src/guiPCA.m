function varargout = guiPCA(varargin)
% GUIPCA MATLAB code for guiPCA.fig
%      GUIPCA, by itself, creates a new GUIPCA or raises the existing
%      singleton*.
%
%      H = GUIPCA returns the handle to a new GUIPCA or the handle to
%      the existing singleton*.
%
%      GUIPCA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIPCA.M with the given input arguments.
%
%      GUIPCA('Property','Value',...) creates a new GUIPCA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiPCA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiPCA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiPCA

% Last Modified by GUIDE v2.5 18-Jun-2019 11:03:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiPCA_OpeningFcn, ...
                   'gui_OutputFcn',  @guiPCA_OutputFcn, ...
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


% --- Executes just before guiPCA is made visible.
function guiPCA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiPCA (see VARARGIN)

% Choose default command line output for guiPCA
handles.output = hObject;
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('bg.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = guiPCA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axesPic)
cla(handles.axes2)
set(handles.edit2,'String','Name')
        

% --- Executes on button press in browseButton.
function browseButton_Callback(hObject, eventdata, handles)
% hObject    handle to browseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global img
[filename, pathname] = uigetfile({'*.jpg'},'Pilih foto yang ingin di kenali');
img = [pathname, filename];
assignin('base','testimage',img);
im = imread(img);
guidata(hObject,handles);
axes(handles.axesPic);
imshow(im);


% --- Executes on button press in recbutton.
function recbutton_Callback(hObject, eventdata, handles)
% hObject    handle to recbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im img
data_trainLoc = 'E:\Matlab\ISENG\Train';

data_trainAll = getFace(data_trainLoc);
[m, A, Eigen_faces] = Training(data_trainAll);
name_output = Recognizer(img, m, A, Eigen_faces);

img_output = strcat(data_trainLoc,'\',name_output);
img_output = imread(img_output);

guidata(hObject,handles);
axes(handles.axesPic);
imshow(im);

guidata(hObject,handles);
axes(handles.axes2);
imshow(img_output);

if (name_output == "1.jpg" || name_output == "2.jpg" || name_output == "3.jpg" || name_output == "4.jpg")
    kelas = "Ika";
elseif (name_output == "5.jpg" || name_output == "6.jpg" || name_output == "7.jpg" || name_output == "8.jpg")
    kelas = "Ryu";
else (name_output == "9.jpg" || name_output == "10.jpg" || name_output == "11.jpg" || name_output == "12.jpg")
    kelas = "Nai";
end
set(handles.edit2, 'String', kelas);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
