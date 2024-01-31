function y = membershipFunctionRoad(vS)
load('MemberDecel200.mat')

meanVal = [0 15];
stdVal = [15 20];



        y(1) = 1-normcdf(vS,meanVal(1),stdVal(1));

    

        
        
        y(2) = normcdf(vS,meanVal(2),stdVal(2));

        y = y/sum(y);