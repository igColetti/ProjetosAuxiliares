unit cdAtividade;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, StdCtrls, Buttons, DbCtrls;

type

  { TcadAtividades }

  TcadAtividades = class(TForm)
    btBusca: TBitBtn;
    btNovo: TBitBtn;
    btCancelar: TBitBtn;
    btDeletar: TBitBtn;
    btSalvar: TBitBtn;
    ckLigar: TCheckBox;
    ckPosVenda: TCheckBox;
    ckReuniao: TCheckBox;
    ckTarefa: TCheckBox;
    ckPrazo: TCheckBox;
    ckEmail: TCheckBox;
    ckAlmoco: TCheckBox;
    ckDemonstracao: TCheckBox;
    ckProspecao: TCheckBox;
    ckVisita: TCheckBox;
    dsTipoAtividade: TDataSource;
    dsNegocio: TDataSource;
    dsPessoa: TDataSource;
    dsOrganizacao: TDataSource;
    dsAtividade: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    dbNome: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
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
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    procedure btBuscaClick(Sender: TObject);
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
  cadAtividades: TcadAtividades;

implementation

{$R *.lfm}

Uses
  uModule;

{ TcadAtividades }

procedure TcadAtividades.btBuscaClick(Sender: TObject);
  var
strBusca : String;
filtrocb : String;
begin
 strBusca:= Trim(edtBusca.Text);
 filtrocb := '';

      IF (ckLigar.Checked = true) then
        begin
              filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 1';
        end;

      IF (ckReuniao.Checked = true) then
        begin
              IF (filtrocb = '') then
                      filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 2'
                ELSE
                      filtrocb := filtrocb + ' OR ( a.ID_TIPO_ATIVIDADE = 2 ) ';
        end;

      IF (ckTarefa.Checked = true) then
        begin
              IF (filtrocb = '') then
                      filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 3'
                ELSE
                      filtrocb := filtrocb + ' OR ( a.ID_TIPO_ATIVIDADE = 3 ) ';
        end;

      IF (ckPrazo.Checked = true) then
        begin
              IF (filtrocb = '') then
                filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 4'
              ELSE
                filtrocb := filtrocb + ' OR ( a.ID_TIPO_ATIVIDADE = 4 ) ';
        end;

      IF (ckEmail.Checked = true) then
        begin
              IF (filtrocb = '') then
                filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 5'
              ELSE
                filtrocb := filtrocb + ' OR ( a.ID_TIPO_ATIVIDADE = 5 ) ';
        end;

      IF (ckAlmoco.Checked = true) then
        begin
              IF (filtrocb = '') then
                filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 6'
              ELSE
                filtrocb := filtrocb + ' OR ( a.ID_TIPO_ATIVIDADE = 6 ) ';
        end;

      IF (ckDemonstracao.Checked = true) then
        begin
              IF (filtrocb = '') then
                filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 7'
              ELSE
                filtrocb := filtrocb + ' OR ( a.ID_TIPO_TAREFA = 7 ) ';
        end;

      IF (ckProspecao.Checked = true) then
        begin
              IF(filtrocb = '') then
                filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 8'
              ELSE
                filtrocb := filtrocb + ' OR ( a.ID_TIPO_TAREFA = 8 ) ';
        end;

      IF (ckVisita.Checked = true) then
        begin
              IF (filtrocb = '') then
                filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 9'
              ELSE
                filtrocb := filtrocb + ' OR ( a.ID_TIPO_ATIVIDADE = 9 ) ';
        end;

      IF (ckPosVenda.Checked = true) then
        begin
              IF (filtrocb = '') then
                filtrocb := filtrocb + ' a.ID_TIPO_ATIVIDADE = 10'
              ELSE
                filtrocb := filtrocb + ' OR ( a.ID_TIPO_ATIVIDADE = 10 ) ';
        end;




if (strBusca.Length > 0) then
begin
      if (filtrocb <> '')  then
          filtrocb:= ' and ' + filtrocb;

Module.qrAtividade.Close;
Module.qrAtividade.SQL.Clear;
Module.qrAtividade.SQL.Text:= 'select a.*,b.nome,c.descricao,d.descricao,e.nome from ATIVIDADE a, CONTATO b, NEGOCIO c, tipo_atividade d, contato e where a.id_contato = b.id_contato and a.id_negocio = c.id_negocio and a.id_tipo_atividade = d.id_tipo_atividade and a.id_organizacao = e.id_contato and a.ASSUNTO like :SQLTEXTO ' + filtrocb;
Module.qrAtividade.ParamByName('SQLTEXTO').AsString := '%'+edtBusca.Text+'%';
Module.qrAtividade.Open;

end

Else
begin
// ShowMessage('Nenhum nome foi encontrado com esses caracteres !');


if (filtrocb <> '')  then
          filtrocb:= ' and ' + filtrocb;

Module.qrAtividade.Close;
Module.qrAtividade.SQL.Clear;
Module.qrAtividade.SQL.Text:= 'select a.*,b.nome,c.descricao,d.descricao,e.nome from ATIVIDADE a, CONTATO b, NEGOCIO c, tipo_atividade d, contato e where a.id_contato = b.id_contato and a.id_negocio = c.id_negocio and a.id_tipo_atividade = d.id_tipo_atividade and a.id_organizacao = e.id_contato '+ filtrocb;
Module.qrAtividade.Open;
end;

end;

procedure TcadAtividades.btCancelarClick(Sender: TObject);
begin
     Module.qrAtividade.Cancel;
     Module.qrAtividade.CancelUpdates;

    btNovo.Enabled:= true;
    btCancelar.Enabled:= false;
    btDeletar.Enabled:= true;
    btSalvar.Enabled:= false;
end;

procedure TcadAtividades.btDeletarClick(Sender: TObject);
begin
        if MessageDlg('Atenção', 'Você deseja mesmo deletar esse cadastro ?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
  Module.qrAtividade.Delete;
  Module.qrAtividade.ApplyUpdates; //Pass user-generated changes back to database...
  Module.qrAtividade.CommitUpdates; //... and commit them using the transaction.
  end;
end;

procedure TcadAtividades.btNovoClick(Sender: TObject);
begin
    Module.qrAtividade.Insert;

    btNovo.Enabled:= false;
    btCancelar.Enabled:= true;
    btDeletar.Enabled:= false;
    btSalvar.Enabled:= true;

    if ( dbNome.CanFocus ) then
        dbNome.SetFocus;
end;

procedure TcadAtividades.btSalvarClick(Sender: TObject);
begin
            //module.qrTarefa.Post;
//Module.qrTarefa.ApplyUpdates;
  try
      if Module.conexao.Connected then
      // Only if we are within a started transaction;
      // otherwise you get "Operation cannot be performed on an inactive dataset"
      begin
        Module.qrAtividade.ApplyUpdates; //Pass user-generated changes back to database...
        Module.qrAtividade.CommitUpdates; //... and commit them using the transaction.
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

procedure TcadAtividades.FormCreate(Sender: TObject);
begin
      btNovo.Enabled:= true;
    btCancelar.Enabled:= false;
    btDeletar.Enabled:= true;
    btSalvar.Enabled:= false;
end;


procedure TcadAtividades.FormShow(Sender: TObject);
begin
  Module.qrAtividade.Open;
  Module.qrCFisicaNegocio.Open;
  Module.qrCJuridicaNegocio.Open;
  Module.qrNegocio.Open;
  Module.qrTipoAtividade.Open;
end;

end.

