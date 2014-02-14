facefiles=dir('face/*.pgm');
nonfacefiles=dir('nonface/*.png');

%initialise the features that we are going to use i.e the intensity of the
%pixels

face_mean=zeros(length(facefiles),2);
nonface_mean=zeros(length(nonfacefiles),2);


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
    
    
    face_mean(i,1)=mean(mean(im));
   
    o=im(:,1:12);
    oi=im(:,13:end);
    oi=fliplr(oi);
    face_mean(i,2)=mean(mean(o-oi));
end


%here we are getting the mean intensity of the non face training set

for i=1:length(nonfacefiles)
    
    
    filename=['nonface/',strcat(nonfacefiles(i).name)];
    
    
    im=imread(filename);
    im=imresize(im,[24 24]);
    im=histeq(im);
    
    im=imfilter(im,A,'same');
    
    im=histeq(im);
    
    nonface_mean(i,1)=mean(mean(im));
    
    o=im(:,1:12);
    oi=im(:,13:end);
    oi=fliplr(oi);
    nonface_mean(i,2)=mean(mean(o-oi));
end


plot(face_mean(:,1),face_mean(:,2),'gs','MarkerFaceColor','g');
hold on
plot(nonface_mean(:,1),nonface_mean(:,2),'rs','MarkerFaceColor','r');
hold off


xlabel('intensity per pixel');
ylabel('symmetry');
title('face vs nonface image');
