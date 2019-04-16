clc;
clear all;
close all;

d1 = 1;
d2 = 1;
p = 5;
m = 5;
R = 0.2;

[NL, EL] = mesh_2(d1,d2,p,m,R);


NoN = size(NL,1);
NoE = size(EL,1);
NPE = size(EL,2);

for i = 1 : NoE
    hold on;
    plot([NL(EL(i,1),1),NL(EL(i,2),1)] , [NL(EL(i,1),2),NL(EL(i,2),2)],'LineWidth',4,'Color','k');
    plot([NL(EL(i,2),1),NL(EL(i,3),1)] , [NL(EL(i,2),2),NL(EL(i,3),2)],'LineWidth',4,'Color','k');
    plot([NL(EL(i,3),1),NL(EL(i,4),1)] , [NL(EL(i,3),2),NL(EL(i,4),2)],'LineWidth',4,'Color','k');
    plot([NL(EL(i,4),1),NL(EL(i,1),1)] , [NL(EL(i,4),2),NL(EL(i,1),2)],'LineWidth',4,'Color','k');
    x=(NL(EL(i,1),1)+NL(EL(i,2),1)+NL(EL(i,3),1)+NL(EL(i,4),1))/4;
    y=(NL(EL(i,1),2)+NL(EL(i,2),2)+NL(EL(i,3),2)+NL(EL(i,4),2))/4;
    text(x,y,num2str(i),'Color','b','FontSize',10,'HorizontalAlignment','center')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1 : NoN
         hold on;
     plot(NL(i,1),NL(i,2),'o','MarkerSize',6,'MarkerEdgeColor','g','MarkerFaceColor','g');
     text(NL(i,1),NL(i,2),num2str(i),'Color','r','FontSize',8,'HorizontalAlignment','center')
end

hold off;
axis([0 1.0 0 1.0])
axis equal

toc