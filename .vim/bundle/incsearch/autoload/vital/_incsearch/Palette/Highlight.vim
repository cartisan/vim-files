scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_vital_loaded(V)
	let s:V = a:V
	let s:Message  = s:V.import("Vim.Message")
endfunction


function! s:_vital_depends()
	return [
\		"Vim.Message",
\	]
endfunction


function! s:_execute(cmd)
	execute a:cmd
endfunction


function! s:capture(name)
	if hlexists(a:name) == 0
		return ""
	endif
	return s:Message.capture("highlight " . a:name)
endfunction


function! s:links_to(highlight)
	return matchstr(a:highlight, '^\S\+\s\+xxx links to \zs.*\ze$')
endfunction


function! s:parse_to_name(highlight)
	return matchstr(a:highlight, '^\zs\w\+\ze')
endfunction


function! s:parse(highlight)
	let highlight = a:highlight
	
	if highlight !~# '^\w\+\s\+xxx\s'
		return {}
	endif

	let name = s:parse_to_name(a:highlight)
	let result = { "_name" : name }

	if highlight =~# '^\w\+\s\+xxx cleared'
		let result.cleared = 1
		return result
	endif

	let link = s:links_to(highlight)
	if link != ""
		let result.link = link
		return result
	endif

	let attrs = [
\		"term",
\		"cterm",
\		"ctermfg",
\		"ctermbg",
\		"gui",
\		"font",
\		"guifg",
\		"guibg",
\		"guisp",
\	]
	for attr in attrs
		let item = matchstr(highlight, '\s' . attr . '=\zs#\?\w\+\ze')
		if item != ""
			let result[attr] = item
		endif
	endfor
	return result
endfunction


function! s:get(name, ...)
	if !hlexists(a:name)
		return {}
	endif
	let result = s:parse(substitute(s:capture(a:name), "\n", "", "g"))
	if has_key(result, "link") && get(a:, 1, 0)
		return s:get(result.link, get(a:, 1, 0))
	else
		return result
	endif
endfunction


function! s:set(name, config)
	if type(a:config) == type("")
		return s:set(a:config, s:get(a:config))
	endif
	if has_key(a:config, "cleared")
		return s:_execute("highlight clear " . a:name)
	endif
	if has_key(a:config, "link")
		return s:_execute("highlight link " . a:name . " " . a:config.link)
	endif
	return s:_execute("highlight " . a:name . " " . join(map(items(filter(a:config, "v:key !=# '_name'")), "v:val[0] . '=' . v:val[1]"), " "))
endfunction


function! s:group_list()
	let highlights = split(s:Message.capture("highlight"), "\n")
	return filter(map(highlights, "s:parse_to_name(v:val)"), "v:val != ''")
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
