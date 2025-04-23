%%% Parameters collocation %%%

function [d_opt,fval,d_history] = my_problem(fun,d0,dmin,dmax)

	% Optimization options %
    d_history = [];				
   	options = optimset('Display','off','OutputFcn', @myoutput,'TolFun',0.001,'MaxIter',30);
   	
   	% Optimization
    [d_opt fval] = fminsearchbnd(fun,d0,dmin,dmax,options);

	% Function for save the history        
    function stop = myoutput(d_opt,optimvalues,state);
        stop = false;
        if isequal(state,'iter')
          d_history = [d_history; d_opt];
        end
    end
   
end

