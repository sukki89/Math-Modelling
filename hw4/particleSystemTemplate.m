% Code to generate a particle system that simulates collisions with a sine
% curve, using the Matlab builtin fzero function.

% Boundaries in the plot.
minX = -10;
maxX = +10;
minY = 0;
maxY = +20;

% Initial velocity limits.
minV = -5;
maxV = +5;    % Apply for both x and y components.

% Particles array.
particlesCount = 5;
for I = 1:particlesCount
    % Notice that both position and velocity are 2x1 vectors.
    % *********************************************************************
    posX = (maxX-minX)*rand + minX;
    posY = (maxY-minY)*rand + minY;
    particles(I).position = [posX;posY]; % TODO: Random position within the boundaries minX to maxX, and minY to maxY.
    particles(I).velocity =(maxV-minV).*rand(2,1) + minV; % TODO: Random velocity within the range minV to maxV for both x and y components.
    particles(I).color = rand(3,1);    % TODO: Random color triplet: [R, G, B] between 0 and 1 each.
    % *********************************************************************
end;

% The only force acting on particles is gravity. This is the constant g.
gravity = [0; -9.81];

% Coefficient of restitution to handle Newtonian collisions; modify this to
% get different behaviors.
restCoeff = 0.5;    %0 - inelastic, 1 - fully elastic.

% The ground for collisions (a sinusoidal function).
xSine = linspace( minX, maxX, 100 );
ySine = sin( xSine );

% The optimization parameters.
x0 = 0;         %Initial search point.

% Define time control variables.
deltaT = 0.01;
simulationTime = 0.0;
maxSimulationTime = 10.0;

% Set up window.
set( 0, 'Units', 'pixels' );                %Set default units to pixels. 
screenSize = get( 0, 'ScreenSize' );        %Get screen size and position.
figure( 'Renderer', 'OpenGL', ...
    'OuterPosition', [screenSize(3)/2-350 screenSize(4)/2-350 700 700]);

%create a viedo
%nFrames = maxSimulationTime/deltaT;
writerObj = VideoWriter('peaks.avi');
open(writerObj);

% Begin simulation.
while( simulationTime < maxSimulationTime )
    plot( xSine, ySine, 'Color', 'black', 'LineWidth', 2 );   % Draw sinusoidal ground.
    hold on;

    % Iterate over each particle.
    for I = 1:particlesCount        %Solve for each particle: find its new position.
        
        % *****************************************************************
        % Integrate acceleration to find new velocity.
	    oldV = particles(I).velocity;
        particles(I).velocity = particles(I).velocity + deltaT .* gravity; % TODO: integrate acceleration to get new velocity.
        
        % Integrate velocity to find new position.
        particles(I).position = particles(I).position + deltaT .* oldV; % TODO: integrate velocity to get new 'candidate' position.
        % *****************************************************************deltaT .* particles(I).velocity; % TODO: integrate velocity to get new 'candidate' position.
        % *****************************************************************
        
        % Check collision with ground.
        if( particles(I).position(2) < sin( particles(I).position(1) ) ) % Is particle below ground?
            
            % Move particle above the ground, to the location on the sine
            % function where the distance between the current position and
            % the curve is minimal.
            
            % *************************************************************
            % TODO: Use "fzero" to minimize your distance function.
            % xSol should be the x-coordinate that minimizes your distance
            % function.
            % *************************************************************
            fun = @(x)2*(particles(I).position(1)-x)+ 2*(particles(I).position(2)-sin(x)) - cos(x); 
            xSol = fzero(fun,1);
            particles(I).position = [xSol; sin( xSol )];    % Move particle on the ground.
            
            % Compute a new velocity based on the normal at the point where
            % the particle went through the ground (found in previous step).
            commonFactor = 1/sqrt( 1 + cos( xSol )^2 );
            groundNormal = commonFactor * [ -cos( xSol ); 1 ];
            projOntoN = particles(I).velocity' * groundNormal;
            particles(I).velocity = particles(I).velocity - ...
                projOntoN*groundNormal - restCoeff*projOntoN*groundNormal;
        end;
        
        % Draw particle at its new position.
        plot( particles(I).position(1), particles(I).position(2), ...
            'Marker', 'o', ...
            'MarkerEdgeColor', particles(I).color*0.5, ...
            'MarkerSize', 10, ...
            'MarkerFaceColor', particles(I).color );
       
    end;
    xlabel( sprintf( 'Simulation time: %f', simulationTime ) );
    axis( [minX, maxX, minY-2, maxY] );                 % Give some room to sinusoidal ground.
    hold off;
    
    % Instruct MatLab to refresh plot.
    drawnow;
    
    %frame(k) = getframe;
    %k = k + 1;
    frame = getframe;
    writeVideo(writerObj,frame);
    simulationTime = simulationTime + deltaT;           % Advance time.
end;

%close the vedio writer
%movie2avi(mov, 'myPeaks.avi', 'compression', 'None');
close(writerObj);

