function Images=readDB()
clc ; 
clear all;
%{
fnames = dir('D:\Sharif University\Lessons\Computer Vision\Project\data base\cohn-kanade-images\S053');
tradata = cell(1,length(fnames));
for k=1:length(fnames)
  fname = fnames(k).name;
  tradata{k} = dlmread(fname, ';', [82 2 1168 2]);
end
%}

path='cohn-kanade-images';
pathFACS='FACS';
pathEmotion='Emotion';
dir_personNames=dir(path);

Images=zeros(0,2);

for i=1:length(dir_personNames)

    
    name = dir_personNames(i).name;
    expression = 'S(([0-9])+)';
    startIndex = regexp(name,expression);
    if(~isempty(startIndex))
        pathPersonName=strcat(path,'\',name);
        dir_expretionFiles=dir(pathPersonName);
        
        for j=1:length(dir_expretionFiles)
            list={'001', '002', '003','004', '005', '006','007', '008', '009','010', '011', '012'};
            x = strmatch(dir_expretionFiles(j).name, list,'exact');
            if(~isempty(x))
                pathExpression=strcat(pathPersonName,'\',dir_expretionFiles(j).name,'\*.png');
                 dir_image=dir(pathExpression);
                 
                 
                 EMpath=strcat(pathEmotion,'\',name,'\',dir_expretionFiles(j).name);
                 file=dir(strcat(EMpath,'\*.txt'));
                 if(~isempty(file))
                     Emotionfile=fileread(strcat(EMpath,'\',file.name)) ; 
                 else
                    Emotionfile='0';
                 end
                
                 FACSpath=strcat(pathFACS,'\',name,'\',dir_expretionFiles(j).name);
                 file=dir(strcat(FACSpath,'\*.txt'));
                 FACSfile=fileread(strcat(FACSpath,'\',file.name)) ;   
               
                 for k=1:length(dir_image)
            
                     temp{1}=strcat(pathPersonName,'\',dir_expretionFiles(j).name,'\',dir_image(k).name);
                     temp{2}=name; % person name
                     temp{3}=list(x); %file name in each name
                     temp{4}=k; %sequense of images
                     temp{5}= FACSfile;  % AU
                     temp{6}=str2num(Emotionfile); %emotion expression
                     
                     Images=[Images ; temp];
                     
                     
                     %{
                     field1 = 'ImagePath';  value1 = strcat(pathPersonName,'\',dir_expretionFiles(j).name,'\',dir_image(k).name);
                     field2 = 'PersonName';  value2 =name; % person name
                     field3 = 'exprssionFileName';  value3 =list(x); %file name in each name
                     field4 = 'SequenseOfImages';  value4=k; %sequense of images
                     field5 = 'AU';  value5 = FACSfile;  % AU
                     field6 = 'Emotion';  value6 =str2num(Emotionfile); %emotion expression

                     Image = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6);
                     %}
                 end
                 
                 
                 
            end
        end
    end
   
end
end