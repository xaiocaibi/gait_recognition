function [u,v] = OFEI(BW)

for i=1:length(BW)-1
    [us,vs]=OpticalFlow(BW{i},BW{i+1});
    mus{i}=us;
    mvs{i}=vs;
end

u=0;
v=0;
figure
for i=1:length(BW)-1
    hold on
   quiver(mus{i},mvs{i});
   u=u+mus{i};
   v=v+mus{i};
end

end


