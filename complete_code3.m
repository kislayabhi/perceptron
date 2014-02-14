facefiles=dir('face/*.pgm');
nonfacefiles=dir('nonface/*.png');

%initialise the features that we are going to use i.e the intensity of the
%pixels

face_mean=zeros(length(facefiles),3);
nonface_mean=zeros(length(nonfacefiles),3);


%convolution kernel
A=[-1,-1,-1;-1,-1,-1;-1,-1,-1;+1,+1,+1;+1,+1,+1;+1,+1,+1];


%here we are getting the mean intensity of the face training set

for i=1:length(facefiles)
    
    
    filename=['face/',strcat(facefiles(i).name)];
    
    
    im=imread(filename);
    im=imresize(im,[24 24]);
    im=histeq(im);
    
    im=imfilter(im,A,'same');
    
    im=histeq(im);
    
    
    face_mean(i,3)=mean(mean(im));
   
    
    % vertical symmetry
    o=im(:,1:12);
    oi=im(:,13:end);
    oi=fliplr(oi);
    face_mean(i,2)=mean(mean(o-oi));
    
    % horizontal symmetry
    
    o=im(1:12,:);
    oi=im(13:end,:);
    oi=fliplr(oi);
    face_mean(i,1)=mean(mean(o-oi));
    
end


%here we are getting the mean intensity of the non face training set

for i=1:length(nonfacefiles)
    
    
    filename=['nonface/',strcat(nonfacefiles(i).name)];
    
    
    im=imread(filename);
    im=imresize(im,[24 24]);
    im=histeq(im);
    
    im=imfilter(im,A,'same');
    
    im=histeq(im);
    
    nonface_mean(i,3)=mean(mean(im));
    
    % vertical symmetry
    o=im(:,1:12);
    oi=im(:,13:end);
    oi=fliplr(oi);
    nonface_mean(i,2)=mean(mean(o-oi));
    
    % horizontal symmetry
    o=im(1:12,:);
    oi=im(13:end,:);
    oi=fliplr(oi);
    nonface_mean(i,1)=mean(mean(o-oi));
    
    
    
end


plot3(face_mean(:,1),face_mean(:,2),face_mean(:,3),'gs','MarkerFaceColor','g');
hold on
plot3(nonface_mean(:,1),nonface_mean(:,2),nonface_mean(:,3),'rs','MarkerFaceColor','r');
hold off


xlabel('horizontal symmetry');
ylabel('vertical symmetry');
title('face vs nonface image');
