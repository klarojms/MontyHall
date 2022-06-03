program MontyHall;

uses
  System.StartUpCopy,
  FMX.Forms,
  MontyHall.MainForm in 'MontyHall.MainForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
