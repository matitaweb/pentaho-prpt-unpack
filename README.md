
    UNPACK PRPT
    ----------------------------------------------------------------- 

i file prpt (report pentaho) sono zip contenenti file testuali xml e di configurazione.
per poterli versionare non in bytecode ma in forma testuale ho scelto di decomprimerli prima
che vengano committati


elenco gli script presenti ed il loro funzionamento:


------------------
precommitunzip.bat
------------------

test su WIN e mercurialhg
per ora solo con su windows e provato agganciandolo ad un hook su mercurial hg


Modifica il file ./hg/hgrc aggiungendo la seguente riga:

##################################
[hooks]
pre-commit = precommitunzip.bat
##################################

Questo comando per forzare prima del commit l'unpack dei file .prpt 
Lo script, solo per il file .*prpt modificati, crea una directory 
con lo stesso nome del file .prpt con il contenuto scompattato (praticamente solo dei file .xml)
in modo da tenere tracciate le modifiche realmente fatte sul report dato che il versionamento
di un file compresso non e' possibile capirne le differenze.


--------------
unzip_prpt.bat
--------------

script per unzip massivo dei prpt


------------
zip_prpt.bat
------------

script per zip massivo delle directory in prpt


TODO
----
da creare la controparte bash su linux