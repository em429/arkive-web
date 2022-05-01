import { query, run } from '$lib/db'

export async function post({ params, request }) {
  let form = await request.formData()
  let url = await form.get('url')
  let read = await form.get('read')

  let toggle_read = run('UPDATE webpage SET read = ? WHERE url = ?', [read, url])

  if (toggle_read) {
    return {
      status: 303,
      headers: {
        location: '/',
      },
    }
  }

  return {
    status: 404,
  }
}
