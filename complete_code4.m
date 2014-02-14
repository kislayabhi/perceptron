complete_code2
face_mean=[face_mean,ones(length(face_mean),1)];
nonface_mean=[nonface_mean,ones(length(nonface_mean),1)];
face_mean=[face_mean,ones(length(face_mean),1)];
nonface_mean=[nonface_mean,-1*ones(length(nonface_mean),1)];
data=[face_mean;nonface_mean];
data=data';
test1(0,data)

