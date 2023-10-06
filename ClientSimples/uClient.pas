unit uClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Edit, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  IdTCPConnection, IdTCPClient, IdGlobal;

type
  TForm1 = class(TForm)
    btnConectar: TButton;
    btnEnviar: TButton;
    Layout1: TLayout;
    edtIP: TEdit;
    edtPorta: TEdit;
    TCPClient: TIdTCPClient;
    edtMessage: TEdit;
    procedure btnConectarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnConectarClick(Sender: TObject);
begin
  TCPClient.Port := edtPorta.Text.ToInteger;
  TCPClient.Host := edtIP.Text;
  TCPClient.Connect;
end;

procedure TForm1.btnEnviarClick(Sender: TObject);
begin
  TCPClient.IOHandler.WriteLn(edtMessage.Text, IndyTextEncoding_ASCII());
end;

end.
