For /F "UseBackQ Delims==" %%A In ("C:\temp\EpsonScanSvc\dorestartudupa.log") Do Set "lastline=%%A"
Echo Ostatnia linia: '%lastline%'

set output=***ERROR***
IF not "x%lastline:***ERROR***=%"=="x%lastline%" (
	NET STOP EpsonScanSvc
	NET START EpsonScanSvc
	echo %date%  %time% - Service Restarted Successfully. This will be LINUX year!!! >>"C:\temp\EpsonScanSvc\restart.log"
) else (
	echo %date%  %time% - Service Restarted Unsuccessfully!! Output '%output%' not found in log file. This will be LINUX year!!!  >>"C:\temp\EpsonScanSvc\restart.log"
)
