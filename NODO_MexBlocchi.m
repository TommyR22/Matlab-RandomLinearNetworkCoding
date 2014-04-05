function [G,Y,Z_finale,s] = NODO_MexBlocchi(G,Y,M,Xo,nodo,q,blocco,n,s,Z_finale,fid)

            nodi_destinatari=find(M(nodo,:)==1);
            nodi_precedenti=find(M(:,nodo)==1);
            l=size(nodi_destinatari,2);
            m=size(nodi_precedenti,1);
            H=[];
            J=[];
            Z=[];
            
        
            if nodo==1 
                Xo=fread(fid,blocco);
                G{nodo,1}=[0];
                if isempty(Xo)==1
                    Y{nodo,1}=1234567890;
                elseif isempty(Xo)==0
                    Y{nodo,1}=Xo;
                end;
            end;
                    
            if nodo==2
                if Y{1,1}==1234567890
        
                    elseif Y{1,1}~=1234567890
                    x=size(Y{1,1},1);
                    e=1;
                    g_loc=gf(randi(2*q-1,[l,x]),q);
                    for i=1:l
                        G{nodo,i}=g_loc(i,:);  
                    end;
                    y_loc=g_loc*Y{1,1};
                    i=1;
                    for i=1:l
                        Y{nodo,i}=y_loc(i,:);
                    end;
                    i=1;
                end;
                
            elseif nodo==n 
                Z{s,1}=G{nodo-1,1};
                G{nodo-1,1}=[];
                Z_finale=vertcat(Z_finale,Z{s,1});
                s=s+1;
                
                
            elseif nodo~=1  && 2 && n-1 && n %nodi REALI
                for v=1:m
                    e=1;
                    b=1;
                    Bb=0;
                    a=nodi_precedenti(v,1);
                        for e=1:n
                            if isempty(G{a,e})==1
                                b=b+1;
                                Bb=Bb+1;
                                if Bb==4%%%%%%%%%%%%%%%%%%
                                    break;
                                end;
                            elseif isempty(G{a,e})==0
                                b=e;
                                break;
                            end;
                        end; 
                        
                        if Bb==4
                            break;
                        end;
                        
                    H=vertcat(H,G{a,b});
                        if a~=n-1
                            G{a,b}=[];
                        end;
                    
                    e=1;%-----Y
                    b=1;
                    Bb=0;
                    a=nodi_precedenti(v,1);
                        for e=1:n
                            if isempty(Y{a,e})==1
                                b=b+1;
                                Bb=Bb+1;
                                if Bb==4%%%%%%%%%%%%%
                                    break;
                                end;
                            elseif  isempty(Y{a,e})==0
                                b=e;
                                break;
                            end;
                        end;
                        
                        if Bb==4
                            break;
                        end;
                        
                    J=vertcat(J,Y{a,b});
                        if a~=n-1
                            Y{a,b}=[];
                        end;%fine Y                       
                end;
                

                if nodo==2 && 1 
                  
                    
                elseif nodo==n-1
                    a=size(H,1);
                    b=size(J,1);
                        if a==blocco && b==blocco
                            G{nodo,1}=H\J;
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
                             G{nodo,1}=g\y;
                        elseif a<blocco && b>blocco
                            c=rank(H);
                            g=[];
                                for d=1:1:c
                                    N=H(:,d);
                                    g=horzcat(g,N);
                                end;
                            G{nodo,1}=g\J;
                        end;
                        
                        
                elseif nodo~=2 && 1 && n-1 && Bb~=4
                    e=1;
                    g_loc=gf(randi(2*q-1,[l,m]),q);
                    A=g_loc*H;
                    B=g_loc*J;
                        for i=1:l
                            G{nodo,i}=A(i,:);
                            Y{nodo,i}=B(i,:);
                        end;
                end;                
            end;


   
