program ClientUDP;

uses
  System.StartUpCopy,
  FMX.Forms,
  uClient in 'uClient.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.