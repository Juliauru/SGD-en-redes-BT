function Desviacion_VIP_nominal(elemento,In,tipo)
%Desviacion_VIP_nominal: Funci�n para graficar y guardar la tensi�n, potencia e
%intensidad la frecuencia de ocurrencia de las variaciones porcentuales a
%lo largo del a�o.
    %Se crea una carpeta para los resultados de este caso si no existe ya
    dir_name=strcat(pwd,"\Resultados\",elemento); 
    mkdir(dir_name);
    
    %Tratamiento de datos y gr�fica
    [n,m]=size(In);
    dias=[31;28;31;30;31;30;31;31;30;31;30;31];
    titulos=["Enero";"Febrero";"Marzo";"Abril";"Mayo";"Junio";"Julio";"Agosto";"Septiembre";"Octubre";"Noviembre";"Diciembre"];
    if strcmp(tipo,"tensi�n")
        base=1/sqrt(3);
        letra='V';
    else
        base=1;
        letra='P';
    end    
    for i = 1:m
        In_per(i)=(In(i)-base)/base*100;
    end
    %%Figura con la dispersi�n total
    fig2=figure('Position',[300  50   560    400]);
    histogram(In_per,'BinWidth',1,'FaceColor',[0.3010 0.7450 0.9330],'EdgeColor',[0 0.4470 0.7410]);
    hold on
    titulo=sprintf('Variaci�n porcentual de %s en %s',tipo,elemento);
    title(titulo);    
    ylabel('Frecuencia (horas)');
    xlabel('Porcentaje de variaci�n (%)');       
    hold off  
    name_fig=sprintf('%s_%c_Frecuencia.jpg',elemento,letra);
    file_name=strcat(dir_name,'\',name_fig);   
    saveas(fig2,file_name);
    %%Figura con la dispersi�n por meses
    fig3=figure('Position',[200 75 800 600]);
    fig=tiledlayout(3,4);
    fig.TileSpacing='compact';
    fig.Padding='compact';
    anteriores=0;
    titulo=sprintf('Variaci�n porcentual de %s en %s por meses',tipo,elemento);
    title(titulo);
    ylabel(fig,'Frecuencia (horas)');
    xlabel(fig,'Porcentaje de variaci�n (%)');      
    for n=1:12     
       nexttile;
       histogram(In_per((anteriores*24)+1:1:(anteriores+dias(n))*24),'BinWidth',1,'FaceColor',[0.3010 0.7450 0.9330],'EdgeColor',[0 0.4470 0.7410]);
       anteriores=anteriores+dias(n);
       hold on
       titulo=titulos(n);
       title(titulo);  
       hold off 
    end
    name_fig=sprintf('%s_%c_Frecuencia_M.jpg',elemento,letra);
    file_name=strcat(dir_name,'\',name_fig);   
    saveas(fig3,file_name);    
end

