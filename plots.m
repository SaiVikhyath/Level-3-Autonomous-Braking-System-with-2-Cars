


vS_values = -150:0.1:150;
membership_values = membershipFunctionBrakingNA(vS_values);






function y = membershipFunctionBrakingNA(vS)
    load('MemberDecel200.mat')

    meanVal = [mean(decelMax(1:13)) mean(decelMax(14:28)) mean(decelMax(29:41))];
    stdVal = [std(decelMax(1:10)) std(decelMax(11:30)) std(decelMax(31:41))];

    y = zeros(size(vS));  % Initialize y with zeros

    y(1, :) = 1 - normcdf(vS, meanVal(1), stdVal(1));

    y(2, :) = normpdf(vS, meanVal(2), stdVal(2));
    y(2, :) = y(2, :) / max(normpdf(0:150, meanVal(2), stdVal(2)));

    y(3, :) = normcdf(vS, meanVal(3), stdVal(3));

    y = y / sum(y);

    % Plot the membership functions
    vS_range = -50:0.1:150;  % Define a range of vS values for plotting
    mf1 = 1 - normcdf(vS_range, meanVal(1), stdVal(1));
    mf2 = normpdf(vS_range, meanVal(2), stdVal(2)) / max(normpdf(0:150, meanVal(2), stdVal(2)));
    mf3 = normcdf(vS_range, meanVal(3), stdVal(3));

    figure;
    plot(vS_range, mf1, 'r', 'LineWidth', 2);
    hold on;
    plot(vS_range, mf2, 'g', 'LineWidth', 2);
    plot(vS_range, mf3, 'b', 'LineWidth', 2);
    xlabel('vS');
    ylabel('Membership Value');
    title('Membership Functions');
    legend('Membership Function 1', 'Membership Function 2', 'Membership Function 3');
    grid on;
    hold off;
end
