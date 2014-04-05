
%****SETUP****%
M=[0,1,0,0,0,0,0,0,0;
0,0,1,1,1,1,0,0,0;
0,0,0,0,0,0,1,1,0;
0,0,0,0,0,0,0,1,0;
0,0,0,1,0,0,0,1,0;
0,0,1,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,1;
0,0,0,0,0,0,1,0,0;
0,0,0,0,0,0,0,0,0];

blocco=3;

nodo_finale=7;

q=8;

n=size(M,1);

canali_in=size(find(M(:,nodo_finale)==1),1);

%****INIZIALIZZAZIONE****%
Z=[];
G_RX{n,n}=[];
Y_RX{n,n}=[];
G_TX{n,n}=[];
Y_TX{n,n}=[];
Z_finale=[];
s=1;
Xo=[];
A=[];
t=1;
l=0;
inizializzazione=0;
G{n,n}=[];


%****CREAZIONE MESSAGGI****%
fid=fopen('windows.jpg');
fid2=fopen('windows.jpg');

X=fread(fid2);
dim=size(X,1);


%****INVIO****%
while( size(Z_finale,1)<dim )

    for nodo=n:-1:1
        nodo
        [G_RX,Y_RX,G_TX,Y_TX,Z_finale,s,l,nodo_finale,G] = NODO(G_RX,Y_RX,G_TX,Y_TX,M,Xo,nodo,q,blocco,n,s,Z_finale,fid,l,nodo_finale,G);
        if nodo~=nodo_finale && n
            for dest=1:l
                G_TX{nodo,dest}=G_RX{nodo,dest};
                Y_TX{nodo,dest}=Y_RX{nodo,dest};
                G_RX{nodo,dest}=[];
                Y_RX{nodo,dest}=[];
            end;
        end;
        G_TX
        Y_TX
        Z_finale
        G
    end;

end;

%****RICEZIONE****%
fclose(fid);
fclose(fid2);
 
dest=fopen('data.jpg','w');
z=uint8(Z_finale.x)
fwrite(dest,z);
fclose(dest);

