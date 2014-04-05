function [G_RX,Y_RX,G_TX,Y_TX,Z_finale,s,l,nodo_finale,G] = NODO(G_RX,Y_RX,G_TX,Y_TX,M,Xo,nodo,q,blocco,n,s,Z_finale,fid,l,nodo_finale,G)
            
            %****INIZIALIZZAZIONE****%
            nodi_destinatari=find(M(nodo,:)==1);
            nodi_precedenti=find(M(:,nodo)==1);
            l=size(nodi_destinatari,2);
            m=size(nodi_precedenti,1);
            H=[];
            J=[];
            Z=[];
            o=0;
        
            %****1 NODO****%
            if nodo==1 
                Xo=fread(fid,blocco);
                G_RX{1,1}=[0];
                if isempty(Xo)==1
                    Y_RX{1,1}=1234567890;
                elseif isempty(Xo)==0
                    Y_RX{1,1}=Xo; %Xo
                end; 
            end;
                  
            %****2 NODO****%
            if nodo==2
                if Y_TX{1,1}==1234567890
                %non fa niente..
                elseif Y_TX{1,1}~=1234567890
                    if isempty(G{nodo,1})==1
                        x=size(Y_TX{1,1},1);
                        g_loc=gf(randi(2*q-1,[l,x]),q);
                        G{nodo,1}=g_loc;
                    end;
                        for i=1:l
                            G_RX{nodo,i}=G{nodo,1}(i,:);  
                        end;
                        y_loc=G{nodo,1}*Y_TX{1,1};
                        for i=1:l
                            Y_RX{nodo,i}=y_loc(i,:);
                        end;
                end;
                
            elseif nodo==n 
                if isempty(G_TX{nodo_finale,1})==0             
                    Z{s,1}=G_TX{nodo_finale,1};
                    G_TX{nodo_finale,1}=[];
                    Z_finale=vertcat(Z_finale,Z{s,1});
                    s=s+1;
                end;
             
            %****NODI INTERMEDI****%
            elseif nodo~=1  && 2 && nodo_finale && n %nodi REALI
                for v=1:m
                    b=1;
                    Bb=0;
                    a=nodi_precedenti(v,1);
                    dim=size(G_TX,2);
                        for e=1:n
                            if isempty(G_TX{a,e})==1
                                b=b+1;
                                Bb=Bb+1;
                                if Bb==dim
                                    o=1;
                                    break;
                                end;
                            elseif isempty(G_TX{a,e})==0
                                b=e;
                                break;
                            end;
                        end; 
                        
                        if Bb==dim
                            o=1;
                            break;
                        end;
                        
                    H=vertcat(H,G_TX{a,b});
                        if a~=n-1
                            G_TX{a,b}=[];
                        end;
                    
                    %-----Y
                    b=1;
                    Bb=0;
                    a=nodi_precedenti(v,1);
                    dim=size(Y_TX,2);
                        for e=1:n
                            if isempty(Y_TX{a,e})==1
                                b=b+1;
                                Bb=Bb+1;
                                if Bb==dim
                                    o=1;
                                    break;
                                end;
                            elseif  isempty(Y_TX{a,e})==0
                                b=e;
                                break;
                            end;
                        end;
                        
                        if Bb==dim
                            o=1;
                            break;
                        end;
                        
                    J=vertcat(J,Y_TX{a,b});
                        if a~=n-1
                            Y_TX{a,b}=[];
                        end;                      
                end;
                

                if nodo==2 && 1 
                %non fa nulla..    
                elseif nodo==nodo_finale
                    a=size(H,1);
                    b=size(J,1);
                        if a==0 && b==0
                       %non fa nulla..
                        elseif a==blocco && b==blocco
                            if det(H)==0
                                %G_TX{nodo,1}=[10;10;10];
                                %errore matrice singolare!
                            elseif det(H)~=0
                                G_TX{nodo,1}=H\J
                            end;
                        elseif a>blocco && b>blocco
                            c=rank(H);
                            g=[];
                            y=[];
                                for d=1:1:c
                                    N=H(d,:);
                                    E=J(d,:);
                                    g=vertcat(g,N);
                                    y=vertcat(y,E);
                                end;
                             G_TX{nodo,1}=g\y;
                        elseif a<blocco && b>blocco
                            c=rank(H);
                            g=[];
                                for d=1:1:c
                                    N=H(:,d);
                                    g=horzcat(g,N);
                                end;
                            G_TX{nodo,1}=g\J;
                        end;
                        
                        
                elseif nodo~=2 && 1 && nodo_finale && o==0 
                    if  isempty(G{nodo,1})==1
                        g_loc=gf(randi(2*q-1,[l,m]),q);
                        G{nodo,1}=g_loc;
                    end;
                    A=G{nodo,1}*H;
                    B=G{nodo,1}*J;
                        for i=1:l
                            G_RX{nodo,i}=A(i,:);
                            Y_RX{nodo,i}=B(i,:);
                        end;
                end;                
            end;

   
   
