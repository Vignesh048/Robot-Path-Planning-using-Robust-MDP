function MDPgridworldExample()


set(0,'DefaultAxesFontSize',18)
format compact
pauseOn = false;  %setting this to 'true' is useful for teaching, because it pauses between each graph

World = [
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1
    1 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1
    1 0 0 0 0 1 1 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 1 1 0 0 0 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1
    1 0 0 0 1 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1 1 1 1 0 0 0 1
    1 0 0 0 0 1 1 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 1 1 0 0 0 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1
    1 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1
    1 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

f1 = figure(1); clf
set(f1,'units','normalized','outerposition',[0 0 1 1])
colormap(gray)
%colormap(jet)
R = -50*ones(size(World)); %-50 reward for obstacles
R(World==0) = -1; %small penalty for not being at the goal
R(2,45) = 100; %goal state has big reward

%  DRAW THE WORLD, REWARD, ANIMATE VALUE ITERATION, DISPLAY POLICY
subplot(2,2,1)
imagesc(~World);
set(gca,'Xtick',[], 'Ytick',[])
axis equal
axis tight
text(25,-1,'World','HorizontalAlignment','center','FontSize',18)
drawnow
if pauseOn; pause(); end 

subplot(2,2,2)
imagesc(R);
axis equal
axis tight
set(gca, 'Xtick',[], 'Ytick',[])
text(25,-1,'Reward function','HorizontalAlignment','center','FontSize',18)
drawnow
if pauseOn; pause(); end


V_hat = MDP_discrete_value_iteration(R,World,false);
if pauseOn; pause(); end

DrawPolicy(V_hat,World,false);
if pauseOn; pause(); end

figure(f1)
V_hat_prob = MDP_discrete_value_iteration(R,World,true);
if pauseOn; pause(); end

DrawPolicy(V_hat_prob,World,true);
if pauseOn; pause(); end
a=ones(1,length(linspace(0.7,0.3,1000)));
i=1;
a_0 = StepFunction(V_hat_prob,29,1,R);
for k=linspace(0.7,0.3,1000)  
    a(i) = a_0-StepFunction(V_hat_prob,29,k,R);
    i=i+1;
end

figure(4)
plot(linspace(0.1,0.5,1000),a);
xlabel('robust')
%%%% Enviornment Creation %%%%%%

    function V_hat = MDP_discrete_value_iteration(R,World,prob)
        % iterates on the value function approximation V_hat until the V_hat converges.
        V_hat_prev = zeros(size(World));
        V_hat = -100*ones(size(World));
        V_hat(World==0) = R(World==0);
        colormap(jet)
        gamma = 0.97;
        
        xIND = find(World == 0);
        iteration = 0;
        if ~prob
            subplot(2,2,3)
        else
            subplot(2,2,4)
        end
        hImageV =   imagesc(V_hat);
        axis equal
        axis tight
        set(gca,'Xtick',[], 'Ytick',[])
        htext = text(25,-1,'Vhat','HorizontalAlignment','center','FontSize',18);
        iteration_limit = 200; 
        while ~isequal(V_hat,V_hat_prev) && iteration < iteration_limit 
            V_hat_prev = V_hat;
            for i = 1:numel(xIND)   
                [~,bestPayoff] = robust_MDP(xIND(i),V_hat,prob);
                V_hat(xIND(i)) =  R(xIND(i)) + gamma*( bestPayoff);
            end
            iteration = iteration+1;
            set(hImageV,'cdata',V_hat);
            set(htext,'String',['Vhat, iteration ',num2str(iteration)])
            drawnow
        end
    end
    
    

    function [bestMove,bestPayoff] = policy_MDP(index,V_hat,prob)
        %computes the best control action, the (move) that generates the
        %most (payoff) according to the current value function V_hat
        [Iy,Ix] = ind2sub(size(V_hat),index);
        moves = [1,0; 1,1; 0,1; -1,1; -1,0; -1,-1; 0,-1; 1,-1; 0,0]; 
        bestPayoff = -200; %negative infinity
        probStraight = 0.8;
        for k = [1,3,5,7,2,4,6,8,9]% This order tries straight moves before diagonals %1:size(moves,1) %
            move = [moves(k,1),moves(k,2)];
            if ~prob
                payoff = V_hat(Iy+move(1),Ix+move(2));
            else    
                if k < 8 %move +45deg of command
                    moveR = [moves(k+1,1),moves(k+1,2)];
                else
                    moveR = [moves(1,1),  moves(1,2)];
                end
                if k>1%move -45deg of command
                    moveL = [moves(k-1,1),moves(k-1,2)]; 
                else
                    moveL = [moves(8,1),  moves(8,2)];
                end
                if isequal(move,[0,0])
                    moveR = [0,0];
                    moveL = [0,0];
                end
                payoff =  probStraight*V_hat(Iy+move(1), Ix+move(2) )+...
                    (1-probStraight)/2*V_hat(Iy+moveR(1),Ix+moveR(2))+...
                    (1-probStraight)/2*V_hat(Iy+moveL(1),Ix+moveL(2));
            end
            
            if payoff > bestPayoff
                bestPayoff = payoff;
                bestMove = move;
            end
        end
    end
    
    function [steps] = StepFunction(V_hat,in_state,probb,R)
 
        [bestMove,~] = robust_MDP(in_state,V_hat,true);
        [Iy,Ix] = ind2sub(size(V_hat),in_state);
        x=rand;
        %k = [1,3,5,7,2,4,6,8,9]% This order tries straight moves before diagonals %1:size(moves,1) %
        moves = [1,0; 1,1; 0,1; -1,1; -1,0; -1,-1; 0,-1; 1,-1; 0,0];
        k = intersect(find(moves(:,1) == bestMove(1)),find(moves(:,2) == bestMove(2)));
        if k < 8 %move +45deg of command
            moveR = [moves(k+1,1),moves(k+1,2)];
        else
            moveR = [moves(1,1),  moves(1,2)];
        end
        if k>1%move -45deg of command
            moveL = [moves(k-1,1),moves(k-1,2)]; 
        else
            moveL = [moves(8,1),  moves(8,2)];
        end
        %move = [moves(k,1),moves(k,2)];
        if x<probb
            move = bestMove;
        elseif probb<x && x<(probb+(1-probb)/2)
            move = moveR;
        else
            move = moveL;
        end
        f_state = [Iy+move(1),Ix+move(2)];
        indfstate = sub2ind(size(V_hat),f_state(1),f_state(2));
        if indfstate ~= 662
            steps = R(indfstate) + StepFunction(V_hat,indfstate,probb,R);
        else
            steps = R(indfstate);
        end
    end

    function [DX,DY] = DrawPolicy(V_hat,World,prob)
        % uses arrows to draw the optimal policy according to the Value
        % Funtion approximation V_hat
        xIND = find(World == 0);
        %subplot(3,2,4)
        fh = figure(); clf
        %colormap(gray)
        set(fh,'units','normalized','outerposition',[0 0 1 1])
        imagesc(V_hat);
        axis equal
        axis tight
        set(gca,'Xtick',[], 'Ytick',[])
        if prob
            str = 'Policy under probabilistic motion model';
        else
            str = 'Policy under deterministic motion model';
        end
        text(25,-1,str,'HorizontalAlignment','center','FontSize',18);
        [X,Y] = meshgrid(1:size(World,2),1:size(World,1));
        DX = zeros(size(X));
        DY = zeros(size(Y));
        
        for i = 1:numel(xIND)
            [Iy,Ix] = ind2sub(size(V_hat),xIND(i));
            [bestMove,~] = robust_MDP(xIND(i),V_hat,prob);
            DX(Iy,Ix) = bestMove(1);
            DY(Iy,Ix) = bestMove(2);
        end
        hold on; hq=quiver(X,Y,DY,DX,0.5,'color',[0,0,0]); hold off
        set(hq,'linewidth',2);
        drawnow
    end

end

    function [bestMove,bestPayoff] = robust_MDP(index,V_hat,prob)
        %computes the best control action, the (move) that generates the
        %most (payoff) according to the current value function V_hat
        [Iy,Ix] = ind2sub(size(V_hat),index);
        moves = [1,0; 1,1; 0,1; -1,1; -1,0; -1,-1; 0,-1; 1,-1; 0,0]; 
        bestPayoff = -200; %negative infinity
        probStraight = 0.5;
        for k = [1,3,5,7,2,4,6,8,9]% This order tries straight moves before diagonals %1:size(moves,1) %
            move = [moves(k,1),moves(k,2)];
            if ~prob
                payoff = V_hat(Iy+move(1),Ix+move(2));
            else    
                if k < 8 %move +45deg of command
                    moveR = [moves(k+1,1),moves(k+1,2)];
                else
                    moveR = [moves(1,1),  moves(1,2)];
                end
                if k>1%move -45deg of command
                    moveL = [moves(k-1,1),moves(k-1,2)]; 
                else
                    moveL = [moves(8,1),  moves(8,2)];
                end
                if isequal(move,[0,0])
                    moveR = [0,0];
                    moveL = [0,0];
                end
                payoffs=ones(1,length(linspace(probStraight-0.2,probStraight+0.2, 9)));
                i=1;
                for k = linspace(probStraight-0.2,probStraight+0.2,9)
                    
                    payoffs(i) =  k*V_hat(Iy+move(1), Ix+move(2) )+...
                        (1-k)/2*V_hat(Iy+moveR(1),Ix+moveR(2))+...
                        (1-k)/2*V_hat(Iy+moveL(1),Ix+moveL(2));
                    i=i+1;
                end
            payoff = min(payoffs);
            end
            
            if payoff > bestPayoff
                bestPayoff = payoff;
                bestMove = move;
            end
        end
    end

 