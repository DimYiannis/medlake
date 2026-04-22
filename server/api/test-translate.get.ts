export default defineEventHandler(async () => {
  const config = useRuntimeConfig()
  const apiKey = config.deeplApiKey as string

  if (!apiKey) return { ok: false, reason: 'DEEPL_API_KEY not set' }

  try {
    const res = await $fetch<any>('https://api-free.deepl.com/v2/translate', {
      method: 'POST',
      headers: { Authorization: `DeepL-Auth-Key ${apiKey}`, 'Content-Type': 'application/json' },
      body: JSON.stringify({ text: ['Hallo Welt'], target_lang: 'EN', source_lang: 'DE' }),
    })
    return { ok: true, result: res.translations?.[0]?.text }
  } catch (e: any) {
    return { ok: false, reason: e?.message ?? String(e) }
  }
})
