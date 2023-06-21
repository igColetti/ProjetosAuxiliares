unit cdPessoaEmpresa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, uModule;

type

  { TcadPessoaEmpresa }

  TcadPessoaEmpresa = class(TForm)
    btNovo: TBitBtn;
    btCancelar: TBitBtn;
    btSalvar: TBitBtn;
    dsPessoas: TDataSource;
    dsPessoaEmpresa: TDataSource;
    lkPessoa: TDBLookupComboBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    procedure btCancelarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lkPessoaChange(Sender: TObject);
  private

  public

  end;

var
  cadPessoaEmpresa: TcadPessoaEmpresa;

implementation

{$R *.lfm}


{ TcadPessoaEmpresa }

procedure TcadPessoaEmpresa.FormShow(Sender: TObject);
begin
       if ( Module.qrPessoasTIPO.Value = 'F' ) then
          begin
              Module.qrFiltroPessoa.Close;
              Module.qrFiltroPessoa.SQL.Clear;
              Module.qrFiltroPessoa.SQL.Text:= 'Select * from contato a where a.TIPO = :TIPO';
              Module.qrFiltroPessoa.ParamByName('TIPO').AsString := 'J';
              Module.qrFiltroPessoa.Open;
          end;

              if ( Module.qrPessoasTIPO.Value = 'J' ) then
          begin
              Module.qrFiltroPessoa.Close;
              Module.qrFiltroPessoa.SQL.Clear;
              Module.qrFiltroPessoa.SQL.Text:= 'Select * from contato a where a.TIPO = :TIPO';
              Module.qrFiltroPessoa.ParamByName('TIPO').AsString := 'F';
              Module.qrFiltroPessoa.Open;
          end;
end;

procedure TcadPessoaEmpresa.lkPessoaChange(Sender: TObject);
begin
        if ( Module.qrPessoasTIPO.Value = 'F') then
          Module.qrContatoEmpresaID_CONTATO_PF.Value:= Module.qrPessoasID_CONTATO.Value;

       if ( Module.qrPessoasTIPO.Value = 'J') then
          Module.qrContatoEmpresaID_CONTATO_PJ.Value:= Module.qrPessoasID_CONTATO.Value;

end;

procedure TcadPessoaEmpresa.btNovoClick(Sender: TObject);
begin
      Module.qrContatoEmpresa.Insert;
      btNovo.Enabled:= false;
end;

procedure TcadPessoaEmpresa.btSalvarClick(Sender: TObject);
begin
      //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrContatoEmpresa.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrContatoEmpresa.CommitUpdates; //... and commit them using the transaction.
        //SQLTransaction1.Active now is false
          btNovo.Enabled:= true;
          btCancelar.Enabled:= false;
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

procedure TcadPessoaEmpresa.FormCreate(Sender: TObject);
begin
     if ( Module.qrPessoasTipo.Value = 'F' ) then
       lkPessoa.DataField:= 'ID_CONTATO_PJ';

     if ( Module.qrPessoasTipo.Value = 'J' ) then
       lkPessoa.DataField:= 'ID_CONTATO_PF';
end;

procedure TcadPessoaEmpresa.btCancelarClick(Sender: TObject);
begin
      Module.qrContatoEmpresa.Cancel;
      Module.qrContatoEmpresa.CancelUpdates;
      btNovo.Enabled:= true;
      btCancelar.Enabled:= false;
      btSalvar.Enabled:= false;
end;


end.
