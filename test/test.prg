// It ain't pretty, but it serves as a test.

Function Main()
Local GetList := {}
Local c

   Cls
   ? "Welcome to OSLib"
   ?

   If OL_IsOS2() .Or. OL_IsMSWin() .Or. OL_IsNT()

      ? "Hmm, a "
      Do Case
         Case OL_IsOS2()
            ?? "OS/2"
         Case OL_IsMSWin()
            ?? "MS-Windows"
         Case OL_IsNT()
            ?? "NT"
         Otherwise
            ?? "unknown OS"
      EndCase
      ?? " user eh?"

      ?
      ? "The OS version appears to be " + alltrim( str( OL_OsVerMaj() ) ) + "." + alltrim( str( OL_OsVerMin() ) )

      If OL_IsOS2()
         ?
         ? "You appear to be running " + if( OL_IsOS2Win(), "in a DOS Window", "full screen" ) + "."
      EndIf

      ?
      ? "Now for some tests. Make sure that we are running in a window and not in"
      ? "full screen mode. Also, you might want to run some kind of CPU meter to"
      ? "watch the CPU usage. Press a key when ready....."
      inkey( 0 )

      Cls
      ? "Ok, we are now sat on a bare inkey( 0 ), the CPU usage should be pretty"
      ? "high. (Press any key when done)"
      inkey( 0 )

      Cls
      ? "Now, wait for a key again but this time use a loop that yields to the"
      ? "OS. This time you should notice that the CPU usage is a lot less."
      ? "(Press any key when done)"
      Do While nextkey() == 0
         OL_Yield()
      EndDo
      InKey() // Munch...

      Cls
      ? "Now, this time, we'll turn on the AutoYield feature and do a simple"
      ? "InKey( 0 ) again. This time you should notice that the CPU usage is"
      ? "higher but that it isn't as bad as when AutoYield is turned off."
      ? "(Press any key when done)"
      OL_AutoYield( .T. )
      InKey( 0 )

      If OL_IsMSWin()

         Cls
         ? "Make sure you are in a Window, enter some text below and I'll change the"
         ? "window title to that text"
         c := padr( alltrim( OL_95AppTitle() ), 79 )
         @ row() + 2, 0 Get c Picture "@K"
         Read
         If lastkey() != 27
            OL_95AppTitle( alltrim( c ) )
         EndIf

         Cls
         c := padr( alltrim( OL_95VMTitle() ), 29 )
         ? "Now, lets do the same for the virtual machine title"
         @ row() + 2, 0 Get c Picture "@K"
         Read
         If lastkey() != 27
            OL_95VMTitle( alltrim( c ) )
         EndIf

         Cls
         ? "Now for one Windows trick. Make sure we are in a Window and not full screen."
         ? "Then, press any key and I'll make this full screen for you."
         InKey( 0 )
         OL_WinFullScreen()

         Cls
         ? "Here you are, full screen mode (well, if it worked for you <g>)."

      EndIf

   Else

      ? "You don't appear to be running under MS-Windows, Windows NT or OS/2"
      ? "Bye"

   EndIf

Return( NIL )
