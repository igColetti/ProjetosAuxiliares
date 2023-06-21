unit cdProduto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DbCtrls, DBGrids, StdCtrls;

type

  { TcadProduto }

  TcadProduto = class(TForm)
    btNovo: TBitBtn;
    btCancelar: TBitBtn;
    btDeletar: TBitBtn;
    btSalvar: TBitBtn;
    btBuscar: TBitBtn;
    dsProdutos: TDataSource;
    DBEdit1: TDBEdit;
    dbNome: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dnAtivo: TDBRadioGroup;
    edtBusca: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    rdATIVO: TRadioGroup;
    procedure btCancelarClick(Sender: TObject);
    procedure btDeletarClick(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure dsProdutosStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdATIVOClick(Sender: TObject);
  private

  public

  end;

var
  cadProduto: TcadProduto;

implementation

{$R *.lfm}

Uses
  uModule;

{ TcadProduto }


procedure TcadProduto.FormShow(Sender: TObject);
begin
    Module.qrProdutos.Open;
end;

procedure TcadProduto.rdATIVOClick(Sender: TObject);
begin
          Module.qrProdutos.Close;
        Module.qrProdutos.SQL.Clear;

       if (rdATIVO.ItemIndex = 0 ) then
    begin
        Module.qrProdutos.SQL.Text := 'Select * from PRODUTOS';
        Module.qrProdutos.Open;
    end;

    if (rdAtivo.ItemIndex = 1) then
    begin
        Module.qrProdutos.SQL.Text := 'Select * from PRODUTOS a where a.ATIVO = :SQLATIVO';
        Module.qrProdutos.ParamByName('SQLATIVO').AsString := 'S';
        Module.qrProdutos.Open;
    end;
end;

procedure TcadProduto.btBuscarClick(Sender: TObject);
  var
strBusca : String;
begin
strBusca:= Trim(edtBusca.Text);

  if (strBusca.Length > 0) and (rdATIVO.ItemIndex = 1) then
   begin
    Module.qrProdutos.Close;
    Module.qrProdutos.SQL.Clear;
    Module.qrProdutos.SQL.Text:= 'select * from PRODUTOS a where a.descricao like :SQLTEXTO and a.ATIVO = :SQLATIVO' ;
    Module.qrProdutos.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
    Module.qrProdutos.ParamByName('SQLATIVO').AsString := 'S';
    Module.qrProdutos.Open;

   end;
  if (strBusca.Length > 0) and (rdATIVO.ItemIndex = 0) then
   begin
       Module.qrProdutos.Close;
       Module.qrProdutos.SQL.Clear;
       Module.qrProdutos.SQL.Text:= 'select * from PRODUTOS a where a.DESCRICAO like :SQLTEXTO';
       Module.qrProdutos.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
       Module.qrProdutos.Open;
    end;

    if (strBusca.Length <= 0) and (rdATIVO.ItemIndex = 0) then
     begin

       Module.qrProdutos.Close;
       Module.qrProdutos.SQL.Clear;
       Module.qrProdutos.SQL.Text:= 'select * from PRODUTOS';
       Module.qrProdutos.Open;


     end;

   if (strBusca.Length <= 0) and (rdATIVO.ItemIndex = 1) then
    begin
       Module.qrProdutos.Close;
       Module.qrProdutos.SQL.Clear;
       Module.qrProdutos.SQL.Text:= 'select * from PRODUTOS a where a.ATIVO = :SQLTEXTO';
       Module.qrProdutos.ParamByName('SQLTEXTO').AsString := 'S';
       Module.qrProdutos.Open;
    end;




end;

procedure TcadProduto.btNovoClick(Sender: TObject);
begin
    Module.qrProdutos.Insert;

  if (dbNome.CanSetFocus) then
    dbNome.SetFocus;

     btNovo.Enabled:= false;
     btCancelar.Enabled:= true;
     btDeletar.Enabled:= false;
     btSalvar.Enabled:= true;
     dnAtivo.ItemIndex:= 0;
end;

procedure TcadProduto.btSalvarClick(Sender: TObject);
begin
          //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrProdutos.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrProdutos.CommitUpdates; //... and commit them using the transaction.
        //SQLTransaction1.Active now is false
          btNovo.Enabled:= true;
          btCancelar.Enabled:= false;
          btDeletar.Enabled:= true;
          btSalvar.Enabled:= false;

        Showmessage('Registro criado com sucesso!');
             btNovo.Enabled:= true;
             btCancelar.Enabled:= false;
             btDeletar.Enabled:= true;
             btSalvar.Enabled:= false;


      end
    except
      on E: EDatabaseError do
       begin

         ShowMessage('Um erro ocorreu. Registro não gravado! Com o erro : ' + E.Message);

       end;
   end;
end;

procedure TcadProduto.dsProdutosStateChange(Sender: TObject);
begin
      IF (dsProdutos.State in [dsInsert,dsEdit]) then
  begin
      btNovo.Enabled:= false;
      btCancelar.Enabled:= true;
      btDeletar.Enabled:= false;
      btSalvar.Enabled:= true;
  end;
end;

procedure TcadProduto.FormCreate(Sender: TObject);
begin
     btNovo.Enabled:= true;
   btCancelar.Enabled:= false;
   btDeletar.Enabled:= true;
   btSalvar.Enabled:= false;
   rdATIVO.ItemIndex:= 1;
end;

procedure TcadProduto.btDeletarClick(Sender: TObject);
begin
        if MessageDlg('Atenção', 'Você deseja mesmo deletar esse cadastro ?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
  Module.qrProdutos.Delete;
  Module.qrProdutos.ApplyUpdates; //Pass user-generated changes back to database...
  Module.qrProdutos.CommitUpdates; //... and commit them using the transaction.
  end;
end;

procedure TcadProduto.btCancelarClick(Sender: TObject);
begin
       Module.qrProdutos.Cancel;
     Module.qrProdutos.CancelUpdates;
     btNovo.Enabled:= true;
     btCancelar.Enabled:= false;
     btDeletar.Enabled:= true;
     btSalvar.Enabled:= false;
end;

end.

