unit MontyHall.MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, System.ImageList,
  FMX.ImgList, System.Generics.Collections, FMX.ExtCtrls;

type
  TForm1 = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    Door1RadioButton: TRadioButton;
    Door2RadioButton: TRadioButton;
    Door3RadioButton: TRadioButton;
    ImageList1: TImageList;
    ResultLabel: TLabel;
    Door1ImageViewer: TImageViewer;
    Door2ImageViewer: TImageViewer;
    Door3ImageViewer: TImageViewer;
    Panel1: TPanel;
    openDoorsButton: TSpeedButton;
    WonGamesLabel: TLabel;
    Panel2: TPanel;
    newGameSpeedButton: TSpeedButton;
    LoosedGamesLabel: TLabel;
    procedure newGameSpeedButtonClick(Sender: TObject);
    procedure openDoorsButtonClick(Sender: TObject);
    procedure Door1ImageViewerClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Door1RadioButtonClick(Sender: TObject);
  private
    FGilitoDoor: integer;
    FHasGoat: TArray<boolean>;
    FIsOpen: TArray<boolean>;
    FSize: TSizeF;
    procedure startNewGame;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}

procedure TForm1.Door1RadioButtonClick(Sender: TObject);
begin
  openDoorsButton.Enabled := true;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  FSize.Create(Door1ImageViewer.Width-10, Door1ImageViewer.Height-10);
  startNewGame;
end;

procedure TForm1.startNewGame;
begin
  //Door1Glyph.ImageIndex := 0;
  Door1ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 0);
  Door2ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 0);
  Door3ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 0);

  Door1RadioButton.IsChecked := false;
  Door2RadioButton.IsChecked := false;
  Door3RadioButton.IsChecked := false;

  Door1RadioButton.Enabled := true;
  Door2RadioButton.Enabled := true;
  Door3RadioButton.Enabled := true;

  Randomize;
  FGilitoDoor := random(3);
  FHasGoat := TArray<boolean>.Create(true, true, true);
  FHasGoat[FGilitoDoor] := false;
  FIsOpen := TArray<boolean>.Create(false, false, false);

  ResultLabel.Text := 'Monty Hall (Josep Montoliu 2022)';
  openDoorsButton.Enabled := false;
end;

procedure TForm1.newGameSpeedButtonClick(Sender: TObject);
begin
  startNewGame;
end;

procedure TForm1.openDoorsButtonClick(Sender: TObject);
begin
  if FHasGoat[0] then
    Door1ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 1)
  else
    Door1ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 2);

  if FHasGoat[1] then
    Door2ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 1)
  else
    Door2ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 2);

  if FHasGoat[2] then
    Door3ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 1)
  else
    Door3ImageViewer.Bitmap := ImageList1.Bitmap(FSize, 2);

  if (not FIsOpen[0]) or (not FIsOpen[1]) or (not FIsOpen[2]) then begin
    var vResult :=
      ((not FHasGoat[0]) and Door1RadioButton.IsChecked) or
      ((not FHasGoat[1]) and Door2RadioButton.IsChecked) or
      ((not FHasGoat[2]) and Door3RadioButton.IsChecked);

    if vResult then begin
      ResultLabel.Text := 'You Win!!';
      WonGamesLabel.Text := (WonGamesLabel.Text.ToInteger+1).ToString;
    end else begin
      ResultLabel.Text := 'You loose';
      LoosedGamesLabel.Text := (LoosedGamesLabel.Text.ToInteger+1).ToString;
    end;

    openDoorsButton.Enabled := false;
    Door1RadioButton.Enabled := false;
    Door2RadioButton.Enabled := false;
    Door3RadioButton.Enabled := false;
  end;
end;

procedure TForm1.Door1ImageViewerClick(Sender: TObject);
begin
  var vDoor: integer;

  if Sender=Door1ImageViewer then
    vDoor := 0
  else if Sender=Door2ImageViewer then
    vDoor := 1
  else
    vDoor := 2;

  if not FIsOpen[vDoor] then begin
    FIsOpen[vDoor] := true;
    if FHasGoat[vDoor] then
      TImageViewer(Sender).Bitmap := ImageList1.Bitmap(FSize, 1)
    else
      TImageViewer(Sender).Bitmap := ImageList1.Bitmap(FSize, 2);
  end else begin
    FIsOpen[vDoor] := false;
    TImageViewer(Sender).Bitmap := ImageList1.Bitmap(FSize, 0);
  end;
end;

end.
