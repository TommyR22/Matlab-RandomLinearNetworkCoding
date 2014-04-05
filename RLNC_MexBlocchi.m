
%INIZIALIZZAZIONE
Z=[];
G=[];
Y=[];
Z_finale=[];
s=1;
%END INIZIALIZZAZIONE

%SETUP
M=[0,1,0,0,0,0,0,0,0;
0,0,1,1,1,1,0,0,0;
0,0,0,1,0,0,1,0,0;
0,0,0,0,0,0,1,0,0;
0,0,0,0,0,1,0,1,0;
0,0,0,0,0,0,1,1,0;
0,0,0,0,0,0,0,1,0;
0,0,0,0,0,0,0,0,1;
0,0,0,0,0,0,0,0,0];

blocco=3;

q=16;

n=size(M,1);

canali_in=size(find(M(:,n-1)==1),1);
%FINE SETUP


%MEX
fid=fopen('windows.jpg');
dest=fopen('data.jpg','w');


fid2=fopen('windows.jpg');

X=fread(fid2);
dim=size(X,1);

Xo=[];
A=[];
t=1;


%SLOT        
slot{1,:}=[1];
   
slot{2,:}=[2 1];
   
slot{3,:}=[3 4 5 6 2 1];
   
slot{4,:}=[7 8 9 3 4 5 6 2 1];
   
slot{5,:}=[7 8 9];
%FINE SLOT

   dim_slot(1)=size(slot{1,:},2);
   dim_slot(2)=size(slot{2,:},2);
   dim_slot(3)=size(slot{3,:},2);
   dim_slot(4)=size(slot{4,:},2);
   dim_slot(5)=size(slot{5,:},2);
   
   dim_slot_totali=size(slot,1);
  

 for i=1:dim_slot_totali
   for h=1:dim_slot(i)
       
        nodo=slot{i,:}(1,h)
            [G,Y,Z_finale,s] = NODO_MexBlocchi(G,Y,M,Xo,nodo,q,blocco,n,s,Z_finale,fid)
          
   end;
 end;  
 
 while( size(Z_finale,1)<dim )
 for i=3:dim_slot_totali
   for h=1:dim_slot(i)
       
        nodo=slot{i,:}(1,h)
            [G,Y,Z_finale,s] = NODO_MexBlocchi(G,Y,M,Xo,nodo,q,blocco,n,s,Z_finale,fid)
          
   end;
 end;
 end;
 
 fclose(fid);
 fclose(fid2);
 
z=uint8(Z_finale.x)

fwrite(dest,z);
fclose(dest);



       

        