u = ones(1,20);
h = ones(1,20);


s=conv(u,h);
stem(s,'b')
title("Respuesta Escalon")

