function myprintplot(fullname)

%first print a eps file
epsname = [fullname '.eps'];
print('-depsc', '-loose', epsname );

% then create a pdf
[A, msg] = eps2pdf(epsname);
% eval(['!rm -f ' epsname ]);
% delete the pdf if something went wrong
if A==0
   eval(['!rm -f ' epsname ]);
else
   fprintf('\n %s \n ', msg);
end


