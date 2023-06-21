unit cdPessoas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, DBGrids, DbCtrls, Buttons,uModule,cdPessoaEmpresa;

type

  { TcadPessoa }

  TcadPessoa = class(TForm)
    btBusca: TBitBtn;
    btNovo: TBitBtn;
    btDelete: TBitBtn;
    btCancelar: TBitBtn;
    btSalvar: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    dsCidade: TDataSource;
    DBNavigator2: TDBNavigator;
    dsContatoEmpresa: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid3: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    dbTipo: TDBRadioGroup;
    dbAtivo: TDBRadioGroup;
    dsPessoas: TDataSource;
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
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    rdTipo: TRadioGroup;
    titulo: TPanel;
    Panel4: TPanel;
    pnTopo: TPanel;
    Panel2: TPanel;
    procedure btBuscaClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dsPessoasStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdTipoClick(Sender: TObject);
  private

  public

  end;

var
  cadPessoa: TcadPessoa;

implementation


{$R *.lfm}

{ TcadPessoa }


procedure TcadPessoa.FormShow(Sender: TObject);
begin
       Module.qrPessoas.Open;
       Module.qrContatoEmpresa.Open;
       Module.qrCidade.Open;
 {      btNovo.Enabled:= true;
       btCancelar.Enabled:= false;
       btDelete.Enabled:= true;
       btSalvar.Enabled:= false;   }

       dbAtivo.Value:= 'S';
       rdTipo.ItemIndex:= 2;

       dbAtivo.ItemIndex:= 0;
end;


procedure TcadPessoa.rdTipoClick(Sender: TObject);
begin
       if ( rdTipo.ItemIndex = 0 ) then
          begin
          Module.qrPessoas.Close;
          Module.qrPessoas.SQL.Clear;
          Module.qrPessoas.SQL.Text:= 'select * from contato a where a.tipo = :TIPO order by a.nome';
          Module.qrPessoas.ParamByName('TIPO').AsString:= 'F';
          Module.qrPessoas.Open;
          end;

       if ( rdTipo.ItemIndex = 1 ) then
          begin
                Module.qrPessoas.Close;
                Module.qrPessoas.SQL.Clear;
                Module.qrPessoas.SQL.Text:= 'select * from contato a where a.tipo = :TIPO order by a.nome';
                Module.qrPessoas.ParamByName('TIPO').AsString:= 'J';
                Module.qrPessoas.Open;
          end;

       if ( rdTipo.ItemIndex = 2 ) then
          begin
                Module.qrPessoas.Close;
                Module.qrPessoas.SQL.Clear;
                Module.qrPessoas.SQL.Text:= 'select * from contato a order by a.nome';
                Module.qrPessoas.Open;
          end;
end;


procedure TcadPessoa.btNovoClick(Sender: TObject);
begin
       Module.qrPessoas.Insert;

       btNovo.Enabled:= false;
       btCancelar.Enabled:= true;
       btDelete.Enabled:= false;
       btSalvar.Enabled:= true;
       dbAtivo.ItemIndex:= 0;

       if (rdTipo.ItemIndex = 0 ) then
          dbTipo.ItemIndex:= 0;

              if (rdTipo.ItemIndex = 1 ) then
          dbTipo.ItemIndex:= 1;

              if (DBEdit2.CanFocus) then
                 DBEdit2.SetFocus;
end;

procedure TcadPessoa.btSalvarClick(Sender: TObject);
begin
      //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrPessoas.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrPessoas.CommitUpdates; //... and commit them using the transaction.
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

procedure TcadPessoa.Button1Click(Sender: TObject);
var
  form: TForm;
begin
  form := TcadPessoaEmpresa.Create(nil);
  form.ShowModal;
end;

procedure TcadPessoa.Button2Click(Sender: TObject);
begin
   Module.qrContatoEmpresa.Delete;
   Module.qrContatoEmpresa.ApplyUpdates; //Pass user-generated changes back to database...
   Module.qrContatoEmpresa.CommitUpdates;
end;


procedure TcadPessoa.dsPessoasStateChange(Sender: TObject);
begin
       IF (dsPessoas.State in [dsInsert,dsEdit]) then
         begin
            btNovo.Enabled:= false;
            btCancelar.Enabled:= true;
            btDelete.Enabled:= false;
            btSalvar.Enabled:= true;
         end;
end;

procedure TcadPessoa.FormCreate(Sender: TObject);
begin
btNovo.Enabled:= true;
btCancelar.Enabled:= false;
btDelete.Enabled:= true;
btSalvar.Enabled:= false;

{XW := (((Screen.Width) / 100) * 100);
XH := (((Screen.Height) / 100) * 100);

Self.Width := Round(XW);
Self.Height := Round(xH);

TcadPessoa.Position:= poScreenCenter;}


{  w := width; // automatico ou pode usar a constante sh
  Scaled := true;
  if (Screen.width <> sw) then
     Scaleby(screen.width,sw);

  for i := ComponentCount-1 downto 0 do
     with Components[i] do
       begin
         if GetPropInfo(ClassInfo, 'Font') <> nil then
           Font.Size := (width div w) * font.Size;
       end;}
end;

procedure TcadPessoa.btCancelarClick(Sender: TObject);
begin
       Module.qrPessoas.Cancel;
       Module.qrPessoas.CancelUpdates;

       btNovo.Enabled:= true;
       btCancelar.Enabled:= false;
       btDelete.Enabled:= true;
       btSalvar.Enabled:= false;
end;

procedure TcadPessoa.btBuscaClick(Sender: TObject);
  var
strBusca : String;
begin
strBusca:= Trim(edtBusca.Text);

  if (strBusca.Length > 0) and (rdTipo.ItemIndex = 0) then
   begin
    Module.qrPessoas.Close;
    Module.qrPessoas.SQL.Clear;
    Module.qrPessoas.SQL.Text:= 'select * from CONTATO a where a.NOME like :NOME and a.TIPO = :TIPO';
    Module.qrPessoas.ParamByName('NOME').AsString := '%'+edtBusca.Text+'%';
    Module.qrPessoas.ParamByName('TIPO').AsString := 'F';
    Module.qrPessoas.Open;

   end;
  if (strBusca.Length > 0) and (rdTipo.ItemIndex = 1) then
   begin
       Module.qrPessoas.Close;
       Module.qrPessoas.SQL.Clear;
       Module.qrPessoas.SQL.Text:= 'select * from CONTATO a where a.NOME like :NOME and a.TIPO = :TIPO';
       Module.qrPessoas.ParamByName('NOME').AsString := '%'+edtBusca.Text+'%';
       Module.qrPessoas.ParamByName('TIPO').AsString := 'J';
       Module.qrPessoas.Open;
    end;

    if (strBusca.Length > 0) and (rdTipo.ItemIndex = 2) then
     begin

       Module.qrPessoas.Close;
       Module.qrPessoas.SQL.Clear;
       Module.qrPessoas.SQL.Text:= 'select * from CONTATO a where a.NOME like :NOME';
       Module.qrPessoas.ParamByName('NOME').AsString := '%'+edtBusca.Text+'%';
       Module.qrPessoas.Open;


     end;

      if (strBusca.Length <= 0) and (rdTipo.ItemIndex = 0) then
   begin
    Module.qrPessoas.Close;
    Module.qrPessoas.SQL.Clear;
    Module.qrPessoas.SQL.Text:= 'select * from CONTATO a where a.TIPO = :TIPO';
    Module.qrPessoas.ParamByName('TIPO').AsString := 'F';
    Module.qrPessoas.Open;

   end;
  if (strBusca.Length <= 0) and (rdTipo.ItemIndex = 1) then
   begin
       Module.qrPessoas.Close;
       Module.qrPessoas.SQL.Clear;
       Module.qrPessoas.SQL.Text:= 'select * from CONTATO a where a.TIPO = :TIPO';
       Module.qrPessoas.ParamByName('TIPO').AsString := 'J';
       Module.qrPessoas.Open;
    end;

    if (strBusca.Length <= 0) and (rdTipo.ItemIndex = 2) then
     begin

       Module.qrPessoas.Close;
       Module.qrPessoas.SQL.Clear;
       Module.qrPessoas.SQL.Text:= 'select * from CONTATO';
       Module.qrPessoas.Open;


     end;


end;

procedure TcadPessoa.btDeleteClick(Sender: TObject);
begin
      if MessageDlg('Atenção', 'Você deseja mesmo deletar esse cadastro ?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
  Module.qrPessoas.Delete;
  Module.qrPessoas.ApplyUpdates; //Pass user-generated changes back to database...
  Module.qrPessoas.CommitUpdates; //... and commit them using the transaction.
  end;
end;





end.

