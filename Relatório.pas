var
Unity: string;
i: byte;                   
begin
      
  RPMBalanceamento.Text := 'RPM Balanceamento: ' + FloatToStr(Get('RPM Balanceamento'));
  Cliente.Text := 'Cliente: ' + Get('Cliente');      
  Peca.Text := 'Peça: ' + Get('Peça');
  Operador.Text := 'Operador: ' + Get('Operador');
  Obs.Text := Get('Observações');
  Peso.Text := 'Peso: ' + FloatToStr(Get('Peso Rotor')) + ' Kg';        
  Raio1.Text := 'Raio 1: ' + FloatToStr(Get('Raio 1')) + ' mm';
  Raio2.Text := 'Raio 2: ' + FloatToStr(Get('Raio 2')) + ' mm';
  if Get('Miligramas') = True then
    Unity := ' mg'
  else
    Unity := ' g';                                           
    
  RPMTrabalho.Text := 'RPM Trabalho: ' + FloatToStr(Get('RPM Trabalho'));
  
  if Get('Logotipo') <> '' then
    PictureLogotipo.LoadFromFile(Get('Logotipo'));
  if Get('Desenho Peça') <> '' then                             
    PicturePeca.LoadFromFile(Get('Desenho Peça'));

  if Get('Dois Planos') = True then
    begin
    Inicial1.Visible := True;                                                  
    Inicial2.Visible := True;
    Final1.Visible := True;
    Final2.Visible := True;
    Raio1.Visible := True;                                                    
    Raio2.Visible := True;
    ResidualIdeal1.Visible := True;                      
    ResidualIdeal2.Visible := True;          
    end
  else
    begin
    Inicial1.Visible := (Get('Plano Usado') = 1);                                                  
    Inicial2.Visible := (Get('Plano Usado') = 2);
    Final1.Visible := (Get('Plano Usado') = 1);
    Final2.Visible := (Get('Plano Usado') = 2);        
    Raio1.Visible :=(Get('Plano Usado') = 1);                                                    
    Raio2.Visible := (Get('Plano Usado') = 2);
    ResidualIdeal1.Visible := (Get('Plano Usado') = 1);                      
    ResidualIdeal2.Visible := (Get('Plano Usado') = 2);          
    end;              
          
      
  Inicial1.Text := 'Inicial Plano 1: ' +  Get('Peso Residual Inicial 1') + Unity + ' a ' + FloatToStr(Get('Ângulo Residual Inicial 1')) + ' graus';                                                                                              
  Inicial2.Text := 'Inicial Plano 2: ' + Get('Peso Residual Inicial 2') + Unity + ' a ' + FloatToStr(Get('Ângulo Residual Inicial 2')) + ' graus';
  Final1.Text := 'Final Plano 1: ' + Get('Peso Residual Final 1') + Unity + ' a ' + FloatToStr(Get('Ângulo Residual Final 1')) + ' graus';
  Final2.Text := 'Final Plano 2: ' + Get('Peso Residual Final 2') + Unity + ' a ' + FloatToStr(Get('Ângulo Residual Final 2')) + ' graus';      
  ISOG.Visible := Get('Usou ISO');    
  if ISOG.Visible then
    ISOG.Text := 'Classe ISO G: ' + FloatToStr(Get('ISO G'));
  if Get('Residual Ideal 1') > 0 then                          
    ResidualIdeal1.Text := 'Residual Ideal 1: ' +  Format('%2.2f',[(Get('Residual Ideal 1'))]) + Unity;
  if Get('Residual Ideal 2') > 0 then                          
    ResidualIdeal2.Text := 'Residual Ideal 2: ' +  Format('%2.2f',[(Get('Residual Ideal 2'))]) + Unity;

  if Get('Campo 1') <> null then
    Campo1.Text := Get('Campo 1');
  if Get('Campo 2') <> null then                                        
    Campo2.Text := Get('Campo 2');
  if Get('Campo 3') <> null then                                        
    Campo3.Text := Get('Campo 3');
  if Get('Campo 4') <> null then                                        
    Campo4.Text := Get('Campo 4');
  if Get('Campo 5') <> null then                                        
    Campo5.Text := Get('Campo 5');      
              
end.
