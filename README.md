# ITU projekt - parkourové spoty

## Popis instalace
1. Nainstalovat flutter
2. Připojit k počítači zařízení Android
3. Povolit na Android zařízení `Developer Options` a následně `USB Debugging`
4. Zkontrolovat, jestli při spuštění příkazu lze vidět Android zařízení z počítače (jestli ne, je potřeba postupovat podle návodu na stránce ...) 
5. V kořenové složce projektu spustit příkaz: `flutter build apk --release` (generování spustitelného souboru aplikace)
6. V kořenové složce projektu spustit příkaz: `flutter install` (instalace na zařízení)

Toto by byl postup vhodný pokud by neby používán Firebase jako BE. Tím, že náš program je vázán na Firebase, je možné provést release pouze na našich strojich spojených s tímto projektem.
Tento apk file si ale po vygenerování může kdokoliv nahrát na svoje Android zařízení.

## Knihovny a licence

***Flutter:***

Odkaz: https://github.com/flutter/flutter
Licence: Flutter používá vlastní licenci, která umožňuje široké použití a modifikace.

***Firebase***

Odkaz: https://github.com/firebase
Licence: Firebase balíčky pro Flutter jsou poskytovány pod různými licencemi (Apache License 2.0, MIT, BSD, atd.)

***File Picker***

Odkaz: https://github.com/miguelpruivo/flutter_file_picker
Licence: MIT Licence

***Table Calendar***

Odkaz: https://github.com/aleksanderwozniak/table_calendar
Licence: MIT Licence