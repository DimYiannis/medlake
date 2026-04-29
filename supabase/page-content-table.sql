-- Run this in the Supabase SQL editor

CREATE TABLE IF NOT EXISTS page_content (
  id           SERIAL PRIMARY KEY,
  slug         TEXT UNIQUE NOT NULL,
  content      JSONB NOT NULL DEFAULT '{}',
  translations JSONB NOT NULL DEFAULT '{}'
);

ALTER TABLE page_content ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public read"   ON page_content FOR SELECT USING (true);
CREATE POLICY "service write" ON page_content FOR ALL   USING (true);

-- Clear translations cache when content changes
DROP TRIGGER IF EXISTS page_content_clear_translations ON page_content;
CREATE TRIGGER page_content_clear_translations
  BEFORE UPDATE OF content ON page_content
  FOR EACH ROW EXECUTE FUNCTION clear_translations();

-- ── Seed data ──

INSERT INTO page_content (slug, content) VALUES
('leistungen/krafttraining', '{
  "title": "Krafttraining",
  "intro": "Ein gesundheitsorientiertes Krafttraining führt zu einem besseren Allgemeinzustand — und ist die wirksamste Prävention gegen chronische Schmerzen des Bewegungsapparates.",
  "benefitsLabel": "Vorteile",
  "benefitTitles": ["Kraftreserven", "Prävention", "Stoffwechsel", "Knochengesundheit"],
  "benefitTexts": ["Aufbau von Kraftreserven für Alltagsbelastungen und Sport.", "Verhindert Nackenverspannungen, Rücken- und Gelenkbeschwerden.", "Optimiert den Stoffwechsel und die Fettverbrennung.", "Stärkt den Knochen durch Stimulation der Knochendichte."],
  "paras": ["Mitverantwortlich für akute und chronische Schmerzen des Bewegungsapparates sind immer schwache Muskeln, die bei zusätzlicher Fehlbelastung sowie Abnützungen an Gelenken, Sehnen oder Bandscheiben zu Verspannungen, Entzündung und letztlich Schmerzen führen.", "Ein Kraftzuwachs kompensiert den natürlichen Muskelabbau und bewirkt Stabilität an Gelenken und Wirbelsäule. Dadurch werden die schmerzenden Weichteile wie Bänder, Sehnen und Bandscheiben entlastet.", "Der Hauptnutzen des Trainings an Geräten liegt im dosierbaren Widerstand, der nach und nach vergrössert wird, bis die altersentsprechende Kraft erreicht wird. Krafttraining mit Geräten ist gelenkschonend, weil die Bewegung geführt wird. Eine kräftige Muskulatur hält den Menschen auch im Alter mobil und selbständig."]
}'::jsonb),

('leistungen/herz-kreislauf', '{
  "title": "Herz & Kreislauf",
  "intro": "Cardio-Training führt zur Ökonomisierung des Herzkreislaufsystems mit verbesserter Muskeldurchblutung — und kann in jedem Alter durchgeführt werden.",
  "benefitsLabel": "Was ein trainiertes Herz-Kreislauf-System bewirkt",
  "benefits": ["Tieferer Ruhepuls", "Grösseres Blutauswurfvolumen pro Herzschlag", "Gefässneubildungen in kräftigeren Muskeln", "Verbesserte Sauerstoffversorgung und Energiebereitstellung", "Schnellerer Abtransport von Abbaustoffen wie Milchsäure", "Mehr Ausdauer auch bei körperlicher Belastung", "Erhöhte Stresstoleranz", "Optimales Körpergewicht", "Bessere allgemeine Gesundheit"],
  "para": "Um im Alltag und Sport gute Leistungen vollbringen zu können, braucht es körperliche Ausdauer — einerseits um nicht vorzeitig zu ermüden, anderseits aber auch, um sich möglichst bald von den Strapazen erholen zu können.",
  "recommendationLabel": "Empfehlung",
  "recommendationText": "Ein gesundheitsorientiertes Kreislauftraining wird 1–2 Mal pro Woche während ca. 20 Minuten durchgeführt."
}'::jsonb),

('leistungen/hilfe-bei-schmerzen', '{
  "title": "Hilfe bei Schmerzen",
  "intro": "Schmerzen im Nacken, Rücken und Gelenken werden im Medlake Center von drei Spezialärzten mit modernsten und computerisierten Kräftigungsgeräten behandelt — unterstützt von Physiotherapeutinnen.",
  "statLabels": ["Spezialärzte vor Ort", "Trainingsfläche", "Krankenkassendeckung"],
  "para1": "Es steht eine integrierte Arzt- und Physiotherapiepraxis zur Behandlung und für Notfälle zur Verfügung.",
  "para2": "Sie finden auf 540 m² einen grossen MedX-Gerätepark mit hochwertigen Rückengeräten sowie in einem separaten Raum hochwertige LIFEFITNESS Liegevelos, Bikes und Crosstrainer.",
  "insuranceLabel": "Krankenkasse",
  "insuranceText": "Die Therapiekosten werden von allen Krankenkassen bezahlt. Für ein Jahresabonnement wird ein Kostenanteil übernommen."
}'::jsonb),

('leistungen/firmenfitness', '{
  "title": "Firmenfitness",
  "intro": "Ihr Beitrag zur Gesundheit Ihrer Mitarbeitenden. Profitieren Sie von einer Firmen-Kooperation mit Medlake und investieren Sie in Ihren Erfolgsfaktor Nr. 1.",
  "benefitsLabel": "Vorteile für Ihr Unternehmen",
  "benefits": ["Höhere Team- und Leistungsfähigkeit der Mitarbeitenden", "Stärkt das Selbstvertrauen und die Motivation", "Verbessert Ihr Unternehmensimage als attraktiver Arbeitgeber", "Förderung von Stressresistenz und mentaler Stärke", "Prävention vom Unternehmen aktiv gefördert", "Niedrigerer Krankheitsstand durch regelmässiges Fitnesstraining"],
  "para": "Neben der fachlichen Aus- und Weiterbildung der Mitarbeitenden ist ihre körperliche Fitness eine wesentliche Grundlage für Unternehmensqualität und Produktivität. Wir motivieren Ihre Teams zu mehr Bewegung und Gesundheit — mit messbaren Ergebnissen."
}'::jsonb),

('leistungen/galileo', '{
  "title": "Galileo Vibrationsplatte",
  "intro": "Seitenalternierende Vibrationsbewegungen bringen Muskeln über Dehnreflexe zu vermehrten Kontraktionen — präzise dosierbar für Sport, Rehabilitation und Schmerztherapie.",
  "para": "Die Stimulation lässt sich über die Zeitdauer, die Frequenzeinstellung sowie über die Fussposition und Körperhaltung individuell steigern und anpassen.",
  "usesLabel": "Einsatzgebiete",
  "uses": ["Zusätzliches Hilfsmittel beim Leistungssport", "Intensivierung der Kräftigung im Training", "Rehabilitation nach Verletzung und schmerzhaften Zuständen", "Kniescheiben- oder Achillessehnenschmerzen", "Bewegungsschmerzhafte Arthrosen", "Chronifizierte Schmerzen", "Neurologische Erkrankungen wie MS, Parkinson, inkomplette Lähmungen"],
  "contraLabel": "Kontraindikationen",
  "contra": ["Schwangerschaft", "Neue Implantate im Beinbereich", "Akute Thrombosen", "Epilepsie"]
}'::jsonb),

('leistungen/kinesis', '{
  "title": "KINESIS Training",
  "intro": "KINESIS — griechisch für Bewegung. Einzigartiges Ganzkörpertraining durch Seilrollen-Widerstand gegen die Schwerkraft über einen sehr weiten Bewegungsradius.",
  "para1": "Das auf Technogym KINESIS basierende Konzept heißt entsprechend »Full Gravity«. Natürlich fliessende Übungsausführungen werden dadurch gezielt gefördert. KINESIS ist kein Ersatz für das konventionelle Training — vielmehr eine hocheffektive Ergänzung.",
  "para2": "Eine Vielzahl von Übungen auf engstem Raum ist an der Technogym KINESIS-Station möglich. So lässt sich mit minimalem Zeitbedarf eine grosse Bandbreite an sportlichen Zielen abdecken.",
  "focusTitles": ["Kraft", "Flexibilität", "Koordination", "Haltungskontrolle"],
  "focusTexts": ["Effizienter Muskelaufbau durch funktionelle Widerstände.", "Gezielte Dehnübungen für alle Körperregionen.", "Koordinierte Bewegungen mit Widerständen verbinden.", "Training von Gleichgewicht und stabilisierender Muskulatur."],
  "suitableLabel": "Für wen geeignet?",
  "suitableText": "Fortgeschrittene und ambitionierte Sportler können ein komplettes Trainingsprogramm durch spezielle Bewegungsformen durchführen. Im Rahmen der Physiotherapie wird die KINESIS-Station für gezieltes Training in der Rehabilitation eingesetzt."
}'::jsonb),

('leistungen/med-x', '{
  "title": "Ärztliche Trainingstherapie (MED-X)",
  "intro": "Computerisierte MedX-Geräte fördern den Muskelaufbau im Nacken- und Lendenbereich mit höchster Präzision — jede Therapieeinheit erfolgt in Einzelbehandlung mit dem Arzt.",
  "para1": "Dank optimaler Fixierung des Patienten können Hilfsmuskeln völlig ausgeschaltet werden, was eine optimale Kräftigung der Zielmuskulatur bewirkt. Die Geräteeinstellung erlaubt ein dosiertes Bewegen im schmerzfreien Bereich.",
  "para2": "Mit Gewichten im Pfundbereich, mit dokumentierter Zeit und Bewegungsrepetition kann schonend und kontrolliert trainiert werden. Dies lässt ein Training nach akutem Schmerzschub, nach Gelenksblockierungen oder nach Rückenoperationen zu.",
  "analysisLabel": "Computergestützte Analyse",
  "analysisText": "Aufgrund der gemessenen Werte errechnet der Computer die Kraftkurve des Patienten, welche mit alters-, geschlechts- und gewichtsspezifischen Normdaten verglichen wird.",
  "indicationsLabel": "Geeignet für Patienten mit",
  "indications": ["Eingeschränkter Beweglichkeit der Wirbelsäule", "Zu niedrigem Kraftniveau der Rückenstreckmuskulatur", "Chronischen Rücken- und Nackenschmerzen", "Zustand nach Rückenoperationen", "Zustand nach akutem Schmerzschub", "Gelenksblockierungen"]
}'::jsonb),

('leistungen/physiotherapie', '{
  "title": "Physiotherapie & MTT",
  "intro": "Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates — individuell abgestimmt, therapeutisch begleitet, krankenkassenanerkannt.",
  "para1": "MTT wird zur Steigerung der Belastbarkeit des Bewegungsapparates eingesetzt. Mittels Kraft, Ausdauer, Mobilisation, Beweglichkeit und Koordination werden der Bewegungsapparat und der Herzkreislauf trainiert. Dieses Training wird zur Unterstützung von Rehabilitationsprozessen eingesetzt.",
  "para2": "Das Trainingsprogramm wird von einem Physiotherapeuten erstellt und individuell auf den Patienten abgestimmt — unter Berücksichtigung medizinischer Diagnosen, der aktuellen Rehabilitationsphase und der körperlichen Voraussetzungen.",
  "focusTitles": ["Kraft", "Ausdauer", "Mobilisation", "Koordination"],
  "focusTexts": ["Gezielter Aufbau der Muskulatur im betroffenen Bereich.", "Verbesserung der kardiovaskulären Belastbarkeit.", "Wiederherstellung des vollen Bewegungsumfangs.", "Training neuromuskulärer Steuerung und Stabilität."],
  "insuranceLabel": "Krankenkasse & Verordnung",
  "insuranceText": "Eine MTT-Verordnung wird von Ihrem Arzt ausgestellt und dauert 3 Monate. Die Kosten werden in der Regel von der Grundversicherung oder der Unfallversicherung übernommen. Wir empfehlen nach Ablauf der Verordnung, das Training bei uns fortzuführen."
}'::jsonb),

('preise', '{
  "title": "Preise & Leistungen",
  "desc": "Transparente Preise für alle — inklusive medizinisch begleiteter Betreuung von Beginn an.",
  "adults": "Erwachsene",
  "recommended": "Empfohlen",
  "book": "Termin vereinbaren",
  "includedLabel": "Im Abonnement enthaltene Leistungen",
  "notIncludedLabel": "Zusätzliche Kosten (nicht im Abo enthalten)",
  "insuranceNote": "Gerne beraten wir Sie bezüglich Reduktionen durch Ihre Krankenkasse.",
  "mainPlans": [
    {"name": "Medlake Premium", "desc": "Unser umfassendstes Paket — inklusive aller Spezialgeräte", "price": "1300", "duration": "12 Monate", "featured": true, "features": ["Inklusive Galileo Vibrationsplatte", "Inklusive Sensopro", "Inklusive Kinesis Station", "Handtuch (leihweise)", "Alle Grundleistungen"]},
    {"name": "Medlake Plus+", "desc": "Mit einem Spezialgerät Ihrer Wahl", "price": "1100", "duration": "12 Monate", "featured": false, "features": ["Sensopro ODER Kinesis ODER Galileo", "Alle Grundleistungen"]},
    {"name": "Trainingsabonnement", "desc": "Klassisches Jahresabo ohne Extras", "price": "1000", "duration": "12 Monate", "featured": false, "features": ["Nutzung aller Trainingseinrichtungen", "Einführung & Betreuung", "Trainingskontrolle"]}
  ],
  "otherCategories": [
    {"title": "Studenten", "items": [{"label": "Jahresabonnement", "sub": "12 Monate", "price": "CHF 900.–"}, {"label": "Halbjahresabo", "sub": "6 Monate", "price": "CHF 700.–"}]},
    {"title": "Jugendliche bis 20 Jahre", "items": [{"label": "Jahresabonnement", "sub": "12 Monate", "price": "CHF 700.–"}, {"label": "Halbjahresabo", "sub": "6 Monate", "price": "CHF 500.–"}]},
    {"title": "Familie mit Kind (bis 18 Jahre)*", "items": [{"label": "Jahresabonnement", "sub": "*Für Kinder deren Eltern ebenfalls Abo haben", "price": "CHF 500.–"}]},
    {"title": "Einzelleistungen", "items": [{"label": "Einzeleintritt", "sub": null, "price": "CHF 30.–"}, {"label": "Sensopro", "sub": null, "price": "CHF 15.–"}, {"label": "Personaltraining", "sub": null, "price": "Auf Anfrage"}, {"label": "Handtuchverleih", "sub": null, "price": "CHF 1.–"}, {"label": "Duschgel", "sub": null, "price": "CHF 2.–"}]},
    {"title": "Sensopro — Mitglieder & MedX", "items": [{"label": "Einzeleintritt", "sub": null, "price": "CHF 15.–"}, {"label": "10er Abonnement", "sub": null, "price": "CHF 125.–"}]},
    {"title": "Sensopro — Externe", "items": [{"label": "Einzeleintritt", "sub": null, "price": "CHF 30.–"}, {"label": "10er Abonnement", "sub": null, "price": "CHF 250.–"}]}
  ],
  "included": ["Benützung der Trainingseinrichtungen, Garderoben und Duschkabinen", "Instruktion und Einführung — die ersten 3 Trainings werden von einem Instruktor begleitet", "Regelmässige Trainingskontrolle — jedes 10. Training auf Anfrage mit Instruktor", "Periodische Erneuerung des Trainingsprogrammes nach 20–40 Einheiten", "Kostenlose ärztliche Trainingsberatung (bei Jahresabo)", "Kostenloses gekühltes Wasser von Eauvation — mit oder ohne Kohlensäure"],
  "notIncluded": ["Kinesis-Station", "Galileo-Vibrationstraining", "Sensopro", "Dividat", "MedX-Therapie LE/CE", "Physiotherapie"]
}'::jsonb),

('medizinisches', '{
  "chapters": [
    {"id": "geschichte", "label": "Geschichte", "heading": "Geschichte des Krafttrainings"},
    {"id": "kraft", "label": "Kraftzuwachs", "heading": "Kraftzuwachs & Trainingsprinzipien"},
    {"id": "alter", "label": "Muskelkraft & Alter", "heading": "Muskelkraft & Alter"},
    {"id": "ruecken", "label": "Rückenschmerzen", "heading": "Rückenschmerzen"},
    {"id": "ausdauer", "label": "Ausdauer", "heading": "Ausdauertraining"}
  ],
  "geschichte": [
    {"year": "1850", "text": "Henrik Ling, der Begründer der schwedischen Heilgymnastik, führt mit Patienten gebremste Widerstandsbewegungen durch, um geschwächte Patienten zu kräftigen."},
    {"year": "1885", "text": "Gustaf Zander entwickelt medico-mechanische Apparate als Prototypen der heutigen Trainingsgeräte und gründet 1890 medico-mechanische Institute in ganz Europa."},
    {"year": "1970", "text": "Arthur Jones entwickelt die Nautilus-Kraftgeräte — zuerst von Bodybuildern, später von Sportlern und Patienten genutzt."},
    {"year": "1980", "text": "Arthur Jones führt die MedX-Technologie ein. Computerisierte Geräte ermöglichen reproduzierbare Kraft- und Bewegungsmessungen für wissenschaftliche Studien."}
  ],
  "kraft": {
    "para1": "Der Kraftzuwachs ergibt sich aus Adaptationen von Muskeln und Nerven. Durch repetitives Üben wird die Aktivität der verschiedenen involvierten Nerven optimal synchronisiert. Auf der muskulären Ebene nimmt die Querschnittsfläche der verschiedenen Fasertypen zu.",
    "para2": "Die Muskulatur wächst nur am Widerstand. Um Kraft aufzubauen, muss der Widerstand bis zum Erreichen der Maximalkraft kontinuierlich vergrössert werden. Erst mit dem Erreichen der Ermüdungsgrenze wird jener Reiz gesetzt, der den Muskelaufbau auslöst.",
    "principlesLabel": "Trainingsprinzipien",
    "trainingsprinzipien": ["Trainieren Sie 1–2 Mal pro Woche, jedes Training soll den ganzen Körper umfassen.", "Trainieren Sie zuerst die grossen Muskelpartien.", "Wählen Sie ein Gewicht, das eine Übungsdauer von 90–120 Sekunden erlaubt.", "Führen Sie die Bewegung bis zur Erschöpfung der betroffenen Muskeln durch.", "Kann die Trainingszeit überschritten werden, erhöhen Sie beim nächsten Training das Gewicht.", "Vermeiden Sie Pressen, Mitschwingen des Körpers und ruckartige Bewegungen.", "Trinken Sie vor, während und nach dem Training ausreichend Wasser."]
  },
  "alter": {
    "para1": "Die Muskelkraft erreicht mit etwa 25 Jahren den Maximalwert. Wer nicht trainiert, verliert ungefähr 5% an Muskelmasse pro Lebensjahrzehnt — der Fettanteil steigt, das Gewicht bleibt bestenfalls gleich.",
    "stats": [
      {"age": "Ab 30 Jahre", "loss": "~1% / Jahr", "desc": "Beginn des Kraftverlusts ohne spezifisches Training"},
      {"age": "Ab 60 Jahre", "loss": "~15% / Jahr", "desc": "Deutlich erhöhter Kraftverlust im 6./7. Lebensjahrzehnt"},
      {"age": "Ab 70 Jahre", "loss": "~30% / Jahr", "desc": "Starker Kraftverlust ohne regelmässiges Training"}
    ],
    "para2": "Maria Fiatarone bewies 1990 in einer Studie mit 86–96-jährigen Patienten: Nach 10 Wochen Krafttraining stieg die Muskelkraft um 174%. Treppensteigen war wieder ohne Stock möglich. Die Trainierbarkeit der Muskeln bleibt bis ins hohe Alter erhalten."
  },
  "ruecken": {
    "sections": [
      {"title": "Ursachen mechanisch bedingter Rückenschmerzen", "items": ["Fehlbelastung der Wirbelgelenke", "Muskelverkrampfung", "Bandscheibenabnützung", "Nervenkompression", "Bindegewebeüberdehnung"]},
      {"title": "Prophylaxe", "items": ["Übergewicht vermeiden, aufrechte Haltung einnehmen", "Häufig Positionen wechseln", "Beim Bücken Hüften und Knie beugen", "Schwere Gegenstände körpernah heben", "Lasten auf beide Schultern verteilen", "Rückengymnastik und Krafttraining durchführen"]},
      {"title": "Wann zum Arzt?", "items": ["Bei Schmerzen, die über mehrere Tage zunehmen", "Wirbelsäulenblockade", "Schmerzausstrahlung in Arm oder Bein", "Muskelschwäche"]}
    ]
  },
  "ausdauer": {
    "para1": "Definition: Eine Leistung während längerer Zeit vollbringen zu können und danach möglichst bald wieder erholt zu sein. Die Energiebereitstellung entsteht aerob (mit Sauerstoffaufnahme) oder anaerob (durch andere chemische Prozesse).",
    "trainingLabel": "Optimale Trainingsherzfrequenz",
    "trainingText": "Faustregel: Puls 220 minus Lebensalter, davon 60–70%. Weitere Methode: 65–70% der maximalen Herzfrequenz.",
    "effekteLabel": "Effekte des Ausdauertrainings",
    "effekte": ["Ökonomisierung des Herzkreislaufsystems", "Tieferer Ruhepuls", "Bessere Muskeldurchblutung", "Schnellere Regeneration", "Erhöhte Stresstoleranz", "Optimales Körpergewicht"]
  }
}'::jsonb)

ON CONFLICT (slug) DO NOTHING;
