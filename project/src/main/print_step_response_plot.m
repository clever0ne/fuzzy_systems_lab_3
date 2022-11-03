function print_step_response_plot(t, xd, x, plotname, filename)
    figure('Name', plotname);
    plot(t, xd, t, x);

    grid on;
    axis([t(1), t(end), 0, 1.2]);
    xticks(t(1) : 10 : t(end))
    set(gca, 'FontName', 'Euclid', 'FontSize', 12);
    title(plotname, 'FontWeight', 'normal', 'FontSize', 12);

    xlabel('$t, \rm s$',    'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$h(t), \rm m$', 'Interpreter', 'latex', 'FontSize', 12);
    legend('$h_d(t)$', '$h(t)$', 'Interpreter', 'latex', 'FontSize', 10)
    
    if (~exist('../../graphs', 'dir'))
        mkdir('../../graphs');
    end

    print(['../../graphs/', filename], '-dmeta', '-r0');
end