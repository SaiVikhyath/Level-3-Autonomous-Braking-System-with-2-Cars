

function [swicthed, timeOfSwicth] = SaiVikhyathKudhroli(vA, sAB)

    load('MemberDecel200.mat')

    time = 0;
    swicthed = 0;
    timeOfSwicth = "NA";

    for idx = 1:length(vA)
        
        if idx == 1 || idx == length(vA)
            continue    % Ignoring the first and last value because they'll be zero
        else
            decelerationA = - (vA(idx + 1) - vA(idx)) / (0.01);   % decel = (v2 - v1) / (t2 - t1)
            distanceBtwCars = sAB(idx);
            speedDifference = 0.2;    % From the mobile application.
        end

        FuzzyInferenceSystem = readfis("SaiVikhyathKudhroli.fis");
        decelerationB = evalfis(FuzzyInferenceSystem, [decelerationA, distanceBtwCars, speedDifference]);

        % disp([decelerationB, distanceBtwCars, decelerationA]);

        if (decelerationB > - 0.75 * decelLim)  % Instruction from TA to use only -200 as decelLimit
            % Switch to human with 1.1 * decelLim
            timeOfSwicth = time;
            swicthed = 1;
            break;
        else
            % Remain with autonomous vehicle
        end

        time = time + 0.01;

    end

end





