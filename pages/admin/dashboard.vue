<template>
  <div class="min-h-screen flex">

    <!-- Sidebar -->
    <aside class="w-56 flex-shrink-0 border-r border-ml-border flex flex-col bg-[#060606]">
      <div class="px-6 py-5 border-b border-ml-border">
        <p class="text-[12px] tracking-[0.25em] uppercase text-white/25">Medlake</p>
        <p class="text-[13px] tracking-[0.15em] uppercase text-white/50 mt-0.5">Admin</p>
      </div>

      <nav class="flex-1 py-4">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          class="w-full text-left px-6 py-3 text-[12px] tracking-[0.12em] uppercase transition-colors"
          :class="activeTab === tab.id
            ? 'text-white bg-white/[0.05]'
            : 'text-white/30 hover:text-white/60'"
          @click="activeTab = tab.id"
        >
          {{ tab.label }}
        </button>
      </nav>

      <div class="px-6 py-4 border-t border-ml-border">
        <NuxtLink to="/" target="_blank" class="text-[12px] tracking-widest uppercase text-white/20 hover:text-white/50 transition-colors block mb-2">
          Website ↗
        </NuxtLink>
        <button @click="logout" class="text-[12px] tracking-widest uppercase text-white/20 hover:text-white/50 transition-colors">
          Ausloggen
        </button>
      </div>
    </aside>

    <!-- Main content -->
    <main class="flex-1 overflow-y-auto">
      <div class="px-10 py-8 border-b border-ml-border">
        <h1 class="text-[22px] font-medium tracking-[-0.01em]">{{ currentTab?.label }}</h1>
      </div>

      <div class="px-10 py-8">

        <!-- ── NEWS ── -->
        <div v-if="activeTab === 'news'">
          <div class="flex items-center justify-between mb-6">
            <p class="text-[13px] text-white/30 tracking-widest uppercase">{{ news.length }} Beiträge</p>
            <button @click="openNewPost" class="admin-btn">+ Neuer Beitrag</button>
          </div>

          <div class="space-y-px bg-ml-border border border-ml-border">
            <div
              v-for="post in news"
              :key="post.id"
              class="bg-[#080808] px-5 py-4 flex items-center gap-4 hover:bg-white/[0.02] transition-colors"
            >
              <div class="flex-1 min-w-0">
                <p class="text-[16px] text-white truncate">{{ post.title }}</p>
                <p class="text-[13px] text-white/25 mt-0.5">{{ formatDate(post.published_at) }} · {{ post.published ? 'Veröffentlicht' : 'Entwurf' }}</p>
              </div>
              <div class="flex gap-3 flex-shrink-0">
                <button @click="editPost(post)" class="admin-btn-sm">Bearbeiten</button>
                <button @click="deletePost(post.id)" class="admin-btn-sm text-red-400/50 hover:text-red-400">Löschen</button>
              </div>
            </div>
          </div>

          <!-- Post editor modal -->
          <div v-if="editingPost" class="fixed inset-0 z-50 bg-black/80 flex items-start justify-center overflow-y-auto py-10">
            <div class="bg-[#0a0a0a] border border-ml-border w-full max-w-2xl mx-6 p-8">
              <h2 class="text-[16px] font-medium mb-6">{{ editingPost.id ? 'Beitrag bearbeiten' : 'Neuer Beitrag' }}</h2>
              <div class="space-y-4">
                <div>
                  <label class="admin-label">Titel</label>
                  <input v-model="editingPost.title" type="text" class="admin-input" />
                </div>
                <div>
                  <label class="admin-label">Slug (URL)</label>
                  <input v-model="editingPost.slug" type="text" class="admin-input" placeholder="z.B. sommeraktion-2025" />
                </div>
                <div>
                  <label class="admin-label">Tag</label>
                  <input v-model="editingPost.tag" type="text" class="admin-input" placeholder="z.B. Aktion, Team, News" />
                </div>
                <div>
                  <label class="admin-label">Titelbild</label>
                  <input type="file" accept="image/*" class="admin-input" @change="(e) => handleImageUpload(e, 'news')" />
                  <img v-if="editingPost.image_url" :src="editingPost.image_url" class="mt-2 h-28 object-cover opacity-70" />
                </div>
                <div>
                  <label class="admin-label">Inhalt (HTML)</label>
                  <textarea v-model="editingPost.content" rows="8" class="admin-input font-mono text-[12px]" />
                </div>
                <div class="flex items-center gap-3">
                  <input id="pub" v-model="editingPost.published" type="checkbox" class="accent-white" />
                  <label for="pub" class="text-[12px] text-white/50">Veröffentlicht</label>
                </div>
              </div>
              <div class="flex gap-3 mt-6">
                <button @click="savePost" :disabled="saving" class="admin-btn">{{ saving ? 'Speichern…' : 'Speichern' }}</button>
                <button @click="editingPost = null" class="admin-btn-sm">Abbrechen</button>
              </div>
            </div>
          </div>
        </div>

        <!-- ── TEAM ── -->
        <div v-if="activeTab === 'team'">
          <div class="flex items-center justify-between mb-6">
            <p class="text-[13px] text-white/30 tracking-widest uppercase">{{ team.length }} Mitglieder</p>
            <button @click="openNewMember" class="admin-btn">+ Neues Mitglied</button>
          </div>
          <div class="space-y-px bg-ml-border border border-ml-border">
            <div
              v-for="member in team"
              :key="member.id"
              class="bg-[#080808] px-5 py-4 flex items-center gap-4 hover:bg-white/[0.02] transition-colors"
            >
              <div class="w-9 h-9 rounded-full bg-white/[0.05] flex-shrink-0 overflow-hidden">
                <img v-if="member.photo_url" :src="member.photo_url" class="w-full h-full object-cover" />
                <span v-else class="w-full h-full flex items-center justify-center text-[13px] text-white/30">{{ initials(member.name) }}</span>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-[16px] text-white">{{ member.name }}</p>
                <p class="text-[13px] text-white/25">{{ member.role }}</p>
              </div>
              <div class="flex gap-3">
                <button @click="editMember(member)" class="admin-btn-sm">Bearbeiten</button>
                <button @click="deleteMember(member.id)" class="admin-btn-sm text-red-400/50 hover:text-red-400">Löschen</button>
              </div>
            </div>
          </div>

          <!-- Member editor -->
          <div v-if="editingMember" class="fixed inset-0 z-50 bg-black/80 flex items-center justify-center">
            <div class="bg-[#0a0a0a] border border-ml-border w-full max-w-md mx-6 p-8">
              <h2 class="text-[16px] font-medium mb-6">{{ editingMember.id ? 'Mitglied bearbeiten' : 'Neues Mitglied' }}</h2>
              <div class="space-y-4">
                <div>
                  <label class="admin-label">Name</label>
                  <input v-model="editingMember.name" type="text" class="admin-input" />
                </div>
                <div>
                  <label class="admin-label">Funktion</label>
                  <input v-model="editingMember.role" type="text" class="admin-input" />
                </div>
                <div>
                  <label class="admin-label">Foto</label>
                  <input type="file" accept="image/*" class="admin-input" @change="(e) => handleImageUpload(e, 'team')" />
                  <img v-if="editingMember.photo_url" :src="editingMember.photo_url" class="mt-2 h-24 w-24 object-cover rounded-full opacity-70" />
                </div>
                <div>
                  <label class="admin-label">Reihenfolge</label>
                  <input v-model.number="editingMember.sort_order" type="number" class="admin-input" />
                </div>
              </div>
              <div class="flex gap-3 mt-6">
                <button @click="saveMember" :disabled="saving" class="admin-btn">{{ saving ? 'Speichern…' : 'Speichern' }}</button>
                <button @click="editingMember = null" class="admin-btn-sm">Abbrechen</button>
              </div>
            </div>
          </div>
        </div>

        <!-- ── GALLERY ── -->
        <div v-if="activeTab === 'gallery'">
          <div class="flex items-center justify-between mb-6">
            <p class="text-[13px] text-white/30 tracking-widest uppercase">{{ gallery.length }} Fotos</p>
          </div>
          <div class="mb-6">
            <label class="admin-label">Fotos hochladen</label>
            <input type="file" accept="image/*" multiple class="admin-input" :disabled="uploadingGallery" @change="handleGalleryUpload" />
            <p v-if="uploadingGallery" class="text-[12px] text-white/30 mt-2 tracking-widest uppercase">Wird hochgeladen…</p>
          </div>
          <div class="grid grid-cols-3 gap-px bg-ml-border border border-ml-border">
            <div
              v-for="photo in gallery"
              :key="photo.id"
              class="bg-[#080808] relative group aspect-[4/3] overflow-hidden"
            >
              <img v-if="photo.url" :src="photo.url" class="w-full h-full object-cover opacity-70" />
              <div class="absolute inset-0 bg-black/0 group-hover:bg-black/50 transition-colors flex items-center justify-center">
                <button
                  @click="deleteGalleryPhoto(photo.id)"
                  class="opacity-0 group-hover:opacity-100 transition-opacity text-[12px] tracking-widest uppercase text-red-400/80 border border-red-400/30 px-3 py-1.5"
                >
                  Löschen
                </button>
              </div>
              <input v-model="photo.caption" type="text" placeholder="Beschriftung…"
                class="absolute bottom-0 left-0 right-0 bg-black/60 text-white/50 text-[13px] px-2 py-1 border-t border-ml-border focus:outline-none placeholder-white/20"
                @blur="updateCaption(photo)"
              />
            </div>
          </div>
        </div>

        <!-- ── HERO ── -->
        <div v-if="activeTab === 'hero'">
          <div class="space-y-6 max-w-xl">
            <div>
              <label class="admin-label">Haupt-Titel (Zeile 1)</label>
              <input v-model="siteSettings.hero_title_1" type="text" class="admin-input" />
            </div>
            <div>
              <label class="admin-label">Haupt-Titel (Zeile 2, gedimmt)</label>
              <input v-model="siteSettings.hero_title_2" type="text" class="admin-input" />
            </div>
            <div>
              <label class="admin-label">Untertitel</label>
              <textarea v-model="siteSettings.hero_subtitle" rows="3" class="admin-input" />
            </div>
            <div>
              <label class="admin-label">Eyebrow-Text</label>
              <input v-model="siteSettings.hero_eyebrow" type="text" class="admin-input" />
            </div>
            <button @click="saveSettings" :disabled="saving" class="admin-btn">
              {{ saving ? 'Speichern…' : 'Einstellungen speichern' }}
            </button>
          </div>
        </div>

        <!-- ── HOURS ── -->
        <div v-if="activeTab === 'hours'">
          <div class="space-y-4 max-w-lg">
            <div v-for="(row, i) in siteSettings.opening_hours" :key="i" class="flex gap-3">
              <input v-model="row.day" type="text" placeholder="Tag" class="admin-input flex-1" />
              <input v-model="row.time" type="text" placeholder="Zeit" class="admin-input flex-1" />
              <input v-model="row.link" type="text" placeholder="Link (optional)" class="admin-input flex-1" />
            </div>
            <button @click="siteSettings.opening_hours.push({ day: '', time: '', link: null })" class="admin-btn-sm">+ Zeile</button>
            <button @click="saveSettings" :disabled="saving" class="admin-btn mt-4">
              {{ saving ? 'Speichern…' : 'Speichern' }}
            </button>
          </div>
        </div>

        <!-- ── CONTACT ── -->
        <div v-if="activeTab === 'contact'">
          <div class="space-y-4 max-w-md">
            <div>
              <label class="admin-label">Adresse</label>
              <input v-model="siteSettings.contact.address" type="text" class="admin-input" />
            </div>
            <div>
              <label class="admin-label">Telefon</label>
              <input v-model="siteSettings.contact.phone" type="text" class="admin-input" />
            </div>
            <div>
              <label class="admin-label">Fax</label>
              <input v-model="siteSettings.contact.fax" type="text" class="admin-input" />
            </div>
            <div>
              <label class="admin-label">E-Mail</label>
              <input v-model="siteSettings.contact.email" type="email" class="admin-input" />
            </div>
            <button @click="saveSettings" :disabled="saving" class="admin-btn mt-2">
              {{ saving ? 'Speichern…' : 'Speichern' }}
            </button>
          </div>
        </div>

        <!-- ── DOCTORS ── -->
        <div v-if="activeTab === 'doctors'">
          <div class="flex items-center justify-between mb-6">
            <p class="text-[13px] text-white/30 tracking-widest uppercase">{{ doctors.length }} Ärzte</p>
            <button @click="openNewDoctor" class="admin-btn">+ Neuer Arzt</button>
          </div>
          <div class="space-y-px bg-ml-border border border-ml-border">
            <div v-for="d in doctors" :key="d.id" class="bg-[#080808] px-5 py-4 flex items-center gap-4 hover:bg-white/[0.02] transition-colors">
              <div class="w-9 h-9 rounded-full bg-white/[0.05] flex-shrink-0 overflow-hidden">
                <img v-if="d.photo_url" :src="d.photo_url" class="w-full h-full object-cover" />
                <span v-else class="w-full h-full flex items-center justify-center text-[13px] text-white/30">{{ initials(d.name) }}</span>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-[16px] text-white">{{ d.name }}</p>
                <p class="text-[13px] text-white/25">{{ d.specialty }}</p>
              </div>
              <div class="flex gap-3">
                <button @click="editDoctor(d)" class="admin-btn-sm">Bearbeiten</button>
                <button @click="deleteDoctor(d.id)" class="admin-btn-sm text-red-400/50 hover:text-red-400">Löschen</button>
              </div>
            </div>
          </div>
          <div v-if="editingDoctor" class="fixed inset-0 z-50 bg-black/80 flex items-start justify-center overflow-y-auto py-10">
            <div class="bg-[#0a0a0a] border border-ml-border w-full max-w-2xl mx-6 p-8">
              <h2 class="text-[16px] font-medium mb-6">{{ editingDoctor.id ? 'Arzt bearbeiten' : 'Neuer Arzt' }}</h2>
              <div class="space-y-4">
                <div><label class="admin-label">Name</label><input v-model="editingDoctor.name" type="text" class="admin-input" /></div>
                <div><label class="admin-label">Funktion</label><input v-model="editingDoctor.role" type="text" class="admin-input" /></div>
                <div><label class="admin-label">Fachgebiet</label><input v-model="editingDoctor.specialty" type="text" class="admin-input" /></div>
                <div><label class="admin-label">Telefon</label><input v-model="editingDoctor.phone" type="text" class="admin-input" /></div>
                <div><label class="admin-label">Foto</label><input type="file" accept="image/*" class="admin-input" @change="(e) => handleImageUpload(e, 'doctors')" /><img v-if="editingDoctor.photo_url" :src="editingDoctor.photo_url" class="mt-2 h-20 w-20 object-cover rounded-full opacity-70" /></div>
                <div>
                  <label class="admin-label">Biografie (eine Zeile pro Eintrag)</label>
                  <div v-for="(item, i) in editingDoctor.bio" :key="i" class="flex gap-2 mb-2">
                    <input v-model="editingDoctor.bio[i]" type="text" class="admin-input flex-1" />
                    <button @click="editingDoctor.bio.splice(i, 1)" class="text-red-400/50 hover:text-red-400 px-2">×</button>
                  </div>
                  <button @click="editingDoctor.bio.push('')" class="admin-btn-sm mt-1">+ Zeile</button>
                </div>
                <div><label class="admin-label">Reihenfolge</label><input v-model.number="editingDoctor.sort_order" type="number" class="admin-input" /></div>
              </div>
              <div class="flex gap-3 mt-6">
                <button @click="saveDoctor" :disabled="saving" class="admin-btn">{{ saving ? 'Speichern…' : 'Speichern' }}</button>
                <button @click="editingDoctor = null" class="admin-btn-sm">Abbrechen</button>
              </div>
            </div>
          </div>
        </div>

        <!-- ── SERVICES ── -->
        <div v-if="activeTab === 'services'">
          <div class="flex items-center justify-between mb-6">
            <p class="text-[13px] text-white/30 tracking-widest uppercase">{{ services.length }} Leistungen</p>
            <button @click="openNewService" class="admin-btn">+ Neue Leistung</button>
          </div>
          <div class="space-y-px bg-ml-border border border-ml-border">
            <div v-for="s in services" :key="s.id" class="bg-[#080808] px-5 py-4 flex items-center gap-4 hover:bg-white/[0.02] transition-colors">
              <div class="flex-1 min-w-0">
                <p class="text-[16px] text-white">{{ s.name }}</p>
                <p class="text-[13px] text-white/25 truncate">{{ s.link }}</p>
              </div>
              <div class="flex gap-3">
                <button @click="editService(s)" class="admin-btn-sm">Bearbeiten</button>
                <button @click="deleteService(s.id)" class="admin-btn-sm text-red-400/50 hover:text-red-400">Löschen</button>
              </div>
            </div>
          </div>
          <div v-if="editingService" class="fixed inset-0 z-50 bg-black/80 flex items-start justify-center overflow-y-auto py-10">
            <div class="bg-[#0a0a0a] border border-ml-border w-full max-w-2xl mx-6 p-8">
              <h2 class="text-[16px] font-medium mb-6">{{ editingService.id ? 'Leistung bearbeiten' : 'Neue Leistung' }}</h2>
              <div class="space-y-4">
                <div><label class="admin-label">Name</label><input v-model="editingService.name" type="text" class="admin-input" /></div>
                <div><label class="admin-label">Beschreibung</label><textarea v-model="editingService.description" rows="4" class="admin-input" /></div>
                <div><label class="admin-label">Icon (Pfad)</label><input v-model="editingService.icon" type="text" class="admin-input" placeholder="/images/service-icon-1.png" /></div>
                <div><label class="admin-label">Link</label><input v-model="editingService.link" type="text" class="admin-input" placeholder="/leistungen/name" /></div>
                <div><label class="admin-label">Reihenfolge</label><input v-model.number="editingService.sort_order" type="number" class="admin-input" /></div>
              </div>
              <div class="flex gap-3 mt-6">
                <button @click="saveService" :disabled="saving" class="admin-btn">{{ saving ? 'Speichern…' : 'Speichern' }}</button>
                <button @click="editingService = null" class="admin-btn-sm">Abbrechen</button>
              </div>
            </div>
          </div>
        </div>

        <!-- ── HOLIDAYS ── -->
        <div v-if="activeTab === 'holidays'">
          <div class="flex items-center justify-between mb-6">
            <p class="text-[13px] text-white/30 tracking-widest uppercase">{{ holidays.length }} Einträge</p>
            <button @click="addHoliday" class="admin-btn">+ Neuer Eintrag</button>
          </div>
          <div class="space-y-px bg-ml-border border border-ml-border">
            <div v-for="h in holidays" :key="h.id" class="bg-[#080808] px-5 py-3 flex items-center gap-3">
              <input v-model="h.year" type="text" placeholder="Jahr" class="admin-input w-20 flex-shrink-0" @blur="saveHoliday(h)" />
              <input v-model="h.date" type="text" placeholder="Datum" class="admin-input w-28 flex-shrink-0" @blur="saveHoliday(h)" />
              <input v-model="h.holiday" type="text" placeholder="Feiertag" class="admin-input flex-1" @blur="saveHoliday(h)" />
              <input v-model="h.hours" type="text" placeholder="Zeiten" class="admin-input w-32 flex-shrink-0" @blur="saveHoliday(h)" />
              <button @click="deleteHoliday(h.id)" class="text-red-400/50 hover:text-red-400 text-lg flex-shrink-0">×</button>
            </div>
          </div>
        </div>

        <!-- ── JOBS ── -->
        <div v-if="activeTab === 'jobs'">
          <div class="flex items-center justify-between mb-6">
            <p class="text-[13px] text-white/30 tracking-widest uppercase">{{ jobs.length }} Stellen</p>
            <button @click="openNewJob" class="admin-btn">+ Neue Stelle</button>
          </div>
          <div class="space-y-px bg-ml-border border border-ml-border">
            <div v-for="j in jobs" :key="j.id" class="bg-[#080808] px-5 py-4 flex items-center gap-4 hover:bg-white/[0.02] transition-colors">
              <div class="flex-1 min-w-0">
                <p class="text-[16px] text-white truncate">{{ j.title }}</p>
                <p class="text-[13px] text-white/25">{{ j.active ? 'Aktiv' : 'Inaktiv' }}</p>
              </div>
              <div class="flex gap-3">
                <button @click="editJob(j)" class="admin-btn-sm">Bearbeiten</button>
                <button @click="deleteJob(j.id)" class="admin-btn-sm text-red-400/50 hover:text-red-400">Löschen</button>
              </div>
            </div>
          </div>
          <div v-if="editingJob" class="fixed inset-0 z-50 bg-black/80 flex items-start justify-center overflow-y-auto py-10">
            <div class="bg-[#0a0a0a] border border-ml-border w-full max-w-2xl mx-6 p-8">
              <h2 class="text-[16px] font-medium mb-6">{{ editingJob.id ? 'Stelle bearbeiten' : 'Neue Stelle' }}</h2>
              <div class="space-y-4">
                <div><label class="admin-label">Titel</label><input v-model="editingJob.title" type="text" class="admin-input" /></div>
                <div><label class="admin-label">Untertitel</label><input v-model="editingJob.subtitle" type="text" class="admin-input" /></div>
                <div><label class="admin-label">Einleitung</label><textarea v-model="editingJob.intro" rows="3" class="admin-input" /></div>
                <div>
                  <label class="admin-label">Abschnitte (JSON)</label>
                  <textarea :value="JSON.stringify(editingJob.sections, null, 2)" rows="10" class="admin-input font-mono text-[13px]"
                    @input="(e) => { try { editingJob.sections = JSON.parse((e.target as HTMLTextAreaElement).value) } catch {} }" />
                </div>
                <div class="flex items-center gap-3">
                  <input id="job-active" v-model="editingJob.active" type="checkbox" class="accent-white" />
                  <label for="job-active" class="text-[12px] text-white/50">Aktiv (öffentlich sichtbar)</label>
                </div>
              </div>
              <div class="flex gap-3 mt-6">
                <button @click="saveJob" :disabled="saving" class="admin-btn">{{ saving ? 'Speichern…' : 'Speichern' }}</button>
                <button @click="editingJob = null" class="admin-btn-sm">Abbrechen</button>
              </div>
            </div>
          </div>
        </div>

      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
definePageMeta({ layout: 'admin' })
useHead({ title: 'Dashboard – Medlake Admin' })

const router = useRouter()

// Auth guard
onMounted(() => {
  if (typeof localStorage !== 'undefined' && !localStorage.getItem('ml_admin')) {
    router.push('/admin')
  }
  loadAll()
})

function logout() {
  localStorage.removeItem('ml_admin')
  router.push('/admin')
}

// ── Tabs ──
const tabs = [
  { id: 'news',      label: 'News' },
  { id: 'team',      label: 'Team' },
  { id: 'gallery',   label: 'Galerie' },
  { id: 'doctors',   label: 'Ärzte' },
  { id: 'services',  label: 'Leistungen' },
  { id: 'holidays',  label: 'Feiertage' },
  { id: 'jobs',      label: 'Jobs' },
  { id: 'hero',      label: 'Hero-Text' },
  { id: 'hours',     label: 'Öffnungszeiten' },
  { id: 'contact',   label: 'Kontakt' },
]
const activeTab = ref('news')
const currentTab = computed(() => tabs.find((t) => t.id === activeTab.value))

// ── State ──
const news = ref<any[]>([])
const team = ref<any[]>([])
const gallery = ref<any[]>([])
const doctors = ref<any[]>([])
const services = ref<any[]>([])
const holidays = ref<any[]>([])
const jobs = ref<any[]>([])
const editingPost = ref<any>(null)
const editingMember = ref<any>(null)
const editingDoctor = ref<any>(null)
const editingService = ref<any>(null)
const editingJob = ref<any>(null)
const saving = ref(false)
const uploadingGallery = ref(false)

const siteSettings = ref({
  hero_title_1:   'Die Kraft',
  hero_title_2:   'zu heilen. Die Kraft zu bewegen.',
  hero_subtitle:  'Medizinisches Kompetenzzentrum für gesundheitsorientiertes Kraft- und Ausdauertraining.',
  hero_eyebrow:   'Küsnacht, Schweiz — seit 2001',
  opening_hours:  [
    { day: 'Montag – Freitag',  time: '06:30 – 21:00', link: null as string | null },
    { day: 'Samstag – Sonntag', time: '08:00 – 18:00', link: null as string | null },
    { day: 'Feiertage',         time: 'Variabel →',    link: '/feiertage' as string | null },
  ],
  contact: {
    address: 'Seestrasse 39, 8700 Küsnacht',
    phone:   '+41 44 991 22 02',
    fax:     '+41 44 991 22 03',
    email:   'info@medlake.ch',
  },
  services: [
    { name: 'Krafttraining', desc: 'Gesundheitsorientiertes Krafttraining...' },
    { name: 'Herz & Kreislauf', desc: 'Cardio-Training für ein starkes Herz-Kreislauf-System.' },
  ],
})

const supabase = useSupabaseClient()

// ── Load all data ──
async function loadAll() {
  try {
    const [postsRes, teamRes, galleryRes, settingsRes, doctorsRes, servicesRes, holidaysRes, jobsRes] = await Promise.all([
      supabase.from('news_posts').select('*').order('published_at', { ascending: false }),
      supabase.from('team_members').select('*').order('sort_order'),
      supabase.from('gallery_photos').select('*').order('sort_order'),
      supabase.from('site_settings').select('value').eq('key', 'main').maybeSingle(),
      supabase.from('doctors').select('*').order('sort_order'),
      supabase.from('services').select('*').order('sort_order'),
      supabase.from('holidays').select('*').order('sort_order'),
      supabase.from('jobs').select('*').order('created_at', { ascending: false }),
    ])
    news.value     = postsRes.data     || []
    team.value     = teamRes.data      || []
    gallery.value  = galleryRes.data   || []
    doctors.value  = doctorsRes.data   || []
    services.value = servicesRes.data  || []
    holidays.value = holidaysRes.data  || []
    jobs.value     = jobsRes.data      || []
    if (settingsRes.data?.value) {
      Object.assign(siteSettings.value, settingsRes.data.value)
    }
  } catch { /* Supabase not configured yet */ }
}

// ── News ──
function openNewPost() {
  editingPost.value = { title: '', slug: '', tag: 'News', content: '', image_url: null, published: false }
}
function editPost(p: any) { editingPost.value = { ...p } }
async function savePost() {
  if (!editingPost.value) return
  saving.value = true
  try {
    if (editingPost.value.id) {
      await supabase.from('news_posts').update(editingPost.value).eq('id', editingPost.value.id)
    } else {
      editingPost.value.published_at = new Date().toISOString()
      await supabase.from('news_posts').insert(editingPost.value)
    }
    await loadAll()
    editingPost.value = null
  } finally { saving.value = false }
}
async function deletePost(id: number) {
  if (!confirm('Beitrag wirklich löschen?')) return
  await supabase.from('news_posts').delete().eq('id', id)
  await loadAll()
}

// ── Team ──
function openNewMember() {
  editingMember.value = { name: '', role: '', photo_url: null, sort_order: team.value.length + 1 }
}
function editMember(m: any) { editingMember.value = { ...m } }
async function saveMember() {
  if (!editingMember.value) return
  saving.value = true
  try {
    if (editingMember.value.id) {
      await supabase.from('team_members').update(editingMember.value).eq('id', editingMember.value.id)
    } else {
      await supabase.from('team_members').insert(editingMember.value)
    }
    await loadAll()
    editingMember.value = null
  } finally { saving.value = false }
}
async function deleteMember(id: number) {
  if (!confirm('Mitglied wirklich entfernen?')) return
  await supabase.from('team_members').delete().eq('id', id)
  await loadAll()
}

// ── Image upload ──
async function handleImageUpload(e: Event, context: 'news' | 'team' | 'doctors') {
  const file = (e.target as HTMLInputElement).files?.[0]
  if (!file) return
  try {
    const path = `${context}/${Date.now()}-${file.name}`
    const { error } = await supabase.storage.from('medlake').upload(path, file)
    if (error) throw error
    const { data: urlData } = supabase.storage.from('medlake').getPublicUrl(path)
    if (context === 'news'    && editingPost.value)   editingPost.value.image_url   = urlData.publicUrl
    if (context === 'team'    && editingMember.value) editingMember.value.photo_url = urlData.publicUrl
    if (context === 'doctors' && editingDoctor.value) editingDoctor.value.photo_url = urlData.publicUrl
  } catch (err) { console.error('Upload failed:', err) }
}

async function handleGalleryUpload(e: Event) {
  const files = (e.target as HTMLInputElement).files
  if (!files) return
  uploadingGallery.value = true
  try {
    for (const file of Array.from(files)) {
      const path = `gallery/${Date.now()}-${file.name}`
      const { error } = await supabase.storage.from('medlake').upload(path, file)
      if (error) {
        alert(`Upload fehlgeschlagen: ${error.message}`)
        continue
      }
      const { data: urlData } = supabase.storage.from('medlake').getPublicUrl(path)
      const { error: dbError } = await supabase.from('gallery_photos').insert({
        url: urlData.publicUrl,
        caption: null,
        sort_order: gallery.value.length + 1,
      })
      if (dbError) alert(`DB-Fehler: ${dbError.message}`)
    }
    await loadAll()
  } finally {
    uploadingGallery.value = false
  }
}

async function deleteGalleryPhoto(id: number) {
  if (!confirm('Foto löschen?')) return
  await supabase.from('gallery_photos').delete().eq('id', id)
  await loadAll()
}

async function updateCaption(photo: any) {
  await supabase.from('gallery_photos').update({ caption: photo.caption }).eq('id', photo.id)
}

// ── Doctors ──
function openNewDoctor() {
  editingDoctor.value = { name: '', role: 'Mitinhaber', specialty: '', phone: '', photo_url: null, bio: [], sort_order: doctors.value.length + 1 }
}
function editDoctor(d: any) { editingDoctor.value = { ...d, bio: [...(d.bio || [])] } }
async function saveDoctor() {
  if (!editingDoctor.value) return
  saving.value = true
  try {
    if (editingDoctor.value.id) {
      await supabase.from('doctors').update(editingDoctor.value).eq('id', editingDoctor.value.id)
    } else {
      await supabase.from('doctors').insert(editingDoctor.value)
    }
    await loadAll()
    editingDoctor.value = null
  } finally { saving.value = false }
}
async function deleteDoctor(id: number) {
  if (!confirm('Arzt wirklich löschen?')) return
  await supabase.from('doctors').delete().eq('id', id)
  await loadAll()
}

// ── Services ──
function openNewService() {
  editingService.value = { name: '', description: '', icon: '', link: '', sort_order: services.value.length + 1 }
}
function editService(s: any) { editingService.value = { ...s } }
async function saveService() {
  if (!editingService.value) return
  saving.value = true
  try {
    if (editingService.value.id) {
      await supabase.from('services').update(editingService.value).eq('id', editingService.value.id)
    } else {
      await supabase.from('services').insert(editingService.value)
    }
    await loadAll()
    editingService.value = null
  } finally { saving.value = false }
}
async function deleteService(id: number) {
  if (!confirm('Leistung wirklich löschen?')) return
  await supabase.from('services').delete().eq('id', id)
  await loadAll()
}

// ── Holidays ──
async function saveHoliday(h: any) {
  await supabase.from('holidays').update({ date: h.date, holiday: h.holiday, hours: h.hours }).eq('id', h.id)
}
async function addHoliday() {
  await supabase.from('holidays').insert({ year: new Date().getFullYear().toString(), date: '', holiday: '', hours: '', sort_order: holidays.value.length + 1 })
  await loadAll()
}
async function deleteHoliday(id: number) {
  if (!confirm('Eintrag löschen?')) return
  await supabase.from('holidays').delete().eq('id', id)
  await loadAll()
}

// ── Jobs ──
function openNewJob() {
  editingJob.value = { title: '', subtitle: '', intro: '', sections: [], active: true }
}
function editJob(j: any) { editingJob.value = { ...j, sections: JSON.parse(JSON.stringify(j.sections || [])) } }
async function saveJob() {
  if (!editingJob.value) return
  saving.value = true
  try {
    if (editingJob.value.id) {
      await supabase.from('jobs').update(editingJob.value).eq('id', editingJob.value.id)
    } else {
      await supabase.from('jobs').insert(editingJob.value)
    }
    await loadAll()
    editingJob.value = null
  } finally { saving.value = false }
}
async function deleteJob(id: number) {
  if (!confirm('Job wirklich löschen?')) return
  await supabase.from('jobs').delete().eq('id', id)
  await loadAll()
}

// ── Settings ──
async function saveSettings() {
  saving.value = true
  try {
    await supabase.from('site_settings').upsert({ key: 'main', value: siteSettings.value })
  } finally { saving.value = false }
}

// ── Helpers ──
function formatDate(d: string) {
  if (!d) return '–'
  return new Date(d).toLocaleDateString('de-CH', { day: 'numeric', month: 'short', year: 'numeric' })
}
function initials(name: string) {
  return name.split(' ').map((n) => n[0]).slice(0, 2).join('').toUpperCase()
}
</script>

<style scoped>
.admin-btn {
  @apply text-[13px] tracking-[0.15em] uppercase bg-white text-black px-5 py-2.5 font-medium hover:bg-white/85 transition-colors disabled:opacity-40;
}
.admin-btn-sm {
  @apply text-[12px] tracking-[0.15em] uppercase border border-ml-border px-4 py-2 text-white/40 hover:text-white hover:border-white/30 transition-colors;
}
.admin-label {
  @apply block text-[12px] tracking-[0.2em] uppercase text-white/30 mb-2;
}
.admin-input {
  @apply w-full bg-white/[0.04] border border-ml-border text-white text-[15px] px-4 py-3 placeholder-white/20 focus:outline-none focus:border-white/25 transition-colors;
}
</style>
