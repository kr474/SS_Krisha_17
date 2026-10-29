
function A17_Linear_Nonlinear_GUI
% A17: Linear vs Non-Linear System Demo
% Complete MATLAB GUI project

clc;
close all;

% Create main window
fig = uifigure('Name','A17 - Linear vs Non-Linear Systems', ...
    'Position',[100 80 1100 700]);

tabs = uitabgroup(fig,'Position',[10 10 1080 680]);
tab1 = uitab(tabs,'Title','System Linearity Test');
tab2 = uitab(tabs,'Title','Linearization Tool');

%% TAB 1: SYSTEM LINEARITY TEST

uilabel(tab1,'Position',[20 625 250 25], ...
    'Text','Select a system:','FontSize',14);

systemDrop = uidropdown(tab1, ...
    'Position',[180 625 340 28], ...
    'Items',{'y = x^2', ...
             'y = abs(x)', ...
             'y = x + 2', ...
             'y[n] = x[n] cos(pi*n)', ...
             'y = dx/dt'}, ...
    'Value','y = x^2');

uibutton(tab1,'push', ...
    'Text','Run 3 Random Tests', ...
    'Position',[550 625 180 30], ...
    'ButtonPushedFcn',@runTests);

statusLabel = uilabel(tab1, ...
    'Position',[750 625 300 30], ...
    'Text','Ready to test', ...
    'FontWeight','bold');

axInput = uiaxes(tab1,'Position',[35 350 480 240]);
title(axInput,'Input Signals');
xlabel(axInput,'Time / Sample n');
ylabel(axInput,'Amplitude');
grid(axInput,'on');

axOutput = uiaxes(tab1,'Position',[560 350 480 240]);
title(axOutput,'System Output');
xlabel(axOutput,'Time / Sample n');
ylabel(axOutput,'Amplitude');
grid(axOutput,'on');

uilabel(tab1,'Position',[35 305 300 25], ...
    'Text','Superposition Test Results','FontSize',14, ...
    'FontWeight','bold');

resultsBox = uitextarea(tab1, ...
    'Position',[35 25 1000 270], ...
    'Editable','off', ...
    'Value',{'Select a system and click Run 3 Random Tests.'});

%% TAB 2: LINEARIZATION TOOL

uilabel(tab2,'Position',[25 625 1000 28], ...
    'Text','First-order linearization of y = sin(x)', ...
    'FontSize',16,'FontWeight','bold');

uilabel(tab2,'Position',[25 590 1000 25], ...
    'Text',['Compare approximations at x0 = 0 and x0 = pi/4. ' ...
    'Then examine error versus input amplitude.']);

axLin = uiaxes(tab2,'Position',[35 330 1000 235]);
title(axLin,'Actual Function and Linear Approximations');
xlabel(axLin,'x (radians)');
ylabel(axLin,'y');
grid(axLin,'on');

axError = uiaxes(tab2,'Position',[35 35 1000 235]);
title(axError,'Maximum Absolute Error vs Input Amplitude');
xlabel(axError,'Input Amplitude A (radians)');
ylabel(axError,'Maximum Absolute Error');
grid(axError,'on');

% Draw linearization plots when the tab is opened
drawLinearization();

%% CALLBACK: TEST THE SELECTED SYSTEM

    function runTests(~,~)

        selected = systemDrop.Value;

        % Use sample index for the discrete-time system
        if strcmp(selected,'y[n] = x[n] cos(pi*n)')
            coord = -10:10;
        else
            coord = linspace(-5,5,201);
        end

        dt = coord(2)-coord(1);

        % Use random signals for the three test pairs
        rng('shuffle');

        outputLines = {
            ['Selected system: ' selected]
            ' '
            'Superposition: T(a*x1 + b*x2) = a*T(x1) + b*T(x2)'
            ' '
        };

        errors = zeros(1,3);

        % Store first test signals for plotting
        firstX1 = [];
        firstX2 = [];
        firstY = [];

        for k = 1:3

            x1 = randn(size(coord));
            x2 = randn(size(coord));

            a = 2*rand()-1;
            b = 2*rand()-1;

            % Apply the system to each input
            y1 = systemOutput(selected,x1,coord,dt);
            y2 = systemOutput(selected,x2,coord,dt);

            % Left side: T(a*x1 + b*x2)
            combinedInput = a*x1 + b*x2;
            leftSide = systemOutput( ...
                selected,combinedInput,coord,dt);

            % Right side: a*T(x1) + b*T(x2)
            rightSide = a*y1 + b*y2;

            % Maximum absolute superposition error
            errors(k) = max(abs(leftSide-rightSide));

            outputLines{end+1} = sprintf( ...
                'Test %d: a = %.3f, b = %.3f',k,a,b);

            outputLines{end+1} = sprintf( ...
                'Maximum error = %.6g',errors(k));

            if errors(k) < 1e-8
                outputLines{end+1} = 'Result: PASS';
            else
                outputLines{end+1} = 'Result: FAIL';
            end

            outputLines{end+1} = ' ';

            if k == 1
                firstX1 = x1;
                firstX2 = x2;
                firstY = leftSide;
            end

        end

        % Display average error and overall numerical result
        outputLines{end+1} = sprintf( ...
            'Average error = %.6g',mean(errors));

        if all(errors < 1e-8)
            statusLabel.Text = 'Numerical result: PASS';
        else
            statusLabel.Text = 'Numerical result: FAIL';
        end

        resultsBox.Value = outputLines;

        % Plot the first random pair
        cla(axInput);
        plot(axInput,coord,firstX1,'LineWidth',1.3);
        hold(axInput,'on');
        plot(axInput,coord,firstX2,'LineWidth',1.3);
        hold(axInput,'off');
        legend(axInput,{'x1','x2'},'Location','best');
        title(axInput,'First Random Input Pair');
        grid(axInput,'on');

        cla(axOutput);
        plot(axOutput,coord,firstY,'LineWidth',1.5);
        title(axOutput, ...
            'Output T(a*x1 + b*x2)');
        legend(axOutput,{'Combined input output'}, ...
            'Location','best');
        grid(axOutput,'on');

    end

%% FUNCTION: SYSTEM DEFINITIONS

    function y = systemOutput(name,x,coord,dt)

        switch name

            case 'y = x^2'
                y = x.^2;

            case 'y = abs(x)'
                y = abs(x);

            case 'y = x + 2'
                y = x + 2;

            case 'y[n] = x[n] cos(pi*n)'
                y = x .* cos(pi*coord);

            case 'y = dx/dt'
                % Numerical approximation of derivative
                y = gradient(x,dt);

            otherwise
                error('Unknown system selected.');

        end

    end

%% LINEARIZATION TOOL

    function drawLinearization()

        % Operating points
        x01 = 0;
        x02 = pi/4;

        % First-order Taylor approximation:
        % L(x) = sin(x0) + cos(x0)*(x-x0)

        x = linspace(-1.5,2.8,600);

        actual = sin(x);
        approx1 = sin(x01) + cos(x01)*(x-x01);
        approx2 = sin(x02) + cos(x02)*(x-x02);

        cla(axLin);

        plot(axLin,x,actual,'LineWidth',2);
        hold(axLin,'on');
        plot(axLin,x,approx1,'--','LineWidth',1.6);
        plot(axLin,x,approx2,'-.','LineWidth',1.6);
        hold(axLin,'off');

        legend(axLin, ...
            {'Actual sin(x)', ...
             'Linearized at x0 = 0', ...
             'Linearized at x0 = pi/4'}, ...
             'Location','best');

        grid(axLin,'on');

        % Error against input amplitude
        amplitudes = 0.05:0.05:1.5;

        error1 = zeros(size(amplitudes));
        error2 = zeros(size(amplitudes));

        for i = 1:length(amplitudes)

            A = amplitudes(i);

            % Perturbation around each operating point
            delta = linspace(-A,A,501);

            % At x0 = 0
            true1 = sin(x01 + delta);
            linear1 = sin(x01) + cos(x01)*delta;
            error1(i) = max(abs(true1-linear1));

            % At x0 = pi/4
            true2 = sin(x02 + delta);
            linear2 = sin(x02) + cos(x02)*delta;
            error2(i) = max(abs(true2-linear2));

        end

        cla(axError);

        plot(axError,amplitudes,error1, ...
            'LineWidth',1.8);
        hold(axError,'on');

        plot(axError,amplitudes,error2, ...
            'LineWidth',1.8);

        hold(axError,'off');

        legend(axError, ...
            {'Error at x0 = 0', ...
             'Error at x0 = pi/4'}, ...
             'Location','best');

        grid(axError,'on');

    end

end
