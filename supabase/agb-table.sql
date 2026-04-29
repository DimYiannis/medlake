-- Run this in the Supabase SQL editor

CREATE TABLE IF NOT EXISTS agb (
  id           SERIAL PRIMARY KEY,
  articles     TEXT[] NOT NULL DEFAULT '{}',
  translations JSONB  NOT NULL DEFAULT '{}'
);

-- Only one row ever exists
INSERT INTO agb (articles) VALUES (ARRAY[
  'Bei jedem Besuch müssen Sie Ihren Medlake-Ausweis an der Rezeption hinterlegen. Dieser Ausweis ist persönlich und nicht übertragbar; er berechtigt Sie zur Nutzung der Trainingsanlage während der offiziellen Öffnungszeiten.',
  'Alle Interessenten erhalten zunächst eine Bedürfnisabklärung, eine Risikobefragung sowie ein kostenloses Probetraining. Kunden können drei Einführungstrainings, regelmässige Trainingsbetreuung und neue Trainingsprogramme in Anspruch nehmen. Auf Wunsch wird jedes zehnte Training kontrolliert.',
  'Wenn Sie Leistungen nicht nutzen, gibt es keine Rückerstattung oder Preisreduktion. Bei nachgewiesenem Grund wie Krankheit, Unfall, Schwangerschaft oder Militär kann Ihre Mitgliedschaft für einen Zeitraum von 1 bis maximal 6 Monaten pausiert werden.',
  'Sollte der Betrieb aufgrund von Ereignissen höherer Gewalt – zum Beispiel Brand, Epidemie, Pandemie, staatlichen Vorschriften – eingestellt werden, besteht kein Anspruch auf Erstattung oder Verlängerung des Vertrags.',
  'Ein Umzug rechtfertigt keine Kündigung. Im Todesfall endet die Mitgliedschaft automatisch, bereits gezahlte Beiträge werden anteilig zurückerstattet. Die Übertragung des Vertrags auf Rechtsnachfolger ist möglich; hierfür fällt eine Bearbeitungsgebühr von CHF 100.– an.',
  'Aus hygienischen Gründen ist das Trainieren ohne Schuhe oder mit verschmutztem Schuhwerk verboten.',
  'Der Ausweis kann bei groben Verstössen gegen Trainingsregeln oder Fehlverhalten sofort und ohne Rückerstattung eingezogen werden.',
  'Abweichende Vereinbarungen zu diesen AGB sind nur wirksam, wenn sie schriftlich geschlossen wurden.',
  'Der Abonnementbetrag muss innerhalb von 30 Tagen bezahlt werden. Bei Zahlungsverzug werden Verzugszinsen und eine Mahngebühr von CHF 20.– erhoben. Kommt es zu Ratenverzug, ist der verbleibende Restbetrag sofort fällig.',
  'Das Abonnement verlängert sich jährlich automatisch, sofern keine schriftliche Kündigung mindestens einen Monat vor Ablauf erfolgt.',
  'Für sämtliche Streitigkeiten gilt Zürich als Gerichtsstand.',
  'Die Medlake Training AG kann die AGB jederzeit anpassen und informiert die Mitglieder rechtzeitig darüber.',
  'Datenschutz und Newsletter: Durch den Abschluss des Mitgliedschaftsvertrags stimmt das Mitglied der Datenschutzerklärung der Medlake Training AG zu. Wir erheben auch Daten zur Fitness, Gesundheit, Trainingsplan und Ernährung.'
]) ON CONFLICT DO NOTHING;

-- Clear translations cache when articles change
DROP TRIGGER IF EXISTS agb_clear_translations ON agb;
CREATE TRIGGER agb_clear_translations
  BEFORE UPDATE OF articles ON agb
  FOR EACH ROW EXECUTE FUNCTION clear_translations();

-- RLS
ALTER TABLE agb ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public read" ON agb FOR SELECT USING (true);
CREATE POLICY "service write" ON agb FOR ALL USING (true);
