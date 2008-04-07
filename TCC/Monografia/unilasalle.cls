%==============================================================================
%
% unilasalle - Classe para formatar TCC de graduação do Unilasalle
% Adaptado da classe iiufrgs por Felipe W Damasio <felipewd@terra.com.br>
% Adaptado da classe unisinos por Vinicius L Mignot <vinicius.mignot@gmail.com>
% O Copyright original se encontra abaixo
%
% Copyright (C) 2001-2003 UFRGS TeX Users Group
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
% UFRGS TeX Users Group
% Institute of Informatics --- UFRGS
% Porto Alegre, Brazil
% http://www.inf.ufrgs.br/utug
% Discussion list: utug-l@inf.ufrgs.br
%==============================================================================

%==============================================================================
% Identificação
%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unilasalle}[2006/06/15 v4.2.0 Formatacao de trabalhos de conclusão para o Unilasalle]

%==============================================================================
% Declaração de opções
%==============================================================================
\newcommand{\iiu@novodoc}[1]{\DeclareOption{#1}{\AtEndOfClass{\input{#1.def}}}}
\iiu@novodoc{rp}
\iiu@novodoc{prop-tese}
\iiu@novodoc{plano-doutorado}
\iiu@novodoc{dipl}
\iiu@novodoc{ti}
\iiu@novodoc{pep}
\iiu@novodoc{diss}
\iiu@novodoc{tese}
\iiu@novodoc{tc}
\iiu@novodoc{espec}
\DeclareOption{english}{\@englishtrue\OptionNotUsed}\newif\if@english
\DeclareOption{oneside}{\AtEndOfClass{\@twosidefalse}\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\newcommand{\titlepagespecificinfo}{\dissspecificinfo}
\def\@cipspecificinfo{\dissname}

%==============================================================================
% Herança da classe `report' e inclusão de pacotes e arquivos necessários
%==============================================================================
\LoadClass[12pt,a4paper,oneside]{report}
\RequirePackage[english,brazilian]{babel}
\input{brazilian.babel}
\input{english.babel}
\if@english
        \selectlanguage{english}
        \AtBeginDocument{\selectlanguage{english}}
\fi
\RequirePackage{lastpage}
\RequirePackage{indentfirst}
\RequirePackage{iidefs}
\RequirePackage{natbib}
\RequirePackage{graphicx}
\RequirePackage{graphics}
\RequirePackage{epsf}
\RequirePackage{setspace}
\onehalfspacing{}
 

%==============================================================================
% Margens do texto
%==============================================================================
\newlength{\ii@topmargin}\setlength{\ii@topmargin}{30mm}
\newlength{\ii@pagenummargin}\setlength{\ii@pagenummargin}{20mm}
\newlength{\ii@bottommargin}\setlength{\ii@bottommargin}{20mm}
\newlength{\ii@sidemargin}\setlength{\ii@sidemargin}{30mm}
\setlength{\marginparwidth}{25mm}
% ajuste das medidas verticais
\setlength{\topmargin}{\ii@pagenummargin}
        \addtolength{\topmargin}{-1em} % isto é +- a altura do núm. da página
        \addtolength{\topmargin}{-1in}
\setlength{\headheight}{1em}
\setlength{\headsep}{\ii@topmargin}
        \addtolength{\headsep}{-\ii@pagenummargin}
\setlength{\textheight}{\paperheight}
        \addtolength{\textheight}{-\ii@topmargin}
        \addtolength{\textheight}{-\ii@bottommargin}
\setlength{\footskip}{\ii@bottommargin}

% ajuste das medidas horizontais
\setlength{\oddsidemargin}{\ii@sidemargin}
        \addtolength{\oddsidemargin}{-1in}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\textwidth}{\paperwidth}
        \addtolength{\textwidth}{-2\ii@sidemargin}
\setlength{\marginparsep}{\ii@sidemargin}
        \addtolength{\marginparsep}{-\marginparwidth}
        \setlength{\marginparsep}{.5\marginparsep}

%==============================================================================
% Numeração das páginas
%==============================================================================
\def\ps@unilasalle{
        \let\@oddfoot\@empty
        \let\@evenfoot\@empty
        \def\@evenhead{\small\hfill{\thepage}}
        \def\@oddhead{\small\hfill{\thepage}}
}
\pagestyle{empty}
\let\ps@plain\ps@empty

\def\ps@unilasallecap{% pagina inicial dos capitulos
        \let\@oddfoot\@empty
        \let\@evenfoot\@empty
        \def\@evenhead{}
        \def\@oddhead{}
}
\pagestyle{empty}
\let\ps@plain\ps@empty

%==============================================================================
% Definição de autor(es), orientador e co-orientador
%==============================================================================
\newcounter{ii@authorcount}
\renewcommand{\author}[2]{
        \addtocounter{ii@authorcount}{1}
        \expandafter\gdef\csname @author\alph{ii@authorcount}last\endcsname{#1}
        \expandafter\gdef\csname @author\alph{ii@authorcount}first\endcsname{#2}
        \expandafter\gdef\csname @author\alph{ii@authorcount}\endcsname{#2 #1}
}
\DeclareRobustCommand{\advisor}[3][]{
        \gdef\@advisorlast{#2}
        \gdef\@advisorfirst{#3}
        \gdef\@advisor{#1~#3 #2}
}
\DeclareRobustCommand{\coadvisor}[3][]{
        \gdef\@coadvisorlast{#2}
        \gdef\@coadvisorfirst{#3}
        \gdef\@coadvisor{#1~#3 #2}
}

%==============================================================================
% Definição do Departamento relacionado ao documento
% deve ser definido como `ina' ou `int'
%==============================================================================
\newcommand{\dept}[1]{\gdef\@dept{#1}}

%==============================================================================
% Definição das palavras-chave (máx. 10)
%==============================================================================
\newcounter{kwcounter}
\newcommand{\keyword}[1]{
        \addtocounter{kwcounter}{1}
        \expandafter\gdef\csname keyw\alph{kwcounter}\endcsname{#1}
}
\newcommand{\@cipkw}{%
        \@ifundefined{keywa}{}{1.~\expandafter\MakeUppercase\keywa\@. }%
        \@ifundefined{keywb}{}{2.~\expandafter\MakeUppercase\keywb\@. }%
        \@ifundefined{keywc}{}{3.~\expandafter\MakeUppercase\keywc\@. }%
        \@ifundefined{keywd}{}{4.~\expandafter\MakeUppercase\keywd\@. }%
        \@ifundefined{keywe}{}{5.~\expandafter\MakeUppercase\keywe\@. }%
        \@ifundefined{keywf}{}{6.~\expandafter\MakeUppercase\keywf\@. }%
        \@ifundefined{keywg}{}{7.~\expandafter\MakeUppercase\keywg\@. }%
        \@ifundefined{keywh}{}{8.~\expandafter\MakeUppercase\keywh\@. }%
        \@ifundefined{keywi}{}{9.~\expandafter\MakeUppercase\keywi\@. }%
        \@ifundefined{keywj}{}{10.~\expandafter\MakeUppercase\keywj\@. }%
}
\newcommand{\@abstractkw}{%
        \@ifundefined{keywa}{}{\expandafter\MakeUppercase\keywa}%
        \@ifundefined{keywb}{}{, \keywb}%
        \@ifundefined{keywc}{}{, \keywc}%
        \@ifundefined{keywd}{}{, \keywd}%
        \@ifundefined{keywe}{}{, \keywe}%
        \@ifundefined{keywf}{}{, \keywf}%
        \@ifundefined{keywg}{}{, \keywg}%
        \@ifundefined{keywh}{}{, \keywh}%
        \@ifundefined{keywi}{}{, \keywi}%
        \@ifundefined{keywj}{}{, \keywj}%
}

%==============================================================================
% Redefinição da data (para ter mês e ano separados)
%==============================================================================
\renewcommand{\date}[2]{
        \gdef\@publmonth{#1}
        \gdef\@publyear{#2}
}
\date{\monthname}{\number\year}

%==============================================================================
% Definição padrão da capa.
%==============================================================================
\newcommand{\location}[2]{
        \gdef\@city{#1}
        \gdef\@state{#2}
}
\location{Canoas}{RS}
\newcommand{\maketoppage}{
	\noindent
	\begin{center}
	%vinicius%\includegraphics[height=24.1mm, width=150mm]{unilasalle.jpg}\\
	%pkvm%
	\includegraphics[height=24.1mm, width=150mm]{logoUnilasalle.eps}\\
        \noindent\MakeUppercase{\textbf{Curso de bacharelado em ciência da computação}}\\
        \vspace{75.9mm}
	{\large\textbf{\MakeUppercase\@title}\par}
	\vspace{50mm}
                \MakeUppercase{\@authora}\\
                \@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}%
                \@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}%
                \@ifundefined{@authord}{}{\MakeUppercase{\@authord}\\}%
	\end{center}
	\vfill
        \centerline{\@city, \ii@date}
	\clearpage
        \setcounter{page}{0}%
}
%==============================================================================
% Definição padrão da folha de rosto.
% Os dados específicos do tipo de trabalho (dissertação, tese, etc.) são
% informados definindo-se o comando \titlepagespecificinfo. Veja os
% arquivos .def incluídos com a classe.
%==============================================================================
\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{95mm}
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{60mm}
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{112mm}
\location{Canoas}{RS}
\renewcommand{\maketitle}{%
        \begin{titlepage}
                \thetitlepage
        \end{titlepage}%
        \clearpage
        %\setcounter{page}{10}%
        %\@ifundefined{@cipspecificinfo}{}{\@makecippage}
}
\newcommand{\thetitlepage}{%
        \noindent\@topbox\\
        \vfill
        \@ifundefined{titlepagespecificinfo}{}{
                \hspace*{\fill}\makebox[.5\textwidth][l]{%
                        \parbox[b]{8.5cm}{\justify\titlepagespecificinfo}%
                }
                \vfill
        }
        \centerline{\@city, \ii@date}
}
\def\@topbox{%
        \parbox[t]{\textwidth}{%
                \centering%
                \vbox to \titlepagewinvoffset{%
                        \titlepagetopinfo\vfill\@winbox
                }
        }
}
\def\@winbox{%
%       \fbox{
        \parbox[b]{\titlepagewinwidth}{%
        %\centering\vbox to \titlepagewinheight{%
        \centering\vbox to 80mm{%
                \vspace*{\fill}
                \MakeUppercase{\@authora}\\
                \@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}%
                \@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}%
                \@ifundefined{@authord}{}{\MakeUppercase{\@authord}\\}%
                \vspace{\stretch{4}}
                {\large\textbf{\MakeUppercase\@title}\par}
                \vfill
        }}%
%       }%
}
\newcommand{\course}[1]{\gdef\@course{#1}}
\newcommand{\titlepagetopinfo}{%
        %\MakeUppercase{Centro Universitário La Salle - Unilasalle}\\
        %\@ifundefined{@dept}{}{\MakeUppercase{\csname dept\@dept\endcsname}\\}%
}
\newcommand{\titlepageadvisorinfo}{%
        \@ifundefined{@advisor}{}{\vfill\@advisor\\\advisorname}
        \@ifundefined{@coadvisor}{}{\\[6ex]\@coadvisor\\\coadvisorname}
}


%==============================================================================
% Folha de aprovacao 
%==============================================================================
\newcommand{\makeappage}{
	\noindent
	\begin{center}
        \vspace{30mm}
	{\textbf{\MakeUppercase{Termo de aprovação}}\par}
	\vspace{30mm}
                \MakeUppercase{\@authora}\\
                \@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}%
                \@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}%
                \@ifundefined{@authord}{}{\MakeUppercase{\@authord}\\}%
	\vspace{30mm}
        {\large\textbf{\MakeUppercase\@title}\par}
	\vspace{40mm}
	\noindent\singlespacing{Trabalho de conclusão aprovado como requisito parcial para obtenção do grau de Bacharel em Ciência da Computação do Centro Universitário La Salle - Unilasalle, pela seguinte banca examinadora:}
	\vspace{15mm}
	\singlespacing{Prof. Me. Marcos Ennes Barreto\\Centro Universitário La Salle - Unilasalle}
	\vspace{15mm}
	\singlespacing{Prof. Me. Mozart Lemos de Siqueira\\Centro Universitário La Salle - Unilasalle}
	\vspace{15mm}
      \singlespacing{Prof. Dsc. Patrícia Kayser Vargas Mangan\\Centro Universitário La Salle - Unilasalle}
	\end{center}
	\vfill
        \centerline{\@city, \ii@date}
	\clearpage
}


%==============================================================================
% Ajuste do sumário (nada identado) 
%==============================================================================
\newlength{\ii@chapnumindent}\setlength{\ii@chapnumindent}{1.8em}
\renewcommand*{\l@chapter}[2]{
        \addpenalty{-\@highpenalty}
        \vskip -1ex \@plus\p@
        \setlength\@tempdima{1.5em}
        \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode\bfseries
        \advance\leftskip\@tempdima
        \hskip -\leftskip
%      esta é a definicao original da classe report:
%      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
        \@dottedtocline{0}{0em}{\ii@chapnumindent}{\uppercase{#1}}{#2}
%        \@dottedtocline{0}{0em}{\ii@chapnumindent}{\MakeUppercase{#1}}{#2}
        \penalty\@highpenalty
        \endgroup
}
\renewcommand*{\l@section}[2]
              {\@dottedtocline{1}{0em}{2.8em}{\textbf{#1}}{\hss #2}}
\renewcommand*{\l@subsection}{\@dottedtocline{2}{0em}{3.7em}}
\newif\if@aftertoc
\@aftertocfalse
\renewcommand{\tableofcontents}{%
        \chapter*{\contentsname}
        \@starttoc{toc}\@aftertoctrue%
}

%==============================================================================
% Definição das listas de abreviaturas e siglas e de símbolos
%==============================================================================
\newenvironment{listofabbrv}[1]{
        \chapter*{\listabbrvname}
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{3em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
}
\newenvironment{listofsymbols}[1]{
        \chapter*{\listsymbolname}
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{1em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
}

%==============================================================================
% Resumo (abstract) e Abstract (englishabstract)
%==============================================================================
\renewenvironment{abstract}{%
        \chapter*{\abstractname}
}{%
        \par%\vfill
        \noindent\textbf{\keywordsname:} \@abstractkw.
}
\newenvironment{englishabstract}[2]{%
        %\if@openright\cleardoublepage\else\clearpage\fi%
        \gdef\@englishkeywords{#2}%
        \iflanguage{english}{
                \begin{otherlanguage}{brazilian}
        }{
                \begin{otherlanguage}{english}
        }
                \chapter*{Abstract}
                % os 22ex abaixo fazem o título em inglês iniciar a
                % aproximadamente 5cm da borda superior
                \noindent\raisebox{22ex}[0pt][0pt]{%
                       \parbox[t]{\textwidth}{\centering\textbf{#1}}
                }\vspace{-\baselineskip}\par
}{
        \par%\vfill
       \noindent\textbf{Keywords:} \@englishkeywords.
        \end{otherlanguage}
}

%==============================================================================
% Formatação dos capítulos.
% Os comandos \@chapter e \@schapter são redefinidos para que a
% numeração de páginas seja correta (deve aparecer somente a partir do
% primeiro capítulo do texto, mas não nas páginas iniciais de
% capítulos).
% Os comandos \@makechapterhead e \@makeschapterhead fazem a
% formatação dos títulos propriamente ditos.
%==============================================================================
\newcommand{\ii@chapterfont}{}
\def\@chapapp{}
\def\@chapter[#1]#2{%
        \refstepcounter{chapter}%
        \addcontentsline{toc}{chapter}{\protect\numberline{\@chapapp\thechapter}#1}%
        \addtocontents{lof}{\protect\addvspace{10\p@}}%
        \addtocontents{lot}{\protect\addvspace{10\p@}}%
        \pagestyle{unilasalle}\let\ps@plain\ps@unilasallecap%
        \@makechapterhead{#2}\@afterheading
}
\def\@makechapterhead#1{%
        \vspace*{50mm}
        \reset@font\noindent{\ii@chapterfont\textbf{\@chapapp\thechapter\hspace{1em}\MakeUppercase{#1}}\par}
        \addvspace{42pt}
}
\def\@schapter#1{%
        \if@aftertoc\addcontentsline{toc}{chapter}{#1}\fi%
        \addtocontents{lof}{\protect\addvspace{10\p@}}%
        \addtocontents{lot}{\protect\addvspace{10\p@}}%
        \@makeschapterhead{#1}\@afterheading
}
\def\@makeschapterhead#1{%
        \vspace*{80pt}
        \reset@font\centerline{\ii@chapterfont\textbf{\MakeUppercase{#1}}}
        \addvspace{36pt}
}
\renewcommand{\appendix}[1][\appendixname]{%
        \setcounter{chapter}{0}%
        \renewcommand{\thechapter}{\Alph{chapter}}%
        \setcounter{tocdepth}{0}%
        \@captionlistingfalse%
        \gdef\@chapapp{\MakeUppercase{#1}\space}%
        \addtocontents{toc}{%
          \settowidth{\ii@chapnumindent}{{\textbf{\@chapapp}}}
          \addtolength{\ii@chapnumindent}{1.8em}
        }%
}
\newcommand{\annex}{\appendix[\annexname]}

%==============================================================================
% Formatação das seções
%==============================================================================
\setcounter{secnumdepth}{4}
\renewcommand{\section}{%
        \@startsection{section}{1}{0pt}{18pt}{9pt}{\reset@font\bfseries}
}
\renewcommand{\subsection}{%
        \@startsection{subsection}{2}{0pt}{12pt}{6pt}{}
}
\renewcommand{\subsubsection}{%
        \@startsection{subsubsection}{3}{0pt}{12pt}{6pt}{}
}
\renewcommand{\paragraph}{%
        \@startsection{paragraph}{4}{0pt}{12pt}{6pt}{\reset@font}
}
\renewcommand{\subparagraph}{%
        \@startsection{subparagraph}{5}{0pt}{1ex}{-1em}{\reset@font\bfseries}
}

%==============================================================================
% Redefinição do conteúdo das listas de figuras e tabelas
%==============================================================================
\newif\if@captionlisting\@captionlistingtrue
\long\def\@caption#1[#2]#3{%
  \par
  \if@captionlisting%
    \addcontentsline{\csname ext@#1\endcsname}{#1}%
        {\protect\numberline{\csname fnum@#1\endcsname:}{\ignorespaces #2}}%
  \fi%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup%
}
\renewcommand*{\l@figure}{\@dottedtocline{1}{0em}{5.5em}}
\let\l@table\l@figure

%==============================================================================
% Redefinição do formato de citações longas
%==============================================================================
\renewenvironment{quote}{%
        \small%
        \begin{list}{}{\setlength{\leftmargin}{40mm}\item\relax}
}{%
        \end{list}
}

%==============================================================================
% Ajuste do formato das citações e referências
%==============================================================================
\setlength{\bibhang}{0pt}
\let\cite\citep

%
% comandos DEPRECATED
% mantidos aqui somente para compatibilidade, nao constam mais do exemplo
% sugere-se remove-los a partir de julho/2003
% 07/dez/2002 - avila
%
\newcommand{\cip}{}
\newenvironment{dedicatoria}{%
        \clearpage%
        \mbox{}\vfill\begin{flushright}
}{
        \end{flushright}
}
\newenvironment{agradecimentos}{\chapter*{Agradecimentos}}{}
