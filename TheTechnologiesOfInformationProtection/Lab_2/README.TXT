dec.1998
-------------------------------------------------------------------------------
                      "KRYPTON" - The cryptography system.

                    Version 1.3.xx BETA brief documentation.
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
1 - SOME INFO ABOUT PROGRAM:
-----------------------------------------------------------------------------

 KRYPTON - A file oriented encryption/decryption program.

 Please note: if you use keybook - keep it open for writing
 (not 'Read-Only') - krypton makes service records, which is prevent it from
 using same key twice, and when no keys left - warn you!

 Command line switches summary:

 To execute shell - simply run KRYPTON without any command line parameters.

 In all functions, that encrypts (a,akw,apw) you may use wildcards,
 but in decrypt commands (e,ekw,ekp) wildcards it is not allowed.

 Example: to add all files from current dir: krypton myenc *.*
          to extract all files just: krypton myenc

 krypton a myenc file1.txt file2.zz file3
  This command creates new encryptin 'myenc.enc' and key for it 'myenc.key'.
  Then it encodes in them files 'file1.txt', 'file2.zz' and 'file3'. 
  (You can encode any number of files.)

 krypton akb myenc mykb10 file1.txt file2.zz file3
  This command creates new encryption 'myenc.enc'. Key for it located
  in 'mykb10.kyb' (KeyBook) which must already be in same dir.
  If you don't know how to generate KeyBook - see next example.
  Then it encodes in 'myenc.enc' files 'file1.txt', 'file2.zz' and 'file3'. 
  Programm gives you "Key ID#" - a number that is required for decryption.
  Advantage of such method of encryption in that you required to send only
  one encrypted file and key ID. But the SAME generation keybook required
  to decrypt.

 krypton gkb curkb
  This simple command provides you with keybook 'curkb.kyb' - the program
  asks you only about lenght of key in keybook, and number of keys in!
  It's recommended to use keys not less than 5000 bytes,(Each new month,
  as power of PC's increases, this number is also need to be greater. Sic.)

 krypton e myenc
  This command decrypts everything from encryption 'myenc.enc' using key
  'myenc.key'

 krypton e myenc compil1.rar
  This command decrypts file 'compil1.rar' from encryptin 'myenc.enc' using
  key 'myenc.key'.

 krypton ekb myenc smbook raritet.com
  This command decrypts file 'raritet.com' from encryptin 'myenc.enc' using
  keybook 'smbook.kyb'. The program asks you about "Key ID#" - it is number
  which is given during encryption process.

 krypton mkb badbook
  If you required to change counters on keybook (for example if you make
  encryption, but somewhy decided to add some file, or remove it at all)
  and you required to use same key - use this command! Programm offers you
  simple menu, with all possible actions with keybook 'badbook.kyb'.
  IMPORTANT!: It's possible to resurrect expired keybooks (simple rewind
  to 0 it counters) BUT NEVER DO THIS! Files, which is encrypted with
  same key LOST MOST OF IT PROTECTION!

 krypton l myenc
  If you need to know what files contains in encryption - use this command.

 krypton l unknown xfile.12
  Somtimes you need to check: is there a file you searched for? This simple
  command check's encryption 'unknown.enc' for presence of file 'xfile.12'
  (Also for .bat files: KRYPTON return 0 if file present and 1 if not)

 krypton akw myenc file1.txt file2.zz file3
  This command creates new encryptin 'myenc.enc' and encodes in it files
  'file1.txt', 'file2.zz' and 'file3'. Just before encoding, it also
  ask's you about 'Code phrase' - your password for this encryption.

 krypton ekw myenc raritet.com
  This command decrypts file 'raritet.com' from encryption 'myenc.enc'.
  Just before extraction, it ask's you about 'Code phrase' - the password
  under which encryption was created. 

 Short info about encryption methods used:

 OTP - a One-Time-Pad - is one of the most powerfull and simple encryption
 sheme currently availible. It's power lies in impossibility to cheat other
 than by direct recheck of all possible keys. This ensured by generation of
 new unique key for each new file.

 DDRND - A very complex method which allows program to generate a nearly
 random bitstream, for use it in OTP-kind of encryption process.

 Also: Minimal password must have two symbols. In shareware version
       maximum lenght of it limited to 4 symbols.

 Rating of protection (Upper is most strongest):
 * OTP (Due to "true" random nature of it)
 * DDRND (Pass phrase) - still on test - may be stronger than OTP.
 * KeyBook - method currently unsafe - not recommended for use.

-----------------------------------------------------------------------------
2 - HOW TO REGISTER:
-----------------------------------------------------------------------------

 After the registration you may use this version of KRYPTON on one PC
 as long, as you wish. There will be discount for future versions of KRYPTON.
 Also the next features of KRYPTON will be opened for you:
  - Pass phrase lenght will be limited to 78 symbols (Shareware - 4 symbols)

 Price of license for non-company users (Per one PC): 16$ USD
 Price for company users: 160$ USD initial + 11$ USD per each PC on which
                          KRYPTON will be used.

 To register program you required to run qregistr.exe (DOS) program.

 How to register:
 Send filled registration form (below,please print) with checks (in US dollars
 drawn on a US bank) or money to:

 "RUSSIA, MOSCOW 125422,
  To: Vladimir V. Sungorkin
  Before requested (Do vostrebovaniya)"

 Also send me E-MAIL (overmaster@geocities.com) with filled copy of form.
 After receiving money (about month) i send you (via E-MAIL) your unique
 Program Serial and SIC numbers.

<== Form begin - cut from this line ==>
ZX-0023-01
Registration form for KRYPTON 1.3 (DOS)

Full name(required)__________________________________________________________

Company______________________________________________________________________

Country__________________________ City_______________________________________

E-MAIL(required)_____________________________________________________________

Full daytime phone(not required)_____________________________________________

Where did you find KRYPTON?(not required)____________________________________

Date dd/mm/yyyy [    /    /    ]

--------- next part for fill by authorized personnel ---------------

DATE [     /     /     ]              SIGN______________

SIC:___________________________________________________________

S/N:___________________________________________________________

NOTES:

<== Form end - cut to this line ==>

-----------------------------------------------------------------------------
3 - POSSIBLE Q&A:
-----------------------------------------------------------------------------

Q: Why don't WINDOWS but DOS?
A: Cause i'd like it more... or, possible, programming in it better...
   or (possible) i'm nearly 100% sure that it's work there! ;-)

Q: Is there some kind of data integrity checks?
A: No. KRYPTON protects data from being readed in it original form, but
   not from modifying it! If after receiving & decrypting file you get a
   scratch from some place in it, it's very possible that this file was
   tampered with.

Q(Obsolete): I'm see RAR archiver - how nice shell it have! Why don't you
   include something like it in krypton?
A: I'm think it's not needed - one time i'm even include it, completed it
   for about 70%, but then scrap. Why (i'm think) someone can need shell?
   Nowdays, not much people works with DOS (thankly to Win95), but thouse
   whose works - knows how to handle it. They definitly use some kind of
   shell, possible even best of them - Norton Commander - so there is no need
   to include any shell in KRYPTON. The main purpose of shell - to easily
   work with files - already maked well by NC! Such thinks maked KRYPTON
   looks how it's looks now - i.e. without any shell. Others - Win95 users -
   buy 'NC for Win95' or don't buy! (I'm not - DOS & NC already works well!) 
A2: Or, in two MAIN words: I'm LAZY. (Not simply lazy, but really LAZY!)

Q: (From hackers) Why this program have such simple registration protection?
A: If some program worth to be cracked - it will be cracked.
   I'm never seen any program that's be able to override this rule. So, why
   then i'm need to include sophisticated protection? Currently, it protects
   only from persons with minimal (by my opinion) hacking abilities -
   from businessmans, kids whom-think-that-they-a-great-hackers, and so on.
   Anyone other can cheat registration easily.
   Anyway, if this program worth hacking - that's a very good sign! ;-)
   And if i'm found it hacked somewhere - it's a VERY GOOD sign! But if i'm
   found someone who hacking my program...  8-)

-----------------------------------------------------------------------------
4 - KNOWN POSSIBLE PROBLEMS:
-----------------------------------------------------------------------------

1 - Do not even try to generate a huge keybook file ( >2gigabytes )!
    KRYPTON cannot work with internal counters, and files aren't generated.
    NOTE: This is not bug, and it cannot be corrected anyhow - 2gb is limit
          which is declared by 'long' variable size, and FAT16. I'm don't
          include any limiters in keybook generation - so be careful not
          to get out of this limit, it's can be dangerous for data on HD.

-=BETA NOTES (KNOWN BUGS)=-

Shell: * Changing drive to floppy without diskette resulting to undeterminate
         result. (Depends on handler) Most possibly quit.
       *

-----------------------------------------------------------------------------
5 - LEGAL:
-----------------------------------------------------------------------------

ALL RIGHTS NOT EXPRESSLY GRANTED HERE ARE RESERVED BY VLADIMIR SOUNGORKINE

ALL COPYRIGHTS TO SOFTWARE ARE EXCLUSIVELY OWNED BY THE AUTHOR -
VLADIMIR SOUNGORKINE

THIS SOFTWARE IS PROVIDED "AS IS". THE AUTOR WILL NOT BE LIABLE FOR ANY
KIND OF LOSS OR DAMAGE ARISING OUT OF THE USE, ABUSE OR THE INABILITY TO USE
THIS SOFTWARE. USE IT AT YOUR OWN RISK!

THIS SOFTWARE COMES WITHOUT ANY KIND OF WARRANTY, EITHER EXPRESSED OR
IMPLIED, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

IF YOU DON'T AGREE WITH THIS TERMS OR IF YOUR JURISTDICTION DOES NOT ALLOW
THE EXCLUSION OF WARRANTY AND LIABILITY AS STATED ABOVE YOU ARE NOT ALLOWED
TO USE THIS SOFTWARE AT ALL.

ONCE REGISTERED, the user is granted a non-exclusive
   license to use KRYPTON on one computer (i.e. a single motherboard),
   for any legal purpose, at a time.  The registered KRYPTON
   software may not be rented or leased, but may be
   permanently transferred, if the person receiving it agrees
   to terms of this license.  If the software is an update,
   the transfer must include the update and all previous
   versions.

THIS SOFTWARE IS SHAREWARE. NON-EXCLUSIVE LICENSE TO USE THIS SOFTWARE IN
ITS UNMODIFIED FORM FOR ANY LEGAL PURPOSE HEREBY GRANTED FOR 30 DAYS TRIAL
PERIOD (BEGINNING FROM DATE OF FIRST INSTALLATION OF THIS SOFTWARE). AFTER
EXPIRING OF THAT PERIOD, ONLY REGISTERED USERS ALLOWED TO USE THIS SOFTWARE
ON THE SAME LICENSE BASIS, AS STATED IN THIS TERMS. IF SOFTWARE REMAINS
UNREGISTERED TO THE END OF TRIAL PERIOD YOU MUST REMOVE IT FROM YOUR COMPUTER.
IF YOU ALREADY SEND REGISTRATION FORM, YOU MUST CEASE TO USE SOFTWARE UNTIL
REGISTRATION INFO WAS RECEIVED AND SOFTWARE REGISTERED VIA INCLUDED
REGISTRATION PROGRAM.

YOU ARE NOT ALLOWED TO USE OTHER METHODS OF REGISTRATION THAN VIA INCLUDED IN
ORIGINAL DISTRIBUTION REGISTRATION PROGRAM AND REGISTRATION INFORMATION
WHICH YOU RECEIVE AFTER PAYMENT OF LICENSE FEES TO COPYRIGHT HOLDER.

YOU ARE NOT ALLOWED TO USE OTHER REGISTRATION INFO THAN BY THOUSE PROVIDED TO
YOU BY COPYRIGHT HOLDER.

THE UNREGISTERED SHAREWARE VERSION OF SOFTWARE MAY BE FREELY DISTRIBUTED,
PROVIDED THE DISTRIBUTION PACKAGE IS NOT MODIFIED. NO PERSON OR COMPANY
MAY CHARGE A FEE FOR THE DISTRIBUTION OF SOFTWARE WITHOUT WRITTEN PERMISSION
FROM THE COPYRIGHT HOLDER. YOU ARE NOT ALLOWED TO REDISTRIBUTE REGISTERED
COPIES OF THE SOFTWARE OR MERE PARTS OF IT.

YOU MAY NOT USE, COPY(EXCEPT FOR YOUR ONE PERSONAL BACKUP COPY),
EMULATE, CLONE, RENT, LEASE, SELL, MODIFY, DECOMPILE, DISASSEMBLE,
OTHERWISE REVERSE ENGINEER, OR TRANSFER THE LICENSED PROGRAM OR ANY SUBSET OF
LICENSED PROGRAM EXCEPT AS PROVIDED FOR IN THIS AGREEMENT. ANY SUCH
UNAUTHORIZED USE SHALL RESULT IN IMMEDIATE AND AUTOMATIC TERMINATION OF THIS
LICENSE AND MAY RESULT IN CRIMINAL AND/OR CIVIL PROSECUTION

ALL BRANDNAMES AND TRADEMARKS ARE PROPERTY OF THEIR RESPECTIVE HOLDERS.

-----------------------------------------------------------------------------
6 - HISTORY:
-----------------------------------------------------------------------------

Version      Date                         Info
  0.7b    3.jun.1998     Initial beta release - nothing more to say...
                         Supports single file OTP.
                         C-source:300+ lines

  0.xxb  __.ju_.1998     There be some versions with NC style shell.
                         But they never went in big world.
                         C-source:about 1400 lines (don't sure)
                         
  0.17b   8.jul.1998     Completly rewrited version:
                         ADDED: Ability to form a multi-file archives,
                         registration,shareware time limiters.
                         REMOVED: Some nasty bugs! ;-)
                         C-source:550+ lines

  1.0    14.jul.1998     Initial commercial release. Also 'l' option added.
                         C-source:600+ lines

  1.1    24.jul.1998     Second commercial release:
                         ADDED: Pass Phrase encoding.
                         CHANGED: Encryption method's maked stronger;
                         so, this version cannot work with 1.0 created
                         encryptions. Sorry. Also changed some internal
                         things, to allow use other file extensions in
                         extraction process.
                         REMOVED: ShareWare internal time limiters!
                         (Previous version have expiration timelimiter)
                         C-source:850+ lines

  1.2    25.aug.1998     Third commercial release - first time WWW publiced.
                         Many minor changes. (Added progress meter, etc.)
                         Very hightly improved encryption for KeyBooks.
                         For Pass Phrase encryption it's changed to DDRND.
                         (I.e. practically rewrited - so new format for all
                         files - and again no more previous versions support.
                         Sorry.)
                         C-source:1200+ lines
                         P.S. Still no one registeres. So bad it?
                         There will be just one next version, then work will
                         be stopped, untill i'm don't have at least 20 reg's.
                         Or, may be, even next version don't be.

  1.21    7.sep.1998     Service Release.
                         Very huge bug detected and removed - you need
                         to re-encrypt all previous encryptions that uses
                         password method.

  1.3.xx xx.nov.1998     Next version. Improved DDRND method, so you need
                         to re-encrypt all previous encryptions that uses
                         password method. But anyway, in previous versions
                         this method was availible only in registered version
                         but i'm still don't receive any registrations - so
                         this doesnt bothers you! ;-) Also added NC (or RAR)
                         style shell and opened password encryption, with
                         limit to 4 chars in password itself. (You may call
                         it 'Priview' - as it noway else limited)
                         "NULL FILE" bug corrected.
                         "epw no params" bug corrected.
                         C-source: 1800+

-----------------------------------------------------------------------------
7 - FUTURE OF KRYPTON:
-----------------------------------------------------------------------------

Version 1.3 planned to be released in decembre, but may be late - i don't
have time to spend on it - for me it already work's well.
Also unpaid work is slow work.

-----------------------------------------------------------------------------
8 - HOW TO CONTACT:
-----------------------------------------------------------------------------

E-Mail: overmaster@geocities.com

-----------------------------------------------------------------------------
P.S. Sorry about english spelling & grammar, but thus aren't my native lang!
