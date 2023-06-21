unit cdCidade;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, DbCtrls, Buttons;

type

  { TcadCidade }

  TcadCidade = class(TForm)
    btNovo: TBitBtn;
    btCancelar: TBitBtn;
    btDeletar: TBitBtn;
    btSalvar: TBitBtn;
    btBuscar: TBitBtn;
    dsEstado: TDataSource;
    dsCidade: TDataSource;
    DBEdit1: TDBEdit;
    dbNome: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    edtBusca: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    procedure btBuscarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btDeletarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  cadCidade: TcadCidade;

implementation

{$R *.lfm}

Uses
  uModule;

{ TcadCidade }


procedure TcadCidade.FormShow(Sender: TObject);
begin
     Module.qrCidade.Open;
     Module.qrEstado.Open;
end;

procedure TcadCidade.btNovoClick(Sender: TObject);
begin
     Module.qrCidade.Insert;

     btNovo.Enabled:= false;
     btCancelar.Enabled:= true;
     btDeletar.Enabled:= false;
     btSalvar.Enabled:=true;

     if ( dbNome.CanFocus) then
       dbNome.SetFocus;
end;

procedure TcadCidade.btSalvarClick(Sender: TObject);
begin
              //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrCidade.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrCidade.CommitUpdates; //... and commit them using the transaction.
        //SQLTransaction1.Active now is false
          btNovo.Enabled:= true;
          btCancelar.Enabled:= false;
          btDeletar.Enabled:= true;
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

procedure TcadCidade.FormCreate(Sender: TObject);
begin
      btNovo.Enabled:= true;
    btCancelar.Enabled:= false;
    btDeletar.Enabled:= true;
    btSalvar.Enabled:= false;
end;

procedure TcadCidade.btCancelarClick(Sender: TObject);
begin
     Module.qrCidade.Cancel;
     Module.qrCidade.CancelUpdates;

     btNovo.Enabled:= true;
     btCancelar.Enabled:= false;
     btDeletar.Enabled:= true;
     btSalvar.Enabled:=false;
end;

procedure TcadCidade.btBuscarClick(Sender: TObject);
  var
strBusca : String;
begin
strBusca:= Trim(edtBusca.Text);

if (strBusca.Length > 0) then
begin
Module.qrCidade.Close;
Module.qrCidade.SQL.Clear;
Module.qrCidade.SQL.Text:= 'select c.*, e.SIGLA from cidade c, estado e where c.id_estado = e.id_estado and   c.NOME like :SQLTEXTO order by c.ID_CIDADE' ;
Module.qrCidade.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
Module.qrCidade.Open;

end

Else
begin
// ShowMessage('Nenhum nome foi encontrado com esses caracteres !');
Module.qrCidade.Close;
Module.qrCidade.SQL.Clear;
Module.qrCidade.SQL.Text:= 'select c.*, e.SIGLA from cidade c, estado e where c.id_estado = e.id_estado order by c.ID_CIDADE';
Module.qrCidade.Open;
end;
end;

procedure TcadCidade.btDeletarClick(Sender: TObject);
begin
         if MessageDlg('Atenção', 'Você deseja mesmo deletar esse cadastro ?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
  Module.qrCidade.Delete;
  Module.qrCidade.ApplyUpdates; //Pass user-generated changes back to database...
  Module.qrCidade.CommitUpdates; //... and commit them using the transaction.
  end;
end;

end.

