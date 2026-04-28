/**
 * Translates i18n/locales/de.json → target language via DeepL.
 * Usage: node scripts/translate-locales.mjs FR
 * Requires DEEPL_API_KEY in .env
 */
import { readFileSync, writeFileSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dir = dirname(fileURLToPath(import.meta.url))
const KEY = process.env.DEEPL_API_KEY
if (!KEY) { console.error('DEEPL_API_KEY not set'); process.exit(1) }

const LANG = (process.argv[2] || 'FR').toUpperCase()
const LANG_FILE = LANG.toLowerCase()

const ENDPOINT = 'https://api-free.deepl.com/v2/translate'

function flatten(obj, prefix = '') {
  const out = {}
  for (const [k, v] of Object.entries(obj)) {
    const path = prefix ? `${prefix}.${k}` : k
    if (typeof v === 'string') {
      out[path] = v
    } else if (Array.isArray(v)) {
      v.forEach((item, i) => {
        if (typeof item === 'string') out[`${path}[${i}]`] = item
        else if (item && typeof item === 'object') Object.assign(out, flatten(item, `${path}[${i}]`))
      })
    } else if (v && typeof v === 'object') {
      Object.assign(out, flatten(v, path))
    }
  }
  return out
}

function setPath(obj, path, value) {
  const parts = path.replace(/\[(\d+)\]/g, '.$1').split('.')
  let cur = obj
  for (let i = 0; i < parts.length - 1; i++) {
    const k = parts[i]
    const nextIsIndex = /^\d+$/.test(parts[i + 1])
    if (cur[k] == null) cur[k] = nextIsIndex ? [] : {}
    cur = cur[k]
  }
  cur[parts[parts.length - 1]] = value
}

async function translate(texts) {
  const body = new URLSearchParams()
  body.append('target_lang', LANG)
  body.append('source_lang', 'DE')
  texts.forEach(t => body.append('text', t))
  const res = await fetch(ENDPOINT, {
    method: 'POST',
    headers: { Authorization: `DeepL-Auth-Key ${KEY}`, 'Content-Type': 'application/x-www-form-urlencoded' },
    body: body.toString(),
  })
  if (!res.ok) throw new Error(`DeepL ${res.status}: ${await res.text()}`)
  return (await res.json()).translations.map(t => t.text)
}

const de = JSON.parse(readFileSync(resolve(__dir, '../i18n/locales/de.json'), 'utf8'))
const flat = flatten(de)
const keys = Object.keys(flat)
const values = Object.values(flat)

console.log(`Translating ${keys.length} strings DE → ${LANG}...`)

const BATCH = 50
const translated = []
for (let i = 0; i < values.length; i += BATCH) {
  process.stdout.write(`  ${i + 1}–${Math.min(i + BATCH, values.length)} / ${values.length}\r`)
  translated.push(...await translate(values.slice(i, i + BATCH)))
}

const result = {}
keys.forEach((k, i) => setPath(result, k, translated[i]))

const outPath = resolve(__dir, `../i18n/locales/${LANG_FILE}.json`)
writeFileSync(outPath, JSON.stringify(result, null, 2) + '\n', 'utf8')
console.log(`\nDone → i18n/locales/${LANG_FILE}.json`)
