unit uServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IdUDPServer,
  IdGlobal, FMX.Memo.Types, FMX.Edit, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, IdContext, FMX.Layouts;

type
  TForm1 = class(TForm)
    mLog: TMemo;
    btnServerOn: TButton;
    TCPServer: TIdTCPServer;
    edtPort: TEdit;
    Layout1: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure btnServerOnClick(Sender: TObject);
    procedure IdTCPServerConnect(AContext: TIdContext);
    procedure IdTCPServerExecute(AContext: TIdContext);
    procedure IdTCPServerStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Log(p_sender, p_message: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnServerOnClick(Sender: TObject);
begin
  TCPServer.Bindings.Clear;
  TCPServer.Bindings.Add.Port := edtPort.Text.ToInteger;
  TCPServer.Active            := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TCPServer.OnExecute       := IdTCPServerExecute;
  TCPServer.OnStatus        := IdTCPServerStatus;
  mLog.Lines.Clear;
end;

procedure TForm1.IdTCPServerConnect(AContext: TIdContext);
var
  ip          : string;
  port        : Integer;
  peerIP      : string;
  peerPort    : Integer;

  nClients    : Integer;

  msgToClient : string;
  typeClient  : string;

begin
    ip        := AContext.Binding.IP;
    port      := AContext.Binding.Port;
    peerIP    := AContext.Binding.PeerIP;
    peerPort  := AContext.Binding.PeerPort;

    Log('SERVER', 'Conectado!');
    Log('SERVER', 'Port=' + IntToStr(Port)
                      + ' '   + '(PeerIP=' + PeerIP
                      + ' - ' + 'PeerPort=' + IntToStr(PeerPort) + ')'
           );
    msgToClient := ' ' + typeClient + ' ' + ' :)';
    AContext.Connection.IOHandler.WriteLn( msgToClient );
end;

procedure TForm1.IdTCPServerExecute(AContext: TIdContext);
var
    Port          : Integer;
    PeerPort      : Integer;
    PeerIP        : string;

    msgFromClient : string;
    msgToClient   : string;
begin
    msgFromClient := AContext.Connection.IOHandler.ReadLn;

    peerIP    := AContext.Binding.PeerIP;
    peerPort  := AContext.Binding.PeerPort;

    Log('Client IP =' + PeerIP + ':' + IntToStr(PeerPort), msgFromClient);
end;

procedure TForm1.IdTCPServerStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  Log('Server', AStatusText);
end;

procedure TForm1.Log(p_sender : String; p_message : string);
begin
  TThread.Queue(nil, procedure
                     begin
                         mLog.Lines.Add('[' + p_sender + '] - '
                         + FormatDateTime('dd/mm/yyyy hh:nn', Now()) + ' - ' + p_message);
                     end
               );
end;

end.
