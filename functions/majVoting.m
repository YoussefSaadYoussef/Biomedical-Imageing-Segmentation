function result = majVoting(x1,x2,x3)

% majorty voting funtion take three region results and calc majory of them 
result=zeros(size(x1));
 for i=1:size(x1,1)
      for j=1:size(x1,2)
          result(i,j)=x1(i,j)+x2(i,j)+x3(i,j);
          
          if result(i,j) > 1
              result(i,j)=1;
              
          else
              result(i,j) =0 ;
          end
         
      end
      end
 
 imshow(result,[])