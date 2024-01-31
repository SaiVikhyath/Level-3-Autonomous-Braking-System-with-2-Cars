function y = membershipFunctionDistance(vS)
load('MemberDecel200.mat')

meanVal = [-30 -10];
stdVal = [15 20];



        y(1) = 1-normcdf(vS,meanVal(1),stdVal(1));

    

        
        
        y(2) = normcdf(vS,meanVal(2),stdVal(2));

        y = y/sum(y);