unit tableMaintance;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait,
  FMX.Layouts, FMX.Objects, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls,
  FMX.Controls.Presentation, Data.DB, FireDAC.Comp.Client, FireDAC.DApt, MidasLib, Vcl.CheckLst,
  FMX.ListBox, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, Datasnap.DBClient, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, System.UIConsts, IdHTTP,
  FMX.Edit, System.JSON, WinInet, Winapi.UrlMon, System.Zip, NetEncoding;

type
  TOperacao = (Analyze, API, Check, CheckSum, Drop, Optimize, Repair, Truncate);

  TfrmPrincipal = class(TForm)
    Conexao: TFDConnection;
    pnPai: TPanel;
    recFuncoes: TRectangle;
    lTextoTop: TLayout;
    lTitulo: TLabel;
    lBotoes1: TLayout;
    lBotaoEsquerdo: TLayout;
    btnEsquerda1: TButton;
    lBotaoDireito: TLayout;
    btnDireita1: TButton;
    Button2: TButton;
    lBotoes2: TLayout;
    lBotaoEsquerdo2: TLayout;
    Button3: TButton;
    lBotaoDireito2: TLayout;
    Button4: TButton;
    lResultado: TLayout;
    lProcessamento: TLayout;
    lbProcessamento: TLabel;
    recImageMemocash: TRectangle;
    imgFundo: TImage;
    imgTexto: TImage;
    recTabelas: TRectangle;
    lTituloTabelas: TLayout;
    lbTabelas: TLabel;
    StyleBook1: TStyleBook;
    ListCheckBox: TListBox;
    ScrollVertical: TVertScrollBox;
    lvResultado: TListView;
    Layout1: TLayout;
    ckSelecionarTudo: TCheckBox;
    cdsResultado: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    lColunasResultado: TLayout;
    Layout3: TLayout;
    lResultadoScroll: TLayout;
    HorzScrollBox1: THorzScrollBox;
    Tabela: TLabel;
    Layout4: TLayout;
    lbOperacao: TLabel;
    Layout5: TLayout;
    lbMsgType: TLabel;
    Layout6: TLayout;
    lbMsgText: TLabel;
    Layout2: TLayout;
    Layout7: TLayout;
    btnCenter2: TButton;
    Edit1: TEdit;
    edtIDCliente: TEdit;
    lbIDCliente: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ckSelecionarTudoChange(Sender: TObject);
    procedure btnEsquerda1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnDireita1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnCenter2Click(Sender: TObject);
    procedure btnCenter3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure ConfigurarConexao;
  public
    { Public declarations }
    procedure MostrarTabelas;
    procedure EventApi;
    procedure EventoBotaoBanco(OP: TOperacao);
    procedure EventoBotaoBancoExec(OP: TOperacao);
    procedure AplicarEstilo;
    procedure DropEscepecifico;
    procedure ApagarArquivoIBD;
    procedure ApagarArquivoEspecificoIBD(tabela: string);
    procedure RodarArquivoSQL(caminho: string);
    procedure CarregarAlerta(mensagem: string);
    procedure CarregarSenha(Acao: TOperacao; titulo, mensagem: string);

    procedure btConfirmarAnalyzeCarregarSenha;
    procedure btConfirmarOptimizeCarregarSenha;
    procedure btConfirmarRepairCarregarSenha;
    procedure btConfirmarCheckCarregarSenha;
    procedure btConfirmarAPICarregarSenha(Sender: TObject);
    procedure btConfirmarDropCarregarSenha(Sender: TObject);
    procedure btConfirmarTruncateCarregarSenha(Sender: TObject);
    procedure btCancelarCarregarSenha(Sender: TObject);

    procedure MensagemCarregando(Acao: TOperacao);
    procedure VerificacaoGeralSenha(Acao: TOperacao);
    procedure GerarPastaSQL;
    function  DescompactarZIP(nome,destino: string): boolean;
    function  RequisitarAPI(JSONToSender: TStringList): TJSONObject;
    function  RequisitarSenhaAPI(JSONToSender: TStringList): TJSONObject;
    function  GetTabelasJSON(): TJSONArray;
    function  GetOpcoesJSON(): TJSONObject;
    function  GetJsonAPI(): TStringList;
    function  GetJSONLoginAPI(): TStringList;
    function  ValidaTabelaSeleciona(): boolean;

  end;
var
  frmPrincipal: TfrmPrincipal;
  SENHA_ADMIN : string = 'batman';

implementation

uses
  Vcl.Controls, Vcl.Graphics, ufrmAlerta, ufrmSenha, uComp;

{$R *.fmx}

{ TfrmPrincipal }

procedure TfrmPrincipal.ApagarArquivoEspecificoIBD(tabela: string);
var
  caminho : string;
  SR: TSearchRec;
  I: integer;
begin
  try
    caminho := 'C:\Program Files (x86)\MariaDB 10.3\data\memocash\'  + tabela + '.ibd';
    if FileExists(caminho) then
    begin
      if not DeleteFile(caminho) then
        CarregarAlerta('Erro ao deletar  ' + caminho);
    end;
  except
    on E: Exception do
      CarregarAlerta(E.Message);
  end;
end;

procedure TfrmPrincipal.ApagarArquivoIBD;
var
  caminho : string;
  SR: TSearchRec;
  I: integer;
begin
  try
    caminho := 'C:\Program Files (x86)\MariaDB 10.3\data\memocash\*.ibd';
    I := FindFirst(caminho, faAnyFile, SR);

    while I = 0 do
    begin
      if (SR.Attr and faDirectory) <> faDirectory then
      begin
        caminho := 'C:\Program Files (x86)\MariaDB 10.3\data\memocash\'  + SR.Name; //MUDAR CAMINHO PARA O PRINCIPAL
        if FileExists(caminho) then
        begin
          if not DeleteFile(caminho) then
            CarregarAlerta('Erro ao deletar  ' + caminho);
        end;

      end;
      I := FindNext(SR);
    end;

  except
    on E: Exception do
      CarregarAlerta(E.Message);
  end;
end;

procedure TfrmPrincipal.AplicarEstilo;
var
  I : integer;
begin
  for I := 0 to lvResultado.Items.Count - 1 do
  begin
    if (cdsResultado.FieldByName('msg_type').AsString <> 'status') then
    begin
      lvResultado.Items[I].Objects.FindObjectT<TListItemText>('table').TextColor    := claRed;
      lvResultado.Items[I].Objects.FindObjectT<TListItemText>('operacao').TextColor := claRed;
      lvResultado.Items[I].Objects.FindObjectT<TListItemText>('msg_type').TextColor := claRed;
      lvResultado.Items[I].Objects.FindObjectT<TListItemText>('msg_text').TextColor := claRed;
    end;
  end;
end;

procedure TfrmPrincipal.btCancelarCarregarSenha(Sender: TObject);
begin
  try
    frmSenha.Close;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btConfirmarAnalyzeCarregarSenha;
begin
  try
    EventoBotaoBanco(Analyze);
    AplicarEstilo;

  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btConfirmarAPICarregarSenha(Sender: TObject);
var
  JsonToSender : TStringList;
  retorno      : string;
  RetornoFTP   : TJSONObject;
  RetornoLogin : TJSONObject;
  Dados        : TJSONObject;
  teste        : string;
begin
  try
    JsonToSender := GetJSONLoginAPI;
    RetornoLogin := RequisitarSenhaAPI(GetJSONLoginAPI);
    LogTable(Now, 'LOGIN', RetornoLogin.ToString);

    if RetornoLogin.GetValue<string>('Status') = 'true' then
    begin
      EventoBotaoBancoExec(Drop);
      //ApagarArquivoIBD;
      JsonToSender := GetJsonAPI;
      LogTable(Now, 'LOGIN - TABELAS', GetTabelasJSON.ToString);

      RetornoFTP := RequisitarAPI(JsonToSender);

      if RetornoFTP.GetValue<string>('Status') = 'true' then
        GerarPastaSQL                                                //CRIANDO -PASTA- PARA EXTRAIR O ARQUIVO ZIP DA API
      else
        CarregarAlerta(RetornoFTP.GetValue<string>('Resposta'));

      FreeAndnil(JSONToSender);
      frmSenha.Close;
    end
    else
    begin
      CarregarAlerta(RetornoLogin.GetValue<string>('Resposta'));
      frmSenha.edtInputDados.SetFocus;
    end;

  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btConfirmarCheckCarregarSenha;
begin
  try
    EventoBotaoBanco(Check);
    AplicarEstilo;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btConfirmarDropCarregarSenha(Sender: TObject);
var
  JsonToSender : TStringList;
  RetornoLogin : TJSONObject;
begin
  try
    JsonToSender := GetJSONLoginAPI;
    RetornoLogin := RequisitarSenhaAPI(GetJSONLoginAPI);

    if RetornoLogin.GetValue<string>('Status') = 'true' then
    begin
      EventoBotaoBanco(Drop);
      ApagarArquivoIBD;
      frmSenha.Close;
    end
    else
    begin
      CarregarAlerta(RetornoLogin.GetValue<string>('Resposta'));
      frmSenha.edtInputDados.SetFocus;
    end;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btConfirmarOptimizeCarregarSenha;
begin
  try
    EventoBotaoBanco(Optimize);
    AplicarEstilo;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btConfirmarRepairCarregarSenha;
begin
  try
    EventoBotaoBanco(Repair);
    AplicarEstilo;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btConfirmarTruncateCarregarSenha(Sender: TObject);
var
  JsonToSender : TStringList;
  RetornoLogin : TJSONObject;
begin
  try
    JsonToSender := GetJSONLoginAPI;
    RetornoLogin := RequisitarSenhaAPI(GetJSONLoginAPI);

    if RetornoLogin.GetValue<string>('Status') = 'true' then
    begin
      EventoBotaoBanco(Truncate);
      frmSenha.Close;
    end
    else
    begin
      CarregarAlerta(RetornoLogin.GetValue<string>('Resposta'));
      frmSenha.edtInputDados.SetFocus;
    end;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.btnCenter2Click(Sender: TObject);
var
  I : integer;
begin
  if not ValidaTabelaSeleciona then
    CarregarAlerta('Execute um comando para identificar as tabelas que estão com erro');

  ckSelecionarTudo.IsChecked := false;
  for I := 0 to lvResultado.Items.Count - 1 do
  begin
    if lvResultado.Items[I].Objects.FindObjectT<TListItemText>('msg_type').Text <> 'status' then //  .Selected.Index.ToBoolean then
      ListCheckBox.ListItems[I].IsChecked := true
  end;
end;

procedure TfrmPrincipal.btnCenter3Click(Sender: TObject);
begin
  VerificacaoGeralSenha(Truncate);
end;

procedure TfrmPrincipal.btnDireita1Click(Sender: TObject);
begin
  MensagemCarregando(Optimize);
  LogTable(Now, 'OPTIMIZE');
end;

procedure TfrmPrincipal.btnEsquerda1Click(Sender: TObject);
begin
  MensagemCarregando(Check);
  LogTable(Now, 'CHECK');
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  MensagemCarregando(Drop);
  LogTable(Now, 'DROP');
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  MensagemCarregando(API);
  LogTable(Now, 'API');
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
  MensagemCarregando(Analyze);
  LogTable(Now, 'ANALYZE');
end;

procedure TfrmPrincipal.Button4Click(Sender: TObject);
begin
  MensagemCarregando(Repair);
  LogTable(Now, 'REPAIR');
end;

procedure TfrmPrincipal.CarregarAlerta(mensagem: string);
begin
  frmAlerta := TfrmAlerta.Create(frmPrincipal);
  frmAlerta.CarregarMensagem(mensagem);
  frmAlerta.ShowModal;
end;

procedure TfrmPrincipal.CarregarSenha(Acao: TOperacao; titulo, mensagem: string);
begin
  try
    frmPrincipal.pnPai.Enabled := false;
    if not ValidaTabelaSeleciona then
    begin
      CarregarAlerta('Nenhuma tabela selecionada. ' + #13 + 'Após isso, todas as tabelas do banco offline serão deletadas e baixará todas do online.');
    end;
    if Acao in [API,Drop,Truncate] then
    begin
      frmSenha := TfrmSenha.Create(frmPrincipal);
      frmSenha.CarregarMensagem(titulo, mensagem);

      case Acao of
        API:
          frmSenha.Confirmar := btConfirmarAPICarregarSenha;
        Drop:
          frmSenha.Confirmar := btConfirmarDropCarregarSenha;
        Truncate:
          frmSenha.Confirmar := btConfirmarTruncateCarregarSenha;
      end;

      frmSenha.Cancelar  := btCancelarCarregarSenha;
      frmSenha.ShowModal;
    end;

    case Acao of
      Analyze:
        btConfirmarAnalyzeCarregarSenha;
      Check:
        btConfirmarCheckCarregarSenha;
      Optimize:
        btConfirmarOptimizeCarregarSenha;
      Repair:
        btConfirmarRepairCarregarSenha;
    end;
    frmPrincipal.pnPai.Enabled := true;

  except
    on E: Exception do
      CarregarAlerta(E.Message)
  end;
end;

procedure TfrmPrincipal.ckSelecionarTudoChange(Sender: TObject);
var
 I  : Integer;
begin
  for I := 0 to ListCheckBox.Count -1 do
    ListCheckBox.ListItems[I].IsChecked := ckSelecionarTudo.IsChecked;
end;

procedure TfrmPrincipal.ConfigurarConexao;
var
  teste: integer;
begin
  try
    Conexao.Params.Clear;
    Conexao.DriverName := 'MySQL';
    Conexao.Params.Add('Database=memocash');
    Conexao.Params.Add('User_name=master');
    Conexao.Params.Add('Server=127.0.0.1');
    Conexao.Params.Add('Password=123456789');
    Conexao.Params.Add('Port=3306');

  except
    on E: Exception do
      CarregarAlerta(E.Message);
  end;
end;

function TfrmPrincipal.DescompactarZIP(nome, destino: string): boolean;
var
  Descompactar : TZipFile;
begin
  try
    Descompactar := TZipFile.Create;
    Descompactar.Open(nome, zmRead);
    Descompactar.ExtractAll(destino);
    Descompactar.Close;
    result := true;
  finally
    FreeAndNil(Descompactar)
  end;
end;

procedure TfrmPrincipal.DropEscepecifico;
var
  I   : integer;
  Qry : TFDQuery;
begin
  for I := 0 to lvResultado.Items.Count - 1 do
  begin
    if lvResultado.Selected.Index > -1 then
    begin
      ckSelecionarTudo.IsChecked := false;
      Qry                        := TFDQuery.Create(nil);
      Qry.Connection             := Conexao;

      with Qry do
      begin
        with Sql do
        begin
          //Add('DROP TABLE ' + lvResultado. );
        end;
      end;
    end;
  end;
end;

procedure TfrmPrincipal.EventApi;
begin
  //
end;

procedure TfrmPrincipal.EventoBotaoBanco(OP: TOperacao);
var
  Qry     : TFDQuery;
  I       : integer;
  acao    : string;
  teste   : integer;
begin
  try
    cdsResultado.EmptyDataSet;

    for I := 0 to ListCheckBox.Count -1 do
    begin
      if ListCheckBox.ListItems[I].IsChecked then
      begin
        Qry            := TFDQuery.Create(nil);
        Qry.Connection := Conexao;

        case OP of
          Analyze:
            acao := 'ANALYZE';
          Check:
            acao := 'CHECK';
          Drop:
            acao := 'DROP';
          Optimize:
            acao := 'OPTIMIZE';
          Repair:
            acao := 'REPAIR';
          Truncate:
            acao := 'TRUNCATE';
        end;

        with Qry do
        begin
          with SQL do
          begin
            Add(acao + ' TABLE ' + ListCheckBox.ListItems[I].Text);
          end;
          Open;

          cdsResultado.Insert;
          cdsResultado.FieldByName('tabela').AsString   := FieldByName('Table').AsString.Replace('memocash.','');
          cdsResultado.FieldByName('operacao').AsString := FieldByName('Op').AsString;
          cdsResultado.FieldByName('msg_type').AsString := FieldByName('Msg_type').AsString;
          cdsResultado.FieldByName('msg_text').AsString := FieldByName('Msg_text').AsString;

          if FieldByName('Msg_text').AsString.Length > 50 then
            lResultadoScroll.Width := 700;

          cdsResultado.Post;

          Close;
        end;
      end;
    end;

    cdsResultado.Close;
    cdsResultado.Open;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TfrmPrincipal.EventoBotaoBancoExec(OP: TOperacao);
var
  Qry     : TFDQuery;
  I       : integer;
  acao    : string;
  teste   : integer;
begin
  try
    for I := 0 to ListCheckBox.Count -1 do
    begin
      if ListCheckBox.ListItems[I].IsChecked then
      begin
        Qry            := TFDQuery.Create(nil);
        Qry.Connection := Conexao;

        case OP of
          Drop:
            acao := 'DROP';
          Truncate:
            acao := 'TRUNCATE';
        end;

        with Qry do
        begin
          with SQL do
          begin
            Clear;
            Add(acao + ' TABLE ' + ListCheckBox.ListItems[I].Text);
          end;
          ExecSQL;
        end;

        ApagarArquivoEspecificoIBD(ListCheckBox.ListItems[I].Text);
      end;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  CkBox : TCheckListBox;
  Qry     : TFDQuery;
  Conexao : TFDConnection;
begin
  try
    ConfigurarConexao;
    MostrarTabelas;
  except
    on E: Exception do
  end;
end;

procedure TfrmPrincipal.GerarPastaSQL;
var
  caminho : string;
  Origem  : string;
  Destino : string;
begin
  try
    caminho := 'C:\MemoCash Web\ManutencaoTabelas\DownloadTabelas';
    if not DirectoryExists(caminho) then
      CreateDir(caminho);

    Origem  := 'https://api.memocashweb.com/Temp/memocash_' + edtIDCliente.Text + '.zip';
    Destino := caminho + '\memocashweb_' + edtIDCliente.Text + '.zip';
    UrlDownloadToFile(nil, PChar(Origem), PChar(Destino), 0, nil);

    DescompactarZIP(Destino, caminho);      // DESCOMPACTANDO ZIP DA API NA PASTA EM QUE FOI CRIADA

    RodarArquivoSQL(caminho + '\Temp\memocash_' + edtIDCliente.Text + '.sql');  // RODADNDO ARQUIVO SQL DO ARQUIVO ZIP DENTRO DA PASTA EM QUE FOI CRIADA
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

function TfrmPrincipal.GetJsonAPI: TStringList;
begin
  try
    result := TStringList.Create;
    result.Values['Acao']    := 'DownloadTabelas';
    result.Values['Banco']   := 'memocash_' + edtIDCliente.Text;
    result.Values['Tabelas'] := GetTabelasJSON.ToJSON;
    result.Values['Opcoes']  := GetOpcoesJSON.ToJSON;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

function TfrmPrincipal.GetJSONLoginAPI: TStringList;
var
  base64 : TBase64Encoding;
begin
  try
    base64 := TBase64Encoding.Create;
    result := TStringList.Create;
    result.Values['Cliente'] := edtIDCliente.Text;
    result.Values['Usuario'] := frmSenha.edtUsuario.Text;
    result.Values['Senha']   := base64.Encode(frmSenha.edtInputDados.Text);
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

function TfrmPrincipal.GetOpcoesJSON: TJSONObject;
var
  JSONObject : TJSONObject;
  I          : integer;
begin
  try
    result := TJSONObject.Create;
    result.AddPair('estrutura', 'true');
    result.AddPair('dados', 'true');
    result.AddPair('truncate', 'false');
    result.AddPair('drop', 'true');
  except
    on E: Exception do
      CarregarAlerta(E.Message);
  end;
end;

function TfrmPrincipal.GetTabelasJSON: TJSONArray;
var
  JSONObject : TJSONObject;
  I          : integer;
begin
  try
    result := TJSONArray.Create;
    for I := 0 to ListCheckBox.Items.Count - 1 do
    begin
      if ListCheckBox.ListItems[I].IsChecked then
        Result.AddElement(TJSONString.Create(ListCheckBox.ListItems[I].Text.Replace('memocash.','')));
    end;
  except
    on E: Exception do
      CarregarAlerta(E.Message);
  end;
end;

procedure TfrmPrincipal.MensagemCarregando(Acao: TOperacao);
begin
  try
    Application.ProcessMessages;
    lbProcessamento.Text := 'Processando...';
    Application.ProcessMessages;

    VerificacaoGeralSenha(Acao);

    Application.ProcessMessages;
    lbProcessamento.Text := '';
    Application.ProcessMessages;
  except
    on E: Exception do
    begin
      CarregarAlerta(E.Message);
    end;
  end;
end;

procedure TfrmPrincipal.MostrarTabelas;
var
  CheckBox : TCheckBox;
  Qry      : TFDQuery;
  I        : integer;
begin
  try
    try
      Qry            := TFDQuery.Create(nil);
      Qry.Connection := Conexao;

      with Qry do
      begin
        with SQL do
        begin
          Add('SHOW TABLES');
        end;
        Open;
        First;
        while not EOF do
        begin
          ListCheckBox.Items.Add(FieldByName('Tables_in_memocash').AsString);
          Next;
        end;
        Close;
      end;
    except
      on E: Exception do
      begin
        CarregarAlerta(E.Message);
      end;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

function TfrmPrincipal.RequisitarAPI(JSONToSender: TStringList): TJSONObject;
var
  HTTP         : TIdHTTP;
  Return       : TStringStream;
  fileDownload : TFileStream;
  caminho      : string;
  Origem       : string;
  Destino      : string;
  testeb       : Boolean;
begin
  Return := TStringStream.Create;
  HTTP   := TIdHTTP.Create(nil);

  try
    HTTP.HandleRedirects     := true;
    HTTP.Request.Method      := 'POST';
    HTTP.Request.ContentType := 'application/x-www-form-urlencoded';

    HTTP.Post('http://api.memocashweb.com/ftp.php', JSONToSender, Return);

    HTTP.ProxyParams.BasicAuthentication := true;
    HTTP.Request.BasicAuthentication     := true;

    LogTable(Now, 'FTP', Return.DataString);                              // LOG DE ACESSO

    result := TJSONObject.ParseJSONValue(Return.DataString) as TJSONObject;
  except
    on E: Exception do
    begin
      result := nil;
      CarregarAlerta(E.Message);
    end;
  end;
  FreeAndNil(Return);
  FreeAndNil(HTTP);
end;
function TfrmPrincipal.RequisitarSenhaAPI(JSONToSender: TStringList): TJSONObject;
var
  HTTP         : TIdHTTP;
  Return       : TStringStream;
  fileDownload : TFileStream;
  caminho      : string;
  Origem       : string;
  Destino      : string;
  testeb       : Boolean;
  Retorno      : TJSONObject;
begin
  Return := TStringStream.Create;
  HTTP   := TIdHTTP.Create(nil);

  try
    HTTP.HandleRedirects     := true;
    HTTP.Request.Method      := 'POST';
    HTTP.Request.ContentType := 'application/x-www-form-urlencoded';

    HTTP.Post('http://api.memocashweb.com/login/revenda', JSONToSender, Return);

    HTTP.ProxyParams.BasicAuthentication := true;
    HTTP.Request.BasicAuthentication     := true;

    result := TJSONObject.ParseJSONValue(Return.DataString) as TJSONObject
  except
    on E: Exception do
    begin
      result := nil;
      CarregarAlerta(E.Message);
    end;
  end;
  FreeAndNil(Return);
  FreeAndNil(HTTP);
end;

procedure TfrmPrincipal.RodarArquivoSQL(caminho: string);
var
  Qry      : TFDQuery;
begin
  try
    Qry            := TFDQuery.Create(nil);
    Qry.Connection := Conexao;

    with Qry do
    begin
      with SQL do
      begin
        Clear;
        LoadFromFile(caminho);
      end;
      ExecSQL;
    end;

  finally
    FreeAndNil(Qry);
  end;
end;
function TfrmPrincipal.ValidaTabelaSeleciona(): boolean;
var
  I      : integer;
  valida : boolean;
begin
  valida := false;

  for I := 0 to ListCheckBox.Count -1 do
  begin
    if ListCheckBox.ListItems[I].IsChecked then
    begin
      valida := true;
      break;
    end;
  end;
  result := valida;
end;

procedure TfrmPrincipal.VerificacaoGeralSenha(Acao: TOperacao);
begin
  try
    if not ValidaTabelaSeleciona and not (Acao = API) then
    begin
      CarregarAlerta('Selecione alguma tabela para executar um método.');
      Exit;
    end;

    if (edtIDCliente.Text.IsEmpty) and (Acao = API) then
    begin
      CarregarAlerta('Insira o ID do cliente para executar um método.');
    end
    else
    begin
      CarregarSenha(Acao, 'MemoCash','Usuário');
    end;

  except
    on E: Exception do
      CarregarAlerta(E.Message);
  end;
end;

end.
