; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines


!define MAINDIR $PROGRAMFILES64
!define PRODUCT_NAME "MeshLab_64b"
!define PRODUCT_VERSION "2018.03"
!define PRODUCT_PUBLISHER "Paolo Cignoni - Guido Ranzuglia VCG - ISTI - CNR"
!define PRODUCT_WEB_SITE "http://www.meshlab.net"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\meshlab.exe"
!define PRODUCT_DIR_REGKEY_S "Software\Microsoft\Windows\CurrentVersion\App Paths\meshlabserver.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define QT_BASE "C:\Qt_5.7\5.7\msvc2015_64\"
!define ADDITIONAL_DLLS "C:\Users\ranzuglia\Desktop\MeshLab-related\additional_dlls"
!define ICU_DLLS "${ADDITIONAL_DLLS}\icu\bin64"
!define DISTRIB_FOLDER "../distrib"
!define MICROSOFT_VS2010_REDIST_KEYDIR "Software\Microsoft\Windows\CurrentVersion\Uninstall\"

; MUI 1.67 compatible -----
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "..\..\LICENSE.txt"
; License page
!insertmacro MUI_PAGE_LICENSE "..\..\docs\privacy.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES


; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\meshlab.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------
!define /date NOW "%Y_%m_%d"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "MeshLab2016.12_${NOW}.exe"
;InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
InstallDir "${MAINDIR}\VCG\MeshLab"
ShowInstDetails show
ShowUnInstDetails show

!include LogicLib.nsh
!macro IfKeyExists ROOT MAIN_KEY KEY
  Push $R0
  Push $R1
  Push $R2
 
  # XXX bug if ${ROOT}, ${MAIN_KEY} or ${KEY} use $R0 or $R1
  SetRegView 64
  StrCpy $R1 "0" # loop index
  StrCpy $R2 "0" # not found
 ;MessageBox MB_OK "Passato : ${MAIN_KEY}"
  ${Do}
    EnumRegKey $R0 ${ROOT} "${MAIN_KEY}" "$R1" 
	;MessageBox MB_OK "Letto : $R0"
    ${If} $R0 == "${KEY}"
      StrCpy $R2 "1" # found
      ${Break}
    ${EndIf}
    IntOp $R1 $R1 + 1
  ${LoopWhile} $R0 != ""
  
  ClearErrors
 
  Exch 2
  Pop $R0
  Pop $R1
  Exch $R2
!macroend

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "${DISTRIB_FOLDER}\meshlab.exe"
  File "${DISTRIB_FOLDER}\meshlabserver.exe"
  CreateDirectory "$SMPROGRAMS\MeshLab"
  CreateShortCut "$SMPROGRAMS\MeshLab\MeshLab.lnk" "$INSTDIR\meshlab.exe"
  CreateShortCut "$DESKTOP\MeshLab.lnk" "$INSTDIR\meshlab.exe"
  CreateShortCut "$SMPROGRAMS\MeshLab\MeshLabServer.lnk" "cmd.exe /k $INSTDIR\meshlabserver.exe" 

  ;Let's delete all the dangerous stuff from previous releases.
  Delete "$INSTDIR\qt*.dll"
  Delete "$INSTDIR\ming*.dll"
  Delete "$INSTDIR\plugins\*.dll"
  Delete "$INSTDIR\imageformats\*.dll"
  Delete "$INSTDIR\platforms\*.dll"
  
  SetOutPath "$INSTDIR\shaders"
  File "${DISTRIB_FOLDER}\shaders\*.frag"
  File "${DISTRIB_FOLDER}\shaders\*.gdp"
  File "${DISTRIB_FOLDER}\shaders\*.vert"
  SetOutPath "$INSTDIR\shaders\decorate_shadow\ao"
  SetOutPath "$INSTDIR\shaders\decorate_shadow\sm"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\sm\*.frag"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\sm\*.vert"
  SetOutPath "$INSTDIR\shaders\decorate_shadow\ssao"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\ssao\*.frag"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\ssao\*.vert"
  SetOutPath "$INSTDIR\shaders\decorate_shadow\vsm"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\vsm\*.frag"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\vsm\*.vert"
  SetOutPath "$INSTDIR\shaders\decorate_shadow\vsmb"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\vsmb\*.frag"
  File "${DISTRIB_FOLDER}\shaders\decorate_shadow\vsmb\*.vert"
  File "${DISTRIB_FOLDER}\shaders\*.frag"
  SetOutPath "$INSTDIR\plugins"
  
  ; MeshLab plugins
  File "${DISTRIB_FOLDER}/plugins\*.dll"
  File "${DISTRIB_FOLDER}/plugins\*.xml"
  
  ; All the U3D binary stuff
  SetOutPath "$INSTDIR\plugins\U3D_W32"
  File "${DISTRIB_FOLDER}/plugins\U3D_W32\IDTFConverter.exe"
  File "${DISTRIB_FOLDER}/plugins\U3D_W32\*.dll"
  File "${DISTRIB_FOLDER}/plugins\U3D_W32\*.txt"
  SetOutPath "$INSTDIR\plugins\U3D_W32\plugins"
  File "${DISTRIB_FOLDER}/plugins\U3D_W32\Plugins\IFXExporting.dll"
  
  SetOutPath "$INSTDIR\textures"
  File "${DISTRIB_FOLDER}/textures\chrome.png"
  File "${DISTRIB_FOLDER}/textures\*.dds"
  File "${DISTRIB_FOLDER}/textures\fur.png"
  File "${DISTRIB_FOLDER}/textures\glyphmosaic.png"
  ;File "${DISTRIB_FOLDER}/textures\NPR Metallic Outline.tga"
  File "${DISTRIB_FOLDER}/textures\hatch*.jpg"

  SetOutPath "$INSTDIR\textures\litspheres"
  File "${DISTRIB_FOLDER}/textures\litspheres\*.png"
    
  SetOutPath "$INSTDIR\textures\cubemaps"
  File "${DISTRIB_FOLDER}/textures\cubemaps\uffizi*.jpg"
  SetOutPath "$INSTDIR\samples"
  File "${DISTRIB_FOLDER}/sample\texturedknot.ply"
  File "${DISTRIB_FOLDER}/sample\texturedknot.obj"
  File "${DISTRIB_FOLDER}/sample\texturedknot.mtl"
  File "${DISTRIB_FOLDER}/sample\TextureDouble_A.png"
  File "${DISTRIB_FOLDER}/sample\Laurana50k.ply"
  File "${DISTRIB_FOLDER}/sample\duck_triangulate.dae"
  File "${DISTRIB_FOLDER}/sample\seashell.gts"
  File "${DISTRIB_FOLDER}/sample\chameleon4k.pts"
  File "${DISTRIB_FOLDER}/sample\normalmap\laurana500.*"
  File "${DISTRIB_FOLDER}/sample\normalmap\matteonormb.*"
  SetOutPath "$INSTDIR\samples\images"
  File "${DISTRIB_FOLDER}/sample\images\duckCM.jpg"
  SetOutPath "$INSTDIR\imageformats"
  File "${QT_BASE}\plugins\imageformats\qjpeg.dll"
  File "${QT_BASE}\plugins\imageformats\qgif.dll"
  File "${QT_BASE}\plugins\imageformats\qtiff.dll"
   SetOutPath "$INSTDIR\platforms"
  File "${QT_BASE}\plugins\platforms\qminimal.dll"
  File "${QT_BASE}\plugins\platforms\qwindows.dll"
  
  SetOutPath "$INSTDIR"
  ;File "${DISTRIB_FOLDER}\common.lib"
  File "${QT_BASE}\bin\Qt5Core.dll"
  File "${QT_BASE}\bin\Qt5Gui.dll"
  File "${QT_BASE}\bin\Qt5OpenGL.dll"
  File "${QT_BASE}\bin\Qt5Xml.dll"
  File "${QT_BASE}\bin\Qt5Network.dll"
  File "${QT_BASE}\bin\Qt5Script.dll"
  File "${QT_BASE}\bin\Qt5XmlPatterns.dll"
  File "${QT_BASE}\bin\Qt5Widgets.dll"
  File "${ICU_DLLS}\icuin51.dll"
  File "${ICU_DLLS}\icudt51.dll"
  File "${ICU_DLLS}\icuuc51.dll"
  File "${ADDITIONAL_DLLS}\vc_redist.x64.exe"
  
  ;File "C:\MinGW\bin\mingwm10.dll"
  ;File "${QT_BASE}\..\mingw\bin\mingwm10.dll"
  ;File "${QT_BASE}\..\mingw\bin\libgcc_s_dw2-1.dll"
  ;File "${QT_BASE}\..\mingw\bin\libgomp-1.dll"
  
  File "..\..\docs\readme.txt"
  ;File "..\..\docs\history.txt"
  File "..\..\LICENSE.txt"
SectionEnd

Section -Prerequisites
	;EnumRegKey $0 HKCR "SOFTWARE\Test" 0
	;ReadRegStr $0 HKLM ${MICROSOFT_VS2008_REDIST_KEYDIR} ${MICROSOFT_VS2008_X64}
	;MessageBox MB_OK "Letto : $0" 
	;Quit
	
	;!insertmacro IfKeyExists HKLM  ${MICROSOFT_VS2010_REDIST_KEYDIR} ${MICROSOFT_VS2010_X64}
	;Pop $R0
	;${If} $R0 == "1" 
	;	Goto endPrerequisites
	;${Else}
	;	!insertmacro IfKeyExists HKLM ${MICROSOFT_VS2010_REDIST_KEYDIR} ${MICROSOFT_VS2010_IA64}
	;	Pop $R0
	;	${If} $R0 == "1" 
	;		Goto endPrerequisites
	;	${Else} 
	;		MessageBox MB_OK "Your system does not appear to have $\"Microsoft Visual C++ 2010 SP1 Redistributable Package (x64) installed$\".$\r MeshLab's Installation process will be aborted.$\r Please, install it and restart the MeshLab installer!" 
	;		Quit
	;	${Endif}
	;${Endif}
	;endPrerequisites:
	ReadRegStr $1 HKLM "SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" "Installed"
	${If} $1 == "1"
		Goto endPrerequisites
	${Else}
		ExecWait "$INSTDIR\vc_redist.x64.exe"
	${EndIf}
	endPrerequisites:
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\MeshLab\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\MeshLab\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\meshlab.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY_S}" "" "$INSTDIR\meshlabserver.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\meshlab.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\*.exe"
  Delete "$INSTDIR\shaders\*.frag"
  Delete "$INSTDIR\shaders\*.vert"
  Delete "$INSTDIR\shaders\*.gdp"
  Delete "$INSTDIR\shadersrm\*.rfx"
  Delete "$INSTDIR\samples\*.*"
  Delete "$INSTDIR\samples\images\*.*"
  Delete "$INSTDIR\plugins\*.dll"
  Delete "$INSTDIR\plugins\U3D_W32\*.dll"
  Delete "$INSTDIR\plugins\U3D_W32\*.exe"
  Delete "$INSTDIR\plugins\U3D_W32\*.txt"
  Delete "$INSTDIR\plugins\U3D_W32\plugins\*.dll"
  Delete "$INSTDIR\plugins\*.dll"
  Delete "$INSTDIR\imageformats\*.dll"
  Delete "$INSTDIR\textures\*.png"
  Delete "$INSTDIR\textures\*.dds"
  Delete "$INSTDIR\textures\cubemaps\*.jpg"
  Delete "$INSTDIR\textures\*.jpg"
  Delete "$INSTDIR\textures\*.tga"

  Delete "$SMPROGRAMS\MeshLab\Uninstall.lnk"
  Delete "$SMPROGRAMS\MeshLab\Website.lnk"
  Delete "$DESKTOP\MeshLab.lnk"
  Delete "$SMPROGRAMS\MeshLab\MeshLab.lnk"

  RMDir "$SMPROGRAMS\MeshLab"
  RMDir "$INSTDIR\CVS"
  RMDir "$INSTDIR\imageformats"
  RMDir "$INSTDIR\plugins\U3D_W32\plugins"
  RMDir "$INSTDIR\plugins\U3D_W32"
  RMDir "$INSTDIR\plugins"
  RMDir "$INSTDIR\samples\images"
  RMDir "$INSTDIR\samples"
  RMDir "$INSTDIR\textures\cubemaps"
  RMDir /r "$INSTDIR\textures"
  RMDir /r "$INSTDIR\shaders"
  RMDir /r "$INSTDIR\shadersrm"
  RMDir /r "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}" 
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY_S}"
  SetAutoClose true
SectionEnd

  ;******************** PARTE SPERIMENTALE SULLE ASSOCIAZIONI FILE ****************
;Things that need to be extracted on startup (keep these lines before any File command!)
;Only useful for BZIP2 compression
;Use ReserveFile for your own InstallOptions INI files too!

!define TEMP1 $R0 ;Temp variable

ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"
; ReserveFile "fileassociation_nsis.ini"

;Order of pages
; la prox linea se scommnentata serve ad abilitare il loading di una pagine aggiuntiva
; in cui si settano le associazioni file extensions-registro per il meshlab.
; Page custom SetCustom ValidateCustom ": Testing InstallOptions" ;Custom page. InstallOptions gets called in SetCustom.
;Page instfiles

Section "Components"

  ;Get Install Options dialog user input

  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 2" "State"
  DetailPrint "Install X=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 3" "State"
  DetailPrint "Install Y=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 4" "State"
  DetailPrint "Install Z=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 5" "State"
  DetailPrint "File=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 6" "State"
  DetailPrint "Dir=${TEMP1}"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 8" "State"
  DetailPrint "Info=${TEMP1}"

SectionEnd

Function .onInit

  ;Extract InstallOptions files
  ;$PLUGINSDIR will automatically be removed when the installer closes

  InitPluginsDir
;  File /oname=$PLUGINSDIR\fileassociation_nsis.ini "fileassociation_nsis.ini"

FunctionEnd

Function SetCustom

  ;Display the InstallOptions dialog

  Push ${TEMP1}

    InstallOptions::dialog "$PLUGINSDIR\fileassociation_nsis.ini"
    Pop ${TEMP1}

  Pop ${TEMP1}

FunctionEnd

Function ValidateCustom

  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 2" "State"
  StrCmp ${TEMP1} 1 done

  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 3" "State"
  StrCmp ${TEMP1} 1 done

  ReadINIStr ${TEMP1} "$PLUGINSDIR\fileassociation_nsis.ini" "Field 4" "State"
  StrCmp ${TEMP1} 1 done
    MessageBox MB_ICONEXCLAMATION|MB_OK "You must select at least one install option!"
    Abort

  done:

FunctionEnd
