


function [ w,error] = test1(pause_set,data )

    x=-200:0.05:200;

    %rd=randi([-10 10],2,n);
    %data=[data;ones(1,size(data,2))];
    figure(3)
    plot(data(1,:),data(2,:),'o');
    hold on
    title('the data');
    xlabel('horizontal symmetry')
    ylabel('vertical symmetry')
    
    %The unknown target function is say.. -3 * A + 5 * B + 1
    %That means the weights are like this.. W12=3, W34=5, W0=1;
    %W=[randi([-10 10]),randi([-10 10]),randi([-10 10])];
    %f=[num2str(W(1)),'*x+',num2str(W(2)),'*y+',num2str(W(3)),'*1'];
    
    
    %ezplot(f,[0 200 0 200]);
    
    
    %axis([0 200 0 200]);
    
    %data=[data;sign(W*data)];
    neg_data=find(data(4,:)==-1);
    pos_data=find(data(4,:)~=-1 );
    data(4,data(4,:)==0)=1;
    plot(data(1,neg_data),data(2,neg_data),'rs','MarkerFaceColor','r');
    plot(data(1,pos_data),data(2,pos_data),'gs','MarkerFaceColor','g');
    pause(5);
    
    hold off;
    
   % weights=zeros(length(data),1);
    %it represents weights of each datapoint.
    l=length(pos_data);
    m=length(neg_data);
    weights=[ones(l,1)./(2*l);ones(m,1)./(2*m)];
    

    figure(4)
    hold on
    
    plot(data(1,:),data(2,:),'o');
    title('the output of our code')
    xlabel('horizontal symmetry')
    ylabel('vertical symmetry')
    plot(data(1,neg_data),data(2,neg_data),'rs','MarkerFaceColor','r');
    plot(data(1,pos_data),data(2,pos_data),'gs','MarkerFaceColor','g');
    
    
for cmplxty=1:22
    
    weights=weights./(sum(weights));
    
    no_iter=0;
    error=zeros(length(data),4);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    %if cmplxty==1
    
    w=[randi([-100 100]),randi([-100 100]),randi([-100 100])];
    
    %end
    
    
    %axis([0 140 0 60]);
    
    
    %m=[-W(1)/W(2)];
    %c=[-W(3)/W(2)];
    %plot(x,m*x+c,'g','LineWidth',4)
    
    
    while no_iter<2000
        no_iter=no_iter+1;
        
        result=sign(w*data(1:3,:));
        
        k=(result==data(4,:));
        l=find(k==0);
        
        %[~,l]=find(result~=data(4,:));
        
        
        
        %error value to be used in pocket
        error(no_iter,1)=length(l)/length(result);
        error(no_iter,2:4)=w(:);
        
        %disp(error)
        
        % Pick a misclassified point.
        %[~,max_mscfd]=max(weights(l));   
        %mscfd=max_mscfd;
        [~,index_max_missclassified]=(max(weights(l)));
        
        
        mscfd=l(index_max_missclassified);
        
        % find the value of y for the misclassified point picked.
        y=data(4,mscfd);
        
        %find the value of data at that location
        msfd_data=data(1:3,mscfd);
        
        
        
        % update the weight vector.
        
        w=w+(y*msfd_data)';
        
        
        
        
        
        
        %func=[num2str(w(1)),'*x+',num2str(w(2)),'*y+',num2str(w(3)),'*1'];
        %ezplot(func,[-10 10 -10 10]);
        
        m=-w(1)/w(2);
        c=-w(3)/w(2);
        %disp(no_iter);
        
        %for plotting the first line of each epoc
        %if no_iter==1
            %plot(x,m*x+c,'r','LineWidth',4)
            
            
            %else
            %plot(x,m*x+c,'k')
        %end
        
        
        
        if pause_set==1
            
            pause(0.005);
        end
        
    end
    [min_error,min_error_index]=min(error(:,1));
    w(:)=error(min_error_index,2:4);
    
    m=-w(1)/w(2);
    c=-w(3)/w(2);
    
    
    
    plot(x,m*x+c,'b','LineWidth',2)
    
    
    %disp(no_iter)
    %disp(w)
    disp('');
    disp(min_error);
    disp(w);
    disp('');
    
    result=sign(w*data(1:3,:));
    
    
    beta = min_error./(1-min_error);
    
    
    [corclfd_r,~]=find(result==data(4,:));
    
    weights(corclfd_r)=weights(corclfd_r).*(beta);
    
    
end

hold off

end
