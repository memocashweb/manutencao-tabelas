program TablesMaintance;

uses
  System.StartUpCopy,
  FMX.Forms,
  tableMaintance in 'tableMaintance.pas' {frmPrincipal},
  Vcl.CheckLst in 'units\Vcl.CheckLst.pas',
  uComp in 'units\uComp.pas',
  uCompJSON in '..\PDV\units\uCompJSON.pas',
  ufrmAlerta in 'ufrmAlerta.pas' {frmAlerta},
  ufrmSenha in 'ufrmSenha.pas' {frmSenha};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmAlerta, frmAlerta);
  Application.CreateForm(TfrmSenha, frmSenha);
  Application.Run;
end.
