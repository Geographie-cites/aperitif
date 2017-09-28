## Présentation du projet

L'automobile est au coeur d'un système d'externalités négatives bien renseigné qui affecte la santé publique via la pollution locale et l'accidentologie, qui nuit à l'environnement local et mondial via sa participation au changement climatique, et qui consomme une part importante de l'espace urbain. L'Ile-de-France, de plus en plus connue pour ses pics de pollution et ses embouteillages à répétition, offre un cas particulièrement intéressant pour penser une sortie de l'automobile. Elle présente à la fois une agglomération dense où l'utilisation de l'automobile diminue et des espaces périphériques (espaces ruraux et villes secondaires), moins pourvus en transports alternatifs, où son usage continue de croître.

Le projet [Postcar Île-de-France](http://fr.forumviesmobiles.org/projet/2017/02/27/post-car-ile-france-3516) est une collaboration de recherche entre le laboratoire [Géographie-Cités](http://parisgeo.cnrs.fr) et le [Forum des Vies Mobiles](http://fr.forumviesmobiles.org). Le laboratoire Géographie-cités a composé une équipe réunissant des compétences pluridisciplinaires d'aménagement-urbanisme ([Jean Debrie](http://www.parisgeo.cnrs.fr/spip.php?article5684&lang=fr), [Juliette Maulat](http://www.parisgeo.cnrs.fr/spip.php?article324&lang=fr), de géographie urbaine ([Sandrine Berroir](http://www.parisgeo.cnrs.fr/spip.php?article51&lang=fr) et de modélisation en géographie ([Arnaud Banos](http://www.parisgeo.cnrs.fr/spip.php?article5&lang=fr), [Hadrien Commenges](http://www.parisgeo.cnrs.fr/spip.php?article87&lang=fr). Les chercheurs sont accompagnés par les étudiants d'un atelier du master Aménagement-Urbanisme (Univ. Paris 1) et du master Carthagéo (Univ. Paris 1, Univ. Paris 7, ENSG). **Cette application est le fruit du travail effectué dans le cadre de l'atelier du master Carthagéo**.

<img src="logos.png" alt="logos" style="height:100px">


## Citation

- **pour l'application :**
	- COMMENGES Hadrien (dir.), ADOLPHE Mary Francia, AINSA Alice, BASSOLE Simon, BEN RHAIM Mohamed Amine, BOCQUILLON Marie, DESHAYES Marion, DOUET Aurélie, FOUGEIROL Séverine, JANIN Oscar, LAMY Thomas, MARCEL Olivier, MUSSEAU Laurent, PAIRE Marianne, PICARD Floriane, POTTIER Billy, QUENON Maxime, RABINIAUX Coralie, VERDIER Cédric (2017) *Apérit-IF : explorations introductives sur les mobilités en Île-de-France*, UMR 8504 Géographie-cités.

- **pour les données :**
	- fond de carte : OpenStreetMap, Carto.DB, leaflet
	- délimitations administratives : IGN, Base municipale Geofla 2012
	- temps de transport : DRIEA-IF, Matrices de temps de transport du modèle MODUS
	- navettes domicile-travail : Insee, Recensement de la population 2012
	- aspirations : Forum des Vies Mobiles & ObSoCo, Enquête aspirations


## Accès à l'application et au code

- Accès à l'application Apérit-IF sur le serveur de l'UMR 8504 Géographie-cités : XXX
- Accès à l'application Apérit-IF sur le serveur du TGIR Huma-Num : https://analytics.huma-num.fr/Hadrien.Commenges/aperitif
- Accès au code de l'application sur le dépot Github : XXX


## Description des analyses

### Visibilité

L'analyse de **visibilité** doit se comprendre comme métaphore des jeux vidéos dans lesquels le terrain de jeux est initialement obscurci (*terra incognita*) et apparait au fur et à mesure de son exploration. Pour une commune, un mode de transport et un temps de transport, la zone de visibilité est définie comme la zone accessible (desserte). Les matrices de temps de transport sont riches d'enseignement parce qu'elles portent une information sur la structure du réseau d'infrastructure mais aussi sur la structure des flux.

- **Commentaires et exemples :**
	- Au départ d'Argenteuil, en voiture à l'heure de pointe du matin (VPM), avec un temps de transport maximum de 45 minutes, la zone de visibilité s'étend à tout le Nord-Ouest de l'Île-de-France jusqu'aux frontières de l'Oise. En revanche, cette zone s'arrête au Nord du périphérique parisien et Paris dans son ensemble reste inaccessible.
	- Avec les mêmes paramètres (VP matin, temps de 45 mn) mais à destination d'Argenteuil, Paris fait partie de la zone de visibilité. Ceci est une illustration de la structure des flux, centripète le matin et centrifuge le soir : les Argenteuillais ne peuvent pas accéder à Paris en voiture le matin en moins de 45 minutes, alors que les Parisiens peuvent accéder à Argenteuil dans ces mêmes conditions.

- **Données et méthodes :**
	- Matrices de temps de transport entre zones, en transport en commun (TC), en véhicule particulier à l'heure de pointe du matin (VPM) et à l'heure de pointe du soir (VPS).
	- Le zonage de la DREIA-IF (zonage du modèle de prévision MODUS) est transféré dans le zonage communal francilien (1300 communes et arrondissements). Les zones MODUS sont très fines dans Paris et très vastes en grande couronne, le transfert du zonage MODUS au zonage communal permet une bonne approximation des temps de transport dans toute la zone dense de Paris et de la petite couronne (départements 75, 92, 93, 94). En revanche,  dans les communes peu denses de grande couronne, l'estimation des temps de transport est imprécise.
	- Les zones d'accessibilité sont calculées à partir des matrices de temps par interpolation avec une moyenne pondérée par la distance (*Inverse Distance Weighted*).

### Vitesses

L'analyse des **vitesses** consiste à calculer pour chaque commune le temps moyen d'accès vers toutes les autres communes et la vitesse moyenne d'accès vers toutes les autres communes d'Île-de-France. Cette analyse est tirée des travaux de Karel Martens qui considère que la vitesse moyenne d'accès à l'ensemble de la ville donne un "index de mobilité potentielle" (*PMI - Potential Mobility Index*). La vitesse moyenne d'accès, ou PMI, a l'intérêt d'être indépendante de la position de la commune dans l'espace d'étude, ce qui n'est pas le cas du temps moyen d'accès. Une commune en bordure de la région aura une accessibilité faible (temps moyen d'accès important) parce qu'elle est loin de toutes les autres, alors qu'une commune située au centre de la région aura une accessibilité forte (temps moyen d'accès faible). Cette différence est due uniquement à la situation de la commune. En revanche la vitesse moyenne d'accès sera comparable pour ces deux communes indépendemment de leur situation au sein de la région.

- **Commentaires et exemples :**
	- Il y a une relation faible entre PMI (vitesse moyenne) et accessibilité (temps moyen). Pour le VP les résultats reflètent à la fois la structure du réseau et la structure des flux (congestion). Cette relation est plutôt positive : plus le temps moyen est élevé, plus la vitesse moyenne est élevée. Les communes de grande couronne par exemple sont éloignées de l'ensemble des autres communes (temps moyen élevé) mais on y circule à grande vitesse. À l'inverse, les communes du centre de l'agglomération sont proches de l'ensemble de la région (temps moyen faible) mais les vitesses de circulation sont faibles. Pour le TC, les résultats reflètent uniquement la structure du réseau et la relation est négative : plus le temps moyen est élevé plus la vitesse moyenne est faible. Les communes du centre de l'agglomération sont bien connectées à l'ensemble de la région par le réseau de transport public, elles sont à la fois proches de l'ensemble et bénéficient de vitesses rapides. À l'inverse, les communes de grande couronne (à l'exception de certains points du réseau de RER et Transilien comme Meaux ou Melun) sont éloignées de l'ensemble tout en subbissant des vitesses moyennes faibles.
	- La mise en relation de l'accessibilité et de la vitesse forme un cadre d'analyse intéressant (*POMA framework*, voir les travaux de Martens) : il met en avant les communes fragiles du point de vue de l'accessibilité (en rouge : communes éloignées des autres avec des vitesses faibles) et les communes gagnantes (en vert : communes proches des autres avec des vitesses élevées).

- **Données et méthodes :**
	- Matrices de temps de transport entre zones, en transport en commun (TC), en véhicule particulier à l'heure de pointe du matin (VPM) et à l'heure de pointe du soir (VPS).
	- Le zonage de la DREIA-IF (zonage du modèle de prévision MODUS) est transféré dans le zonage communal francilien (1300 communes et arrondissements). Les zones MODUS sont très fines dans Paris et très vastes en grande couronne, le transfert du zonage MODUS au zonage communal permet une bonne approximation des temps de transport dans toute la zone dense de Paris et de la petite couronne (départements 75, 92, 93, 94). En revanche,  dans les communes peu denses de grande couronne, l'estimation des temps de transport est imprécise.
	- Le graphique représente la position des communes selon leur vitesse moyenne et leur temps moyen d'accès, les cadrants sont définis par la médiane de chacune des deux variables.

### Flux

L'analyse des **flux** permet de visualiser les principaux flux à origine ou à destination d'une commune donnée, avec le moyen de transport sélectionné.

- **Commentaires et exemples :**
	- L'analyse des flux permet de raisonner en termes de nombre d'individus et en termes de cumul de distance. En Île-de-France, la distance moyenne parcourue entre domicile et travail est d'environ 10km. Avec environ 5 millions d'actifs occupés, ce sont donc 50 millions de kilomètres qui sont parcourus quotidiennement. Le critère du cumul de distance met en avant, pour une commune donnée, les flux qui participent à alimenter ces 50 millions de kilomètres quotidiens. Par exemple, à origine de Paris, c'est presque toujours Roissy qui apparait comme destination principalement responsable de la distance parcourue.
	- Il est intéressant de comparer, pour une même commune d'origine, les principaux flux en véhicule particulier et en transport public (essayer par exemple Saint-Denis). Les flux en transport public sont centripètes alors que les flux en véhicule particulier sont beaucoup moins polarisés. Ceci reflète le caractère centralisé du réseau de transport public et le caractère distribué du réseau viaire.

- **Données et méthodes :**
	- Navettes domicile-travail du Recensement de la population 2012 (Insee) avec sélection des déplacements ayant leur origine et leur destination en Île-de-France.
	- Le recensement renseigne sur le transport principal utilisé avec une typologie ancienne et contestée, en effet, le mode "deux-roues" comprend aussi bien les vélos que les véhicules à deux-roues motorisés. Dans le cadre du projet Postcar il a été considéré qu'un véhicule privé motorisé est assimilable à une voiture, quel que soit le nombre de roues. Les deux-roues motorisés ont été réassignés à la catégorie "véhicule particulier" avec un modèle de régression logistique fondé sur la distance du trajet et sur le sexe de l'individu.



### Bassins

L'analyse des **bassins** met en avant les déséquilibres entre bassin d'emploi et bassins de main d'oeuvre. Chaque déplacement domicile-travail est défini par une origine (commune de résidence de l'actif) et une destination (commune de travail). Considérant qu'un actif est prêt à parcourir 5 km pour atteindre un emploi (plus de précisions ci-dessous), en chaque point du territoire sont comptabilisés dans une fenêtre de 5 km le nombre d'actifs (bassin à l'origine ou bassin de main d'oeuvre) et le nombre d'emplois (bassin à destination ou bassin d'emploi).

- **Commentaires et exemples :**
	- Le bassin à l'origine, ou bassin de main d'oeuvre, est donc le nombre d'actifs disponibles dans une fenêtre de 5 km. Au centre de Paris le bassin de main d'oeuvre est d'environ 800~000 actifs, en grande couronne ce nombre tombe à quelques dizaines.
	- Le bassin à destination, ou bassin d'emploi, est le nombre d'emplois disponibles dans une fenêtre de 5 km. Au centre de Paris le bassin d'emplois est d'environ 1,2 million d'emplois, en grande couronne ce nombre tombe à quelques dizaines.
	- Le différentiel soustrait le bassin d'emploi au bassin d'actif. Les zones apparaissant en rouge sont déficitaires en actifs : il faut importer des actifs pour y remplir les emplois. Les zones apparaissant en bleu sont déficitaires en emplois : il faut que les actifs se déplacent pour aller chercher des emplois ailleurs.
	- Toutes les analyses (bassin de main d'oeuvre, bassin d'emploi, différentiel) peuvent être déclinées selon des catégories de population : par sexe, par catégorie socio-professionnelle, par mode de transport principal.

- **Données et méthodes :**
	- Navettes domicile-travail du Recensement de la population 2012 (Insee) avec sélection des déplacements ayant leur origine et leur destination en Île-de-France.
	- Les stocks d'actifs et d'emplois en tout point sont estimés par un modèle d'accessibilité gravitaire. Pour un point donné on dénombre le nombre d'emplois (ou d'actifs) accessibles dans un rayon de 5 km en pondérant cette accessibilité par la distance. Il y a ainsi un gradient d'accessibilité : accessibilité totale de l'emploi lorsqu'il se situe au lieu de résidence, puis qui diminue lorsque la distance augmente. Les emplois situés au-delà de 5 km (distance médiane des déplacements domicile-travail en Île-de-France) continuent d'être accessibles mais avec un poids faible.

### Aspirations

À voir.

### Bibliographie

- Sur le calcul de l'indice de mobilité potentielle (onglet `Vitesses`), voir Martens K. (2015) "Accessibility and potential mobility as a guide for policy action", *Transportation Research Record*, nº2499, pp.18-24.
- Sur le calcul de l'accessibilité gravitaire (onglet `Bassins`), voir Commenges H., Giraud T., Lambert N. (2016) "ESPON FIT : Functional indicators for spatial-aware policy-making", *Cartographica*, vol.51, nº3, pp.127-136.
- Sur les outils utilisés : le langage `R`, les packages `sp`, `SpatialPosition`, `shiny` et `leaflet`.
