function [sbestpos, sbestval] = Particle_Swarm_Optimization(lower_limit,upper_limit,d,ssize,w, c1, c2)

% d: dimension of the problem : 5
% ssize: size of the population : 50 
% w:coefficient of inertia : 0.8
% c1: cognitive coefficient : 2
% c2: social coefficient : 2
% lower_limit=-10;
% upper_limit=10;


swarm= unifrnd(lower_limit,upper_limit, [ssize, d]);

obj=zeros(ssize,1);

for i=1:ssize
    obj(i)= sum(swarm(i,:).^2);
end

velocity=zeros(ssize,d);

pbestpos = swarm;
pbestval = obj;

sbestval= min(obj);
idx=find(sbestval==obj);
sbestpos=swarm(idx,:);

iteration=1;
while(iteration<=50)
    
for i=1:ssize
    velocity(i,:)=w*velocity(i,:) + c1*unifrnd(0,1)*(pbestpos(i,:)-swarm(i,:))+ c2*unifrnd(0,1)*(sbestpos-swarm(i,:));
end

vmax=(upper_limit-lower_limit)/2;
for i=1:ssize
    for j=1:d
        if(velocity(i,j)>vmax)
            velocity(i,j)=vmax;
        elseif(velocity(i,j)<-vmax)
            velocity(i,j)=-vmax;
        end
    end
end

swarm= swarm+velocity;
for i=1:ssize
    for j=1:d
        if(swarm(i,j)>upper_limit)
            swarm(i,j)=upper_limit;
        elseif(swarm(i,j)<lower_limit)
            swarm(i,j)=lower_limit;
        end
    end
end

for i=1:ssize
    obj(i)= sum(swarm(i,:).^2);
end

for i=1:ssize
    if(obj(i)<pbestval(i))
        pbestval(i)=obj(i);
        pbestpos(i,:) = swarm(i,:);
    end
end

for i=1:ssize
    if(min(obj)<sbestval)
        sbestval=min(obj);
        idx=find(sbestval==obj);
        sbestpos=swarm(idx,:);
    end
end

iteration=iteration+1;
end


end

