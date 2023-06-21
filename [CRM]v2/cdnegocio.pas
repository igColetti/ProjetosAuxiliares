unit cdNegocio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, DbCtrls, Buttons, Menus, db;
type

  { TcadNegocio }

  TcadNegocio = class(TForm)
    btNovo: TBitBtn;
    btCancelar: TBitBtn;
    btDelete: TBitBtn;
    btSalvar: TBitBtn;
    btBusca: TBitBtn;
    dsNegocio: TDataSource;
    dsEtapaBusca: TDataSource;
    dsPessoaJuridica: TDataSource;
    dsPessoaFisica: TDataSource;
    dsEtapa: TDataSource;
    dsPedido: TDataSource;
    DBEdit4: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    edtTitulo: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    lkBuscaEtapa: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    dbSituacao: TDBRadioGroup;
    edtBusca: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    rdVisu: TRadioGroup;
    procedure btBuscaClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure dsNegocioStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lkBuscaEtapaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdVisuClick(Sender: TObject);
  private

  public

    procedure Busca;

  end;

var
  cadNegocio: TcadNegocio;

implementation

{$R *.lfm}

Uses
  uModule;

{ TcadNegocio }

procedure TcadNegocio.FormShow(Sender: TObject);
begin
        Module.qrNegocio.Open;
        Module.qrPedido.Open;
        Module.qrEtapa.Open;
        Module.qrCFisicaNegocio.Open;
        Module.qrCJuridicaNegocio.Open;
        Module.qrEtapaBusca.Open;



        rdVisu.ItemIndex:= 2;



end;

procedure TcadNegocio.rdVisuClick(Sender: TObject);
begin

   Busca;

end;

procedure TcadNegocio.Busca;
var  strBusca : String;
begin

    strBusca:= Trim(edtBusca.Text);


   Module.qrNegocio.Close;
   Module.qrNegocio.SQL.Clear;
   Module.qrNegocio.SQL.Text:=

 ' select a.*,B.ID_CONTATO,B.NOME,C.DESCRICAO,D.ID_CONTATO,D.NOME,p.total from negocio a join contato b on a.id_contato_organizacao = b.id_contato '
 + 'join contato d on a.id_contato_pessoa = d.id_contato '
 + 'join etapa c on a.id_etapa = c.id_etapa '
 + 'left outer join pedido p on a.id_pedido = p.id_pedido';


    if (rdVisu.ItemIndex = 0 ) then
    begin
        Module.qrNegocio.SQL.Text := Module.qrNegocio.SQL.Text + ' where  a.SITUACAO = :SQLTEXTO1 ';
        Module.qrNegocio.ParamByName('SQLTEXTO1').AsString := 'G';
    end;

    if (rdVisu.ItemIndex = 1 ) then
    begin
       Module.qrNegocio.SQL.Text := Module.qrNegocio.SQL.Text + ' where a.SITUACAO = :SQLTEXTO ';
       Module.qrNegocio.ParamByName('SQLTEXTO').AsString := 'P';
    end;


    if (lkBuscaEtapa.KeyValue > -1) and  (rdVisu.ItemIndex = 2 ) then
      begin
        Module.qrNegocio.SQL.Text :=  Module.qrNegocio.SQL.Text + ' where c.id_etapa = :SQLVALOR ';
        Module.qrNegocio.ParamByName('SQLVALOR').AsInteger := lkBuscaEtapa.KeyValue;
      end;

      if (lkBuscaEtapa.KeyValue > -1) and  (rdVisu.ItemIndex <> 2 ) then
      begin
        Module.qrNegocio.SQL.Text :=  Module.qrNegocio.SQL.Text + ' and c.id_etapa = :SQLVALOR ';
        Module.qrNegocio.ParamByName('SQLVALOR').AsInteger := lkBuscaEtapa.KeyValue;
      end;


       if  (rdVisu.ItemIndex = 2 ) and (strBusca.Length > 0) then
       begin
           Module.qrNegocio.SQL.Text :=  Module.qrNegocio.SQL.Text + ' where  a.descricao like :SQLTEXTO';
           Module.qrNegocio.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
       end;

       if ( rdVisu.ItemIndex <> 2) and (strBusca.Length > 0)then
       begin
           Module.qrNegocio.SQL.Text :=  Module.qrNegocio.SQL.Text + ' and a.descricao like :SQLTEXTO';
           Module.qrNegocio.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
       end;

   // ShowMessage(Module.qrNegocio.SQL.Text);
    Module.qrNegocio.Open;
end;

 {  ////////////
   strBusca : String;
begin
  strBusca:= Trim(edtBusca.Text);

if (strBusca.Length > 0) then
begin
Module.qrNegocio.Close;
Module.qrNegocio.SQL.Clear;
Module.qrNegocio.SQL.Text:= 'select a.*,B.ID_CONTATO,B.NOME,C.ID_ETAPA,C.DESCRICAO,D.ID_CONTATO,D.NOME,p.total from negocio a, contato b, etapa c, contato d, pedido p where a.id_contato_organizacao = b.id_contato  and a.id_contato_pessoa = d.id_contato and a.id_etapa = c.id_etapa and (a.id_pedido = p.id_pedido or a.id_pedido IS NULL)and a.descricao like :SQLTEXTO';
Module.qrNegocio.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
Module.qrNegocio.Open;
 ///////////// }

procedure TcadNegocio.btNovoClick(Sender: TObject);
begin
        Module.qrNegocio.Insert;

        if ( edtTitulo.CanFocus ) then
          edtTitulo.SetFocus;
        btNovo.Enabled:= false;
        btCancelar.Enabled:= true;
        btDelete.Enabled:= false;
        btSalvar.Enabled:= true;
        dbSituacao.ItemIndex:= 2;
end;

procedure TcadNegocio.btSalvarClick(Sender: TObject);
begin
        //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrNegocio.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrNegocio.CommitUpdates; //... and commit them using the transaction.
        //SQLTransaction1.Active now is false
          btNovo.Enabled:= true;
          btCancelar.Enabled:= false;
          btDelete.Enabled:= true;
          btSalvar.Enabled:= false;

        Showmessage('Registro criado com sucesso!');


      end
    except
      on E: EDatabaseError do
       begin

         ShowMessage('Um erro ocorreu. Registro não gravado! Com o erro : ' + E.Message);

       end;

    end;
end;

procedure TcadNegocio.dsNegocioStateChange(Sender: TObject);
begin
         IF (dsNegocio.State in [dsInsert,dsEdit]) then
         begin
            btNovo.Enabled:= false;
            btCancelar.Enabled:= true;
            btDelete.Enabled:= false;
            btSalvar.Enabled:= true;
         end;
end;

procedure TcadNegocio.FormCreate(Sender: TObject);
begin
btNovo.Enabled:= true;
btCancelar.Enabled:= false;
btDelete.Enabled:= true;
btSalvar.Enabled:= false;
end;

procedure TcadNegocio.lkBuscaEtapaChange(Sender: TObject);
begin
  Busca;
end;

procedure TcadNegocio.btCancelarClick(Sender: TObject);
begin
        Module.qrNegocio.Cancel;
        Module.qrNegocio.CancelUpdates;
        btNovo.Enabled:= true;
        btCancelar.Enabled:= false;
        btDelete.Enabled:= true;
        btSalvar.Enabled:= false;
end;

procedure TcadNegocio.btBuscaClick(Sender: TObject);
begin
  Busca;
end;

procedure TcadNegocio.btDeleteClick(Sender: TObject);
begin
           if MessageDlg('Atenção', 'Você deseja mesmo deletar esse cadastro ?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
  Module.qrNegocio.Delete;
  Module.qrNegocio.ApplyUpdates; //Pass user-generated changes back to database...
  Module.qrNegocio.CommitUpdates; //... and commit them using the transaction.
  end;
end;

end.

