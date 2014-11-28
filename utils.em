/* Utils.em - a small collection of useful editing macros */
macro AutoFillBrace()
{
	hwnd = GetCurrentWnd()
	lnCurrent = GetWndSelLnFirst(hwnd)
	hbuf = GetCurrentBuf()

	text = GetBufLine(hbuf, lnCurrent)
	textlen = strlen(text)
	pos = GetWndSelIchFirst(hwnd)

	blankline = ""
	righttext = ""

	startpos = 0

	if(pos > 0)
	{
		if(pos < textlen)
		{
			righttext = strmid(text, pos, textlen)
		}

		PutBufLine(hbuf, lnCurrent, strmid(text, 0, pos))

		while(startpos < pos)
		{
			char = strmid(text, startpos, startpos+1)
			if(AsciiFromChar(char) > 32)
			{
				break;
			}
			else
			{
				blankline = cat(blankline, char)
			}
			startpos = startpos + 1
		}

		if(strmid(text, pos-1, pos) == "{")
		{

			if(strlen(righttext) == 0)
			{
				righttext = "}"
			}

			InsBufLine(hbuf, lnCurrent+1, cat(blankline, CharFromAscii(9)))
			InsBufLine(hbuf, lnCurrent+2, cat(blankline, righttext))

			SetBufIns(hbuf, lnCurrent+1, startpos+1)
			return
		}
	}

	InsBufLine(hbuf, lnCurrent+1, cat(blankline, righttext))
	SetBufIns(hbuf, lnCurrent+1, startpos)
}
