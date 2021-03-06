unit ufrmAlerta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, System.Actions, FMX.ActnList, FMX.Layouts;

type
  TfrmAlerta = class(TForm)
    ActionList1: TActionList;
    acEscape: TAction;
    pAlerta: TPanel;
    btOkAlerta: TButton;
    lbTituloAlerta: TLabel;
    lbMsgAlerta: TLabel;
    StyleBook1: TStyleBook;
    lBotoes: TLayout;
    Button1: TButton;
    Button2: TButton;
    procedure acEscapeExecute(Sender: TObject);
    procedure btOkAlertaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CarregarMensagem(mensagem: string; titulo: string = 'Alerta');
    { Public declarations }
  end;

var
  frmAlerta: TfrmAlerta;

implementation

{$R *.fmx}

procedure TfrmAlerta.acEscapeExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmAlerta.btOkAlertaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAlerta.CarregarMensagem(mensagem, titulo: string);
begin
  try
    lbTituloAlerta.Text := titulo;
    lbMsgAlerta.Text    := mensagem;
    btOkAlerta.SetFocus;
  except
    on E: Exception do
  end;
end;

procedure TfrmAlerta.FormCreate(Sender: TObject);
begin
  btOkAlerta.Text := 'OK[ESC]';
  btOkAlerta.TextSettings.Font.Family := 'Roboto';
  btOkAlerta.TextSettings.Font.Size   := 16;
end;

end.
