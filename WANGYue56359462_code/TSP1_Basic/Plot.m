function Plot()
%PLOT - Draw a path graph （subplot1）

    global positions
    global best_path
    global PLOT
    global PLOT_TITLE
    global PATH_PLOT

    figure('Name', 'Cities','Units', 'normalized',...
        'Position', [0.05 0.05 0.4 0.8]); %位置

    %1
    subplot(2,1,1);
    
    %图的抬头信息
    t = { ['BEST PATH: ' num2str(best_path)];...
          ['DISTANCE = ' num2str(DistanceOfPath(best_path))];...
          ['GENERATION ' num2str(1)] };
    PLOT_TITLE = title(t);
    hold on;
    
    %plot
    PLOT = plot(positions(1,:),positions(2,:),...
        'bo', 'MarkerFaceColor', 'b');    
    %line
    PATH_PLOT = plot(...
        [positions(1, best_path) positions(1, best_path(1))],...
        [positions(2, best_path) positions(2, best_path(1))],...
        'r-');

    
end

