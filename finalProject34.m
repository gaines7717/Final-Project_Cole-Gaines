function [ ] = finalProject34( )

% Final Project: My final project is the default program. It is an
% automated graphing application; it allows for a user input of 
% graphing color, graphing style, plot title and axis titles, a reset graph
% and user input function, a quit function, etc. To use, enter coordinates
% into the x and y edit boxes (each must have same amount of coordiantes
% with no letters or special characters other than "."  or "," or
% spaces). Then select your desired line style and line/point color. Then
% add a title name and axis names, via the edit boxes. Finally, press
% graph. When finished with the application, you can press QUIT, located
% in the upper left corner. 

% Initiate global variable
global gui;

% Set up a figure where the information
% will be presented to the user and on which all of the ui controls
% and the graph wil live. Also, line 11 will position the figure at a 
% particular location on the screen
gui.fig = figure();
set(gcf,'position',[300,300,550,400]);
            % gui.fig = figure( 'Renderer', 'painters', 'Position', [10 10 900 600]);


% Create a blank plot with center (0,0) by plotting (0,0) with no visible
% indication on the plot itself; this will allow the user to start with a
% blank plot when the app is initulized. Also, line 25 positions the plot
% in the upper right region of the figure, so that there is space to
% include the user inputs. 
gui.plotFinal = plot(0,0);
hold on
            % set(gcf,'position',[300,300,550,400]);
            % gui.table = set(gca,'xtick',[1 5 9 10]);
            % gui.table = set(gca,'xtick',[]);
            % gui.table = set(gca,'ytick',[]);
 set(gca, 'Units','normalized', 'Position',[.3 .35 .65 .60]);

% Added gui.buttonGroup1 which doesn't have functionality; I liked the consistent asthetic it gave
% the application. Instead, I layed the x coordiante and y coordinate edit
% boxes onto the bottonGroup box. 
gui.buttonGroup1 = uibuttongroup('visible','on','units', 'normalized', 'position',[0.005 0.02 .4 .2]');

% The following text sets up the Directions and Edit Box to Input the X postion; it can hold more than
% one number, and can use commas, spaces, or "." without crashing.
% Also, the application will indicate an error if characters other than commas, spaces, ".", "-" or numbers 
% are entered. gui.xEdit also contains a callback function, xPositionInput,
% which will take the inputed characters in the x position and convert them
% into an array to be stored and then graphed when desired
gui.xEdit = uicontrol('style','edit','units','normalized','position',[.17 .15 .15 .05],...
    'fontsize',12, 'fontweight','bold','callback',{@xPositionInput});
gui.xText = uicontrol('style','text','units','normalized','position',[.01 .15 .15 .05],...
    'string','x-position');

% The following text sets up the Directions and Edit Box to Input the Y postion; it can hold more than
% one number, and can use commas, spaces, or "." without crashing.
% Also, the application will indicate an error if characters other than commas, spaces, ".", "-" or numbers 
% are entered. gui.yEdit also contains a callback function, yPositionInput,
% which will take the inputed characters in the y position and convert them
% into an array to be stored and then graphed when desired
gui.yEdit = uicontrol('style','edit','units','normalized','position',[.17 .08 .15 0.05],...
    'fontsize',12, 'fontweight','bold','callback',{@yPositionInput});
gui.yText = uicontrol('style','text','units','normalized','position',[.01 .08 .15 0.05],...
    'string','y-position');

% Sets up a push style button that will 'reset' the graph and other user inputs; this
% means that the graph will be cleared and the input edit boxes will be
% cleared. In order to do this, gui.resetButton has a callback command to
% the function resetButtonPush. This function will be 'resetting' the
% application
gui.resetButton = uicontrol('style','push','units','normalized', 'position',[.72, .065, .26, .05], 'string','Reset Graph and Inputs', 'callback' ,{@resetButtonPush});

% Sets up a push style button to graph the points that the user inputs; In
% order to do this, gui.graphButton has a callback command to the function
% graphCoordinates, which will take the arrays created by and stored by
% gui.yEdit (and its callback function) and gui.xEdit (and its callback
% function) and graph them accordingly.
gui.graphButton = uicontrol('style','push','units','normalized', 'position',[.72, .01, .26, .05], 'string','Graph', 'callback' ,{@graphCoordinates});

% The following code sets up the the global variables, edit boxes, and
% callback functions to allow the user to change the xAxis label, yAxis
% label, and the plot title.
gui.xAxis = uicontrol('style','edit','units','normalized','position',[.68 .14 .3 .05],...
    'fontsize',12, 'fontweight','bold','string','X-Axis Name: ','callback',{@xAxisName});
gui.yAxis = uicontrol('style','edit','units','normalized','position',[.68 .19 .3 .05],...
    'fontsize',12, 'fontweight','bold','string','Y-Axis Name: ', 'callback',{@yAxisName});
gui.Title = uicontrol('style','edit','units','normalized','position',[.68 .24 .3 .05],...
    'fontsize',12, 'fontweight','bold','string','Title Name: ', 'callback',{@titleName});

% The following code sets up a button group with 5 radio-style buttons so
% that the user can pick whether they want their graph to have circle markers, astricks markers,
% a dashed line, a solid line, or a solid line with circle markers.
% I have a callback functions  evaluating whether the gui.r_ is on or
% not and assigns certain plot characteristics based on that information.
% This function is then called in the graphCoordinates function.
gui.buttonGroup2 = uibuttongroup('visible','on','units', 'normalized', 'position',[0.005 0.54 .23 .35]);%, 'selectionchangedfcn',(@LineSelect));
gui.r11 = uicontrol(gui.buttonGroup2,'style','radiobutton','units', 'normalized','position',[.05 .85 1 .2],'HandleVisibility','off','string','Circles');
gui.r12 = uicontrol(gui.buttonGroup2,'style','radiobutton','units', 'normalized','position',[.05 .6 1 .2],'HandleVisibility','off','string','Astricks');
gui.r13 = uicontrol(gui.buttonGroup2,'style','radiobutton','units', 'normalized','position',[.05 .4 1 .2],'HandleVisibility','off','string','Dashed Lines');
gui.r14 = uicontrol(gui.buttonGroup2,'style','radiobutton','units', 'normalized','position',[.05 .2 1 .2],'HandleVisibility','off','string','Solid Line');
gui.r15 = uicontrol(gui.buttonGroup2,'style','radiobutton','units', 'normalized','position',[.05 .0 1 .2],'HandleVisibility','off','string','Solid Line w/ Circles');
gui.buttonGroup2Text = uicontrol('style','text','units','normalized','position',[.01 .89 .2 .04],...
    'string','Line Style');

% The following code sets up a button group with 3 radio-style buttons so
% that the user can pick whether they want their graph to be blue, red, or black.
% I have a callback functions  evaluating whether the gui.r_ is on or
% not and assigns certain plot characteristics based on that information.
% This function is then called in the graphCoordinates function.
gui.buttonGroup3 = uibuttongroup('visible','on','units', 'normalized', 'position',[0.005 0.25 .23 .25]);%, 'selectionchangedfcn',(@ColorSelect));
gui.r21 = uicontrol(gui.buttonGroup3,'style','radiobutton','units', 'normalized','position',[.05 .8 1 .2],'HandleVisibility','off','string','Blue');
gui.r22 = uicontrol(gui.buttonGroup3,'style','radiobutton','units', 'normalized','position',[.05 .45 1 .2],'HandleVisibility','off','string','Red');
gui.r23 = uicontrol(gui.buttonGroup3,'style','radiobutton','units', 'normalized','position',[.05 .1 1 .2],'HandleVisibility','off','string','Black');
gui.buttonGroup3Text = uicontrol('style','text','units','normalized','position',[.01 .5 .2 .04],...
    'string','Line Color');

% The following code sets up a QUIT push-style button. Though not
% functionally necessary to exit the application, I thought it added
% asthetic appeal.
gui.closeFig = uicontrol('style','push','units','normalized', 'position',[.015, .92, .2, .07], 'string','QUIT','FontSize',15, 'callback' ,{@closeFigure});
end

% The following function is a callback fucntion of the radio buttion group 2; this function
% finds the values of each radio button within the button group and makes the global
% plot variable's linestyle match the determination of the user.
            function [ ] = LineSelect (hObject,~)
             global gui;
            if gui.r11.Value
            gui.plotFinal.Marker = 'o';
            gui.plotFinal.LineStyle = 'none';
        elseif gui.r12.Value
             gui.plotFinal.Marker = '*';
             gui.plotFinal.LineStyle = 'none';
        elseif gui.r13.Value
             gui.plotFinal.LineStyle = '--';
        elseif gui.r14.Value
             gui.plotFinal.LineStyle = '-';
        elseif gui.r15.Value
             gui.plotFinal.Marker = 'o';
            end
    end

% The following function is a callback fucntion of the radio buttion group 3; this function
% finds the values of each radio button within the button group and makes the global
% plot variable's color match the determination of the user.
function [ ] = ColorSelect (hObject,~)
            global gui;
              if gui.r21.Value
                gui.plotFinal.Color = 'b';
            elseif gui.r22.Value
                 gui.plotFinal.Color = 'r';
            elseif gui.r23.Value
                 gui.plotFinal.Color = 'k';
              end
end

                    % The following was my first attempt at a colorAndLine function
                    % (a function meant to set the line style and line/point color) based on
                    % what radio buttons were pushed in buttonGroup2 and buttonGroup3. It
                    % didn't work as expected, though, so I moved onto the now operating
                    % solution.
                                % switch gui.ButtonGroup2.SelectedObject.Text
                                %     case 'r11'
                                %         gui.plotFinal.Color = 'b'; 
                                %     case 'r12'
                                %         gui.plotFinal.Color = 'r'; 
                                %     otherwise
                                %         gui.plotFinal.Color = 'k'; 
                                % end
                                % 
                                % switch gui.ButtonGroup3.SelectedObject.Text
                                %     case 'r21' 
                                %         gui.plotFinal.Color = 'b'; 
                                %     case 'r22'
                                %         gui.plotFinal.Color = 'r'; 
                                %     otherwise
                                %         gui.plotFinal.Color = 'k'; 
                                % end
                    % The following was my second attempt at a colorAndLine function
                    % (a function meant to set the line style and line/point color) based on
                    % what radio buttons were pushed in buttonGroup2 and buttonGroup3. It
                    % didn't work as expected, though, so I moved onto the now operating
                    % solution (which is much more concise, easy to read, and simple in design).        
                                % global gui;
                                %     if gui.r11 == true && gui.r21 == true
                                %         gui.lineColor = 'bo';
                                %         elseif gui.r11 == true && gui.r22 == true
                                %             gui.lineColor = 'b*';
                                %             elseif gui.r11 == true && gui.r23 == true
                                %                 gui.lineColor = 'b--';
                                %                 elseif gui.r12 == true && gui.r21 == true
                                %                     gui.lineColor = 'ro';
                                %                     elseif gui.r12 == true && gui.r22 == true
                                %                         gui.lineColor = 'r*';
                                %                         elseif gui.r12 == true && gui.r22 == true
                                %                             gui.lineColor = 'r--';
                                %                             elseif gui.r13 == true && gui.r21 == true
                                %                                 gui.lineColor = 'ko';
                                %                                 elseif gui.r13 == true && gui.r22 == true
                                %                                     gui.lineColor = 'k*';
                                %                                     elseif gui.r13 == true && gui.r23 == true
                                %                                         gui.lineColor = 'k--';
                                %     end

% The following function determines the x coordinates of the graph based on
% the input that the user eneters into the gui.xEdit edit box. To do so, it
% uses regular expressions to determine whether the input has any errors
% (letters or special characters other than "," or "."), then uses regular
% expressions to break apart the numbers into a cell array and delete any
% commas or spaces that may have been present (the function breaks the
% numbers apart based on the commas or spaces present). Finally, the
% function turns the entered string (which has been put into cell arrays)
% into a 'double' (integers).
function [ ] = xPositionInput (hObject, ~, ~)
   global gui;
    strX = get(hObject, 'string');
    checkLetters1 = regexp(strX,'[^0-9\.,\- ]','match');
    if numel(checkLetters1) > 0
            msgbox('X and Y Inputs may only contatin numbers, commas, periods, and spaces!', 'Input Error','error','modal')
    end
    newStrX =  regexprep(strX,'[^0-9+\.\-]',' ');
    newStr2X =  regexprep(newStrX,' {2,}',' ');
    spaceBeginningX = regexprep(newStr2X,'^ ','');
    spaceEndX = regexprep(spaceBeginningX,' $','');
    gui.strX3 = regexp(spaceEndX,'[^0-9+\.\-]', 'split');
    gui.xCoordinates =  str2double(gui.strX3);
end

% The following function determines the y coordinates of the graph based on
% the input that the user eneters into the gui.yEdit edit box. To do so, it
% uses regular expressions to determine whether the input has any errors
% (letters or special characters other than "," or "."), then uses regular
% expressions to break apart the numbers into a cell array and delete any
% commas or spaces that may have been present (the function breaks the
% numbers apart based on the commas or spaces present). Finally, the
% function turns the entered string (which has been put into cell arrays)
% into a 'double' (integers).
function [ ] = yPositionInput (hObject, ~, ~) 
    global gui;
    strY = get(hObject, 'string');
    checkLetters2 = regexp(strY,'[^0-9+\.,\- ]','match');
    if numel(checkLetters2) > 0
            msgbox('X and Y Inputs may only contatin numbers, commas, periods, and spaces!', 'Input Error','error','modal')
    end
    newStrY =  regexprep(strY,'[^0-9+\.\-]',' ');
    newStr2Y =  regexprep(newStrY,' {2,}',' ');
    spaceBeginningY = regexprep(newStr2Y,'^ ','');
    spaceEndY = regexprep(spaceBeginningY,' $','');
    gui.strY3 = regexp(spaceEndY,'[^0-9+\.\-]', 'split');
    gui.yCoordinates = str2double(gui.strY3);
end

% The following function is a callback of the graph push button; this
% function (1) compares the number of distinct numbers in the x and y coordinate
% edit boxes and determines whether there are the same amount of elements
% (if not, it alerts the user of an error), then (2) it plots the points,
% and (3) finally it calls on the colorAndLine function to determine the
% color and line/point style of the graph.
function [ ] = graphCoordinates(~, ~, ~)
global gui;
    if numel(gui.xCoordinates) ~= numel(gui.yCoordinates)
        msgbox('Must Have Same Amount of Elements in X and Y!', 'Input Error','error','modal')
    else
         gui.plotFinal = plot(gui.xCoordinates, gui.yCoordinates);
         ColorSelect
         LineSelect
    end
end

% This funtion is a callback function of the gui.resetButton push-style
% button; this function will first clear the graph and its titles by
% enacting 'hold off' graphing a new blank plot and then enacting 'hold on
% again. Next, it clears the x and y edit boxes by setting their respective
% gui variable's strings to ''. Next, it clears the memory of the
% xCoordinates and yCoordinates variables. Next, it sets the xAxis, yAxis,
% and title edit boxes to their original string composition. 
function [ ] = resetButtonPush(~,~)
    global gui;
    hold off
    gui.table = plot(0,0);
    hold on
    set([gui.xEdit, gui.yEdit], 'string', '');
    gui.xCoordinates = [];
    gui.yCoordinates = [];
    set([gui.xAxis], 'String', 'X-Axis Name: ');
    set([gui.yAxis], 'String', 'Y-Axis Name: ');
    set([gui.Title], 'String', 'Title: ');
end

% This is a callback function gui.xAxis; it sets the graph's x axis label to the
% string that is entered into the edit box.
function [ ] = xAxisName (hObject,~)
xlabel(get(hObject,'string'));
end

% This is a callback function gui.xAxis; it sets the graph's y axis label to the
% string that is entered into the edit box.
function [ ] = yAxisName (hObject,~)
ylabel(get(hObject,'string'));
end

% This is a callback function gui.title; it sets the graph's title to the
% string that is entered into the edit box.
function [ ] = titleName (hObject,~)
title(get(hObject,'string'));
end

% This is a callback function of the gui.closeFig push button; first, it
% calls ont he resetButtonPush function to clear any risidual information
% entered during the applications use. Next it closes the figure.
function [ ] = closeFigure(~,~)
global gui;
resetButtonPush
close(gui.fig);
end
