function [ pendientes ] = TasaCrecimiento(OD,t,idxt1,idxt2)
%Funcion para obtener la tasa de crecimiento a través de la pendiente en la
%fase de crecimiento exponencial
%OD es una matriz de [m x n] parámetros ordenados en 'm' filas y 'n' columnas. 
%OD corresponde a la densidad óptica a 600 nm.
%t es un vector de [m] parámetros distribuidos en una fila o columna. Representa el tiempo (horas, min, seg, etc)
%idxt1 e idxt2  es la ventana de tiempo seleccionada en la que la función realizará el
%robustfit para obtener la pendiente: (idxt1<tiempo<idxt2)
pendientes=[];
% figure()
% clf;
for i=OD(:,1:end);
    logod=log2(i);
    plot(t,logod,'k-')
    idx=t>idxt1 & t<idxt2;
    brob=robustfit(t(idx),logod(idx));
    m=brob(2); %el parámetro (2) es la pendiente, correspondiente a la tasa de crecimiento
    pendientes=[pendientes;(m)];
    hold on
    y=brob(1)+brob(2).*t(idx);
    x=t(idx);
    plot(x([1 end]), y([1 end]),'ro-','linewidth',2);
end
end

