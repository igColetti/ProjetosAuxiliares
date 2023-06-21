unit menu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, Buttons, StdCtrls;

type

  { TMenuCad }

  TMenuCad = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private

  public

  end;

var
  MenuCad: TMenuCad;

implementation

{$R *.lfm}

Uses
  cdPessoas, cdNegocio, cdAtividade,cdCidade, cdProduto;

{ TMenuCad }

procedure TMenuCad.BitBtn1Click(Sender: TObject);
var
  form : TForm;
begin
   form := TcadPessoa.Create(nil);
   form.ShowModal;
end;

procedure TMenuCad.BitBtn2Click(Sender: TObject);
var
  form : TForm;
begin
    form := TcadNegocio.Create(nil);
    form.ShowModal;
end;

procedure TMenuCad.BitBtn3Click(Sender: TObject);
var
   form : TForm;
begin
   form := TcadAtividades.Create(nil);
   form.ShowModal;
end;

procedure TMenuCad.BitBtn4Click(Sender: TObject);
var
   form : TForm;
begin
   form := TcadCidade.Create(nil);
   form.ShowModal;
end;

procedure TMenuCad.BitBtn5Click(Sender: TObject);
var
   form : TForm;
begin
   form := TcadProduto.Create(nil);
   form.ShowModal;
end;

end.

