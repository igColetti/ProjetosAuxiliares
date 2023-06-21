unit cdVenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, DBGrids, Buttons, DbCtrls;

type

  { TcadVenda }

  TcadVenda = class(TForm)
    btBusca: TBitBtn;
    BitBtn2: TBitBtn;
    btNovoDoc: TButton;
    btExcluirDoc: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    DBEdit2: TDBEdit;
    dsItens: TDataSource;
    dsProdutos: TDataSource;
    dsStatus: TDataSource;
    dsPedido: TDataSource;
    dsPessoa: TDataSource;
    DBEdit1: TDBEdit;
    edtDOC: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBGrid1: TDBGrid;
    dbItensPedido: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    GroupBox2: TGroupBox;
    lkProduto: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBRadioGroup1: TDBRadioGroup;
    edtBusca: TEdit;
    GroupBox1: TGroupBox;
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
    pgAbas: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Pedidos: TTabSheet;
    Itens: TTabSheet;
    rdTipo: TRadioGroup;
    procedure BitBtn2Click(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure btExcluirDocClick(Sender: TObject);
    procedure btNovoDocClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure lkProdutoChange(Sender: TObject);
    procedure dsItensStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ItensEnter(Sender: TObject);
    procedure rdTipoClick(Sender: TObject);
  private
    procedure pedidoAfterScrol(dataset: TDataSet);

  public

  end;

var
  cadVenda: TcadVenda;

implementation

{$R *.lfm}

Uses
  uModule;

{ TcadVenda }

procedure TcadVenda.BitBtn2Click(Sender: TObject);
begin
        pgAbas.PageIndex:= 1;
end;

procedure TcadVenda.btBuscaClick(Sender: TObject);
    var
strBusca : String;
begin
strBusca:= Trim(edtBusca.Text);

if (strBusca.Length > 0) then
begin
Module.qrPedido.Close;
Module.qrPedido.SQL.Clear;
Module.qrPedido.SQL.Text:= 'select a.*, b.nome,c.descricao from PEDIDO a, CONTATO b, PEDIDO_STATUS c where a.id_pessoa = b.id_contato and a.id_pedido_status = c.id_pedido_status and a.NUM_DOC like :SQLTEXTO';
Module.qrPedido.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
Module.qrPedido.Open;

end

Else
begin
// ShowMessage('Nenhum nome foi encontrado com esses caracteres !');
Module.qrPedido.Close;
Module.qrPedido.SQL.Clear;
Module.qrPedido.SQL.Text:= 'select a.*, b.nome,c.descricao from PEDIDO a, CONTATO b, PEDIDO_STATUS c where a.id_pessoa = b.id_contato and a.id_pedido_status = c.id_pedido_status';
Module.qrPedido.Open;
end;
end;

procedure TcadVenda.btExcluirDocClick(Sender: TObject);
begin
          if MessageDlg('Atenção', 'Você deseja mesmo deletar esse pedido ?', mtConfirmation,
           [mbYes, mbNo],0) = mrYes
        then
          begin
               Module.qrPedido.Delete;
               Module.qrPedido.ApplyUpdates; //Pass user-generated changes back to database...
               Module.qrPedido.CommitUpdates; //... and commit them using the transaction.
          end;
end;

procedure TcadVenda.btNovoDocClick(Sender: TObject);
begin
        Module.qrPedido.Insert;
      btNovoDoc.Enabled:= false;
      Module.qrPedidoDATA_COTACAO.Value:= date;

      IF (edtDOC.CanFocus) then
          edtDOC.SetFocus;
end;

procedure TcadVenda.Button3Click(Sender: TObject);
begin
        Module.qrPedido.Cancel;
      Module.qrPedido.CancelUpdates;
end;

procedure TcadVenda.Button4Click(Sender: TObject);
begin
              //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrPedido.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrPedido.CommitUpdates; //... and commit them using the transaction.
              btNovoDoc.Enabled:= true;

        Showmessage('Registro criado com sucesso!');
        Module.qrPedido.Refresh;

      end
    except
      on E: EDatabaseError do
       begin

         ShowMessage('Um erro ocorreu. Registro não gravado! Com o erro : ' + E.Message);

       end;
   end;
end;

procedure TcadVenda.Button5Click(Sender: TObject);
begin
    Module.qrItens.Insert;
end;

procedure TcadVenda.Button6Click(Sender: TObject);
begin
   Module.qrItens.Cancel;
   Module.qrItens.CancelUpdates;
                 btNovoDoc.Enabled:= true;
end;

procedure TcadVenda.Button7Click(Sender: TObject);
begin
              if MessageDlg('Atenção', 'Você deseja mesmo deletar esse item ?', mtConfirmation,
           [mbYes, mbNo],0) = mrYes
        then
          begin
               Module.qrItens.Delete;
               Module.qrItens.ApplyUpdates; //Pass user-generated changes back to database...
               Module.qrItens.CommitUpdates; //... and commit them using the transaction.
          end;
end;

procedure TcadVenda.Button8Click(Sender: TObject);
begin
                    //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrItens.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrItens.CommitUpdates; //... and commit them using the transaction.
        Module.qrItens.Refresh;

        Showmessage('Registro criado com sucesso!');

      end
    except
      on E: EDatabaseError do
       begin

         ShowMessage('Um erro ocorreu. Registro não gravado! Com o erro : ' + E.Message);

       end;
   end;
end;

procedure TcadVenda.lkProdutoChange(Sender: TObject);
begin
               IF (lkProduto.KeyValue > 0 ) then
             begin

                 Module.qrProdutoBusca.Close;
                 Module.qrProdutoBusca.ParamByName('ID_PRODUTO').AsInteger:= lkProduto.KeyValue;
                 Module.qrProdutoBusca.Open;


                if (Module.qrProdutoBusca.FieldByName('ID_PRODUTO').Value  = lkProduto.KeyValue) then
                   begin
                      Module.qrItensPRECO_UNITARIO.AsBCD := Module.qrProdutoBusca.FieldByName('VALOR').AsBCD;


                   end
                else
                    ShowMessage('[ERRO] Entre em contato com o suporte !');


             end;
end;

procedure TcadVenda.dsItensStateChange(Sender: TObject);
begin
         {IF (dsItens.State in [dsInsert]) then
  begin
       Module.qrItensPedidoID_PEDIDO.Value:= Module.qrPedidoID_PEDIDO.Value;
  end;}
end;

procedure TcadVenda.FormShow(Sender: TObject);
begin
      Module.qrPedido.Open;
      //Module.qrPedido.AfterScroll:= pedidoAfterScrol;
      Module.qrCFisicaNegocio.Open;
      Module.qrStatus.Open;

      Module.qrProdutos.Open;
      Module.qrItens.Open;
      Module.qrProdutoBusca.Open;
      Module.qrCFisicaNegocio.Refresh;

      rdTipo.ItemIndex:= 2;
end;

procedure TcadVenda.pedidoAfterScrol(dataset:TDataSet);
begin
         //dsTesteItens.DataSet.Close;
         Module.qrItens.Close;
         Module.qrItens.ParamByName('ID_PEDIDO').AsInteger:= Module.qrPedidoID_PEDIDO.Value;
         //dsTesteItens.dataset.Open;
         Module.qrItens.Open;
end;

procedure TcadVenda.ItensEnter(Sender: TObject);
begin

end;

procedure TcadVenda.rdTipoClick(Sender: TObject);
begin
   if ( rdTipo.ItemIndex = 0 ) then
      begin
         Module.qrPedido.Close;
         Module.qrPedido.SQL.Clear;
         Module.qrPedido.SQL.Text:= ' select a.*, b.nome,c.descricao from PEDIDO a, CONTATO b, PEDIDO_STATUS c where a.id_pessoa = b.id_contato and a.id_pedido_status = c.id_pedido_status and a.TIPO = :TIPO';
         Module.qrPedido.ParamByName('TIPO').AsString:= 'P';
         Module.qrPedido.Open;
      end;

      if ( rdTipo.ItemIndex = 1 ) then
      begin
         Module.qrPedido.Close;
         Module.qrPedido.SQL.Clear;
         Module.qrPedido.SQL.Text:= ' select a.*, b.nome,c.descricao from PEDIDO a, CONTATO b, PEDIDO_STATUS c where a.id_pessoa = b.id_contato and a.id_pedido_status = c.id_pedido_status and a.TIPO = :TIPO';
         Module.qrPedido.ParamByName('TIPO').AsString:= 'O';
         Module.qrPedido.Open;
      end;

         if ( rdTipo.ItemIndex = 2 ) then
      begin
         Module.qrPedido.Close;
         Module.qrPedido.SQL.Clear;
         Module.qrPedido.SQL.Text:= ' select a.*, b.nome,c.descricao from PEDIDO a, CONTATO b, PEDIDO_STATUS c where a.id_pessoa = b.id_contato and a.id_pedido_status = c.id_pedido_status';
         Module.qrPedido.Open;
      end;
end;

end.

