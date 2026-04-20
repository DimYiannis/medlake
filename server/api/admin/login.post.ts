export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  const config = useRuntimeConfig()

  if (body?.password === config.adminPassword) {
    return { ok: true }
  }

  setResponseStatus(event, 401)
  return { ok: false }
})
