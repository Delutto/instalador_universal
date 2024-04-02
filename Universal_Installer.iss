#define MyAppName "Instalador Universal de Impressoras Térmicas Não Fiscais"
#define MyAppVersion "0.9.2"
#define MyAppPublisher "Delutto"
#define MyAppURL "https://github.com/Delutto/thermal_printers"
#define MyAppExeName "MyProg.exe"
#define MyAppID "{CAEE27B6-4093-4999-BAC5-5175399A31F0}"

[Setup]
AppId={{#MyAppID}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
CreateAppDir=no
OutputBaseFilename=Instalador_Universal_0.9.2
Compression=lzma2/ultra64
SolidCompression=yes
PrivilegesRequired=none
UsePreviousGroup=False
Uninstallable=no
InternalCompressLevel=ultra64
DisableStartupPrompt=True
DisableReadyPage=True
DisableReadyMemo=True
DisableFinishedPage=True

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[CustomMessages]
CustomForm_Caption=Seleção da Impressora
CustomForm_Description=Selecione a Marca e o Modelo da impressora que deseja instalar os drivers.
CustomForm_Label1_Caption0=Marca
CustomForm_Label2_Caption0=Modelo
CustomForm_ComboBoxModelo_Text0=Selecione o Modelo...
CustomForm_ComboBoxMarca_Text0=Selecione a Marca...

CustomForm_ComboBoxMarca_Strings=Argox%nBematech%nControl ID%nDaruma%nDascom%nDiebold%nDimep%nElgin%nEpson%nEvadin%nFeasso%nGainscha%nGertec%nJetway%nLedtec%nMafra%nMenno%nOi Vida%nPerto%nPOS%nStar%nSweda%nTanca%nWaytec

TODOSList=Todos os modelos
BematechList=MP-100S TH%nMP-2500 TH%nMP-2800 TH%nMP-4000 TH%nMP-4200 TH%nMP-4200 TH ADV%nMP-5100 TH%nPP-10
ControlIDList=Print ID%nPrint ID Touch
DarumaList=DR700%nDR800%nFS700%nFS800
DascomList=DT-210%nDT-230
DieboldList=TSP143MU%nMecaf Perfecta%nIM903TT%nIM693H-002%nIM453HU%nIM433TD%nIM113ID%nIM402TD
DimepList=D-Print Dual
ElginList=iX(i10)%ni7%ni8%ni9%nVOX%nVOX+%nNIX%nProlific Windows 11%nProlific 2303%nProlific 23XX
EpsonList=TM-T20%nTM-T20X%nTM-T81%nTM-T88 III%nTM-T88 IV%nTM-T88 V%nTM-T88 VI%nTM-T88 VII
EvadinList=EP-26M
FeassoList=F-IMTER-01%nF-IMTER-02%nF-IMTER-03
GertecList=G250
JetwayList=JMP-100%nJP-500%nJP-800
LedtecList=PMF
MennoList=IT 250%niTD 250%nLT56050%nLT76050
OiVidaList=OI-58H%nOI-1005%nOI-1007%nOI-1006
PertoList=PertoPrinter
POSList=POS 58%nPOS 80
StarList=BSC10%nFVP10%nMCP20%nMCP21%nMCP30%nMCP31%nPOP10%nSP512%nSP542%nSP712%nSP717%nSP742%nSP747%nTSP043%nTSP143IVUE%nTSP650II%nTSP700II%nTSP800II
SwedaList=SI-150%nSI-250%nSI-300L%nSI-300S%nSI-300E%nSI300W
TancaList=TMP-500%nTP-450%nTP-509%nTP-550%nTP-620%nTP-650
WaytecList=WP-50%nWP-100

Download_Form_Caption=Baixando drivers
Download_Form_Description=Aguarde os drivers necessários serem baixados.
Download_Form_LabelDownloading_Caption0=Baixando...



[Code]
var
   Label1: TLabel;
   Label2: TLabel;
   ComboBoxModelo: TComboBox;
   ComboBoxMarca: TComboBox;
   URL: String;

   LabelDownloading: TLabel;
   ProgressBarDownload: TNewProgressBar;


procedure CustomForm_Activate(Page: TWizardPage);
begin
   WizardForm.ActiveControl := ComboBoxMarca;
   WizardForm.NextButton.Enabled := False;
end;

function CustomForm_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
   Result := False;
end;

function CustomForm_BackButtonClick(Page: TWizardPage): Boolean;
begin
   Result := True;
end;

function IsWindows8OrLater: Boolean;
begin
   Result := (GetWindowsVersion >= $06020000);
end;

function CustomForm_NextButtonClick(Page: TWizardPage): Boolean;
begin
   Result := True;
   case ComboBoxMarca.ItemIndex of
	  0: // Argox
	     URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Argox/Argox_PrinterDrivers_v2022.1.exe';
      1: // Bematech
      begin
         case ComboBoxModelo.ItemIndex of
            2: // MP-2800 TH
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Bematech/Bematech_MP_2800_SpoolerDrivers_v1.3.exe';
            5, 7: // MP-4200 TH ADV e PP-10
            begin
               if IsWin64 then
                  URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Bematech/BematechSpoolerDrivers_x64_v6.0.1.0.exe'
               else
                  URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Bematech/BematechSpoolerDrivers_x86_v6.0.1.0.exe';                  
            end;
            else // Outras...
            begin
               if IsWin64 then
                  URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Bematech/BematechSpoolerDrivers_x64_v4.4.0.3.exe'
               else
                  URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Bematech/BematechSpoolerDrivers_x86_v4.4.0.3.exe';  
            end;
         end;
      end;
	  2: // Control ID
	  begin
	     case ComboBoxModelo.ItemIndex of
		    0: // Print ID
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/PrintID/Print_iD_&_Print_iD_Touch_v1.1.10.2.exe';
			1: // Print ID Toutch
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/PrintID/Print_iD_&_Print_iD_Touch_v1.1.10.2.exe';
		 end;
	  end;
      3: // Daruma
      begin
         case ComboBoxModelo.ItemIndex of
            0: // DR700
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Daruma/Daruma_700_Spooler_Driver_v4.0.3.1.exe';
            1: // DR800
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Daruma/Daruma_800_Spooler_Driver_v2.0.1.7.exe';
            2: // FS700
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Daruma/Daruma_700_Spooler_Driver_v4.0.3.1.exe';
            3: // FS800
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Daruma/Daruma_800_Spooler_Driver_v2.0.1.7.exe';
         end; 
      end;
	  4: // Dascom
	  begin
	     case ComboBoxModelo.ItemIndex of
		    0: // DT-210
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Dascom/Dascom_DT-210_DT-230_Driver_v1.0.0.7.exe';
			1: // DT-230
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Dascom/Dascom_DT-210_DT-230_Driver_v1.0.0.7.exe';
		 end;
	  end;
      5: // Diebold
      begin
         case ComboBoxModelo.ItemIndex of
		    1: // Mecaf Perfecta
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Diebold/Diebold_Printers_v1.34_drv_1.9.exe';
            2: // IM903TT
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Diebold/Diebold_IM903TT_1.0.1.exe';
            6: // IM113ID
            begin
               if IsWin64 then
                  URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Diebold/Diebold_IM113ID_v1.2.0.10_x64.exe'
               else
                  URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Diebold/Diebold_Printers_v1.34_drv_1.9.exe';
            end;
            else
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Diebold/Diebold_Printers_v1.34_drv_1.9.exe';
         end;
      end;
	  6: // Dimep
	  begin
	     URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Dimep/Dimep_D-PRINT_DUAL_v2.1.4.4.exe';
	  end;
      7: // Elgin
      begin
         case ComboBoxModelo.ItemIndex of
            0: // iX(i10)
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Elgin_iX_v1.02.exe';
            1: // i7
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Elgin_i7_i9_v1.7.3.exe';
            2: // i8
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Elgin_i8_v7.1.7.exe';
            3: // i9
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Elgin_i7_i9_v1.7.3.exe';
            4: // VOX
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Elgin_VOX_V1.25.exe';
            5: // VOX+
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Elgin_VOX_V1.25.exe';
            6: // NIX
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Elgin_NIX_Driver_v2.3.0.0.exe';
            7: // Prolific Windwos 11
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/Serial_Virtual_W11_(PL2303v206).exe';
            8: // Prolific 2303
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/PL2303_Driver_v1.12.0.exe';
            9: // Prolific 23XX
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Elgin/PL23XX_Driver_v4.0.2.exe';
         end;
      end;
      8: // Epson
      begin
         case ComboBoxModelo.ItemIndex of
            0: // TM-T20
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T20_v5.6.0.0.exe';
            1: // TM-T20X
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T20X_v6.1.0.0.exe';
            2: // TM-T81
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T81_v15.0.0.498.exe';
            4: // TM-T88 III
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T88_III_v4.exe';
			5: // TM-T88 IV
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T88_IV_4.0.0.0.exe';
            6: // TM-T88 V
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T88_V_v5.6.0.0.exe';
            7: // TM-T88 VI
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T88_VI_v5.11.0.0.exe';
			7: // TM-T88 VII
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Epson/Epson_TM-T88_VII_Driver_v6.7.1.0.exe';
         end;
      end;
	  9: // Evadin
	  begin // EP-26M
         URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/POS/POS_Printer_Driver_Setup_v11.3.0.0.exe';
	  end;
	  10: // Feasso
	  begin
	     case ComboBoxModelo.ItemIndex of
		    0: // F-IMTER-01
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Feasso/Feasso_F-IMTER-01_Driver_v1.7.exe';
			1: // F-IMTER-02
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Feasso/Feasso_F-IMTER-02_Driver_v2.0.exe';
			2: // F-IMTER-03
			   URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Feasso/Feasso_F-IMTER-03_Driver_v1.5.exe';
		 end;
	  end;
	  11: // Gainscha
	  begin
	     URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Gainscha/Gainscha_GPrinterDrivers_v2020.1.exe';
	  end;
	  12: // Gertec
	  begin
	     // G250
	     URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Gertec/Driver-G250-Spooler_VCOM-v1.1.exe';
	  end;	  
      13: // Jetway
      begin
         case ComboBoxModelo.ItemIndex of
            0: //JMP-100
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Jetway/Jetway_JMP-100_Driver_v2.61J.exe';
            end;
            1: //JP-500
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Jetway/Jetway_JP-500_Printer_Driver_v7.17.exe';
            end;
            2: //JP-800
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Jetway/Jetway_JP-800_PrinterDriver_v2.38E.exe';
            end;
         end;
      end;
	  14: // Ledtec
	  begin
	     // PMF
	     if IsWindows8OrLater then // Windows 8/10/11
       begin
         if IsWin64 then
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Ledtec/ENGWORKSPrinters_Win8_10_x64.exe'
         else
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Ledtec/ENGWORKS_Printers_Win8_10_x86.exe';
       end
       else
       begin // Windows 7
         if IsWin64 then
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Ledtec/ENGWORKS_Printers_Win7_x64.exe'
         else
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Ledtec/ENGWORKS_Printers_Win7_x86.exe';
       end;
	  end;
	  15: // Mafra
	  begin
	     URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/POS/POS_Printer_Driver_Setup_v11.3.0.0.exe';
	  end;
	  16: // Menno
	  begin
	     case ComboBoxModelo.ItemIndex of
	        0: // IT 250
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Menno/Menno_Printer_Driver_v2.52.exe';
          end;
          1: // iTD 250
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Menno/Menno_Printer_Driver_v2.52.exe';
          end;
          2: // LT56050
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Menno/Menno_Printer_Driver_v2.52.exe';
          end;
          3: // LT76050
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Menno/Menno_Printer_Driver_v2.52.exe';
          end;
       end;		 
	  end;
	  17: // Oi Vida
	  begin
       case ComboBoxModelo.ItemIndex of
          0: // OI-58H
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/POS/POS_Printer_Driver_Setup_v11.3.0.0.exe';
          end;
          1: // OI-1005
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/POS/POS_Printer_Driver_Setup_v11.3.0.0.exe';
          end;
          2: // OI-1007
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/POS/POS_Printer_Driver_Setup_v11.3.0.0.exe';
          end;
          3: // OI-1006
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/POS/POS_Printer_Driver_Setup_v11.3.0.0.exe';
          end;
       end;
	  end;	  
    18: // Perto
    begin
       URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/PertoPrinter/PertoPrinter_Driver_2.5.exe';
    end;
    19: // POS
    begin
       URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/POS/POS_Printer_Driver_Setup_v11.3.0.0.exe';
    end;
	  20: // Star
	  begin
	     case ComboBoxModelo.ItemIndex of
          0: // BSC10
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_BSC10_Drivers_v2.1_x64.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_BSC10_Drivers_v2.1_x86.exe';
          end;
          1: // FVP10
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          2: // MCP20
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.1.1.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.1.1.exe';
          end;
          3: // MCP21
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.1.1.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.1.1.exe';
          end;
          4: // MCP30
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.1.1.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.1.1.exe';
          end;
          5: // MCP31
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.1.1.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.1.1.exe';
          end;
          6: // POP10
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.1.1.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.1.1.exe';
          end;
          7: // SP512
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          8: // SP542
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          9: // SP712
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          10: // SP717
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          11: // SP742
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          12: // SP747
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          13: // TSP043
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_TSP043_x64_v2.1.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_TSP043_x86_v2.1.exe';
          end;
          14: // TSP143IVUE
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.1.1.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.1.1.exe';
          end;
          15: // TSP650II
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          16: // TSP700II
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
          17: // TSP800II
          begin
             if IsWin64 then
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x64_v3.7.2.exe'
             else
                URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Star/Star_PrinterDrivers_x86_v3.7.2.exe';
          end;
       end;
	  end;
    21: // Sweda
	  begin
      case ComboBoxModelo.ItemIndex of
        0: // SI-150
        begin
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Sweda/Sweda_SI-150_SI-250_Drivers_v1.001.exe';
        end;
        1: // SI-250
        begin
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Sweda/Sweda_SI-150_SI-250_Drivers_v1.001.exe';
        end;
        2: // SI-300L
        begin
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Sweda/Sweda_SI-300_SI-300E_SI-300W_v1.2.0.exe';
        end;
        3: // SI-300S
        begin
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Sweda/Sweda_SI-300_SI-300E_SI-300W_v1.2.0.exe';
        end;
        4: // SI-300E
        begin
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Sweda/Sweda_SI-300_SI-300E_SI-300W_v1.2.0.exe';
        end;
        5: // SI300W
        begin
           URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Sweda/Sweda_SI-300_SI-300E_SI-300W_v1.2.0.exe';
        end;
      end;
	  end;
      22: // Tanca
      begin
         case ComboBoxModelo.ItemIndex of
            0: // TMP-500
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Tanca/Tanca_TMP-500_v2.61T.exe';
            end;
            1: // TP-450
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Tanca/Tanca_TP-450_Driver_v2.29E.exe';
            end;
            2: // TP-509
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Tanca/Tanca_TP-509_DriverInstall_v2.62.exe';
            end;
            3: // TP-550
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Tanca/Tanca_TP-550_Printer_Driver_v8.1.1.2.exe';
            end;
            4: // TP-620
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Tanca/Tanca_TP-620_Driver_v6.1.0.exe';
            end;
            5: // TP-650
            begin
               URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Tanca/Tanca_TP-650_DriverInstall_v2.11.exe';
            end;
         end;
      end;
	  23: // Waytec
	  begin
	     case ComboBoxModelo.ItemIndex of
          0: // WP-50
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Waytec/WayTec_WP-50_Driver_v7.17.50.exe';
          end;
          1: // WP-100
          begin
             URL := 'https://raw.githubusercontent.com/Delutto/thermal_printers/main/Waytec/Waytec_WP-100_Driver_v7.17.exe';
          end;
       end;
	  end;
   end;
end;

procedure CustomForm_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
   // enter code here...
end;

procedure CustomForm_ComboBoxMarcaChange(Sender: TObject);
begin
   case ComboBoxMarca.ItemIndex of
      0:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:TODOSList}');
      1:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:BematechList}');
      2:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:ControlIDList}');
      3:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:DarumaList}');
      4:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:DascomList}');
      5:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:DieboldList}');
      6:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:DimepList}');
      7:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:ElginList}');
      8:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:EpsonList}');
      9:  ComboBoxModelo.Items.Text := ExpandConstant('{cm:EvadinList}');
      10: ComboBoxModelo.Items.Text := ExpandConstant('{cm:FeassoList}');
      11: ComboBoxModelo.Items.Text := ExpandConstant('{cm:TODOSList}');
      12: ComboBoxModelo.Items.Text := ExpandConstant('{cm:GertecList}');
      13: ComboBoxModelo.Items.Text := ExpandConstant('{cm:JetwayList}');
      14: ComboBoxModelo.Items.Text := ExpandConstant('{cm:LedtecList}');
      15: ComboBoxModelo.Items.Text := ExpandConstant('{cm:TODOSList}');
      16: ComboBoxModelo.Items.Text := ExpandConstant('{cm:MennoList}');
      17: ComboBoxModelo.Items.Text := ExpandConstant('{cm:OiVidaList}');
      18: ComboBoxModelo.Items.Text := ExpandConstant('{cm:PertoList}');
      19: ComboBoxModelo.Items.Text := ExpandConstant('{cm:POSList}');
      20: ComboBoxModelo.Items.Text := ExpandConstant('{cm:StarList}');
      21: ComboBoxModelo.Items.Text := ExpandConstant('{cm:SwedaList}');
      22: ComboBoxModelo.Items.Text := ExpandConstant('{cm:TancaList}');
      23: ComboBoxModelo.Items.Text := ExpandConstant('{cm:WaytecList}');
   end;
   ComboBoxModelo.ItemIndex := 0;
   WizardForm.NextButton.Enabled := True;
end;

function CustomForm_CreatePage(PreviousPageId: Integer): Integer;
var
   Page: TWizardPage;
begin
   Page := CreateCustomPage(PreviousPageId,  ExpandConstant('{cm:CustomForm_Caption}'), ExpandConstant('{cm:CustomForm_Description}'));

   { Label1 }
   Label1 := TLabel.Create(Page);
   with Label1 do
   begin
      Parent := Page.Surface;
      Caption := ExpandConstant('{cm:CustomForm_Label1_Caption0}');
      Left := ScaleX(136);
      Top := ScaleY(56);
      Width := ScaleX(29);
      Height := ScaleY(13);
   end;
  
   { Label2 }
   Label2 := TLabel.Create(Page);
   with Label2 do
   begin
      Parent := Page.Surface;
      Caption := ExpandConstant('{cm:CustomForm_Label2_Caption0}');
      Left := ScaleX(136);
      Top := ScaleY(104);
      Width := ScaleX(34);
      Height := ScaleY(13);
   end;

   { ComboBoxModelo }
   ComboBoxModelo := TComboBox.Create(Page);
   with ComboBoxModelo do
   begin
      Parent := Page.Surface;
      Left := ScaleX(136);
      Top := ScaleY(120);
      Width := ScaleX(145);
      Height := ScaleY(21);
      TabOrder := 1;
      Style := csDropDownList;
      Text := ExpandConstant('{cm:CustomForm_ComboBoxModelo_Text0}');
   end;

   { ComboBoxMarca }
   ComboBoxMarca := TComboBox.Create(Page);
   with ComboBoxMarca do
   begin
      Parent := Page.Surface;
      Left := ScaleX(136);
      Top := ScaleY(72);
      Width := ScaleX(145);
      Height := ScaleY(21);
      TabOrder := 0;
      Style := csDropDownList;
      Text := ExpandConstant('{cm:CustomForm_ComboBoxMarca_Text0}');
      Items.Text := ExpandConstant('{cm:CustomForm_ComboBoxMarca_Strings}');
      OnChange := @CustomForm_ComboBoxMarcaChange;
   end;

   with Page do
   begin
      OnActivate := @CustomForm_Activate;
      OnShouldSkipPage := @CustomForm_ShouldSkipPage;
      OnBackButtonClick := @CustomForm_BackButtonClick;
      OnNextButtonClick := @CustomForm_NextButtonClick;
      OnCancelButtonClick := @CustomForm_CancelButtonClick;
   end;   

   Result := Page.ID;
end;

function OnDownloadProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
   LabelDownloading.Caption := ExpandConstant('{cm:Download_Form_LabelDownloading_Caption0}');
   ProgressBarDownload.Max := ProgressMax; 
   ProgressBarDownload.Position := Progress;
   Result := True;
end;

procedure Download_Form_Activate(Page: TWizardPage);
var
   ResultCode: Integer;
begin
   ProgressBarDownload.Position := 0;
   WizardForm.NextButton.Enabled := False;

   try
      DownloadTemporaryFile(URL, 'Setup_Driver.exe', '', @OnDownloadProgress);
   except
      Log(GetExceptionMessage);
   end;

   Exec(ExpandConstant('{tmp}\Setup_Driver.exe'), '', '', SW_SHOW, ewNoWait, ResultCode);

   WizardForm.NextButton.Enabled := True;
end;

function Download_Form_ShouldSkipPage(Page: TWizardPage): Boolean;
begin
   Result := False;
end;

function Download_Form_BackButtonClick(Page: TWizardPage): Boolean;
begin
   Result := True;
end;

function Download_Form_NextButtonClick(Page: TWizardPage): Boolean;
begin
   Result := True;
end;

procedure Download_Form_CancelButtonClick(Page: TWizardPage; var Cancel, Confirm: Boolean);
begin
   // enter code here...
end;

procedure Download_Form_CreatePage;
var
   Page: TWizardPage;
begin
   Page := PageFromId(wpInstalling);

   LabelDownloading := TLabel.Create(Page);
   with LabelDownloading do
   begin
      Parent := Page.Surface;
      Caption := ExpandConstant('{cm:Download_Form_LabelDownloading_Caption0}');
      Left := ScaleX(16);
      Top := ScaleY(36);
      Width := ScaleX(56);
      Height := ScaleY(13);
      Visible := True;
   end;

   ProgressBarDownload := TNewProgressBar.Create(Page);
   with ProgressBarDownload do
   begin
      Parent := Page.Surface;
      Left := ScaleX(16);
      Top := ScaleY(56);
      Width := ScaleX(382);
      Height := ScaleY(17);
      Min := 0;
      Max := 100;
   end;

   with Page do
   begin
      Caption := ExpandConstant('{cm:Download_Form_Caption}');
      Description := ExpandConstant('{cm:Download_Form_Description}')
      OnActivate := @Download_Form_Activate;
      OnShouldSkipPage := @Download_Form_ShouldSkipPage;
      OnBackButtonClick := @Download_Form_BackButtonClick;
      OnNextButtonClick := @Download_Form_NextButtonClick;
      OnCancelButtonClick := @Download_Form_CancelButtonClick;
   end;
end;

procedure InitializeWizard;
begin
   CustomForm_CreatePage(wpWelcome);
   Download_Form_CreatePage;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
   Result := True;
end;
