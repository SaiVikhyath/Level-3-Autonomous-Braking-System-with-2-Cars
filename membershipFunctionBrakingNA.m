function y = membershipFunctionBrakingNA(vS)
load('MemberDecel200.mat')

meanVal = [mean(decelMax(1:13)) mean(decelMax(14:28)) mean(decelMax(29:41))];
stdVal = [std(decelMax(1:10)) std(decelMax(11:30)) std(decelMax(31:41))];



        y(1) = 1-normcdf(vS,meanVal(1),stdVal(1));

    

        
        y(2) = normpdf(vS,meanVal(2),stdVal(2));
        y(2) = y(2)/max(normpdf(0:150,meanVal(2),stdVal(2)));

        y(3) = normcdf(vS,meanVal(3),stdVal(3));

        y = y/sum(y);