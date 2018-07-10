function [X lX Y lY]=read_split_dataset(directory)



fprintf('----------------------------------\n Read data ... \n');

persons = [1:13,15:39];% there is no image for the 14-th person in Extended YaleB
L = []; % labels;
cnts = [];
isFirst = 1;
for p = persons
    if(p<10)
        str_p = ['0',num2str(p)];
    else
        str_p = num2str(p);
    end
    D = dir([directory,'yaleB' ,str_p]);
    cnt = 0;
    for i = 1:length(D),
        [pathstr, name, ext] = fileparts(D(i).name);
        if ((~(D(i).isdir))&&strcmpi(ext, '.pgm')&&(~length(strfind(name, 'Ambient'))))
            if(isFirst)
                filename = [directory,'yaleB' ,str_p, '/',D(i).name];
                im = imread(filename);
                [height,width] = size(im);
            end
            isFirst = 0;
            cnt = cnt+1;
        end
    end
    cnts(end+1) = cnt;
end
num_im = min(cnts);
%num_im = 10; % set a value if you want to use a subset of faces.


%---- split the data------------------------------
%-------------------------------------------------
fprintf('----------------------------------\n Split data into \n train and test sets ... \n');
per = length(persons);
num = floor(num_im/2); % use equal size training and testing sets. Not neccessary.
s = 0;
%order = 1:2*num;
order =[1:2:2*num 2:2:2*num];

X = zeros(height*width,per*num);% training images
Y = zeros(height*width,per*num);% testing images
current = zeros(height*width,2*num); % temporary faces for one person


for p = persons
    if(p<10)
        str_p = ['0',num2str(p)];
    else
        str_p = num2str(p);
    end
    D = dir([directory,'yaleB' ,str_p]);
    cnt = 0;
    for i = 1:length(D),
        [pathstr, name, ext] = fileparts(D(i).name);
        if ((~(D(i).isdir))&&strcmpi(ext, '.pgm')&&(cnt<2*num)&&(~length(strfind(name, 'Ambient'))))
            cnt = cnt+1;
            filename = [directory,'yaleB' ,str_p, '/',D(i).name];
            im = imread(filename);
            %imshow(im);
            %title([num2str(cnt),'-th face for ', num2str(p),'-th person' ])
            L(end+1) = p;
            current(:,cnt) = reshape(im,height*width,1);
        end
        
    end
    
    if(p<14)
        p2 = p;
    else
        p2 = p-1;
    end
    fprintf([num2str(p2),'-th person\n'])
    
    X(:,(p2-1)*num+1:p2*num) = current(:,order(1:num));
    Y(:,(p2-1)*num+1:p2*num) = current(:,order(num+1:end));  
    lX((p2-1)*num+1:p2*num,1)=p2;
    lY((p2-1)*num+1:p2*num,1)=p2;
    
    
end
