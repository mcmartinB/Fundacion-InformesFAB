unit UFNotas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFNotas = class(TForm)
    pnl1: TPanel;
    mmoNotas: TMemo;
    btnAceptar: TButton;
    btnCancelar: TButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    bAceptar: Boolean;
  public
    { Public declarations }
  end;

  function GetNotas( var VNotas: string ): Boolean;


implementation

{$R *.dfm}

var
  FNotas: TFNotas;

function GetNotas( var VNotas: string ): Boolean;
begin
  Application.CreateForm( TFNotas, FNotas );
  try
    FNotas.ShowModal;
    result:= FNotas.bAceptar;
    if result then
      VNotas:= FNotas.mmoNotas.Lines.Text
    else
      VNotas:= '';
  finally
    FreeAndNil( FNotas );
  end;
end;

procedure TFNotas.btnAceptarClick(Sender: TObject);
begin
  bAceptar:= True;
  Close;
end;

procedure TFNotas.btnCancelarClick(Sender: TObject);
begin
  bAceptar:= False;
  Close;
end;

procedure TFNotas.FormCreate(Sender: TObject);
begin
  bAceptar:= False;
end;

end.
