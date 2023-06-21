program primeiroProjeto;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, cdPessoas, uModule, cdPessoaEmpresa, cdNegocio, menu,
  cdAtividade, cdCidade, cdProduto, cdVenda;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
//  Application.CreateForm(TcadPessoa, cadPessoa);
  Application.CreateForm(TModule, Module);
 // Application.CreateForm(TcadNegocio, cadNegocio);
  Application.CreateForm(TMenuCad, MenuCad);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  //Application.CreateForm(TcadVenda, cadVenda);
 // Application.CreateForm(TcadProduto, cadProduto);
  //Application.CreateForm(TcadCidade, cadCidade);
 // Application.CreateForm(TcadAtividades, cadAtividades);
//  Application.CreateForm(TcadPessoaEmpresa, cadPessoaEmpresa);
  Application.Run;
end.

