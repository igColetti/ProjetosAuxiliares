unit uModule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, ZConnection, ZDataset, ZSqlUpdate,
  ZConnectionGroup, ZGroupedConnection,IniFiles;

type

  { TModule }

  TModule = class(TDataModule)
    conexao: TZConnection;
    qrAtividadeASSUNTO: TStringField;
    qrAtividadeDATA: TDateField;
    qrAtividadeDESCRICAO: TStringField;
    qrAtividadeDESCRICAO_1: TStringField;
    qrAtividadeDURACAO: TTimeField;
    qrAtividadeHORA: TTimeField;
    qrAtividadeID_ATIVIDADE: TLongintField;
    qrAtividadeID_CONTATO: TLongintField;
    qrAtividadeID_NEGOCIO: TLongintField;
    qrAtividadeID_ORGANIZACAO: TLongintField;
    qrAtividadeID_TIPO_ATIVIDADE: TLongintField;
    qrAtividadeNOME: TStringField;
    qrAtividadeNOME_1: TStringField;
    qrAtividadeNOTAS: TStringField;
    qrCFisicaNegocioATIVO: TStringField;
    qrCFisicaNegocioCPF_CNPJ: TStringField;
    qrCFisicaNegocioEMAIL: TStringField;
    qrCFisicaNegocioENDERECO: TStringField;
    qrCFisicaNegocioID_CIDADE: TLongintField;
    qrCFisicaNegocioID_CONTATO: TLongintField;
    qrCFisicaNegocioNOME: TStringField;
    qrCFisicaNegocioOBS: TStringField;
    qrCFisicaNegocioTELEFONE1: TStringField;
    qrCFisicaNegocioTELEFONE2: TStringField;
    qrCFisicaNegocioTESTE: TSmallintField;
    qrCFisicaNegocioTIPO: TStringField;
    qrCidadeID_CIDADE: TLongintField;
    qrCidadeID_ESTADO: TLongintField;
    qrCidadeNOME: TStringField;
    qrCidadeSIGLA: TStringField;
    qrCJuridicaNegocioATIVO: TStringField;
    qrCJuridicaNegocioCPF_CNPJ: TStringField;
    qrCJuridicaNegocioEMAIL: TStringField;
    qrCJuridicaNegocioENDERECO: TStringField;
    qrCJuridicaNegocioID_CIDADE: TLongintField;
    qrCJuridicaNegocioID_CONTATO: TLongintField;
    qrCJuridicaNegocioNOME: TStringField;
    qrCJuridicaNegocioOBS: TStringField;
    qrCJuridicaNegocioTELEFONE1: TStringField;
    qrCJuridicaNegocioTELEFONE2: TStringField;
    qrCJuridicaNegocioTESTE: TSmallintField;
    qrCJuridicaNegocioTIPO: TStringField;
    qrContatoEmpresaID_CONTATO_PF: TLongintField;
    qrContatoEmpresaID_CONTATO_PJ: TLongintField;
    qrContatoEmpresaNOME: TStringField;
    qrContatoEmpresaNOME_1: TStringField;
    qrEtapaBuscaDESCRICAO: TStringField;
    qrEtapaBuscaID_ETAPA: TLongintField;
    qrEtapaDESCRICAO: TStringField;
    qrEtapaID_ETAPA: TLongintField;
    qrFiltroPessoaATIVO: TStringField;
    qrFiltroPessoaCPF_CNPJ: TStringField;
    qrFiltroPessoaEMAIL: TStringField;
    qrFiltroPessoaENDERECO: TStringField;
    qrFiltroPessoaID_CIDADE: TLongintField;
    qrFiltroPessoaID_CONTATO: TLongintField;
    qrFiltroPessoaNOME: TStringField;
    qrFiltroPessoaOBS: TStringField;
    qrFiltroPessoaTELEFONE1: TStringField;
    qrFiltroPessoaTELEFONE2: TStringField;
    qrFiltroPessoaTESTE: TSmallintField;
    qrFiltroPessoaTIPO: TStringField;
    qrItensDESCRICAO: TStringField;
    qrItensDESC_ACRESC: TFloatField;
    qrItensID_PEDIDO: TLongintField;
    qrItensID_PEDIDO_ITEM: TLongintField;
    qrItensID_PRODUTO: TLongintField;
    qrItensID_PRODUTO_1: TLongintField;
    qrItensPRECO_UNITARIO: TFloatField;
    qrItensQUANTIDADE: TFloatField;
    qrItensTOTAL_ITEM: TFloatField;
    qrNegocioDATA_CRIACAO: TDateTimeField;
    qrNegocioDESCRICAO: TStringField;
    qrNegocioDESCRICAO_1: TStringField;
    qrNegocioID_CONTATO: TLongintField;
    qrNegocioID_CONTATO_1: TLongintField;
    qrNegocioID_CONTATO_ORGANIZACAO: TLongintField;
    qrNegocioID_CONTATO_PESSOA: TLongintField;
    qrNegocioID_ETAPA: TLongintField;
    qrNegocioID_NEGOCIO: TLongintField;
    qrNegocioID_PEDIDO: TLongintField;
    qrNegocioNOME: TStringField;
    qrNegocioNOME_1: TStringField;
    qrNegocioOBS: TStringField;
    qrNegocioSITUACAO: TStringField;
    qrNegocioTOTAL: TFloatField;
    qrPedidoDATA_COTACAO: TDateField;
    qrPedidoDATA_PEDIDO: TDateField;
    qrPedidoDESCRICAO: TStringField;
    qrPedidoID_PEDIDO: TLongintField;
    qrPedidoID_PEDIDO_STATUS: TLongintField;
    qrPedidoID_PESSOA: TLongintField;
    qrPedidoNOME: TStringField;
    qrPedidoNUM_DOC: TStringField;
    qrPedidoOBSERVACAO: TStringField;
    qrPedidoTIPO: TStringField;
    qrPedidoTOTAL: TFloatField;
    qrPessoas: TZQuery;
    qrPessoasATIVO: TStringField;
    qrPessoasCPF_CNPJ: TStringField;
    qrPessoasEMAIL: TStringField;
    qrPessoasENDERECO: TStringField;
    qrPessoasID_CIDADE: TLongintField;
    qrPessoasID_CONTATO: TLongintField;
    qrPessoasNOME: TStringField;
    qrPessoasOBS: TStringField;
    qrPessoasTELEFONE1: TStringField;
    qrPessoasTELEFONE2: TStringField;
    qrPessoasTESTE: TSmallintField;
    qrPessoasTIPO: TStringField;
    qrProdutoBuscaATIVO: TStringField;
    qrProdutoBuscaDESCRICAO: TStringField;
    qrProdutoBuscaID_PRODUTO: TLongintField;
    qrProdutoBuscaOBS: TStringField;
    qrProdutoBuscaSERVICO: TStringField;
    qrProdutoBuscaVALOR: TFloatField;
    qrProdutosATIVO: TStringField;
    qrProdutosDESCRICAO: TStringField;
    qrProdutosID_PRODUTO: TLongintField;
    qrProdutosOBS: TStringField;
    qrProdutosSERVICO: TStringField;
    qrProdutosVALOR: TFloatField;
    qrStatusDESCRICAO: TStringField;
    qrStatusID_PEDIDO_STATUS: TLongintField;
    qrTipoAtividadeDESCRICAO: TStringField;
    qrTipoAtividadeID_TIPO_ATIVIDADE: TLongintField;
    upPessoas: TZUpdateSQL;
    qrContatoEmpresa: TZQuery;
    upContatoEmpresa: TZUpdateSQL;
    qrFiltroPessoa: TZQuery;
    qrNegocio: TZQuery;
    upNegocio: TZUpdateSQL;
    qrPedido: TZQuery;
    upPedido: TZUpdateSQL;
    qrEtapa: TZQuery;
    qrCFisicaNegocio: TZQuery;
    qrCJuridicaNegocio: TZQuery;
    qrEtapaBusca: TZQuery;
    qrItens: TZQuery;
    upItensPedido: TZUpdateSQL;
    qrAtividade: TZQuery;
    upAtividade: TZUpdateSQL;
    qrProdutos: TZQuery;
    upProdutos: TZUpdateSQL;
    qrStatus: TZQuery;
    qrProdutoBusca: TZQuery;
    qrCidade: TZQuery;
    upCidade: TZUpdateSQL;
    qrEstado: TZQuery;
    qrTipoAtividade: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrItensAfterApplyUpdates(Sender: TObject);
    procedure qrItensAfterInsert(DataSet: TDataSet);
    procedure qrItensApplyUpdateError(DataSet: TDataSet; E: EDatabaseError;
      var DataAction: TDataAction);
    procedure qrItensBeforePost(DataSet: TDataSet);
    procedure qrItensPRECO_UNITARIOChange(Sender: TField);
    procedure qrItensQUANTIDADEChange(Sender: TField);
    procedure qrPedidoAfterScroll(DataSet: TDataSet);
//    procedure qrPedidoAfterScroll(DataSet: TDataSet);
    procedure qrPessoasAfterScroll(DataSet: TDataSet);
  private

  public

  end;

  const
  C_DB_SECTION = 'conexao';

var
  Module: TModule;
  INI: TINIFile;
  database : String;
  host : String;
  porta : String;

implementation

{$R *.lfm}



{ TModule }

procedure TModule.qrPessoasAfterScroll(DataSet: TDataSet);
begin
        IF ( qrPessoasTIPO.Value = 'F' ) THEN
       BEGIN
          qrContatoEmpresa.Close;
          qrContatoEmpresa.SQL.Text:= 'Select a.*,b.Nome,c.Nome from CONTATO_EMPRESA a, CONTATO b, CONTATO c where a.ID_CONTATO_PF = :ID_CONTATO and a.ID_CONTATO_PF = b.ID_CONTATO and a.ID_CONTATO_PJ = c.ID_CONTATO ';
          qrContatoEmpresa.ParamByName('ID_CONTATO').AsInteger := qrPessoasID_CONTATO.Value;
          qrContatoEmpresa.Open;


       end;


     IF ( qrPessoasTIPO.Value = 'J' ) THEN
       BEGIN
          qrContatoEmpresa.Close;
          qrContatoEmpresa.SQL.Text:= 'Select a.*,b.Nome,c.Nome from CONTATO_EMPRESA a, CONTATO b, CONTATO c where a.ID_CONTATO_PJ = :ID_CONTATO and a.ID_CONTATO_PF = b.ID_CONTATO and a.ID_CONTATO_PJ = c.ID_CONTATO';
          qrContatoEmpresa.ParamByName('ID_CONTATO').AsInteger := qrPessoasID_CONTATO.Value;
          qrContatoEmpresa.Open;
       end;
end;

procedure TModule.qrItensAfterInsert(DataSet: TDataSet);
begin
       qrItens.fieldbyname('id_pedido').asinteger   := qrPedido.FieldByName('id_pedido').asinteger;
     qrItensQUANTIDADE.Value:= 1;
end;

procedure TModule.qrItensApplyUpdateError(DataSet: TDataSet; E: EDatabaseError;
  var DataAction: TDataAction);
begin

end;

procedure TModule.qrItensBeforePost(DataSet: TDataSet);
begin

end;

procedure TModule.DataModuleCreate(Sender: TObject);
begin
     INI:= TINIFile.Create('config.ini');

     try
    // Demonstrates reading values from the INI file.
    database:= INI.ReadString(C_DB_SECTION,'database','crm_teste');
    host:= INI.ReadString(C_DB_SECTION,'host','localhost');
    porta:= INI.ReadString(C_DB_SECTION,'porta','3050');

    // Do something with the values read; e.g. verify the password

  {  writeln('database               : ', database);
    writeln('host                 : ', host);
    writeln('porta             : ', porta);
    writeln;
    write('Press Enter to close...');
    Readln; }
    conexao.Database:= database;
    conexao.HostName:= host;
    conexao.Port:= StrToInt(porta);
    conexao.Connected:= true;

  finally
    // After the ini file was used it must be freed to prevent memory leaks.
    INI.Free;
  end;
end;

procedure TModule.qrItensAfterApplyUpdates(Sender: TObject);
var
  id : integer;
begin
  id := qrPedidoID_PEDIDO.Value;
  qrPedido.Refresh;
  qrPedido.Locate('ID_PEDIDO',id,[]);
end;

procedure TModule.qrItensPRECO_UNITARIOChange(Sender: TField);
begin
      qrItensTOTAL_ITEM.Value := ( qrItensPRECO_UNITARIO.Value * qrItensQUANTIDADE.Value);
end;

procedure TModule.qrItensQUANTIDADEChange(Sender: TField);
begin
    qrItensTOTAL_ITEM.Value := ( qrItensPRECO_UNITARIO.Value * qrItensQUANTIDADE.Value);
 //   ShowMessage(qrItensTOTAL_ITEM.Value := ( qrItensPRECO_UNITARIO.Value * qrItensQUANTIDADE.Value);   )
end;

procedure TModule.qrPedidoAfterScroll(DataSet: TDataSet);
begin
             //dsTesteItens.DataSet.Close;
         Module.qrItens.Close;
         Module.qrItens.ParamByName('ID_PEDIDO').AsInteger:= Module.qrPedidoID_PEDIDO.Value;
         //dsTesteItens.dataset.Open;
         Module.qrItens.Open;
end;

{procedure TModule.qrPedidoAfterScroll(DataSet: TDataSet);
begin
           //dsTesteItens.DataSet.Close;
         Module.qrItens.Close;
         Module.qrItens.ParamByName('ID_PEDIDO').AsInteger:= Module.qrPedidoID_PEDIDO.Value;
         //dsTesteItens.dataset.Open;
         Module.qrItens.Open;
end;}


end.

