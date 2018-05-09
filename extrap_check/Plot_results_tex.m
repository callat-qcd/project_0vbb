
function [F] = Plot_results_tex(x, y1, ey1, xlab, ylab, style, mycolor, scale_ymin, scale_ymax, scale_xmin, scale_xmax)

if (nargin < 6)
    style='bd';
    mycolor='b';
end
    
pl=errorbar(x, y1, ey1, style);

set(pl,'markersize',10,'lineWidth',1.5,'MarkerEdgeColor','k','MarkerFaceColor',mycolor);
 hold on;

if (nargin<10)
scale_xmin=min(x);
scale_xmax=max(x);
%%% plot the x and y axis
if (nargin < 8)
    scale_ymin=min([y1-ey1 ]);
    scale_ymin=scale_ymin-abs(scale_ymin)*2/100;
    scale_ymax=max([y1+ey1 ]);
    scale_ymax=scale_ymax+abs(scale_ymax)*2/100;
    scale_xmin=min(x);
    scale_xmax=max(x);
elseif ((scale_ymin==0)&&(scale_ymax==0));
%    [scale_xmin scale_xmax scale_ymin scale_ymax] = axis
A=axis;
scale_xmin = A(1);
scale_xmax = A(2);
scale_ymin = A(3);
scale_ymax = A(4);
%else 
end

end

axis([scale_xmin scale_xmax  scale_ymin scale_ymax ]);

xlabel({xlab},'fontsize',25,'Interpreter','latex')
ylabel(ylab,'fontsize',25,'Interpreter','latex');

hold on;

