% part2 signal generator
% Nourhan Waleed 6609
N=2;
while(N==2)
disp('General Signal Generator');
sampling_frequency = input(sprintf('Please enter the sampling frequency:'));
while(sampling_frequency<=0)
    disp('Invalid input');
    sampling_frequency = input(sprintf('Please enter the sampling frequency:'));
end

start_time = input(sprintf('Please enter the start time:'));
end_time = input(sprintf('Please enter the end time:'));
while(end_time<=start_time)
    disp('Invalid input');
    end_time = input(sprintf('Please enter the end time:'));
end


no_of_break_points = input(sprintf('Please enter the number of break points:'));
while(no_of_break_points<0)
    disp('Invalid input');
    no_of_break_points = input(sprintf('Please enter the number of break points:'));
end
previous_time = start_time;
break_point_times=zeros(1,no_of_break_points+1);
for i=1:no_of_break_points
    H=['Please enter the time of break point number ', num2str(i),':'];
    break_point_times(i) = input(H);
    while(break_point_times<previous_time)
        disp('Invalid input');
        break_point_times(i) = input(H);
    end
     while(break_point_times>end_time)
        disp('Invalid input');
        break_point_times(i) = input(H);
    end
    previous_time = break_point_times(i);
end
j=1;
previous_time = start_time;
n=0;
Yt=[];
X=[];
while(j<=no_of_break_points+1 && n~=6)
    if (no_of_break_points==0)
        break_point_times(j)=end_time;
    end
    F=['Please Choose the number corresponding to the signal in the region ',num2str(previous_time),' to ', num2str(break_point_times(j)),':'];
    disp(F);
    n=input(sprintf(' 1.DC signal \n 2.Ramp Signal \n 3.General Order Polynomial \n 4.Exponential Signal \n 5.Sinosoidal Signal \n 6.exit \n'));
    xt=linspace(previous_time,break_point_times(j),(break_point_times(j)-previous_time)*sampling_frequency);
    X=[X xt];
    switch n
        case 1
            amplitude=input(sprintf('Please enter the amplitude of the signal:'));
            Yt=[Yt amplitude.* ones(1, length(xt))];
        case 2
            slope=input(sprintf('Please enter the slope of the signal:'));
            intercept=input(sprintf('Please enter the intercept of the signal:'));
            Yt=[Yt slope.*xt+intercept];
            
        case 3
            n=input(sprintf('Please enter the highest power of the signal:'));
            while(n<1)
                disp('Invalid input');
                n=input(sprintf('Please enter the highest power of the signal:'));
            end
            Fn=[];
            amplitude=zeros(1, n + 1); 
            for i=1:n+1 
                amplitude(i)=input(sprintf('amplitude of x^%d:', n - i + 1)); 
                
            end
            Yt=[Yt polyval(amplitude, xt)];
        case 4
            amplitude=input(sprintf('Please enter the amplitude of the signal:'));
            exponent=input(sprintf('Please enter the exponent of the signal:'));
            Yt=[Yt amplitude.*exp(exponent .* xt)];
        case 5
            amplitude=input(sprintf('Please enter the amplitude of the signal:'));
            frequency=input(sprintf('Please enter the frequency of the signal:'));
            phase=input(sprintf('Please enter the phase of the signal:'));
            offset=input(sprintf('Please enter the DC offset of the signal:'));
            Yt=[Yt (amplitude.*sin(2.*pi.*frequency.*xt+(phase*pi/180))+offset)];
        case 6
            exit;
            
    end
    
    previous_time = break_point_times(j);
    j=j+1;
    if(j==length(break_point_times))
    break_point_times(j)= end_time;
    end
end
plot(X, Yt)

N=input(sprintf('Would you like to perform any opertaions on the signal? 1.Y 2.N:'));
switch N
    case 1
        m=0;
        while(m<6)
            m=input(sprintf('Please choose the number corresponding to the opeartion you would like to perform on the signal\n 1.Amplitude Scaling \n 2.Time Reversal\n 3.Time shift\n 4.Expanding\n 5.Compressing\n '));
            switch m
                case 1
                    newamp=input(sprintf('Please enter the scaling factor:'));
                    Yt=newamp.*Yt;
                case 2
                    X=X.*-1;
                case 3
                    shiftingfactor=input(sprintf('Please enter the shifting factor:'));
                    X=X + shiftingfactor;
                case 4
                    expantionfactor=input(sprintf('Please enter the expanding factor:'));
                    X=X.*expantionfactor;
                case 5
                    compressionfactor=input(sprintf('Please enter the compression factor:'));
                    X=X./compressionfactor;
               
            end
         N=input(sprintf('Would you like to do another modification on the signal? 1.Yes 2.No'));    
         if(N==2)
                 m=6;
         end
        end
        plot(X, Yt)
%         when th user chooses 2 the programs restarts

end

end
