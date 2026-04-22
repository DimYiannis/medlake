<template>
  <div class="min-h-screen pt-36 pb-24" style="background:var(--bg)">

    <div class="px-10 mb-16 border-b pb-12" style="border-color:var(--border)">
      <p class="text-[12px] tracking-[0.3em] uppercase mb-4" style="color:var(--text-3)">Medlake</p>
      <h1 class="font-semibold tracking-[-0.025em] leading-none" style="font-size:clamp(40px,6vw,80px);color:var(--text)">
        {{ $t('pages.agb.title') }}
      </h1>
      <p class="text-[16px] mt-5" style="color:var(--text-3)">{{ $t('pages.agb.subtitle') }}</p>
    </div>

    <div class="px-10 max-w-2xl">
      <div class="space-y-px" style="border-top:1px solid var(--border)">
        <div
          v-for="(article, i) in articles"
          :key="i"
          class="flex gap-8 py-7 border-b"
          style="border-color:var(--border)"
        >
          <span class="text-[15px] font-medium flex-shrink-0 w-6 pt-0.5" style="color:var(--text-3)">{{ i + 1 }}.</span>
          <p class="text-[16px] leading-[1.85]" style="color:var(--text-2)">{{ article }}</p>
        </div>
      </div>

      <div class="mt-12 pt-10 border-t" style="border-color:var(--border)">
        <p class="text-[15px] leading-[1.8]" style="color:var(--text-3)">
          {{ $t('pages.agb.questions') }}
        </p>
        <a href="mailto:info@medlake.ch"
          class="inline-flex items-center gap-2 mt-6 text-[13px] tracking-[0.18em] uppercase transition-opacity hover:opacity-60"
          style="color:var(--text-2)">
          info@medlake.ch
          <svg width="10" height="10" viewBox="0 0 10 10" fill="none"><path d="M1 5h8M5 1l4 4-4 4" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round"/></svg>
        </a>
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
const { t } = useI18n()
useHead({ title: t('pages.agb.meta') })

const articles = [
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
  'Datenschutz und Newsletter: Durch den Abschluss des Mitgliedschaftsvertrags stimmt das Mitglied der Datenschutzerklärung der Medlake Training AG zu. Wir erheben auch Daten zur Fitness, Gesundheit, Trainingsplan und Ernährung.',
]
</script>
