

clear all
clc


% -------------------- Tester -------------------- %



% SpeedsA = linspace(20, 60, 10);
% SpeedsB = linspace(20, 60, 10);

SpeedsA = [35];
SpeedsB = [60];


load('MemberDecel200.mat');


collisions = 0;

for idxA = 1:length(SpeedsA)

    for idxB = 1:length(SpeedsB)

        initSpeedA = SpeedsA(idxA)
        initSpeedB = SpeedsB(idxB)

        open_system("LaneMaintainSystem3Car.slx");
        set_param("LaneMaintainSystem3Car/VehicleKinematics/Saturation", "LowerLimit", num2str(decelLim));
        set_param("LaneMaintainSystem3Car/VehicleKinematics/vx","InitialCondition", num2str(initSpeedB));
        set_param("LaneMaintainSystem3Car/CARA/VehicleKinematics/Saturation", "LowerLimit", num2str(decelLim));
        set_param("LaneMaintainSystem3Car/CARA/VehicleKinematics/vx", "InitialCondition", num2str(initSpeedA));
        save_system("LaneMaintainSystem3Car");
        simulatedModel = sim("LaneMaintainSystem3Car.slx");

        distanceA = simulatedModel.sx1.Data;
        distanceB = simulatedModel.sxB.Data;
        vA = simulatedModel.vx1.Data;
        sAB = distanceB - distanceA;

        [switched, timeOfSwicth] = AdvisoryControl(vA, sAB);

        disp(["Switched: ", switched, "  Time of Switch: ", timeOfSwicth]);


        if switched
            
            HumanReactionTime = 0;
            timeToSwitchToHuman = timeOfSwicth;

            open_system("Level3Model.slx");
            set_param('Level3Model/VehicleKinematics/Saturation','LowerLimit',num2str(100*decelLim));
            set_param('Level3Model/VehicleKinematics/vx','InitialCondition',num2str(initSpeedB));
            set_param('Level3Model/CARA/VehicleKinematics/Saturation','LowerLimit',num2str(decelLim));
            set_param('Level3Model/CARA/VehicleKinematics/vx','InitialCondition',num2str(initSpeedA));
            set_param('Level3Model/Constant1','Value',num2str(timeToSwitchToHuman));
            set_param('Level3Model/Step','Time',num2str(HumanReactionTime+timeToSwitchToHuman));
            set_param('Level3Model/Step','After',num2str(1.1*decelLim));
            save_system("Level3Model");
            
            simulatedModel = sim("Level3Model.slx")

            disp(simulatedModel.sxB.Data);

            if any(simulatedModel.sxB.Data >= 0)
                collisions = collisions + 1;
            end
            
            break;

        else
            % Continue with autonomous model
        end

    end

end

disp(["Number of collisions: ", collisions]);




