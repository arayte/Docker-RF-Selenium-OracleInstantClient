*** Settings ***
Library			SeleniumLibrary
*** Variables ***
${BROWSER}		%{BROWSER}

*** Test Cases ***
Visit Baidu
	Open Browser			https://www.baidu.com		${BROWSER}
        Sleep    100000000s
        Capture Page Screenshot

Visit Bing
	Open Browser			https://www.bing.com		${BROWSER}
	Capture Page Screenshot

Visit Google
	Open Browser			https://www.google.com		${BROWSER}
	Capture Page Screenshot

Visit Yahoo
	Open Browser			https://search.yahoo.com	${BROWSER}
	Capture Page Screenshot
